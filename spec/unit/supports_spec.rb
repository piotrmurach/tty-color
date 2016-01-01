# encoding: utf-8

RSpec.describe TTY::Color::Support, '#supports?' do
  let(:output) { StringIO.new('', 'w+') }

  subject(:color) { described_class.new }

  before { TTY::Color.output = output }

  it "doesn't check color support for non tty terminal" do
    allow(TTY::Color).to receive(:tty?).and_return(false)

    expect(color.supports?).to eq(false)
  end

  it "fails to find out color support" do
    allow(TTY::Color).to receive(:tty?).and_return(true)

    allow(color).to receive(:from_curses).and_return(TTY::Color::NoValue)
    allow(color).to receive(:from_tput).and_return(TTY::Color::NoValue)
    allow(color).to receive(:from_term).and_return(TTY::Color::NoValue)
    allow(color).to receive(:from_env).and_return(TTY::Color::NoValue)

    expect(color.supports?).to eq(false)
  end

  it "fails to load curses for color support" do
    allow(color).to receive(:require).with('curses').
      and_raise(LoadError)
    allow(color).to receive(:warn)

    expect(color.from_curses).to eq(TTY::Color::NoValue)
    expect(color).to_not have_received(:warn)
  end

  it "sets verbose mode on" do
    TTY::Color.verbose = true
    allow(color).to receive(:require).with('curses').
      and_raise(LoadError)
    allow(color).to receive(:warn)
    color.from_curses
    expect(color).to have_received(:warn).with(/no native curses support/)
    TTY::Color.verbose = false
  end

  it "loads curses for color support" do
    allow(color).to receive(:require).with('curses').and_return(true)
    stub_const("Curses", Object.new)
    curses = double(:curses)
    allow(curses).to receive(:init_screen)
    allow(curses).to receive(:has_colors?).and_return(true)
    allow(curses).to receive(:close_screen)

    expect(color.from_curses(curses)).to eql(true)
    expect(curses).to have_received(:has_colors?)
  end

  it "fails to find color for dumb terminal" do
    allow(ENV).to receive(:[]).with('TERM').and_return('dumb')

    expect(color.from_term).to eq(false)
  end

  it "inspects term variable for color capabilities" do
    allow(ENV).to receive(:[]).with('TERM').and_return('xterm')

    expect(color.from_term).to eq(true)
  end

  it "inspects color terminal variable for support" do
    allow(ENV).to receive(:include?).with('COLORTERM').and_return(true)

    expect(color.from_env).to eq(true)
  end
end
