module Guider
  # Generates <script> tag for including google font.
  class Font
    def self.to_html
      <<-EOHTML
      <script type="text/javascript">
      (function(){
        var protocol = (document.location.protocol === "https:") ? "https:" : "http:";
        document.write("<link href='"+protocol+"//fonts.googleapis.com/css?family=Exo' rel='stylesheet' type='text/css' />");
      })();
      </script>
      EOHTML
    end
  end
end
