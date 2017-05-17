require "spec_helper"

RSpec.describe Markdown2wiki do
  it "has a version number" do
    expect(Markdown2wiki::VERSION).not_to be nil
  end

  it "convert markdown" do
    markdown        = "Hello, [Markdown2Wiki](https://github.com/madeindjs/markdown2wiki) is ~good~ **anwesome** *(and it's written in `Ruby`)*"
    expected_result = "Hello, [Markdown2Wiki](https://github.com/madeindjs/markdown2wiki) is ~good~ *anwesome* _(and it's written in @Ruby@)_"
    expect(markdown.markdown_to_wiki).to eq(expected_result)
  end


end
