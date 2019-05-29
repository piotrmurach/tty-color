# frozen_string_literal: true

RSpec.describe TTY::Color, 'integratation' do
  it "defaults output to stderr" do
    expect(TTY::Color.output).to eq($stderr)
  end

  it "defaults verbose mode to false" do
    expect(TTY::Color.verbose).to eq(false)
  end

  it "accesses color mode" do
    mode_instance = spy(:mode)
    allow(TTY::Color::Mode).to receive(:new).and_return(mode_instance)

    described_class.mode

    expect(mode_instance).to have_received(:mode)
  end

  it "accesses color support" do
    support_instance = spy(:support)
    allow(TTY::Color::Support).to receive(:new).and_return(support_instance)

    described_class.support?

    expect(support_instance).to have_received(:support?)
  end
end
