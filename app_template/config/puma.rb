
preload_app!

after_worker_fork do
  # Must re-establish DB connections!
  Grande.c.run_after_fork
end
