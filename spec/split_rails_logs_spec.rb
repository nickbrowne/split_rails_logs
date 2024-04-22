require "split_rails_logs"
require "pathname"
require "logger"

RSpec.describe SplitRailsLogs do
  let(:example) { double(call: nil, metadata: { file_path: "spec/example_spec.rb", line_number: 123 }) }
  let(:expected_pathname) { Pathname.new("foo/log/spec/example_spec.rb:123.test.log") }

  before do
    stub_const("Rails", double(
      root: Pathname.new("foo"),
      logger: Logger.new(nil),
      "logger=": nil,
      initialized?: true,
    ))
  end

  describe ".for_all" do
    it "writes logs for a successful example" do
      expect(example).to receive(:exception).and_return false
      expect(File).to receive(:write).with(expected_pathname, "")

      SplitRailsLogs.for_all(example)
    end

    it "writes logs for a failed example" do
      expect(example).to receive(:exception).and_return true
      expect(File).to receive(:write).with(expected_pathname, "")

      SplitRailsLogs.for_all(example)
    end
  end

  describe ".for_failed" do
    it "does not write logs for a successful example" do
      expect(example).to receive(:exception).and_return false
      expect(File).to_not receive(:write)

      SplitRailsLogs.for_failed(example)
    end

    it "writes logs for a failed example" do
      expect(example).to receive(:exception).and_return true
      expect(File).to receive(:write).with(expected_pathname, "")

      SplitRailsLogs.for_failed(example)
    end
  end
end
