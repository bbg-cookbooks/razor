# <a name="title"></a> chef-razor

## <a name="description"></a> Description

...coming soon...

## <a name="usage"></a> Usage

...coming soon...

## <a name="requirements"></a> Requirements

### <a name="requirements-chef"></a> Chef

Tested on 10.12.0 but newer and older version should work just fine. File an
[issue][issues] if this isn't the case.

### <a name="requirements-platform"></a> Platform

The following platforms have been tested with this cookbook, meaning that the
recipes run on these platforms without error:

* ubuntu (10.04/12.04)

### <a name="requirements-cookbooks"></a> Cookbooks

This cookbook depends on the following external cookbooks:

* [build-essential][build_essential_cb]
* [git][git_cb]
* [mongodb][mongodb_cb]
* [nodejs][nodejs_cb]

## <a name="installation"></a> Installation

Depending on the situation and use case there are several ways to install
this cookbook. All the methods listed below assume a tagged version release
is the target, but omit the tags to get the head of development. A valid
Chef repository structure like the [Opscode repo][chef_repo] is also assumed.

### <a name="installation-librarian"></a> Using Librarian-Chef

[Librarian-Chef][librarian] is a bundler for your Chef cookbooks.
Include a reference to the cookbook in a [Cheffile][cheffile] and run
`librarian-chef install`. To install Librarian-Chef:

    gem install librarian
    cd chef-repo
    librarian-chef init

To use the Opscode platform version:

    echo "cookbook 'razor'" >> Cheffile
    librarian-chef install

Or to reference the Git version:

    cat >> Cheffile <<END_OF_CHEFFILE
    cookbook 'razor',
      :git => 'git://github.com/fnichol/chef-user.git', :ref => 'v0.1.0'
    END_OF_CHEFFILE
    librarian-chef install

### <a name="installation-kgc"></a> Using knife-github-cookbooks

The [knife-github-cookbooks][kgc] gem is a plugin for *knife* that supports
installing cookbooks directly from a GitHub repository. To install with the
plugin:

    gem install knife-github-cookbooks
    cd chef-repo
    knife cookbook github install fnichol/chef-razor/v0.1.0

### <a name="installation-gitsubmodule"></a> As a Git Submodule

A common practice (which is getting dated) is to add cookbooks as Git
submodules. This is accomplishes like so:

    cd chef-repo
    git submodule add git://github.com/fnichol/chef-razor.git cookbooks/razor
    git submodule init && git submodule update

**Note:** the head of development will be linked here, not a tagged release.

### <a name="installation-tarball"></a> As a Tarball

If the cookbook needs to downloaded temporarily just to be uploaded to a Chef
Server or Opscode Hosted Chef, then a tarball installation might fit the bill:

    cd chef-repo/cookbooks
    curl -Ls https://github.com/fnichol/chef-razor/tarball/v0.1.0 | tar xfz - && \
      mv fnichol-chef-razor-* razor

### <a name="installation-platform"></a> From the Opscode Community Platform

...coming soon...


## <a name="recipes"></a> Recipes

### <a name="recipes-default"></a> default



### <a name="recipes-mongodb"></a> mongodb



### <a name="recipes-nodejs"></a> nodejs



### <a name="recipes-ruby-from-package"></a> ruby-from-package



### <a name="recipes-app"></a> app



## <a name="attributes"></a> Attributes

### <a name="attributes-ruby-system-packages"></a> ruby_system_packages



### <a name="attributes-npm-packages"></a> npm_packages



### <a name="attributes-install-path"></a> install_path



### <a name="attributes-bundle-cmd"></a> bundle_cmd



### <a name="attributes-npm-cmd"></a> npm_cmd



### <a name="attributes-app-git-url"></a> app/git_url



### <a name="attributes-app-git-rev"></a> app/git_rev



### <a name="attributes-rubygems-source-version"></a> rubygems_source/version



### <a name="attributes-rubygems-source-url"></a> rubygems_source/url



## <a name="lwrps"></a> Resources and Providers

There are **no** resources and providers in this cookbook.

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

[build_essential_cb]: http://community.opscode.com/cookbooks/build-essential
[chef_repo]:    https://github.com/opscode/chef-repo
[cheffile]:     https://github.com/applicationsonline/librarian/blob/master/lib/librarian/chef/templates/Cheffile
[git_cb]:       http://community.opscode.com/cookbooks/git
[kgc]:          https://github.com/websterclay/knife-github-cookbooks#readme
[librarian]:    https://github.com/applicationsonline/librarian#readme
[mongodb_cb]:   http://community.opscode.com/cookbooks/mongodb
[nodejs_cb]:    http://community.opscode.com/cookbooks/nodejs

[fnichol]:      https://github.com/fnichol
[repo]:         https://github.com/fnichol/chef-user
[issues]:       https://github.com/fnichol/chef-user/issues
