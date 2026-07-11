#!/bin/sh
# automated smoke test for the quark container
# builds the image, serves a docroot and asserts quark actually serves it over HTTP
set -eu

IMAGE=quark-test
NAME=quark-test-run
DOCROOT=$(mktemp -d)
MARKER="quark-smoke-test-$$-ok"

FAILED=0
fail() {
  echo "FAIL: $*" >&2
  FAILED=1
}

cleanup() {
  echo ">> cleanup: removing container $NAME"
  docker rm -f "$NAME" >/dev/null 2>&1 || true
  rm -rf "$DOCROOT" || true
}
trap cleanup EXIT INT TERM

echo ">> preparing docroot $DOCROOT"
echo "$MARKER" > "$DOCROOT/index.html"

echo ">> building image $IMAGE"
docker build -t "$IMAGE" .

echo ">> (re)starting container $NAME"
docker rm -f "$NAME" >/dev/null 2>&1 || true
# quark serves /data on port 80 (see Dockerfile CMD)
docker run -d --name "$NAME" -v "$DOCROOT":/data "$IMAGE"

echo ">> waiting for quark to come up (up to ~30s)"
READY=0
i=0
while [ "$i" -lt 15 ]; do
  if ! docker ps --format '{{.Names}}' | grep -q "^${NAME}$"; then
    echo "!! container is not running anymore, dumping logs:" >&2
    docker logs "$NAME" >&2 2>&1 || true
    fail "container exited during startup"
    break
  fi
  if docker exec "$NAME" ps aux 2>/dev/null | grep -q '[q]uark'; then
    READY=1
    break
  fi
  i=$((i + 1))
  sleep 2
done

if [ "$READY" -ne 1 ] && [ "$FAILED" -eq 0 ]; then
  echo "!! quark did not come up in time, dumping logs:" >&2
  docker logs "$NAME" >&2 2>&1 || true
  fail "timed out waiting for quark"
fi

if docker ps --format '{{.Names}}' | grep -q "^${NAME}$"; then

  echo ">> assert: quark process present"
  if docker exec "$NAME" ps aux | grep -q '[q]uark'; then
    echo "ok - quark running"
  else
    fail "quark process not found"
  fi

  echo ">> assert: quark serves the file over HTTP with the right content"
  BODY=""
  n=0
  while [ "$n" -lt 15 ]; do
    BODY=$(docker exec "$NAME" wget -qO- http://127.0.0.1:80/index.html 2>/dev/null || true)
    [ -n "$BODY" ] && break
    n=$((n + 1))
    sleep 1
  done
  if [ "$BODY" = "$MARKER" ]; then
    echo "ok - HTTP response matched marker ($MARKER)"
  else
    fail "HTTP response did not match marker (got: '$BODY')"
  fi

fi

echo
if [ "$FAILED" -eq 0 ]; then
  echo "ALL TESTS PASSED"
  exit 0
else
  echo "SOME TESTS FAILED"
  exit 1
fi
