require "rdiscount"
require "fileutils"
require "guider/inline_tags"

module Guider
  class Guide
    def initialize(cfg)
      @cfg = cfg
      @markdown = IO.read(@cfg[:path]+"/README.md")
    end

    def write(path)
      html = RDiscount.new(@markdown).to_html
      html = InlineTags.replace(html)
      guide_path = path + "/" + @cfg[:name]
      FileUtils.mkdir(guide_path)
      File.open(guide_path+"/index.html", 'w') {|f| f.write(html) }
    end
  end
end
