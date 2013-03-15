require "guider/inline_tags"

describe Guider::InlineTags do

  def replace(str)
    Guider::InlineTags.new.replace(str)
  end

  it "replaces @link to class" do
    replace("{@link Foo Bar}").should == "<a href='#!/api/Foo'>Bar</a>"
  end

end
