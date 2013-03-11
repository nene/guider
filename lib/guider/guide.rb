require "kramdown"
require "fileutils"
require "guider/inline_tags"

module Guider
  class Guide
    def initialize(cfg, tpl)
      @cfg = cfg
      @template = tpl
      @markdown = IO.read(@cfg[:path]+"/README.md")
      @html = Kramdown::Document.new(@markdown).to_html
    end

    def write(path)
      guide_path = path + "/" + @cfg[:name]
      FileUtils.mkdir(guide_path)
      write_html(guide_path+"/index.html")
      copy_images(@cfg[:path], guide_path)
    end

    def write_html(filename)
      html = InlineTags.replace(@html)
      html = @template.apply(:content => html, :title => title)
      File.open(filename, 'w') {|f| f.write(html) }
    end

    # Extracts the first line from markdown
    def title
      @markdown =~ /\A(.*?)$/
      result = $1.sub(/^#/, '').strip

      # When guide name missing, take it from config file
      if result == ""
        @cfg[:title]
      else
        result
      end
    end

    # Returns the name of a guide, for use in links
    def name
      @cfg[:name]
    end

    # Lists all h2 level headings within the guide
    def chapters
      @html.scan(/<h2[^>]*id="(\S*)"[^>]*>([^\n]*)<\/h2>/).map do |m|
        {:href => @cfg[:name] + "#" + m[0], :title => m[1]}
      end
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
