#
# Cookbook Name:: lsyncd
# Recipe:: default
#
# Copyright (C) 2014 Rackspace, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


include_recipe "yum-epel" if platform_family?('rhel')

package 'lsyncd'

directory '/etc/lsyncd/conf.d' do
  recursive true
  mode 0755
end

if platform_family?('fedora', 'rhel')
  template '/etc/lsyncd.conf' do
    source 'lsyncd.conf.lua.erb'
    mode 0644
  end
else
  template '/etc/lsyncd/lsyncd.conf.lua' do
    source 'lsyncd.conf.lua.erb'
    mode 0644
  end
end

node['lsyncd']['targets'].each do |target|
  next if target['name'].nil?
  lsyncd_target target['name'] do
    target.each_key do |attr|
      send(attr, target[attr]) if target[attr]
    end
    notifies :restart, 'service[lsyncd]', :delayed
  end
end

service 'lsyncd' do
  action [:enable, :start]
  ignore_failure true
end
