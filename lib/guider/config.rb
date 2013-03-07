require "json"

module Guider
  # Reads the guides config file
  class Config
    def initialize(path)
      @groups = JSON.parse(IO.read(path))

      # add :path fields to the configs of all the guides
      base_path = File.dirname(path)
      each_guide do |guide|
        keys_to_symbols(guide)
        guide[:path] = base_path + "/guides/" + guide[:name]
      end
    end

    # Invokes given block with the config of each guide
    def each_guide
      @groups.each do |group|
        group["items"].each {|guide| yield guide }
      end
    end

    # Turns all string keys in Hash into symbols
    def keys_to_symbols(hash)
      hash.keys.each do |k|
        hash[k.to_sym] = hash[k]
        hash.delete(k)
      end
    end
  end
end
