# encoding: utf-8

RSpec.describe TTY::Color::Mode, 'detecting mode' do
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
  end

  it 'infers mode for xterm-256color' do
    mode = described_class.new('TERM' => 'xterm-256color')
    expect(mode.from_term).to eq(256)
  end

  it 'infers mode for iTerm.app' do
    mode = described_class.new('TERM' => 'iTerm.app')
    expect(mode.from_term).to eq(256)
  end

  it 'infers mode from terminal environment' do
    mode = described_class.new('TERM' => 'amiga-8bit')
    expect(mode.from_term).to eq(256)
  end

  it 'infers mode for wy730' do
    mode = described_class.new('TERM' => 'wy370-105k')
    expect(mode.from_term).to eq(64)
  end

  it 'infers mode for d430-unix-ccc' do
    mode = described_class.new('TERM' => 'd430-unix-ccc')
    expect(mode.from_term).to eq(52)
  end

  it 'infers mode for d430-unix-s-ccc' do
    mode = described_class.new('TERM' => 'd430c-unix-s-ccc')
    expect(mode.from_term).to eq(52)
  end

  it 'infers mode for nsterm-bce' do
    mode = described_class.new('TERM' => 'nsterm-bce')
    expect(mode.from_term).to eq(16)
  end

  it 'infers mode for d430-c' do
    mode = described_class.new('TERM' => 'd430c-dg')
    expect(mode.from_term).to eq(16)
  end

  it 'infers mode for d430-unix-w' do
    mode = described_class.new('TERM' => 'd430-unix-w')
    expect(mode.from_term).to eq(16)
  end

  it 'infers mode for vt100' do
    mode = described_class.new('TERM' => 'konsole-vt100')
    expect(mode.from_term).to eq(8)
  end

  it 'infers mode for xnuppc' do
    mode = described_class.new('TERM' => 'xnuppc+basic')
    expect(mode.from_term).to eq(8)
  end
end
