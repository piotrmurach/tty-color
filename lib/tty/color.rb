# encoding: utf-8

require 'tty/color/mode'

module TTY
  # Responsible for checking terminal color support
  #
  # @api public
  module Color
    extend self

    NoValue = Module.new

    @verbose = false

    @output = $stderr

    attr_accessor :output, :verbose

    # Detect if terminal supports color
    #
    # @return [Boolean]
    #   true when terminal supports color, false otherwise
    #
    # @api public
    def supports?
      return false unless tty?

      value = false
      %w(from_curses from_tput from_term from_env).each do |from_check|
        break if (value = public_send(from_check)) != NoValue
      end
      return false if value == NoValue
      value
    end
    alias_method :color?, :supports?
    alias_method :supports_color?, :supports?

    # Attempt to load curses to check color support
    #
    # @return [Boolean]
    #
    # @api private
    def from_curses(curses_class = nil)
      require 'curses'

      if defined?(Curses)
        curses_class ||= Curses
        curses_class.init_screen
        has_color = curses_class.has_colors?
        curses_class.close_screen
        has_color
      else
        NoValue
      end
    rescue LoadError
      warn 'no native curses support' if verbose
      NoValue
    end

    # Shell out to tput to check color support
    #
    # @api private
    def from_tput
      %x(tput colors 2>/dev/null).to_i > 2
    rescue Errno::ENOENT
      NoValue
    end

    # Inspect environment $TERM variable for color support
    #
    # @api private
    def from_term
      if ENV['TERM'] == 'dumb'
        false
      elsif ENV['TERM'] =~ /^screen|^xterm|^vt100|color|ansi|cygwin|linux/i
        true
      else NoValue
      end
    end

    # @api private
    def from_env
      ENV.include?('COLORTERM')
    end

    # @api public
    def mode
      Mode.new.mode
    end

    # TERM environment variable
    #
    # @api public
    def term
      ENV['TERM']
    end

    # @api private
    def tty?
      output.tty?
    end
  end # Color
end # TTY
