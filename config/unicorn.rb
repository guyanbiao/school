# This file should be placed on the directory of ~/blog/config

working_directory "/home/rails/school"
pid "/home/rails/school/tmp/pids/unicorn.pid"
stderr_path "/home/rails/school/unicorn/err.log"
stdout_path "/home/rails/school/unicorn/out.log"

listen "/tmp/unicorn.school.socket"

worker_processes 2
timeout 30
