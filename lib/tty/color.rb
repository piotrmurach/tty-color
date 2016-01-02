# encoding: utf-8

require 'tty/color/support'
require 'tty/color/mode'
require 'tty/color/version'

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

    def supports?
      Support.new.supports?
    end
    alias_method :color?, :supports?
    alias_method :supports_color?, :supports?

    # Check how many colors this terminal supports
    #
    # @return [Integer]
    #
    # @api public
    def mode
      Mode.new(ENV).mode
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
