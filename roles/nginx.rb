name "nginx"
description "An role to install and configure NGINX"
run_list "recipe[nginx]"

default_attributes "nginx" => { 
                                "init_style" => "init",
                                "port" => 80,
                                "proxy_pass_uri" => "http://192.168.50.50:8080",
                                "default_site_enabled" => "false",
                                }
