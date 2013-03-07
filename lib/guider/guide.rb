require "rdiscount"

module Guider
  class Guide
    def initialize(cfg)
      @cfg = cfg
      @markdown = IO.read(@cfg[:path]+"/README.md")
    end

    def write(path)
      html = RDiscount.new(@markdown).to_html
      File.open(path+"/#{@cfg[:name]}.html", 'w') {|f| f.write(html) }
    end
  end
end
