require "spec_helper"

RSpec.describe Markdown2wiki do
  it "has a version number" do
    expect(Markdown2wiki::VERSION).not_to be nil
  end

  it "convert strong tag" do
    expect("Alex **is** awesome".markdown_to_wiki).to eq("Alex *is* awesome")
  end

  it "convert italic tag" do
    expect("Alex *is* awesome".markdown_to_wiki).to eq("Alex _is_ awesome")
  end

  it "convert heading tag" do
    expect("# Alex is awesome\n\n".markdown_to_wiki).to eq("h1. Alex is awesome\n\n")
    expect("## Alex is awesome\n\n".markdown_to_wiki).to eq("h2. Alex is awesome\n\n")
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
    markdown        = "Hello, [Markdown2Wiki](https://github.com/madeindjs/markdown2wiki) is ~good~ **anwesome** *(and it's written in `Ruby`)*"
    expected_result = "Hello, \"Markdown2Wiki\":https://github.com/madeindjs/markdown2wiki is -good- *anwesome* _(and it's written in @Ruby@)_"
    expect(markdown.markdown_to_wiki).to eq(expected_result)
  end


end
