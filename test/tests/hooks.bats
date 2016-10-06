# source docker helpers
. util/docker.sh

@test "Start Container" {
  start_container "hooks-test"
}

@test "Verify hooks installed" {
  skip
  # look for a hook that should be there
  run docker exec "hooks-test" bash -c "[ -f /opt/nanobox/hooks/configure ]"

  [ "$status" -eq 0 ]
}

@test "Stop Container" {
  stop_container "hooks-test"
}
