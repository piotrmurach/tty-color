# encoding: utf-8

RSpec.describe TTY::Color::Mode, 'detecting mode' do

  subject(:color) { described_class.new }

  it "isn't terminal" do
    allow(TTY::Color).to receive(:tty?).and_return(false)
    expect(color.mode).to eq(0)
  end

  it "cannot find from term, tput " do
    allow(color).to receive(:from_term).and_return(TTY::Color::NoValue)
    allow(color).to receive(:from_tput).and_return(TTY::Color::NoValue)

    expect(color.mode).to eq(8)
  end

  it 'infers mode for xterm-256color' do
    allow(TTY::Color).to receive(:term).and_return('xterm-256color')
    expect(color.from_term).to eq(256)
  end

  it 'infers mode from terminal environment' do
    allow(TTY::Color).to receive(:term).and_return('amiga-8bit')
    expect(color.from_term).to eq(256)
  end

  it 'infers mode for wy730' do
    allow(TTY::Color).to receive(:term).and_return('wy370-105k')
    expect(color.from_term).to eq(64)
  end

  it 'infers mode for d430-unix-ccc' do
    allow(TTY::Color).to receive(:term).and_return('d430-unix-ccc')
    expect(color.from_term).to eq(52)
  end

  it 'infers mode for d430-unix-s-ccc' do
    allow(TTY::Color).to receive(:term).and_return('d430c-unix-s-ccc')
    expect(color.from_term).to eq(52)
  end

  it 'infers mode for d430-c' do
    allow(TTY::Color).to receive(:term).and_return('d430c-dg')
    expect(color.from_term).to eq(16)
  end

  it 'infers mode for d430-unix-w' do
    allow(TTY::Color).to receive(:term).and_return('d430-unix-w')
    expect(color.from_term).to eq(16)
  end

  it 'infers mode for vt100' do
    allow(TTY::Color).to receive(:term).and_return('konsole-vt100')
    expect(color.from_term).to eq(8)
  end
end
