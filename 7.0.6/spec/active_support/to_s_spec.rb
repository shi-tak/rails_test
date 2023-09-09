require "active_support/time"
require "active_support/core_ext/module"
require "active_support/core_ext/range"

RSpec.describe "ActiveSupport#to_s" do
  context "with Time" do
    time = Time.new(2000,1,1,11,0,0)
    
    context "with default format" do
      Time::DATE_FORMATS[:default] = "%Y年%m月%d日 %H時%M分%S秒"
      it "use custom format" do
        # v7.0.6 does not use default format
        expect(time.to_s).to eq "2000-01-01 11:00:00 +0900"
      end
    end
  end

  context "in Range" do
    range = (1..10)
    
    context "with default format" do
      ActiveSupport::RangeWithFormat::RANGE_FORMATS[:default] = ->(s, e) { "s: #{s}, e: #{e}" }
      it "use custom format" do
        # v7.0.6 does not use default format
        expect(range.to_s).to eq "1..10"
      end
    end
  end
end