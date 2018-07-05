worker_processes 3

app_path = '/var/www/vhost/lovedaddy/current'

listen  File.expand_path('tmp/sockets/unicorn.sock', app_path)
pid File.expand_path('tmp/pids/unicorn.pid', app_path)
stderr_path File.expand_path('log/unicorn.stderr.log', app_path)
stdout_path File.expand_path('log/unicorn.stdout.log', app_path)

timeout 200

preload_app true

GC.respond_to?(:copy_on_write_friendly=) and
GC.copy_on_write_friendly = true

before_fork do |server, worker|
 defined?(ActiveRecord::Base) and
   ActiveRecord::Base.connection.disconnect!

 old_pid = "#{server.config[:pid]}.oldbin"
 if old_pid != server.pid
   begin
     sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
     Process.kill(sig, File.read(old_pid).to_i)
   rescue Errno::ENOENT, Errno::ESRCH
   end
 end

 sleep 1
end

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile', app_path)
end

after_fork do |server, worker|
 defined?(ActiveRecord::Base) and
   ActiveRecord::Base.establish_connection
end
