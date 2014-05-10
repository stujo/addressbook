module Stujo
  module Git
    def self.method_missing(m, *args, &block)
      raw = "raw_#{m}".to_sym
      if self.respond_to? raw
        self.send raw # no args or block
      else
        '_unknown_'
      end
    end

    def self.age_ago
      timestamp = current_timestamp.to_i
      if timestamp > 0
        Time.now.to_i - timestamp
      else
        '_unknown_'
      end
    end

  end
end

