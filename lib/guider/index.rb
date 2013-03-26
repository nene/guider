require 'guider/template'
require 'guider/config'

module Guider
  class Index
    def initialize(options)
      @options = options
      @config = Config.new(@options[:index])
      @tpl = Template.new(@options[:tpl_dir] + "/index.html")
    end

    def write
      html = @tpl.apply(:title => @options[:title], :content => @config.to_html)
      File.open(@options[:output] + "/index.html", 'w') {|f| f.write(html) }
    end

  end
end
