require "active_support"

module Samples::ActiveSupport
  class NullStore
    def self.execute
      puts "sample for v7.0.7"
      cache = ActiveSupport::Cache.lookup_store(:null_store)

      puts
      puts "------"
      puts "Cache::NullStore doesn't store value."
      puts
      name = "Taro"
      cache.write("name", name)
      result = cache.read("name")
      puts "write: " + name.to_s
      puts "read: " + result.to_s
      
      puts
      puts "------"
      puts "Cache::NullStore store value inside block of #with_local_cache."
      puts
      cache.with_local_cache do
        cache.write("name", name)
        result = cache.read("name")
        puts "write: " + name.to_s
        puts "read: " + result.to_s
      end

      puts
      puts "------"
      puts "Cache::NullStore can call #read_multi repeatdly inside block of #with_local_cache."
      puts

      cache.with_local_cache do
        cache.clear
        cache.read_multi("name")
        cache.read_multi("name")

        puts "success"
      end
    end 
  end
end