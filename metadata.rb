name 'minio-server'
maintainer 'Takaaki Furukawa'
maintainer_email 'takaaki.frkw@gmail.com'
license 'MIT'
description 'Installs/Configures Minio'
long_description 'Installs/Configures Minio'
version '0.1.1'
chef_version '>= 12.14' if respond_to?(:chef_version)

supports 'redhat', '>= 7.0'
supports 'centos', '>= 7.0'

issues_url 'https://github.com/tkak/minio-server-cookbook/issues'
source_url 'https://github.com/tkak/minio-server-cookbook'
