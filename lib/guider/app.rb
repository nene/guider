require "fileutils"
require "guider/guide_factory"

module Guider
  class App
    def initialize(options)
      @options = options
      @guide_factory = Guider::GuideFactory.new(@options)
    end

    def run
      # clean output dir
      FileUtils.rm_rf(@options[:output])

      copy_dir(@options[:input], @options[:output])

      copy_template_files
    end

    private

    # Copies all files and directories in source dir over to
    # destination dir.  Processes all .md files.
    def copy_dir(src, dest)
      FileUtils.mkdir(dest)

      Dir[src+"/*"].each do |filename|
        target = dest+"/"+File.basename(filename)

        if filename =~ /\/README\.md$/
          @guide_factory.create(filename).write(target.sub(/\/README\.md$/, "/index.html"))
        elsif filename =~ /\.md$/
          @guide_factory.create(filename).write(target.sub(/.md$/, ".html"))
        elsif File.directory?(filename)
          copy_dir(filename, target)
        else
          FileUtils.cp_r(filename, target)
        end
      end
    end

    # Copies over main template resources
    def copy_template_files
      Dir[@options[:tpl_dir]+"/*.{js,css,ico}"].each do |fname|
        FileUtils.cp(fname, @options[:output])
      end
    end
  end
end
