ward
====

Its a demo app for server monitoring, using a monitor web interface and a agent running on the monitored instance


Setup
-----

The setup is really easy and is done like a normal rails app.

#### Run bundle install

``$
bundle
``

#### Configure the application

``$
cp config/mongoid{.sample,}.yml
cp config/secrets{.sample,}.yml
``

> If you need to change the mongo db or port you can do so by:

``$
vi config/mongoid.yml
``

#### Run the migrations and load seed data

> There a no migrations tu run as this project uses MongoDB as its data store.

#### Start the server

``$
rails s
``


Tests
-----

As stated above the testing is done using rspec, to run all the suite execute:

``$
rspec
``


Supported Platforms
-------------------

This app has been tested on:

* MRI 2.2.3


License
-------

MIT License. Copyright 2016 Adrian Gomez (https://github.com/adrian-gomez)