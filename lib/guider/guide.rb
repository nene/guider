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
      guide_path = path + "/" + @cfg[:name]
      FileUtils.mkdir(guide_path)
      write_html(guide_path+"/index.html")
      copy_images(@cfg[:path], guide_path)
    end

    def write_html(filename)
      html = RDiscount.new(@markdown).to_html
      html = InlineTags.replace(html)
      File.open(filename, 'w') {|f| f.write(html) }
    end

    def copy_images(src, dest)
      Dir[src+"/**/*.{png,jpg,jpeg,gif}"].each do |img|
        if !["icon.png", "icon-lg.png"].include?(File.basename(img))
          FileUtils.cp(img, dest+"/"+File.basename(img))
        end
      end
    end
  end
end
