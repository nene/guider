require "json"
require "guider/guide"

module Guider
  # Reads the guides config file.
  # Turns it into list Guide instances accessible through .guides attribute.
  class Config
    def initialize(path, tpl, inline_tags)
      guide_cfgs = flatten(JSON.parse(IO.read(path)))
      guide_cfgs.each {|g| keys_to_symbols(g) }
      guide_cfgs.each {|g| add_path(g, path) }
      @guides = to_guides(guide_cfgs, tpl, inline_tags)
    end

    # List of Guide instances.
    attr_reader :guides

    private

    # Turns grouped guides structure into flat list.
    def flatten(groups)
      arr = []
      groups.each do |group|
        group["items"].each {|guide| arr << guide }
      end
      arr
    end

    # Turns all string keys in Hash into symbols
    def keys_to_symbols(hash)
      hash.keys.each do |k|
        hash[k.to_sym] = hash[k]
        hash.delete(k)
      end
      hash
    end

    # adds :path fields to the configs of all the guides
    def add_path(guide, path)
      guide[:path] = File.dirname(path) + "/guides/" + guide[:name]
    end

    # Turns guide configs to actual Guide instances
    def to_guides(guide_cfgs, tpl, inline_tags)
      guide_cfgs.find_all {|g| File.exists?(g[:path]) }.map {|g| Guide.new(g, tpl, inline_tags) }
    end

  end
end
