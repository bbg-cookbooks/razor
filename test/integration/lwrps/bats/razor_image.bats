#!/usr/bin/env bats

@test "downloads tinycorelinux ISO to iso_path directory" {
  [ -f "/var/razor/images/tinycorelinux-core-x86/Core-4.7.7.iso" ]
}

@test "add the image to razor" {
  unset GEM_HOME GEM_PATH
  run razor image

  [ $status -eq 0 ]
  echo "$output" | egrep -q 'ISO Filename\s+=>\s+Core-4\.7\.7\.iso'
}
