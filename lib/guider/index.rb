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
      list = @guides.map {|g| "<li><a href='#{g.name}'>#{g.title}</a>#{chapters_list(g.chapters)}</li>" }.join("\n")
      "<ul>#{list}</ul>"
    end

    def chapters_list(chapters)
      return "" if chapters.length == 0

      "\n<ul>" + chapters.map {|c| "<li><a href='#{c[:href]}'>#{c[:title]}</a></li>" }.join("\n") + "</ul>\n"
    end

  end
end
