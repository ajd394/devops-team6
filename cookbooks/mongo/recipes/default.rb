#
# Cookbook:: mongo
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe "sc-mongodb::default"

service "mongod" do
  action :start
end
