# lfs_modder

Module loader for debian system

Usage of this Cookbook

Pass modules for load or remove in arrays, like the examples below.

node.default['modules']['load'] = ['drbd', 'bridge', 'ipmi_devintf', 'bonding', '8021q']
node.default['modules']['remove'] = ['ipmi_si']

Place these in your cookbook.

  ```
node['modules']['load'].each do |mod|
  modder mod do
    action :load
  end
end
  ```
  ```
node['modules']['remove'].each do |mod|
  modder mod do
    action :remove
  end
end
```
Unkown modules will be ignored.
