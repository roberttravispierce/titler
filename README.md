# ![titler-icon](https://user-images.githubusercontent.com/1078402/27513069-a1b89f32-591e-11e7-8e82-07f991b07b31.png) Titler

  _NOTE: Titler is not ready for use yet; in case you stumbled across this somehow. I expect to have it working as a useable gem by the end of July (2017). &mdash;RTP_

[![Build Status](https://travis-ci.org/roberttravispierce/titler.svg?branch=master)](https://travis-ci.org/roberttravispierce/titler)
[![Code Climate](https://codeclimate.com/github/roberttravispierce/titler/badges/gpa.svg)](https://codeclimate.com/github/roberttravispierce/titler)

1. [What is it?](#what-is-it?)
2. [How do I get up and running quickly?](#quick-start)
3. [How do I use it?](#usage)
4. [So why the fuss about titles anyway?](#so-why-the-fuss-about-titles-anyway?)
5. [Who built this?](#who-built-thi?)
6. [How can I help improve it?](#how-can-i-help-improve-it?)

## What is it?

Titler is a ruby gem that automaticaly gives you useful and consistent page titles for your Rails application.

## How do I get up and running quickly?

1. Install the titler gem in your app:
```ruby
gem 'titler' # Add this to your Gemfile
$ bundle install # Run in your terminal
```

2. Run the generator:
```ruby
$ rails generate titler:install
```

3. Add the set_titler before_action to your application controller:
```ruby
# app/controller/application_controller.rb
class ApplicationController < ActionController::Base
    before_action :set_titler
    ...
```

4. Change your application layout title tag to:
```ruby
# app/views/layouts/application.html.erb
<title><%= titler.set(content_for(:titler)) %></title>
```

5. Set specific page titles you may need in your controller or view:
```ruby
# set title in controller method
titler.set("Legal and Privacy Notices")
# set title in view (haml)
= content_for :titler, "Post - #{@course.title}"
```

This will get you basic, consistent page titles. You can further customize universal and specific page title behavior. See the [How do I use it?](#usage) section.

## How do I use it?

![titler-string-elements](https://user-images.githubusercontent.com/1078402/27513269-9194340c-5925-11e7-8e7c-726a2d45e041.png)

With Titler, a page title consists of the following elements:

### Environment Prefix
(env_prefix)
- A one letter prefix in parentheses showing the rails environment. Example "(D) Title here..."  for Development environment, or "(S) Title here..." for Staging environment. This aids in quickly scanning and locating browser tabs during development and testing. It is omitted for production environments.

### Admin Namespace
(admin_namespace)
- The title will be prefixed with "Admin" (admin_namespace i18n value) if the page controller is within an Admin namespace.

### Element Delimiter
(delimiter)
- Elements within the built title string will be delimited by this string. Developer can set it in the i18n file. The default is " - "

### Title Body
(title_body)

This is the core of the individual page title, which is set by the developer throughout their app. In order of preference:

- content_for :page_title if found
- @page_title instance variable if found
- The Controller and Action (method) name is used if none of the above are found

### App Tagline
(app_tagline)

This allows for an additional marketing tagline to be in every title. Set in the "app_tagline" i18n value and ignored if not found.

### App Name
(app_name)

- The built title string is appended with the name of the application. This is set in the "app_name" i18n value. Default fallback is the Rails.application.class name.

### _Examples_

- (D) Privacy Policy | Mom App
- About - Best App for Busy Moms - Mom App
- (S) Admin - User Profile - Mom App
- Recipe of the Week / Best App for Busy Mom's / Mom App
- Mom App | Posts Index


### Demonstration App with Live Versions

{{Insert screenshot of app}}

There is a [titler_demo](https://github.com/roberttravispierce/titler_demo) demonstration app that shows how the titler gem works in a Rails app in many of the different combinations & situations. You can view live versions of it here:

- In a Staging Environment: https://titler-demo-staging.herokuapp.com/
- In a Production Environment: https://titler-demo-production.herokuapp.com/

## So why the fuss about titles anyway?

Here are some resources to learn more about the importance of well-crafted and consistent page titles:

-

## Who built this?

Titler was conceived and developed by Robert Pierce ([roberttravispierce](https://github.com/roberttravispierce)), to scratch his own itch and further his education in Ruby and Rails. He received invaluable guidance and encouragment along the way from Jonathan Allured ([jonallured](https://github.com/jonallured)). Thank you Jon, for agreeing to be a mentor and give back to the community.

## How can I help improve it?

Bug reports and pull requests are welcome on GitHub at https://github.com/roberttravispierce/titler.

Here's the most direct way to get your work merged into the project.

- Fork the project
- Clone down your fork
- Create a feature branch
- Hack away and add tests, not necessarily in that order
- Make sure everything still passes by running tests
- If necessary, rebase your commits into logical chunks without errors
- Push the branch up to your fork
- Send a pull request for your branch

### Developing locally

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
