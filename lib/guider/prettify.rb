module Guider
  # Generates <script> tag for syntax-highlighting code blocks.
  class Prettify
    def self.to_html
      <<-EOHTML
      <script type="text/javascript">
      (function(){
        var pres = document.getElementsByTagName("pre");
        for (var len=pres.length, i=0; i < len; i++) {
          var code = pres[i].getElementsByTagName("code")[0];
          if (code) code.className = "prettyprint";
        }
        prettyPrint();
      })();
      </script>
      EOHTML
    end
  end
end
