require 'guider/template'
require 'guider/social'
require 'guider/search'
require 'guider/analytics'
require 'guider/prettify'
require 'guider/font'

module Guider
  # Initializes the common Guider template placeholders with default
  # values generated from Guider options.
  class DefaultTemplate < Template
    def initialize(path, options)
      super(path, {
        :title => options[:title],
        :footer => options[:footer],
        :search => Social.to_html(options[:social]),
        :search => Search.to_html(options[:search]),
        :analytics => Analytics.to_html(options[:analytics]),
        :prettify => Prettify.to_html,
        :font => Font.to_html,
      })
    end
  end
end
