# frozen_string_literal: true

RSpec.describe TTY::Color::Mode, "detecting mode" do
  it "isn't terminal" do
    allow(TTY::Color).to receive(:tty?).and_return(false)
    mode = described_class.new({})
    expect(mode.mode).to eq(0)
  end

  it "cannot find from term, tput " do
    allow(TTY::Color).to receive(:tty?).and_return(true)
    mode = described_class.new({})
    allow(mode).to receive(:from_term).and_return(TTY::Color::NoValue)
    allow(mode).to receive(:from_tput).and_return(TTY::Color::NoValue)

    expect(mode.mode).to eq(8)
    expect(mode).to have_received(:from_term).ordered
    expect(mode).to have_received(:from_tput).ordered
  end

  it "detects color mode" do
    allow(TTY::Color).to receive(:tty?).and_return(true)
    mode = described_class.new("TERM" => "xterm-256color")

    expect(mode.mode).to eq(256)
  end

  context "#from_term" do
    {
      "xterm+direct" => 16777216,
      "vscode-direct" => 16777216,
      "xterm-256color" => 256,
      "alacritty" => 256,
      "mintty" => 256,
      "ms-terminal" => 256,
      "nsterm" => 256,
      "nsterm-build400" => 256,
      "terminator" => 256,
      "vscode" => 256,
      "iTerm.app" => 256,
      "iTerm 2.app" => 256,
      "amiga-8bit" => 256,
      "wy370-105k" => 64,
      "d430-unix-ccc" => 52,
      "d430c-unix-s-ccc" => 52,
      "nsterm-bce" => 16,
      "d430c-dg" => 16,
      "d430-unix-w" => 16,
      "konsole-vt100" => 8,
      "xnuppc+basic" => 8,
      "dummy" => 0
    }.each do |term_name, number|
      it "infers #{term_name.inspect} to have #{number} colors" do
        mode = described_class.new("TERM" => term_name)
        expect(mode.from_term).to eq(number)
      end
    end

    it "doesn't match any term variable" do
      mode = described_class.new({})
      expect(mode.from_term).to eq(TTY::Color::NoValue)
    end
  end

  context "#from_tput" do
    it "fails to find tput utilty" do
      mode = described_class.new({})
      cmd = "tput colors"
      allow(TTY::Color).to receive(:command?).with(cmd).and_return(nil)
      expect(mode.from_tput).to eq(TTY::Color::NoValue)
    end
  end
end
