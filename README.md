Markdown2Wiki
=============

A simple Monkey patch of `String` to convert **Markdown** to **Wiki**.


Instalation
-----------

Add this line to your application's Gemfile:

```ruby
gem 'recipe_crawler'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install recipe_crawler
```


Usage
-----

```ruby
require "markdown2wiki"

markdown = "Hello, [Markdown2Wiki](https://github.com/madeindjs/markdown2wiki) is ~good~ **anwesome** *(and it's written in `Ruby`)*."
puts markdown.markdown_to_wiki
# => Hello, "Markdown2Wiki":https://github.com/madeindjs/markdown2wiki is -good- *anwesome* _(and it's written in @Ruby@)_.
```

Know bug
--------

Markdown2wiki will try t convert markdown tag in code tag. Don't hesitate to pull request on this bug.

TODO
----

- Add command line tool
