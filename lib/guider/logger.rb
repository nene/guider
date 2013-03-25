module Guider
  class Logger
    # Turns printing of warnings on or off.
    def self.warnings=(enabled)
      @warnings = enabled
    end

    # Sets file context for warnings
    def self.context=(filename)
      @context = filename
    end

    # Prints out a warning when warnings enabled.
    def self.warn(msg)
      file = @context ? @context + ": " : ""
      $stderr.puts(file + msg) if @warnings
    end

  end
end
