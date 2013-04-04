module Guider
  # Generates HTML for Like-buttons of various social services.
  class Social
    # Given array of social button type names, returns HTML for
    # rendering all these buttons.
    def self.to_html(types)
      types.map {|t| send(t) }.compact.join("\n")
    end

    # Returns array of supported social button types
    def self.supported_types
      [:google, :twitter, :facebook]
    end

    def self.google
      <<-EOHTML
      <div class="g-plusone" data-annotation="none"></div>
      <script type="text/javascript">
        (function() {
          var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
          po.src = 'https://apis.google.com/js/plusone.js';
          var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
        })();
      </script>
      EOHTML
    end

    def self.twitter
      <<-EOHTML
      <a href="https://twitter.com/share" class="twitter-share-button">Tweet</a>
      <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
      EOHTML
    end

    def self.facebook
      <<-EOHTML
      <div id="fb-root"></div>
      <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/et_EE/all.js#xfbml=1";
        fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk'));</script>
      <div class="fb-like" data-send="false" data-layout="button_count" data-width="450" data-show-faces="true"></div>
      EOHTML
    end
  end
end
