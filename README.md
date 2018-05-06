# minio-server cookbook

[![CircleCI](https://circleci.com/gh/tkak/minio-server-cookbook/tree/master.svg?style=svg)](https://circleci.com/gh/tkak/minio-server-cookbook/tree/master)
[![Chef cookbook](https://img.shields.io/cookbook/v/minio-server.svg)](https://supermarket.chef.io/cookbooks/minio-server)

Installs minio and sets up configuration.

## Requirements

### Cookbooks

None

### Platforms

The following platforms are supported and tested with Test Kitchen:

* CentOS 7+

### Chef

* Chef 12.17+

## Attributes

* `node['minio']['volume_path']` - Location of volume. Default: `/data`
* `node['minio']['volumes']` - Array of node configuration. Default: `['/data']`
* `node['minio']['opts']` - Minio option parameter. Default: `--address :9000`
* `node['minio']['access_key']` - Access key of the server. Default: `nil`
* `node['minio']['secret_key']` - Secret key of the server. Default: `nil`
* `node['minio']['user']` - User of the server. Default: `root`
* `node['minio']['group']` - Group of the server. Default: `root`

## Recipes

### default

Installs and configures minio.

## License & Author

This project is licensed under the MIT license by Takaaki Furukawa (takaaki.frkw@gmail.com).

