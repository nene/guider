require "guider/inline_tags"

describe Guider::InlineTags do

  def replace(str)
    Guider::InlineTags.new.replace(str)
  end

  it "replaces @link to class with alt text" do
    replace("{@link Foo Bar}").should == "<a href='#!/api/Foo'>Bar</a>"
  end

  it "replaces @link to class" do
    replace("{@link Foo}").should == "<a href='#!/api/Foo'>Foo</a>"
  end

  it "replaces @link to method with alt text" do
    replace("{@link Foo#method-bar my method}").should == "<a href='#!/api/Foo-method-bar'>my method</a>"
  end

  it "replaces @link to method" do
    replace("{@link Foo#method-bar}").should == "<a href='#!/api/Foo-method-bar'>Foo.bar</a>"
  end

  it "replaces @link to static property" do
    replace("{@link Foo#static-property-bar}").should == "<a href='#!/api/Foo-static-property-bar'>Foo.bar</a>"
  end

  it "replaces @link to ambigous member with link to method" do
    replace("{@link Foo#bar}").should == "<a href='#!/api/Foo-method-bar'>Foo.bar</a>"
  end

  describe "JSDuck-style guide link" do
    it "gets replaced with relative URL" do
      replace('<a href="#!/guide/blah">blah</a>').should == "<a href='./blah'>blah</a>"
    end

    it "doesn't require !-bang" do
      replace('<a href="#/guide/blah">blah</a>').should == "<a href='./blah'>blah</a>"
    end

    it "supports multiple dirs" do
      replace('<a href="#!/guide/foo/bar/baz">blah</a>').should == "<a href='./foo/bar/baz'>blah</a>"
    end

    it "changes .md extension to .html" do
      replace('<a href="#/guide/blah.md">blah</a>').should == "<a href='./blah.html'>blah</a>"
    end

    it "changes README.md to index.html" do
      replace('<a href="#/guide/README.md">blah</a>').should == "<a href='./index.html'>blah</a>"
    end
  end
end
