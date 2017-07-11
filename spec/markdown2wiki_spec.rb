require "spec_helper"

RSpec.describe Markdown2wiki do
  it "has a version number" do
    expect(Markdown2wiki::VERSION).not_to be nil
  end

  it "convert strong tag" do
    expect("**Alex** is **awesome**".markdown_to_wiki).to eq("*Alex* is *awesome*")
  end

  it "convert italic tag" do
    expect("*Alex* is *awesome*".markdown_to_wiki).to eq("_Alex_ is _awesome_")
  end

  it "convert heading tag" do
    expect("# Alex is awesome\n\n".markdown_to_wiki).to eq("h1. Alex is awesome\n\n")
    expect("## Alex is awesome\n\n".markdown_to_wiki).to eq("h2. Alex is awesome\n\n")
  end

  it "convert alternative heading tag" do
    markdown = <<-eos
Hello
=====

How are you?
------------

eos

    wiki = <<-eos
h1. Hello

h2. How are you?

eos
    expect(markdown.markdown_to_wiki).to eq(wiki)
  end

  it "convert inline code" do
    expect("Alex is `awesome`".markdown_to_wiki).to eq("Alex is @awesome@")
  end

  it "convert block code with `" do
    markdown = <<-eos
Hello

```ruby
puts "hello"
```
eos

    wiki = <<-eos
Hello

<pre><code class="ruby">
puts "hello"
</code></pre>
eos
    expect(markdown.markdown_to_wiki).to eq(wiki)
  end

  it "convert block code with ~" do
    markdown = <<-eos
Hello

~~~ruby
puts "hello"
~~~
eos

    wiki = <<-eos
Hello

<pre><code class="ruby">
puts "hello"
</code></pre>
eos
    expect(markdown.markdown_to_wiki).to eq(wiki)
  end

  it "convert unsorted list" do
    markdown = <<-eos
- pommes
- pêches
- poires
eos

    wiki = <<-eos
* pommes
* pêches
* poires
eos
    expect(markdown.markdown_to_wiki).to eq(wiki)
  end

  it "convert sorted list" do
    markdown = <<-eos
1. pommes
2. pêches
3. poires
eos

    wiki = <<-eos
# pommes
# pêches
# poires
eos

    expect(markdown.markdown_to_wiki).to eq(wiki)
  end

  it "convert strikethrough" do
    expect("Alex is ~awesome~".markdown_to_wiki).to eq("Alex is -awesome-")
  end

  it "convert link" do
    expect("I'm [Alex](https://rousseau-alexandre.fr)".markdown_to_wiki).to eq("I'm \"Alex\":https://rousseau-alexandre.fr")
  end

  it "convert markdown" do
    markdown        = "Hello, [Markdown2Wiki](https://github.com/madeindjs/markdown2wiki) is ~good~ **anwesome** *(and it's written in `Ruby`)*."
    expected_result = "Hello, \"Markdown2Wiki\":https://github.com/madeindjs/markdown2wiki is -good- *anwesome* _(and it's written in @Ruby@)_."
    expect(markdown.markdown_to_wiki).to eq(expected_result)
  end

  it "not convert in code tag" do
    markdown = <<-eos

```ruby
require "markdown2wiki"

markdown = "Hello, [Markdown2Wiki](https://github.com/madeindjs/markdown2wiki) is ~good~ **anwesome** *(and it's written in `Ruby`)*."
puts markdown.markdown_to_wiki
# => Hello, "Markdown2Wiki":https://github.com/madeindjs/markdown2wiki is -good- *anwesome* _(and it's written in @Ruby@)_.
```
eos

    wiki = <<-eos
<pre><code class="ruby">
require "markdown2wiki"

markdown = "Hello, [Markdown2Wiki](https://github.com/madeindjs/markdown2wiki) is ~good~ **anwesome** *(and it's written in `Ruby`)*."
puts markdown.markdown_to_wiki
# => Hello, "Markdown2Wiki":https://github.com/madeindjs/markdown2wiki is -good- *anwesome* _(and it's written in @Ruby@)_.
</code></pre>
eos
    expect(markdown.markdown_to_wiki).to eq(wiki)
  end

  it "convert big markdown tag" do
    markdown = <<-eos
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

TODO
----

- Add command line tool
eos

    wiki = <<-eos
h1. Markdown2Wiki

A simple Monkey patch of @String@ to convert *Markdown* to *Wiki*.


h2. Instalation

Add this line to your application's Gemfile:

<pre><code class="ruby">
gem 'recipe_crawler'
</code></pre>

And then execute:

<pre><code class="bash">
$ bundle
</code></pre>

Or install it yourself as:

<pre><code class="bash">
$ gem install recipe_crawler
</code></pre>


h2. Usage

<pre><code class="ruby">
require "markdown2wiki"

markdown = "Hello, [Markdown2Wiki](https://github.com/madeindjs/markdown2wiki) is ~good~ **anwesome** *(and it's written in `Ruby`)*."
puts markdown.markdown_to_wiki
# => Hello, "Markdown2Wiki":https://github.com/madeindjs/markdown2wiki is -good- *anwesome* _(and it's written in @Ruby@)_.
</code></pre>

h2. TODO

* Add command line tool
eos
    expect(markdown.markdown_to_wiki).to eq(wiki)
  end


end
