#!/usr/bin/env puma

log_requests

threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
threads threads_count, threads_count

bind "tcp://0.0.0.0:#{ENV.fetch('PORT', '9292')}"
pidfile "/tmp/pids/puma.pid"
state_path "/tmp/pids/puma.state"

on_worker_boot do
  Sequel::DATABASES.each(&:disconnect)
end
plugin :tmp_restart
