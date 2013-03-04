require "rdiscount"

module Guider
  class Guide
    def initialize(path)
      @markdown = IO.read(path+"/README.md")
    end

    def write(path)
      html = RDiscount.new(@markdown).to_html
      File.open(path+"/README.html", 'w') {|f| f.write(html) }
    end
  end
end
