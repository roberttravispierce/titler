# ![titler-icon](https://user-images.githubusercontent.com/1078402/27513069-a1b89f32-591e-11e7-8e82-07f991b07b31.png) Titler

[![Build Status](https://travis-ci.org/roberttravispierce/titler.svg?branch=master)](https://travis-ci.org/roberttravispierce/titler)
[![Code Climate](https://codeclimate.com/github/roberttravispierce/titler/badges/gpa.svg)](https://codeclimate.com/github/roberttravispierce/titler)
[![Coverage Status](https://coveralls.io/repos/github/roberttravispierce/titler/badge.svg?branch=master)](https://coveralls.io/github/roberttravispierce/titler?branch=master)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)
[![Gem Version](https://badge.fury.io/rb/titler.svg)](https://badge.fury.io/rb/titler)

1. [What is it?](#overview)
2. [How do I get up and running?](#starting)
3. [How do I use it?](#details)
4. [How do I customize it?](#customize)
4. [So why the fuss about titles anyway?](#why)
5. [Who built this?](#attribution)
6. [How can I help improve it?](#contributing)

## <a name="overview"></a>What is it?

Titler is a ruby gem that automaticaly gives you useful and consistent page titles for your Rails application.

![titler-string-elements](https://user-images.githubusercontent.com/1078402/27513269-9194340c-5925-11e7-8e7c-726a2d45e041.png)

There are lots of options and configurations available, all with sensible fallbacks and defaults, including reading from your i18n files. See the [How do I use it?](#how-do-i-use-it?) section for more information.

## <a name="starting"></a>How do I get up and running?

1. Install the titler gem to your Gemfile and install it:
```ruby
gem 'titler'
```
```console
$ bundle install
```

2. Change the title tag in your application layout(s) to:

  *app/views/layouts/application.html.erb*
  ```html
  <title><%= titler %></title>
  ```

3. Set specific page titles as desired in your controllers or views:
```ruby
# Example of setting the title in a controller method:
helpers.page_title "Legal and Privacy Notices"
```
```ruby
# Example of setting the title in a view (haml version):
= page_title "Legal and Privacy Notices"
```

This will get you basic, consistent page titles. You can further customize universal and specific page title behavior. See the [How do I use it?](#usage) section.

## <a name="details"></a>How do I use it?

![titler-string-elements](https://user-images.githubusercontent.com/1078402/27513269-9194340c-5925-11e7-8e7c-726a2d45e041.png)

With Titler, a page title consists of the following elements:

### Environment Prefix (env_prefix)
- A one letter prefix in parentheses showing the rails environment. Example "(D) Title here..."  for Development environment, or "(S) Title here..." for Staging environment. **This aids in quickly scanning and locating browser tabs during development and testing**. It is omitted for production environments.

### Admin Namespace (admin_namespace)
- The title will be prefixed with "Admin" (admin_namespace i18n value) if the page controller is within an Admin namespace.

### Element Delimiter (delimiter)
- Elements within the built title string will be delimited by this string. Developer can set it in the i18n file. The default is " - "

### Title Body (title_body)
This is the core of the individual page title, which is set by the developer throughout their app. In order of preference:

- content_for :page_title if found
- @page_title instance variable if found
- The Controller and Action (method) name is used if none of the above are found

### App Tagline (app_tagline)
This allows for an additional marketing tagline to be in every title. Set in the "app_tagline" i18n value and ignored if not found.

### App Name (app_name)

- The built title string is appended with the name of the application. This is set in the "app_name" i18n value. Default fallback is the Rails.application.class name.

### _Examples_

- (D) Privacy Policy | Mom App
- About - Best App for Busy Moms - Mom App
- (S) Admin - User Profile - Mom App
- Recipe of the Week / Best App for Busy Mom's / Mom App
- Mom App | Posts Index


### _Demonstration App with Live Versions_

![titler_demo_app2](https://user-images.githubusercontent.com/1078402/28021216-c65b61be-654c-11e7-883a-e0dced0fa1c3.png)

There is a [titler_demo](https://github.com/roberttravispierce/titler_demo) demonstration app that shows how the titler gem works in a Rails app in many of the different combinations & situations. You can view live versions of it here:

- In a Staging Environment: https://titler-demo-staging.herokuapp.com/
- In a Production Environment: https://titler-demo-production.herokuapp.com/

## <a name="customize"></a>How do I customize it?


Customize titler settings for your app by running the generator:
```console
rails generate titler:install
```
This will generate two files to give you customization options (see the [titler_demo](https://github.com/roberttravispierce/titler_demo) demonstration app for an example):

*app/config/locales/titler.en.yml*
```yaml
---
en:
  titler:
    app_name: 'App Name'
    app_tagline: 'Your tagline'
    delimiter: ' | '
```

*app/config/initializers/titler.rb*
```ruby
Titler.configure do |config|
  # See titler gem README.md (https://github.com/roberttravispierce/titler)
  # for details on these configuration options. Uncomment and change to use:
  #
  # config.use_env_prefix = true
  # config.delimiter = ' - '
  # config.app_name_position = 'append' # append, prepend, none
  # config.use_app_tagline = true
  # config.admin_name = 'Admin'
  # config.admin_controller = AdminController
end
```

### Configuration options

- **use_env_prefix** (Default = 'true')

  Toggle use of the env_prefix. Note the prefix will never be use in a production environment no matter what the setting.

- **delimiter** (Default = ' - ')

  Change the character delimiter between elements. Be sure to include any spaces you desire.

- **app_name_position** (Default = 'append')

  Adjust how the app name is used. Options are 'append', 'prepend', or 'none'

- **use_app_tagline** (Default = 'true')

  Toggle use of marketing tagline. Position is right before an appended app_name or right after a prepended app_name.

- **admin_name** (Default = 'Admin')

  Change the text to add to the title if an admin controller is being used

- **admin_controller** (Default = 'AdminController')

  Class name of controller to trigger addition of 'admin_name' in title

## <a name="why"></a>So why the fuss about titles anyway?

Here are some resources to learn more about the importance of thoughtful, well-crafted page titles:

- [Title Tags Guide \| Good & Bad Examples \| Search Engine Watch](https://searchenginewatch.com/2016/05/16/how-to-write-meta-title-tags-for-seo-with-good-and-bad-examples/#checklist)
- [9 Best Practices Title Tag Search Engine Optimization \- SEO](http://searchengineland.com/nine-best-practices-for-optimized-title-tags-111979)
- [Writing HTML Title Tags For Humans, Google & Bing](http://searchengineland.com/writing-html-title-tags-humans-google-bing-59384)

## <a name="attribution"></a>Who built this?

Titler was conceived and developed by Robert Travis Pierce ([roberttravispierce](https://github.com/roberttravispierce)), to scratch his own itch and further his education in Ruby and Rails.

Invaluable guidance and encouragement was provided along the way by Jonathan Allured ([jonallured](https://github.com/jonallured)). Thank you Jon, for agreeing to be a mentor and give back to the community.

In addition, the [title gem](https://github.com/calebthompson/title) by [calebthompson](https://github.com/calebthompson), helped greatly with figuring out how to structure the gem as a rails engine, and served as a guide for several improvements.

## <a name="contributing"></a>How can I help improve it?

Please feel free to contribute any suggestions, improvements or refactors. This is an exercise in ruby education for me and an attempt to add something of value to the community.

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

### Future Improvements

- Implement configuration and generator. The components are mostly there already. Just need to hook it all up correctly.
- Have i18n template installed locally by a generator.
- Improve test coverage and scheme
- Implement the more robust controller/action fallback ideas from the [title gem](https://github.com/calebthompson/title)

### Developing locally

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
