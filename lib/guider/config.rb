require "json"

module Guider
  # Reads the guides config file.
  # Turns it into HTML table of contents.
  class Config
    def initialize(path)
      @guides = JSON.parse(IO.read(path))
    end

    # Returns HTML list of guide titles.
    def to_html
      to_list(@guides)
    end

    private

    def to_list(items)
      list = []

      items.each do |guide|
        if guide["items"]
          list << "<li><span>" + guide["title"] + "</span>\n" + to_list(guide["items"]) + "</li>"
        else
          list << "<li>#{to_link(guide)}</li>"
        end
      end

      "<ul>" + list.join("\n") + "</ul>"
    end

    def to_link(guide)
      "<a href='#{to_href(guide)}'>#{guide['title']}</a>"
    end

    def to_href(guide)
      if guide['url']
        guide['url'].sub(/^guides\//, "")
      else
        guide['name']
      end
    end

  end
end
