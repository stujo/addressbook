module Stujo
  module Git
    def self.method_missing(m, *args, &block)
      raw = "raw_#{m}".to_sym

      puts "Checking for #{raw}"

      if self.respond_to? raw
        self.send raw # no args or block
      else
        '_unknown_'
      end
    end
  end
end

