name             'cloudcafe'
maintainer       "Rackspace US, Inc"
license          "Apache 2.0"
description      'Installs/Configures cloudcafe'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ amazon centos debian fedora oracle redhat scientific ubuntu }.each do |os|
  supports os
end

%w{ git python }.each do |dep|
  depends dep
end

recipe "devstack::default",
  "Clones the devstack repo and installs the configured stack"

attribute "devstack/host-ip",
  :description => "The host/ip to bind the stack to",
  :default => "198.101.10.10"

