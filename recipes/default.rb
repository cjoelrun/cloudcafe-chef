#
# Cookbook Name:: cloudcafe
# Recipe:: default
#
# Copyright 2012, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'git'
include_recipe 'python::pip'

directory node['cloudcafe']['dest'] do
  owner "root"
  group "root"
  mode 0755
  action :create
  recursive true
end

cookbook_file "#{node['cloudcafe']['dest']}/pip-requires" do
  source "pip-requires"
  mode 0755
  owner "root"
  group "root"
end

execute "pip install pip-requires" do
  command "pip install -r ./pip-requires"
  cwd "#{node['cloudcafe']['dest']}"
end

%w{ opencafe cloudcafe cloudroast }.each do |package|

  git "#{node['cloudcafe']['dest']}/#{package}" do
    repository "https://github.com/stackforge/#{package}.git"
    reference "master"
  end

  execute "pip install #{package} --upgrade" do
    command "pip install ./#{package} --upgrade"
    cwd "#{node['cloudcafe']['dest']}"
  end

end
