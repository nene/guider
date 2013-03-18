require "guider/template"
require "guider/inline_tags"
require "guider/guide"

module Guider
  # Creates Guide instances
  class GuideFactory
    def initialize(options)
      # Configure {@link} tags.
      @inline_tags = Guider::InlineTags.new
      @inline_tags.link_url = options[:link_url]

      # Create guide rendering template
      @tpl = Guider::Template.new(options[:tpl_dir] + "/guide.html")
    end

    # Creates new Guide instance from filename
    def create(filename)
      Guide.new(filename, @tpl, @inline_tags)
    end
  end
end
