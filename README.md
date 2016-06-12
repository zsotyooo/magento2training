# magento2training Setup

Please follow the below steps to get started, if you encounter any issues installing the dependencies or provisioning the vm please check the [Common Issues](#common-issues) section first.

## Clone the project

Clone the project into your local file system:

```bash
git clone git@github.com:zsotyooo/magento2training.git
```

## Install Dependencies

1. Ensure you are using a ruby managed by rbenv / RVM as system rubies can cause issues. Currently [rbenv](https://github.com/sstephenson/rbenv) is the recommended version manager.

2. Install the latest version of Vagrant from [http://www.vagrantup.com/downloads.html](http://www.vagrantup.com/downloads.html)

3. Install/Update hem:
    [https://github.com/inviqa/hem/wiki](https://github.com/inviqa/hem/wiki)


4. Ensure you have AWS keys correctly configured either using `hem config` or by setting the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.

## Provision Environment

You can now build the development environment for the first time. In the project directory, execute the following command:

    $ hem vm up

You should now be able to access the site at [http://magento2training.dev](http://magento2training.dev)

## Hem Usage

With the hem enabled environment up and running please make use of the following commands for day to day usage.

```bash
hem vm start      # Starts the vm without the overhead of provisioning
hem vm stop       # Graceful halt of the vm
hem vm ssh        # Start an SSH session on the VM
hem vm mysql      # Connect to the database on the VM
hem vm provision  # Provision your vm without rebuilding it
```

## Common Issues

As setup issues are encountered please detail with step by step fix instructions, and where possible update the project itself to provide a more permanent fix.

 - **Composer is asking for "Magento composer username" and "Magento composer password"**
   Please create an account on Magento.com and go to the my account area then you can generate one if you navigate to the secure keys menu on the connect tab.
 - **I'm a frontend developer and varnish is caching my code**
   Ask your TTL to help you to set up the following node to true then re-provision your VM:

    ```
    node['varnish']['not_cache_static_files'] = true
    ```

# License

Copyright 2016, Inviqa

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
