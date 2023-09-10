require "active_support/inflector"

module Samples::ActiveSupport
  class Inflector
    def self.execute
      
      puts "humanize(\"user_id\"): " + ActiveSupport::Inflector.humanize("user_id") 

      begin
        result = ActiveSupport::Inflector.humanize(nil)
        puts result
      rescue NoMethodError => e 
        puts "cause: " +  e.inspect
      end
    end
  end
end