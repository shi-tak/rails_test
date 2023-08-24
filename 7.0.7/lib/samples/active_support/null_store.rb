require "active_support"

module Samples::ActiveSupport
  class NullStore
    def self.execute
      puts "sample for v7.0.7"
      cache = ActiveSupport::Cache.lookup_store(:null_store)
      puts "------"

      puts "Cache::NullStore doesn't store value."
      puts
      cache.write("name", "Taro")
      result = cache.read("name")
      puts "result = " + (result.nil? ? "nil" : result)
      puts "------"
      
      puts "Cache::NullStore store value inside block of #with_local_cache."
      puts
      cache.with_local_cache do
        cache.write("name", "Taro")
        result = cache.read("name")
        puts "result = " + result
      end
      puts "------"
      
      puts "Cache::NullStore can call #read_multi repeatdly inside block of #with_local_cache."
      puts

      cache.with_local_cache do
        cache.clear
        cache.read_multi("name")
        result = cache.read_multi("name")
        puts "result = " + result.to_s
      end
      puts "------"
    end 
  end
end