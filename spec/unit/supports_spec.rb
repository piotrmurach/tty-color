# encoding: utf-8

RSpec.describe TTY::Color::Support, '#supports?' do
  it "doesn't check color support for non tty terminal" do
    support = described_class.new({})
    allow(TTY::Color).to receive(:tty?).and_return(false)
    expect(support.supports?).to eq(false)
  end

  it "fails to find out color support" do
    support = described_class.new({})
    allow(TTY::Color).to receive(:tty?).and_return(true)

    allow(support).to receive(:from_curses).and_return(TTY::Color::NoValue)
    allow(support).to receive(:from_tput).and_return(TTY::Color::NoValue)
    allow(support).to receive(:from_term).and_return(TTY::Color::NoValue)
    allow(support).to receive(:from_env).and_return(TTY::Color::NoValue)

    expect(support.supports?).to eq(false)

    expect(support).to have_received(:from_term).ordered
    expect(support).to have_received(:from_tput).ordered
    expect(support).to have_received(:from_env).ordered
    expect(support).to have_received(:from_curses).ordered
  end

  it "fails to load curses for color support" do
    support = described_class.new({})
    allow(support).to receive(:require).with('curses').
      and_raise(LoadError)
    allow(support).to receive(:warn)

    expect(support.from_curses).to eq(TTY::Color::NoValue)
    expect(support).to_not have_received(:warn)
  end

  it "sets verbose mode on" do
    support = described_class.new({}, verbose: true)
    allow(support).to receive(:require).with('curses').
      and_raise(LoadError)
    allow(support).to receive(:warn)

    support.from_curses

    expect(support).to have_received(:warn).with(/no native curses support/)
  end

  it "loads curses for color support" do
    support = described_class.new({})
    allow(support).to receive(:require).with('curses').and_return(true)
    stub_const("Curses", Object.new)
    curses = double(:curses)
    allow(curses).to receive(:init_screen)
    allow(curses).to receive(:has_colors?).and_return(true)
    allow(curses).to receive(:close_screen)

    expect(support.from_curses(curses)).to eql(true)
    expect(curses).to have_received(:has_colors?)
  end

  it "fails to find color for dumb terminal" do
    support = described_class.new('TERM' => 'dumb')
    expect(support.from_term).to eq(false)
  end

  it "inspects term variable for color capabilities" do
    support = described_class.new('TERM' => 'xterm')
    expect(support.from_term).to eq(true)
  end

  it "inspects color terminal variable for support" do
    support = described_class.new('COLORTERM' => true)
    expect(support.from_env).to eq(true)
  end
end
