require "kramdown"
require "fileutils"
require "guider/inline_tags"

module Guider
  class Index
    def initialize(guides, tpl)
      @guides = guides
      @template = tpl
    end

    def write(path)
      html = @template.apply(:title => "Guides", :content => guide_list)
      File.open(path + "/index.html", 'w') {|f| f.write(html) }
    end

    private

    def guide_list
      list = @guides.map do |g|
        "<li><a href='#{g.name}'>#{g.title}</a></li>"
      end.join("\n")
      "<ul>#{list}</ul>"
    end

  end
end
