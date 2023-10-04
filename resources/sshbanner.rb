# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
provides :sshbanner

property :message_banner, String, default: 'welcome'

action :create do
  # Specify the file path for enabling banner in sshd config
  file_path_sshd = '/etc/ssh/sshd_config'
  # Specify the file path for customizing new banner
  file_path_banner = '/etc/mybanner'

  # modify sshd config
  # Define a hash of search and replace pairs
  # The keys are the lines to search for, and the values are the replacement content
  search_and_replace = {
    '#Banner none' => 'Banner none',
    # Add more search and replace pairs as needed
  }

  # Read the current content of the file
  file_content = ::File.read(file_path_sshd)

  # Perform search and replace
  search_and_replace.each do |search, replace|
    file_content.gsub!(search, replace)
  end

  # Write the modified content back to the file
  ::File.open(file_path_sshd, 'w') do |file|
    file.puts(file_content)
  end

  # create new banner
  file file_path_banner do
    content new_resource.message_banner
    action :create # This action will create or update the file
  end

  # restart sshd
  service 'sshd' do
    action :restart
  end
end
