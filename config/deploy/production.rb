set :rails_env, :production
set :deploy_to, '/home/deploy/tender_ruda_production'

server 'tis-ruda.com', user: 'deploy', roles: %w{web app db}

set :ssh_options, { user: 'deploy', forward_agent: true, keys: %w(~/.ssh/tis-ruda.pem) }
