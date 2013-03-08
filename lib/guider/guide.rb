require "kramdown"
require "fileutils"
require "guider/inline_tags"

module Guider
  class Guide
    def initialize(cfg, tpl)
      @cfg = cfg
      @template = tpl
      @markdown = IO.read(@cfg[:path]+"/README.md")
    end

    def write(path)
      guide_path = path + "/" + @cfg[:name]
      FileUtils.mkdir(guide_path)
      write_html(guide_path+"/index.html")
      copy_images(@cfg[:path], guide_path)
    end

    def write_html(filename)
      html = Kramdown::Document.new(@markdown).to_html
      html = InlineTags.replace(html)
      html = @template.apply(:content => html, :title => get_title)
      File.open(filename, 'w') {|f| f.write(html) }
    end

    # Extracts the first line from markdown
    def get_title
      @markdown =~ /\A(.*?)$/
      $1.sub(/^#/, '').strip
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
