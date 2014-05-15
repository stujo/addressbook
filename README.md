README
====================

This sample app demonstrates Form objects and ActiveRecord::Relations

![CodeShip](https://www.codeship.io/projects/b2e134d0-b9c1-0131-5ab2-4202456fde48/status)

#Basic Auth

The following ENV parameters are used to support basic auth on the website, you'll be prompted
for a username and password on your heroku app, you'll need to match these values to proceed
leaving them blank will make your app easy to access.

* AUTH_USERNAME=SomeString
* AUTH_PASSWORD=AnotherString

#Installation

In order to send messages you'll need a gmail account and to configure these environment variables

* GMAIL_USERNAME=
* GMAIL_PASSWORD=


#For Sidekiq Email Delivery

##Redis
A local Redis server needs to be running:

```
$ redis-server /usr/local/etc/redis.conf
```

[18994] 15 May 11:32:59.684 # Server started, Redis version 2.8.9
[18994] 15 May 11:32:59.685 * DB loaded from disk: 0.001 seconds
[18994] 15 May 11:32:59.685 * The server is now ready to accept connections on port 6379

##Sidekiq
A local sidekiq server needs to be running

```
$ bundle exec sidekiq
```

##How it works

Following this tutorial:

[http://blog.remarkablelabs.com/2013/01/using-sidekiq-to-send-emails-asynchronously](http://blog.remarkablelabs.com/2013/01/using-sidekiq-to-send-emails-asynchronously)


Instead of

```
    ContactMailer.send_message(self).deliver
```

We use:

```
    @message_status = ContactMailer.delay.send_message(self)
```

This returns immediately and hopefully sidekiq will do the job :)

