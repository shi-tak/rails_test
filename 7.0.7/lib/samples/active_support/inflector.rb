require "active_support/inflector"

module Samples::ActiveSupport
  class Inflector
    def self.execute
      puts "humanize(\"user_id\"): " + ActiveSupport::Inflector.humanize("user_id") 

      result = ActiveSupport::Inflector.humanize(nil)
      puts "humanize(nil): " +  (result.empty? ? "\"\"" : result)
    end
  end
end