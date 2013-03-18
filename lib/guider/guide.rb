require "kramdown"
require "pathname"

module Guider
  class Guide
    def initialize(filename, tpl, inline_tags, options)
      @template = tpl
      @inline_tags = inline_tags
      @markdown = IO.read(filename)
      @rel_path = relative_path(options[:input], filename)
      @html = Kramdown::Document.new(@markdown).to_html
    end

    def write(filename)
      html = @inline_tags.replace(@html)
      html = @template.apply({
          :content => html,
          :title => title,
          :path => @rel_path,
        })
      File.open(filename, 'w') {|f| f.write(html) }
    end

    def relative_path(filename, base_dir)
      Pathname.new(filename).relative_path_from(Pathname.new(base_dir)).dirname
    end

    # Extracts the first line from markdown
    def title
      @markdown =~ /\A(.*?)$/
      result = $1.sub(/^#/, '').strip

      return (result == "") ? "Untitled" : result
    end

    # Lists all h2 level headings within the guide
    def chapters
      @html.scan(/<h2[^>]*id="(\S*)"[^>]*>([^\n]*)<\/h2>/).map do |m|
        {:href => @cfg[:name] + "#" + m[0], :title => m[1]}
      end
    end

  end
end
