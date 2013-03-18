require "guider/template"
require "guider/inline_tags"
require "guider/guide"

module Guider
  # Creates Guide instances
  class GuideFactory
    def initialize(options)
      # Configure {@link} tags.
      @inline_tags = InlineTags.new
      @inline_tags.link_url = options[:link_url]

      # Create guide rendering template
      @tpl = Template.new(options[:tpl_dir] + "/guide.html")

      @options = options
    end

    # Creates new Guide instance from filename
    def create(filename)
      Guide.new(filename, @tpl, @inline_tags, @options)
    end

  end
end
