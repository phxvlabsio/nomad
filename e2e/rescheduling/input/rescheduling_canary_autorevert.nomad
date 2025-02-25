# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

job "test" {

  datacenters = ["dc1", "dc2"]

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }

  type = "service"

  group "t1" {
    count = 3

    task "t1" {
      driver = "raw_exec"

      config {
        command = "bash"
        args    = ["-c", "sleep 5000"]
      }
    }

    update {
      canary            = 3
      max_parallel      = 1
      min_healthy_time  = "1s"
      auto_revert       = true
      healthy_deadline  = "2s"
      progress_deadline = "3s"
    }

    restart {
      attempts = 0
      mode     = "fail"
    }

    reschedule {
      unlimited = "true"
    }
  }
}
