# frozen_string_literal: true

RSpec.describe TTY::Color, "integratation" do
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

  it "accesses disabled support" do
    support_instance = spy(:support, disabled?: :maybe)
    allow(TTY::Color::Support).to receive(:new).and_return(support_instance)

    expect(described_class.disabled?).to eq(:maybe)

    expect(support_instance).to have_received(:disabled?)
  end

  it "checks unknown command without raising errors and returns false" do
    allow(described_class).to receive(:system)
      .with("unknown-command", { out: ::File::NULL, err: ::File::NULL })
      .and_return(nil)

    expect(described_class.command?("unknown-command")).to eq(false)
  end

  it "checks 'echo' command and returns true" do
    allow(described_class).to receive(:system).
      with("echo", { out: ::File::NULL, err: ::File::NULL }).and_return("")

    expect(described_class.command?("echo")).to eq(true)
  end

  it "detects windows platform" do
    stub_const("::File::ALT_SEPARATOR", "\\")

    expect(described_class.windows?).to eq(true)
  end
end
