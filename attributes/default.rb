# perlbrew to execute with (should be a legal perlbrew target)
default['application']['perl_version'] = 'perl-5.14.2'

# Install directory
default['application']['deploy_dir'] = '/opt/application'

# Service user/group/port
default['application']['user']  = "nginx"
default['application']['group'] = "nginx"

