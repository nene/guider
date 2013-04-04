module Guider
  # Reads a template from file.
  # Allows replacing {placeholders} inside it.
  class Template
    # Takes path to the template and an optional defaults hash mapping
    # placeholders to values.  These are the default values for
    # placeholders for which no value is given in the hash passed to
    # #apply method.
    def initialize(path, defaults={})
      @template = IO.read(path)
      @defaults = defaults
    end

    # Sets the values for placeholders inside template.
    # Returns the template text with placeholders replaced.
    def apply(hash)
      hash = @defaults.merge(hash)
      @template.gsub(/\{\w+\}/) do |placeholder|
        placeholder =~ /\{(.*)\}/
        hash[$1.to_sym]
      end
    end
  end
end
