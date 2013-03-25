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
      re = /\{@link\s+([^\s\}]*)(?:\s+([^\}]*))?}/
      html.gsub!(re) do |m|
        m =~ re # re-run regex to extract $1 $2 fields
        ref = $1
        alt = $2

        cls, mref = ref.split('#')
        if mref
          apiref = [cls, "method", mref].join("-")
        else
          apiref = cls
        end

        url = @link_url + "#!/api/" + apiref
        "<a href='#{url}'>#{alt || ref}</a>"
      end
    end

    def replace_img!(html)
      re = /\{@img\s+([^\s\}]*)(?:\s+([^\}]*))?}/
      html.gsub!(re) do |m|
        m =~ re # re-run regex to extract $1 $2 fields
        ref = $1
        alt = $2
        "<img src='#{ref}' alt='#{alt}'>"
      end
    end

    def replace_old_guide_links!(html)
      re = /<a href="#!?\/guide\/(\w+)">/
      html.gsub!(re) do |m|
        m =~ re # re-run regex to extract guide name
        name = $1
        "<a href='../#{name}'>"
      end
    end

  end
end
