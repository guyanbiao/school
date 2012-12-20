# This file should be placed on the directory of ~/blog/config

working_directory "/home/db2inst1/rails/school"
pid "/home/db2inst1/rails/school/tmp/pids/unicorn.pid"
stderr_path "/home/db2inst1/rails/school/unicorn/err.log"
stdout_path "/home/db2inst1/rails/school/unicorn/out.log"

listen "/tmp/unicorn.school.socket"

worker_processes 2
timeout 30
