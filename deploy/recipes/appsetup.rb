node[:deploy].each do |app_name, deploy|

  template "#{deploy[:deploy_to]}/current/db-connect.rb" do
    source "db-connect.rb"
    mode 0660
    group deploy[:group]

    if platform?("ubuntu")
      owner "www-data"
    elsif platform?("amazon")
      owner "apache" # Change to nginx/unicorn?
    end

    variables(
      host: (deploy[:database][:host] rescue nil),
      user: (deploy[:database][:username] rescue nil),
      password: (deploy[:database][:password] rescue nil),
      db: (deploy[:database][:database] rescue nil),
      table: (node[:www-prelaunch][:dbtable] rescue nil)
    )

    only_if do
      File.directory?("#{deploy[:deploy_to]}/current")
    end

  end

end
      