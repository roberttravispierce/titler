# ![titler-icon](https://user-images.githubusercontent.com/1078402/27513069-a1b89f32-591e-11e7-8e82-07f991b07b31.png) Titler

[![Build Status](https://travis-ci.org/roberttravispierce/titler.svg?branch=master)](https://travis-ci.org/roberttravispierce/titler)
[![Code Climate](https://codeclimate.com/github/roberttravispierce/titler/badges/gpa.svg)](https://codeclimate.com/github/roberttravispierce/titler)
[![Coverage Status](https://coveralls.io/repos/github/roberttravispierce/titler/badge.svg?branch=master)](https://coveralls.io/github/roberttravispierce/titler?branch=master)

![Titler is not quite ready for use yet; in case you stumbled across this somehow. Coming soon! —RTP](http://messages.hellobits.com/warning.svg?message=Titler%20is%20not%20quite%20ready%20for%20use%20yet%3B%20in%20case%20you%20stumbled%20across%20this%20somehow.%20Coming%20Soon!%20%E2%80%94RTP)

1. [What is it?](#what-is-it?)
2. [How do I get up and running?](#how-do-i-get-up-and-running?)
3. [How do I use it?](#how-do-i-use-it?)
4. [So why the fuss about titles anyway?](#so-why-the-fuss-about-titles-anyway?)
5. [Who built this?](#who-built-this?)
6. [How can I help improve it?](#how-can-i-help-improve-it?)

## What is it?

Titler is a ruby gem that automaticaly gives you useful and consistent page titles for your Rails application.

![titler-string-elements](https://user-images.githubusercontent.com/1078402/27513269-9194340c-5925-11e7-8e7c-726a2d45e041.png)

There are lots of options and configurations available, all with sensible fallbacks and defaults, including reading from your i18n files. See the [How do I use it?](#how-do-i-use-it?) section for more information.

## How do I get up and running?

1. Install the titler gem to your Gemfile and install it:
```ruby
gem 'titler'
```
```console
$ bundle install
```

2. {Not Yet Implemented} Run the generator. This will create an initializer with config values and an i18n file:
```console
$ rails generate titler:install
```

3. Add the page_title and set_page_title helper methods to your application helper:

  *app/helpers/application_helper.rb*
  ```ruby
  module ApplicationHelper

  def page_title(page_title)
    content_for(:page_title) {page_title}
  end

  def set_page_title
    Titler::Title.new(controller: self, i18n: I18n, title_as_set: content_for(:page_title) || @page_title).title
  end
  ...
  ```

4. Change your application layout title tag to:

  *app/views/layouts/application.html.erb*
  ```html
  <title><%= set_page_title %></title>
  ```

5. Set specific page titles as desired in your controllers or views:
```ruby
# Example of setting the title in a controller method:
helpers.page_title "Legal and Privacy Notices"
```
```ruby
# Example of setting the title in a view (haml version):
= page_title "Legal and Privacy Notices"
```

This will get you basic, consistent page titles. You can further customize universal and specific page title behavior. See the [How do I use it?](#usage) section.

## How do I use it?

![titler-string-elements](https://user-images.githubusercontent.com/1078402/27513269-9194340c-5925-11e7-8e7c-726a2d45e041.png)

With Titler, a page title consists of the following elements:

### Environment Prefix
(env_prefix)
- A one letter prefix in parentheses showing the rails environment. Example "(D) Title here..."  for Development environment, or "(S) Title here..." for Staging environment. **This aids in quickly scanning and locating browser tabs during development and testing**. It is omitted for production environments.

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
