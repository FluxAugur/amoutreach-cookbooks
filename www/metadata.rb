maintainer "nmcconnell.com"
description "Configures A+M Outreach Website"
version "0.1"
supports "ubuntu", ">= 8.10"

recipe "www::configure", "Re-configure A+M Outreach Website"

depends "deploy"
depends "nginx"

attribute "www",
  :display_name => "www",
  :description => "Hash of www attributes",
  :type => "hash"

attribute "www/database_flavor",
  :display_name => "www Database Flavor",
  :description => "Specify the flavor of SQL database to use",
  :default => "false"