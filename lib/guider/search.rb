module Guider
  # Generates HTML for Google search.
  class Search
    # Given the ID of custom google search engine, returns the script
    # for generating the search box.  Returns empty string when no ID
    # given.
    def self.to_html(id)
      return "" unless id

      <<-EOHTML
      <script>
      (function() {
        var cx = '#{id}';
        var gcse = document.createElement('script');
        gcse.type = 'text/javascript';
        gcse.async = true;
        gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
            '//www.google.com/cse/cse.js?cx=' + cx;
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(gcse, s);
      })();
      </script>
      <gcse:searchbox-only></gcse:searchbox-only>
      EOHTML
    end
  end
end
