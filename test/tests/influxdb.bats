# source docker helpers
. util/docker.sh

@test "Start Container" {
  start_container "influxdb-test"
}

@test "Verify influxdb installed" {
  # ensure influxdb is installed
  run docker exec "influxdb-test" bash -c "[ -f /usr/bin/influxd ]"
  [ "$status" -eq 0 ]
}

@test "Stop Container" {
  stop_container "influxdb-test"
}
