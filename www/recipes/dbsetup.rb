node[:deploy].each do |app_name, deploy|
  execute "mysql-create-table" do
    command "/usr/bin/mysql -u#{deploy[:database][:username]} -p#{deploy[:database][:password]} #{deploy[:database][:database]} -e'CREATE TABLE #{node[:www][:dbtable]} (
      id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
      email VARCHAR(255) NOT NULL UNIQUE,
      encrypted_password VARCHAR(255) NOT NULL,
      reset_password_token VARCHAR(255) UNIQUE,
      reset_password_sent_at DATETIME,
      remember_created_at DATETIME,
      sign_in_count INT(11),
      current_sign_in_at DATETIME,
      last_sign_in_at DATETIME,
      current_sign_in_ip VARCHAR(255),
      last_sign_in_ip VARCHAR(255),
      created_at DATETIME NOT NULL,
      updated_at DATETIME NOT NULL,
      name VARCHAR(255),
      confirmation_token VARCHAR(255),
      confirmed_at DATETIME,
      confirmation_sent_at DATETIME,
      unconfirmed_email VARCHAR(255),
      PRIMARY KEY (id)
    )'"
    not_if "/usr/bin/mysql -u#{deploy[:database][:username]} -p#{deploy[:database][:password]} #{deploy[:database][:database]} -e'SHOW TABLES' | grep #{node[:www][:dbtable]}"
    action :run
  end
end
