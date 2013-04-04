require "kramdown"
require "pathname"
require "guider/logger"
require "guider/social"
require "guider/search"
require "guider/analytics"

module Guider
  class Guide
    def initialize(filename, tpl, inline_tags, options)
      @template = tpl
      @inline_tags = inline_tags
      @input_filename = filename
      @options = options
      @markdown = IO.read(filename)
      @rel_path = relative_path(options[:input], filename)
      @html = Kramdown::Document.new(@markdown).to_html
    end

    def write(filename)
      Logger.context = @input_filename
      @inline_tags.base_url = @rel_path
      html = @inline_tags.replace(@html)
      html = @template.apply({
          :content => html,
          :title => @options[:title],
          :footer => @options[:footer],
          :guide_name => guide_name,
          :path => @rel_path,
          :social => Social.to_html(@options[:social]),
          :search => Search.to_html(@options[:search]),
          :analytics => Search.to_html(@options[:analytics]),
        })
      File.open(filename, 'w') {|f| f.write(html) }
    end

    def relative_path(filename, base_dir)
      Pathname.new(filename).relative_path_from(Pathname.new(base_dir)).dirname
    end

    # Extracts the first line from markdown
    def guide_name
      @markdown =~ /\A(.*?)$/
      result = $1.sub(/^#/, '').strip

      return (result == "") ? "Untitled" : result
    end

    # Lists all h2 level headings within the guide
    #
    # XXX: Currently this is dead code.
    def toc
      @html.scan(/<h2[^>]*id="(\S*)"[^>]*>([^\n]*)<\/h2>/).map do |m|
        {:href => "#" + m[0], :title => m[1]}
      end
    end

  end
end
