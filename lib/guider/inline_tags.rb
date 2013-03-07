module Guider
  class InlineTags
    def self.replace(html)
      re = /\{@link\s+(\S*)(?:\s+([^\}]*))}/
      html.gsub(re) do |m|
        m =~ re # re-run regex to extract $1 $2 fields
        ref = $1
        alt = $2

        cls, mref = ref.split('#')
        if mref
          apiref = [cls, "method", mref].join("-")
        else
          apiref = cls
        end

        url = "http://docs.sencha.com/ext-js/4-1/#!/api/" + apiref
        "<a href='#{url}'>#{alt || ref}</a>"
      end
    end
  end
end
