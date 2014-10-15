A repo to show my students how to build a client and test an api.
This was an ad-hoc after-class lesson, took us about an hour to go through,
so some things might be a bit rough.

1. Run `bundle install` to install the versions I used when making this (use `gem install bundler` if you don't have a `bundle` command)
1. Run `bundle exec ruby make_db.rb` to make the database
1. Run `bundle exec ruby seeds.rb` to seed some data into the database.
1. Run `bundle exec rackup config.ru` to start the server
1. Direct your web browser to [http://localhost:9292/users/1](http://localhost:9292/users/1) to see what the api returns.
1. Run `bundle exec rspec` to run the client spec.

Key ideas
=========

We want to know our api works. We also want to know our client works. And we want to know that our API and our client match up.
This approach uses rack-test to test the client directly against the application. This will work fine on any rack app, for example,
to get it working on Rails, you would just change the way we wire up the rack session to use `Rails.application` instead of `App`.

To use the same client in production, we just swap out the `Client::Internet::Rack` with `Client::Internet::RestClient` (you can
make one to wrap whatever your favourite way of talking to the internet is, e.g. `Faraday` or even `Net::Http` to avoid the dependency).

Disadvantages: These are very large coarse tests, they require loading of the entire app,
there are many reasons they can break, and they offer little feedback when they are wrong.
Find the tradeoff that's right for you. Me, I'm super apprehensive about whether my client and API
match up, so I like that this is an integration test that gives me a lot more confidence.

Also note that this does not specify the api at all. So you cannot learn about or ensure the api works by using these tests.
This is a drawback if you want your api to be consumed by many different clients, you will probably need other tests directly
on the api itself, to make sure it is specified and your app is meeting your specification. But it has a lot of advantage
in the early stages of a SOA, because as long as everything works, these tests have very little reason to change.
You can move endpoints (ie we might move this endpoint behind an `/api` namespace),
change formats (we're using json here, but if you change the format to XML or something, and update the client,
you won't have to touch the tests), add keys, etc. Tests still pass if client and api match up, no changes necessary.
This is nice because it means everything still works, while still allowing for a high degree of volatility.

Explore
=======

Our example is very simple, we don't have a users index or anything exposing posts.
If you'd like to play with it yourself, try exposing some of this data.

License
=======

<a href="http://www.wtfpl.net/"><img src="http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl.svg" height="20" alt="WTFPL" /></a>

    Copyright (C) 2014 Josh Cheek <josh.cheek@gmail.com>

    This program is free software. It comes without any warranty,
    to the extent permitted by applicable law.
    You can redistribute it and/or modify it under the terms of the
    Do What The Fuck You Want To Public License,
    Version 2, as published by Sam Hocevar.
    See http://www.wtfpl.net/ for more details.
