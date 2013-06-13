# <a name="title"></a> Razor Chef Cookbook

[![Build Status](https://travis-ci.org/bbg-cookbooks/razor.png?branch=master)](https://travis-ci.org/bbg-cookbooks/razor)

* Website: http://bbg-cookbooks.github.io/razor
* Opscode Community Site: http://community.opscode.com/cookbooks/razor
* Source Code: https://github.com/bbg-cookbooks/razor

## <a name="description"></a> Description

Chef cookbook to install and manage [Razor][razor_site], a power control,
provisioning, and management application designed to deploy both bare-metal
and virtual computer resources. An LWRP is provided to manage OS and
micro kernel images.

## <a name="usage"></a> Usage

Include `recipe[razor]` in your run\_list to install the Razor service and its
dependencies. If you wish to modify or alter the details of the installation
(i.e. using a different mongodb cookbook, installing nodejs from source, etc.),
then compose a custom run\_list of the child recipes described
[below](#recipes).

## <a name="requirements"></a> Requirements

### <a name="requirements-chef"></a> Chef

Tested on 10.14.4 and 11.2 but newer and older version should work just fine. File an
[issue][issues] if this isn't the case.

### <a name="requirements-platform"></a> Platform

The following platforms have been tested with this cookbook, meaning that the
recipes run on these platforms without error:

* ubuntu (10.04/12.04/12.10)

### <a name="requirements-cookbooks"></a> Cookbooks

This cookbook depends on the following external cookbooks:

* [build-essential][build_essential_cb]
* [git][git_cb]
* [tftp][tftp_cb]
* [mongodb][mongodb_cb]
* [postgresql][postgresql_cb]
* [nodejs][nodejs_cb]

## <a name="installation"></a> Installation

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release
is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

### <a name="installation-community"></a> From the Opscode Community Site

To install this cookbook from the Opscode Community Site, use the *knife*
command:

    knife cookbook site install razor

### <a name="installation-berkshelf"></a> Using Berkshelf

[Berkshelf][berkshelf] is a cookbook dependency manager and development
workflow assistant. To install Berkshelf:

    cd chef-repo
    gem install berkshelf
    berks init

To use the Opscode Community Site version:

    echo "cookbook 'razor'" >> Berksfile
    berks install

Or to reference the GitHub version:

    repo="bbg-cookbooks/razor"
    latest_release=$(curl -s https://api.github.com/repos/$repo/git/refs/tags \
    | ruby -rjson -e '
      j = JSON.parse(STDIN.read);
      puts j.map { |t| t["ref"].split("/").last }.sort.last
    ')
    cat >> Berksfile <<END_OF_BERKSFILE
    cookbook 'razor',
      :git => 'git://github.com/$repo.git', :branch => '$latest_release'
    END_OF_BERKSFILE
    berks install

### <a name="installation-librarian"></a> Using Librarian-Chef

[Librarian-Chef][librarian] is a bundler for your Chef cookbooks.
To install Librarian-Chef:

    cd chef-repo
    gem install librarian
    librarian-chef init

To use the Opscode Community Site version:

    echo "cookbook 'razor'" >> Cheffile
    librarian-chef install

Or to reference the GitHub version:

    repo="bbg-cookbooks/razor"
    latest_release=$(curl -s https://api.github.com/repos/$repo/git/refs/tags \
    | ruby -rjson -e '
      j = JSON.parse(STDIN.read);
      puts j.map { |t| t["ref"].split("/").last }.sort.last
    ')
    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'razor',
      :git => 'git://github.com/$repo.git', :ref => '$latest_release'
    END_OF_CHEFFILE
    librarian-chef install

## <a name="recipes"></a> Recipes

### <a name="recipes-default"></a> default

Installs the full Razor stack with all dependencies.

Most users will want to use this recipe.

### <a name="recipes-tftp"></a> \_tftp

Installs a tftp server. This recipe is included in the
[default](#recipes-default) recipe.

### <a name="recipes-tftp-files"></a> \_tftp_files

Installs files and configuration needed for PXE booting and Razor
bootstraping. This recipe is included in the [default](#recipes-default)
recipe.

### <a name="recipes-mongodb"></a> \_mongodb

Installs a MongoDB server (from packages) if the `"mongo"` persistance mode is
selected and the `mongo/local_server` attribute is set to a truthy value
(otherwise the recipe is effectively skipped). This recipe is included in the
[default](#recipes-default) recipe.

### <a name="recipes-postgresql"></a> \_postgresql

Installs a PostgreSQL server if the `"postgres"` persistent mode is selected
and the `postgres/local_server` attribute is set to a truthy value. Otherwise
the PostgreSQL client libraries are installed.  This recipe is included in the
[default](#recipes-default) recipe.

### <a name="recipes-nodejs"></a> \_nodejs

Installs Node.js and npm (from packages). This recipe is included in the
[default](#recipes-default) recipe.

### <a name="recipes-ruby-from-package"></a> \_ruby_from_package

Installs Ruby (from system packages) and the Bundler gem. This recipe is
included in the [default](#recipes-default) recipe.

### <a name="recipes-rubygems-from-source"></a> \_rubygems_from_source

Installs Rubygems from source on older Debian/Ubuntu platforms that ship a
crippled Rubygems package. This recipe is included in the
[ruby_from_package](#recipes-ruby-from-package) recipe and will only be used
on Ubuntu 10.04 nodes.

### <a name="recipes-app"></a> \_app

Installs and configures the Razor codebase and service. This recipe is
included in the [default](#recipes-default) recipe.

### <a name="recipes-add-images"></a> \_add_images

Installs images in the Razor service (driven off the `images` attribute). This
recipe is included in the [default](#recipes-default) recipe.

## <a name="attributes"></a> Attributes

### <a name="attributes-bind-address"></a> bind_address

IP address to which the Razor web services are bound.

The default is set to `node['ipaddress']`.

### <a name="attributes-checkin-interval"></a> checkin_interval

The micro kernel checkin interval in seconds.

The default is `60`.

### <a name="attributes-persist-mode"></a> persist_mode

The persistence mode that Razor will use. Currently the two supported values are `"mongo"` and `"postgres"`.

The default is `"mongo"`.

**Note:** The is some upstream Razor code changes needed to support PostgreSQL
authentication via a username and password. In the meantime, your mileage may
vary when using the `"postgres"` persistence mode.

### <a name="attributes-persist-host"></a> persist_host

The hostname or IP adrress of the persistence service.

The default is `"127.0.0.1"`.

### <a name="attributes-persist-port"></a> persist_port

The port number of the persistence service.

The default depends on which [persist_mode](#attributes-persist-mode) is
selected:

* `"mongo"`: the value set will be the value of `node['mongodb']['port']` if
  set and falling back to `27017`.
* `"postgres"`: the value set will be the value of
  `node['postgresql']['config']['port']` if set and falling back to `5432`.

### <a name="attributes-persist-username"></a> persist_username

The username used when authenticating to the persistence service.

The default depends on which [persist_mode](#attributes-persist-mode) is
selected:

* `"mongo"`: a value is not set as the default localhost server does not
  require authentication.
* `"postgres"`: defaults to `"razor"`.

### <a name="attributes-persist-password"></a> persist_password

The password used when authenticating to the persistence service.

The default depends on which [persist_mode](#attributes-persist-mode) is
selected:

* `"mongo"`: a value is not set as the default localhost server does not
  require authentication.
* `"postgres"`: defaults to `"project_razor"`.

**Note** do not rely on a default password if at all possible. Securing your
persistence serivce with adequate password strength is your responsibility.

### <a name="attributes-persist-timeout"></a> persist_timeout

The connection timeout (in secondss) used when communicating with the
persistence service.

The default is `10`.

### <a name="attributes-mongo-local-server"></a> mongo/local_server

Whether or not to install a local MongoDB server on this node. If you want
Razor to use an external MongoDB server then set this value to something
"untruthy" such as `false` or `nil`.

The default depends on which [persist_mode](#attributes-persist-mode) is
selected:

* `"mongo"`: defaults to `true`.
* `"postgres"`: defaults to `false`.

### <a name="attributes-postgres-local-server"></a> postgres/local_server

Whether or not to install a local PostgreSQL server on this node. If you want
Razor to use an external PostgreSQL server then set this value to something
"untruthy" such as `false` or `nil`.

The default depends on which [persist_mode](#attributes-persist-mode) is
selected:

* `"mongo"`: defaults to `false`.
* `"postgres"`: defaults to `true`.

### <a name="attributes-images"></a> images

A Hash of Razor images to be added. The hash key will correspond to the image
`name` attribute and the value will be a hash of other attributes to be fed
to the [razor_image](#lwrps-image) LWRP. For example:

    node['razor']['images'] = {
      'razor-mk' => {
        'type'    => 'mk',
        'url'     => 'http://fdqn.com/razor-mk.iso',
        'action'  => 'add'
      },
      'precise64' => {
        'url'       => 'http://example.com/precise64.iso',
        'checksum'  => 'abcabc...',
        'version'   => '12.04'
      }
    }

The default is an empty hash: `Hash.new`.

### <a name="attributes-ruby-system-packages"></a> ruby_system_packages

An Array of system packages which will install the Ruby runtime. The
defaults are set automatically based on platform and platform\_version but
can be overridden in needed.

### <a name="attributes-npm-packages"></a> npm_packages

An Array of npm packages to be installed. The defaults are set automatically
but can be overridden in needed.

### <a name="attributes-install-path"></a> install_path

The install base path of the Razor codebase.

The default is `"/opt/razor"`.

### <a name="attributes-bundle-cmd"></a> bundle_cmd

The bundle command which will be used to install Ruby gems.

The default is `"bundle"` (using `$PATH` lookup).

### <a name="attributes-npm-cmd"></a> npm_cmd

The npm command which will be used to install npm packages.

The default is `"npm"` (using `$PATH` lookup).

### <a name="attributes-app-git-url"></a> app/git_url

The Git URL for the Razor codebase.

The default is `"https://github.com/puppetlabs/Razor.git"`.

### <a name="attributes-app-git-rev"></a> app/git_rev

The Git reference/branch to check out.

The default is `"0.9.0"`. Valid values could be Git SHA hashes, branch names,
and `"master"` for tracking development.

### <a name="attributes-rubygems-source-version"></a> rubygems_source/version

The version of Rubygems to be compiled (when necessary).

The default is `"1.8.24"`.

### <a name="attributes-rubygems-source-url"></a> rubygems_source/url

The URL containing Rubygems source which will be compiled (when necessary).

The default is set based on the Rubygems version attribute above.

### <a name="attributes-mongodb-address"></a> \[deprecated\] mongodb_address

IP address which has a running MongoDB service.

The default is `"127.0.0.1"`.

**Note** this value will set the [persist_host](#attributes-persist-host)
attribute for backwards compatibility. This attribute will be removed in a 1.0
release so please migrate to using `persist_host`.

## <a name="lwrps"></a> Resources and Providers

### <a name="lwrps-image"></a> razor_image

#### <a name="lwrps-image-actions"></a> Actions

<table>
  <thead>
    <tr>
      <th>Action</th>
      <th>Description</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>add</td>
      <td>Add the microkernel or operating system image to razor.</td>
      <td>Yes</td>
    </tr>
  </tbody>
</table>

#### <a name="lwrps-image-attributes"></a> Attributes

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Default Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>name</td>
      <td>
        <b>Name attribute:</b> The logical name to use for the image.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>type</td>
      <td>
        The type of image. Valid values are <code>"mk"</code> for micro kernel
        images and <code>"os"</code> for operating system images.
      </td>
      <td><code>"os"</code></td>
    </tr>
    <tr>
      <td>url</td>
      <td>
        HTTP URL containing the image ISO.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>version</td>
      <td>
        The version to use for <code>"os"</code> images only.
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>checksum</td>
      <td>
        An optional SHA-256 checksum for the ISO (for added verification).
      </td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td>iso_path</td>
      <td>
        An optional path where the downloaded ISO image will be stored before
        being added to Razor. If no value is provided a path inside the
        <code>Chef::Config[:file_cache_path]</code> will be computed.
      </td>
      <td><code>nil</code></td>
    </tr>
  </tbody>
</table>

#### <a name="lwrps-image-examples"></a> Examples

##### Adding A Micro Kernel Image

    razor_image "rz_mk_prod-image.0.9.1.6" do
      type      "mk"
      url       "http://mirror.example.com/images/rz_mk_prod-image.0.9.1.6.iso"
      checksum  "aljdflkjflajkf..."
      action    :add
    end

    razor_image "rz_mk_prod-image.0.9.1.6" do
      type  "mk"
      url   "http://mirror.example.com/images/rz_mk_prod-image.0.9.1.6.iso"
    end

**Note:** the add action is default, so the second example is a more common
usage.

##### Adding An Operating System Image

    razor_image "precise64" do
      type      "os"
      url       "http://mirror.example.com/images/ubuntu-amd64-12.04.iso"
      checksum  "lkjdfoidadba..."
      version   "12.04"
      iso_path  "/data/razor_images"
    end

    razor_image "sl64-6.3" do
      url     "http://mirror.example.com/images/scientific-amd64-6.3.iso"
      version 6.3
    end

**Note:** the default for type is `"os"` so this can be omitted in most cases.
The version attribute can also be a Float.

## <a name="development"></a> Development

* Source hosted at [GitHub][repo]
* Report issues/Questions/Feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make.

## <a name="license"></a> License and Author

Author:: [Fletcher Nichol][fnichol] (<fnichol@nichol.ca>)

Copyright 2012, Blue Box Group, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[berkshelf]:    http://berkshelf.com/
[build_essential_cb]: http://community.opscode.com/cookbooks/build-essential
[chef_repo]:    https://github.com/opscode/chef-repo
[cheffile]:     https://github.com/applicationsonline/librarian/blob/master/lib/librarian/chef/templates/Cheffile
[git_cb]:       http://community.opscode.com/cookbooks/git
[kgc]:          https://github.com/websterclay/knife-github-cookbooks#readme
[librarian]:    https://github.com/applicationsonline/librarian#readme
[mongodb_cb]:   http://community.opscode.com/cookbooks/mongodb
[nodejs_cb]:    http://community.opscode.com/cookbooks/nodejs
[postgresql_cb]: http://community.opscode.com/cookbooks/postgresql
[razor_site]:   https://github.com/puppetlabs/Razor
[tftp_cb]:      http://community.opscode.com/cookbooks/tftp

[fnichol]:      https://github.com/fnichol
[repo]:         https://github.com/bbg-cookbooks/razor
[issues]:       https://github.com/bbg-cookbooks/razor/issues
