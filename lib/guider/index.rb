require 'guider/template'
require 'guider/config'
require 'guider/search'
require 'guider/analytics'

module Guider
  class Index
    def initialize(options)
      @options = options
      @config = Config.new(@options[:index])
      @tpl = Template.new(@options[:tpl_dir] + "/index.html")
    end

    def write
      html = @tpl.apply({
        :title => @options[:title],
        :footer => @options[:footer],
        :content => @config.to_html,
        :search => Search.to_html(@options[:search]),
        :search => Analytics.to_html(@options[:analytics]),
      })
      File.open(@options[:output] + "/index.html", 'w') {|f| f.write(html) }
    end

  end
end
