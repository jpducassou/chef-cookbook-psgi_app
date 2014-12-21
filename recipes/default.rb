include_recipe 'apt'

#include_recipe 'carton'
#
#%w{build-essential openssl libssl-dev libmysqlclient-dev}.each do |pkg|
#  package pkg do
#    action :install
#  end
#end
#

required_packages = [
	'build-essential',
	'libssl-dev',
	'libmysqlclient-dev',
]

required_packages.each do |pkg|
	package pkg do
		action :install
	end
end




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
#carton_app "cgi_app" do
#  action :start
#end
#
