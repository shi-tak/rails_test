require "active_support"

RSpec.describe "ActiveSupport::Inflector" do
  context "#humanize" do
    context "when argument is user_id" do
      it "return active" do
        expect(ActiveSupport::Inflector.humanize("user")).to eq "User"
      end
    end
    context "when argument is nil" do
      it "return blank" do
        expect(ActiveSupport::Inflector.humanize(nil)).to eq ""
      end
    end
  end
end