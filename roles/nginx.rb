name "nginx"
description "An role to install NGINX "
run_list "recipe[nginx]"
default_attributes "nginx" => { 
                                "init_style" => "init",
                                "default_site_enabled" => "true"
                                }