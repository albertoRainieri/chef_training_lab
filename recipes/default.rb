#
# Cookbook:: chef_training_lab
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.
package 'httpd'

template node['httpd']['html_path'] do
  source 'index.html.erb'
  variables(
    greetings: node['httpd']['greetings'],
    hostname: node['hostname']
  )
  mode '0664'
end

service 'httpd' do
  action [ :enable, :start ]
end

sshbanner 'foo' do
  message_banner 'Hello! This is test server!'
end
