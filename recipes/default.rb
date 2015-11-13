
# ============================================================================
# Checks
# ============================================================================
Chef::Log.fatal "perl_version not set for application" unless node['psgi_app']['perl_version']

# ============================================================================
# perlbrew
# ============================================================================
node.default['perlbrew']['self_upgrade'] = false
Chef::Log.info 'Installing perlbrew ...'
include_recipe 'perlbrew'

Chef::Log.info "Brewing perl: \"#{node['psgi_app']['perl_version']}\" ..."
perlbrew_perl node['psgi_app']['perl_version'] do
	action :install
end

# ============================================================================
# Required distro packages
# ============================================================================
required_packages = node['psgi_app']['required_packages']

if required_packages then

	include_recipe 'apt'

	required_packages.each do |pkg|
		package pkg do
			action :install
		end
	end
else
	Chef::Log.info "apt: no packages set."
end

# ============================================================================
# Basic packages
# ============================================================================
# TODO: install git, vim, etc. Read the list from config file
# TODO: Delete: ~/.profile and ~/.bashrc
# TODO: Clone and install dotfiles

# ============================================================================
# Carton
# ============================================================================
include_recipe 'carton'

carton_app "psgi_app" do
	perlbrew node['psgi_app']['perl_version']
	# command "starman -p #{node['psgi_app']['port']} velia.psgi"
	user       node['psgi_app']['user']
	group      node['psgi_app']['group']
	cwd        node['psgi_app']['deploy_dir']
end

#carton_app "psgi_app" do
#	action :install
#end

# ============================================================================
# END
# ============================================================================

