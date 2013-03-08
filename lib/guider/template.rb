require "json"

module Guider
  # Reads a template from file.
  # Allows replacing {placeholders} inside it.
  class Template
    def initialize(path)
      @template = IO.read(path)
    end

    # Sets the values for placeholders inside template.
    # Returns the template text with placeholders replaced.
    def apply(hash)
      @template.gsub(/\{[^\}]+\}/) do |placeholder|
        placeholder =~ /^\{(.*)\}$/
        hash[$1.to_sym]
      end
    end
  end
end
