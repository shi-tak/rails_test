require "active_support/time"
require "active_support/core_ext/module"
require "active_support/core_ext/range"

RSpec.describe "ActiveSupport#to_s" do
  # # コミット
  # Fix to_s with no arguments not respecting custom :default formats
  # # 概要
  # # 経緯
  # - デフォルトのフォーマットを指定しても、それが反映されないバグがあった。
  #   - to_s(:default)のようにフォーマットを指定していれば問題ないが、引数なしのto_sのときには反映されない
  #   - Object#to_sが呼ばれるため、ActiveSupportの機能であるフォーマットが実施されないため
  # # 変更点
  # - 引数なしのto_sでもデフォルトのフォーマットが反映されるように修正
  # - ActiveSupport#to_sは非推奨なので警告を出力
  # # 対処
  # - 警告を確認して、to_sをto_fsに変更
  # - 警告を発していた部分のフォーマットが変わっていないか点検
  # # リンク
  # - [Merge pull request #48555 from skipkayhil/hm-fix-to-s-default](https://github.com/rails/rails/commit/fc719ff7a606988589d5350be3ac824bc60cb4d4)

  context "with Time" do
    time = Time.new(2000,1,1,11,0,0)
    
    context "with default format" do
      Time::DATE_FORMATS[:default] = "%Y年%m月%d日 %H時%M分%S秒"
      it "use custom format" do
        expect(time.to_s).to eq "2000年01月01日 11時00分00秒"
      end
    end
  end

  context "in Range" do
    range = (1..10)
    
    context "with default format" do
      ActiveSupport::RangeWithFormat::RANGE_FORMATS[:default] = ->(s, e) { "s: #{s}, e: #{e}" }
      it "use custom format" do
        expect(range.to_s).to eq "s: 1, e: 10"
      end
    end
  end
end