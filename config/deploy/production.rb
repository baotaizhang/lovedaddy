set :branch, :master

server 'prod-lovedaddy-web', user: 'deploy', roles: %w(web app db)

set :ssh_options, {
  port: 22,
  forward_agent: true
}
