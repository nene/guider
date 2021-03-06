require 'guider/default_template'
require 'guider/config'

module Guider
  class Index
    def initialize(options)
      @options = options
      @config = Config.new(@options[:index])
      @tpl = DefaultTemplate.new(@options[:tpl_dir] + "/index.html", @options)
    end

    def write
      html = @tpl.apply({
        :content => @config.to_html,
      })
      File.open(@options[:output] + "/index.html", 'w') {|f| f.write(html) }
    end

  end
end
