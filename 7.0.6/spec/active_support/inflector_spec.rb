require "active_support"

RSpec.describe "ActiveSupport::Inflector" do
  context "#humanize" do
    context "when argument is user_id" do
      it "return active" do
        expect(ActiveSupport::Inflector.humanize("user")).to eq "User"
      end
    end
    context "when argument is nil" do
      it "raise NoMethodError" do
        expect {ActiveSupport::Inflector.humanize(nil)}.to raise_error NoMethodError
      end
    end
  end
end