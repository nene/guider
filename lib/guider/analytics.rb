module Guider
  # Generates HTML for Google Analytics.
  class Analytics
    # Given the ID of Google analytics tracker, returns the tracker
    # script.  Returns empty string when no ID given.
    def self.to_html(id)
      return "" unless id

      <<-EOHTML
      <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', '#{id}']);
        _gaq.push(['_trackPageview']);
        (function() {
          var ga = document.createElement('script');
          ga.type = 'text/javascript';
          ga.async = true;
          ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') +
            '.google-analytics.com/ga.js';
          var s = document.getElementsByTagName('script')[0];
          s.parentNode.insertBefore(ga, s);
        })();
      </script>
      EOHTML
    end
  end
end
