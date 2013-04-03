require 'guider/logger'

module Guider
  class InlineTags
    # The base URL for links created by {@link} tags.
    attr_accessor :link_url
    # The base URL for referencing guides from root dir.
    attr_accessor :base_url

    def initialize
      @link_url = ""
      @base_url = "."
    end

    def replace(html)
      replace_link!(html)
      replace_img!(html)
      replace_old_guide_links!(html)
      html
    end

    private

    def replace_link!(html)
      replace!(html, /\{@link\s+([^\s\}]*)(?:\s+([^\}]*))?\}/) do |ref, alt|
        cls, mref = ref.split(/#/)
        if mref
          parts = mref.split(/-/)

          if parts.length < 2
            Logger.warn("Ambiguous member reference: #{cls}##{mref}")
            # Default unqualified member references to method
            mref = "method-" + mref
          end

          api_ref = [cls, mref].join("-")
          api_alt = [cls, parts.last].join(".")
        else
          api_ref = cls
          api_alt = cls
        end

        url = @link_url + "#!/api/" + api_ref
        "<a href='#{url}'>#{alt || api_alt}</a>"
      end
    end

    def replace_img!(html)
      replace!(html, /\{@img\s+([^\s\}]*)(?:\s+([^\}]*))?\}/) do |ref, alt|
        "<img src='#{ref}' alt='#{alt}'>"
      end
    end

    def replace_old_guide_links!(html)
      replace!(html, /<a href="#!?\/guide\/([^"]+)">/) do |name|
        # Transform links to .md files into .html file links
        name.sub!(/README\.md$/, "index.html")
        name.sub!(/\.md$/, ".html")

        "<a href='#{@base_url}/#{name}'>"
      end
    end

    # Helper method to easily do a regex-replace with a block where
    # the block gets called with a list of all the captured strings.
    # The normal String#gsub! method only passes the full match to the
    # block, so we have to do some tedious extra work to extract the
    # actual captures.
    def replace!(string, re, &block)
      string.gsub!(re) do |m|
        captures = re.match(m)[1..-1]
        block.call(*captures)
      end
    end

  end
end
