require "active_support/time"
require "active_support/core_ext/time/deprecated_conversions" 
require "active_support/core_ext/range/deprecated_conversions" 

module Samples::ActiveSupport
  class ToS
    def self.execute
      puts "sample for v7.0.7"
      
      puts "Time"
      time = Time.new(2000,1,1,11,0,0)
      
      puts "without default format"
      puts "Time#to_s:  " + time.to_s
      puts "Time#to_fs: " + time.to_fs
      
      puts "with default format"
      Time::DATE_FORMATS[:default] = "%Y年%m月%d日 %H時%M分%S秒"
      puts "Time#to_s:  " + time.to_s
      puts "Time#to_fs: " + time.to_fs

      
      puts "------"

      puts "Range"
      range = (1..10)

      puts "without default format"
      puts "Range#to_s:  " + range.to_s
      puts "Range#to_fs: " + range.to_fs

      puts "with default format"
      ActiveSupport::RangeWithFormat::RANGE_FORMATS[:default] = ->(s, e) { "s: #{s}, e: #{e}" }
      puts "Range#to_s:  " + range.to_s
      puts "Range#to_fs: " + range.to_fs

    end 
  end
end
