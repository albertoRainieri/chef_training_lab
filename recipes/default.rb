#
# Cookbook:: chef_training_lab
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.
package 'httpd'

# execute 'httpd' do
#   command 'systemctl start httpd'
#   user 'root'
#   action :run
# end

# execute 'httpd' do
#   command 'systemctl enable httpd'
#   user 'root'
#   action :run
# end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  mode '0664'
end

service 'httpd' do
  action [ :enable, :start ]
end
