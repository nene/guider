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
end
