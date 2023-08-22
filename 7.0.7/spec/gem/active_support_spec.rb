require "active_support"

RSpec.describe ActiveSupport do

  context "in 7.0.7" do
    # # Link
    # - [CHANGELOG](https://github.com/rails/rails/releases/tag/v7.0.7)
    # - [Commits](https://github.com/rails/rails/compare/v7.0.6...v7.0.7)
    context "Cache::NullStore" do
      cache = ActiveSupport::Cache.lookup_store(:null_store)
      
      context "without local cache" do
        it "read only once" do
          cache.write("name", "value")
          # NullStoreは値を保存しないので、キャッシュ後に読み込んでもnilが返ってくる
          expect(cache.read("name")).to eq(nil)
        end
      end

      context "with local cache" do
        context "with value" do
          it "read a key repeatedly" do
            cache.with_local_cache do
              cache.write("name", "value")
              
              # #with_local_cacheを使えば、値を保管できるようになる
              expect(cache.read("name")).to eq("value")
              expect(cache.read("name")).to eq("value")
            end
          end
        end
        context "without value" do
          cache.clear
          it "read_multi repeatedly" do
            cache.with_local_cache do 

              # 値が設定させていない場合は、空のハッシュが返される
              expect(cache.read_multi("name", "sub")).to eq({})

              # 2回目はnil
              expect(cache.read_multi("name", "sub")).to eq({"name"=>nil, "sub"=>nil})
            end
          end
          it "read and read_multi" do
            cache.with_local_cache do

              # read と read_multiの場合も同様
              expect(cache.read("name")).to eq(nil)              
              expect(cache.read_multi("name")).to eq({"name"=>nil})
            end
          end
        end
      end
    end

    context "to_s" do
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
    end
    context "ActiceSupport::Inflector#humanize" do
      # # コミット
      # Fix ActiveSupport::Inflector.humanize(nil) raising NoMethodError: undefined method `end_with?' for nil:NilClass
      # # 概要
      # # 経緯
      # # 変更点
      # - ActiveSupport::Inflector.humanize(nil)
      # # 対処
      # - ActiveSupport::Inflector#humanizeを使っている箇所を点検
      #   - ActiveSupport::Inflector#humanizeの前後でNoMethodErrorを前提した処理の有無
      #     - 上流のrescue
      #   - ActiceSupport::Inflector#humanizeの返り値が空文字だったとき、後続の処理が受け付けられるかの確認
      # # リンク
      # - [Merge pull request #48800 from robinjam/fix-humanize-nil](https://github.com/rails/rails/commit/b18b9df65eb7d4e5dfa9a6982a8709c0c94b0b97)
      # - [Fix ActiveSupport::Inflector.humanize(nil) #48800](https://github.com/rails/rails/pull/48800)
    end
    context "Enumerator::Lazy#sum" do
      # # コミット
      # Fix Enumerable#sum for Enumerator#lazy
      # # 概要
      # # 経緯
      # - Rails 7以降から、Enumerator::Lazy#sumとEnumerable#sumで振る舞いが異なるようになりました。
      #   - 条件
      #     - ブロックに副作用がある
      #     - sumに初期値を指定しない
      # - ただし、Rails 7からEnumerator#sumは非推奨になっています。
      # # 変更点
      # - Enumerator#sumの動作をEnumerator::Lazy#sumに合わせる
      # # 対処
      # - Enumerator::Lazy#sumを利用している箇所について点検
      #   - #lazyの直後にforceを入れて、動作が変わっていないか
      #   - Enumerable#sumからEumerator::Lazy#sumに変更したことがある場合、#sumが想定どおりに動くか
      # # リンク
      # - [Merge pull request #48720 from fatkodima/fix-enumerable-sum-with-lazy-enumerator](https://github.com/rails/rails/commit/83385cc7c3fd43e26adc9b3b658cad67c710e431)
      # - [Fix Enumerable#sum for Enumerator#lazy #48720](https://github.com/rails/rails/pull/48720)
    end
    context "template" do
      # # コミット
      # Improve error message when EventedFileUpdateChecker is used without a compatible version of the Listen gem
      # # 概要
      # # 経緯
      # # 変更点
      # # 対策
      # # リンク
    end
  end
end