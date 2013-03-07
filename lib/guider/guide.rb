require "rdiscount"
require "fileutils"

module Guider
  class Guide
    def initialize(cfg)
      @cfg = cfg
      @markdown = IO.read(@cfg[:path]+"/README.md")
    end

    def write(path)
      html = RDiscount.new(@markdown).to_html
      guide_path = path + "/" + @cfg[:name]
      FileUtils.mkdir(guide_path)
      File.open(guide_path+"/index.html", 'w') {|f| f.write(html) }
    end
  end
end
