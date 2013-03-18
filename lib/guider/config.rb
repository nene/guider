require "json"

module Guider
  # Reads the guides config file.
  # Turns it into HTML table of contents.
  class Config
    def initialize(path)
      @guides = flatten(JSON.parse(IO.read(path)))
    end

    # Returns flat HTML list of guide titles.
    def to_html
      "<ul>" + @guides.map {|g| to_link(g) }.join("\n") + "</ul>"
    end

    private

    # Turns grouped guides structure into flat list.
    def flatten(group)
      arr = []
      group.each do |guide|
        if guide["items"]
          arr += flatten(guide["items"])
        else
          arr << guide
        end
      end
      arr
    end

    def to_link(guide)
      "<li><a href='#{to_href(guide)}'>#{guide['title']}</a></li>"
    end

    def to_href(guide)
      if guide['url']
        guide['url'].sub(/^guides\//)
      else
        guide['name']
      end
    end

  end
end
