# encoding: utf-8

module TTY
  module Color
    class Mode
      # Detect supported colors
      #
      # @return [Integer]
      #   out of 0, 8, 16, 52, 64, 256
      #
      # @api public
      def mode
        return 0 unless TTY::Color.tty?

        value = 8
        %w(from_tput from_term).each do |from_check|
          break if (value = public_send(from_check)) != NoValue
        end
        return 8 if value == NoValue
        value
      end

      # Check TERM environment for colors
      #
      # @return [NoValue, Integer]
      #
      # @api private
      def from_term
        case TTY::Color.term
        when /[\-\+](\d+)color/ then $1.to_i
        when /[\-\+](\d+)bit/   then 2 ** $1.to_i
        when /wy370-|hpterm-color/ then 64
        when /d430.*?[\-\+](dg|unix).*?[\-\+]ccc/ then 52
        when /d430.*?[^c]{3}/ then 16
        when /vt100/ then 8
        when /dummy/ then 0
        else NoValue
        end
      end

      # Shell out to tput to check color support
      #
      # @return [NoValue, Integer]
      #
      # @api private
      def from_tput
        colors = %x(tput colors 2>/dev/null).to_i
        colors >= 8 ? colors : NoValue
      rescue Errno::ENOENT
        NoValue
      end
    end # Mode
  end # Color
end # TTY
