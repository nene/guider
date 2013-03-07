require "guider/inline_tags"

describe Guider::InlineTags do

  def replace(str)
    Guider::InlineTags.replace(str)
  end

  it "replaces @link to class" do
    replace("{@link Foo Bar}").should == "<a href='http://docs.sencha.com/ext-js/4-1/#!/api/Foo'>Bar</a>"
  end

end
