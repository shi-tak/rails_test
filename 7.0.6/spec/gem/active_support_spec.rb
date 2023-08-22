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

              # 7.0.6ではエラーが発生
              expect {cache.read_multi("name", "sub")}.to raise_error(NoMethodError)
            end
          end
          it "read and read_multi" do
            cache.with_local_cache do

              # read と read_multiの場合も同様にエラー
              expect(cache.read("name")).to eq(nil)              
              expect {cache.read_multi("name")}.to raise_error(NoMethodError)
            end
          end
        end
      end
    end
  end
end