
# ============================================================================
# Checks
# ============================================================================
Chef::Log.fatal "perl_version not set for application" unless node['application']['perl_version']

# ============================================================================
# perlbrew
# ============================================================================
# node['perlbrew']['self_upgrade'] = false
node.default['perlbrew']['self_upgrade'] = false
Chef::Log.info "Installing perlbrew"
include_recipe 'perlbrew'

Chef::Log.info "Brewing perl: #{node['application']['[perl_version']}"
perlbrew_perl node['application']['perl_version'] do
	action :install
end

# ============================================================================
# Required packages
# ============================================================================
include_recipe 'apt'

required_packages = [
	'libssl-dev',
	'libmysqlclient-dev',
]

required_packages.each do |pkg|
	package pkg do
		action :install
	end
end

# ============================================================================
# Carton
# ============================================================================

#include_recipe 'carton'
#

#
#
#carton_app "cgi_app" do
#  perlbrew node['cgi_app']['perl_version']
#  command "starman -p #{node['cgi_app']['port']} app.psgi"
#  cwd node['cgi_app']['deploy_dir']
#  user node['cgi_app']['user']
#  group node['cgi_app']['group']
#end
#
