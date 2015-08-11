require 'puma'
wd = File.expand_path('../../', __FILE__)
tmp_path = File.join(wd, 'tmp')
log_path = File.join(wd, 'log')
Dir.mkdir(tmp_path) unless File.exist?(tmp_path)
pidfile File.join(tmp_path, 'pids', 'puma.pid')
stdout_redirect File.join(log_path, 'puma.out.log'), File.join(log_path, 'puma.err.log'), true
daemonize true
bind "unix:///var/run/birt.tanliani.com.sock"
