module Guider
  class InlineTags
    # The base URL for links created by {@link} tags.
    attr_accessor :link_url

    def initialize
      @link_url = ""
    end

    def replace(html)
      replace_link!(html)
      replace_img!(html)
      replace_old_guide_links!(html)
      html
    end

    private

    def replace_link!(html)
      replace!(html, /\{@link\s+([^\s\}]*)(?:\s+([^\}]*))?}/) do |ref, alt|
        cls, mref = ref.split(/#/)
        if mref
          api_ref = [cls, mref].join("-")
          api_alt = [cls, mref.split(/-/).last].join(".")
        else
          api_ref = cls
          api_alt = cls
        end

        url = @link_url + "#!/api/" + api_ref
        "<a href='#{url}'>#{alt || api_alt}</a>"
      end
    end

    def replace_img!(html)
      replace!(html, /\{@img\s+([^\s\}]*)(?:\s+([^\}]*))?}/) do |ref, alt|
        "<img src='#{ref}' alt='#{alt}'>"
      end
    end

    def replace_old_guide_links!(html)
      replace!(html, /<a href="#!?\/guide\/(\w+)">/) do |name|
        "<a href='../#{name}'>"
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
