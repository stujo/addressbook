
module Stujo
  module Git
    def self.current_branch
      if defined? Stujo::Git::CURRENT_BRANCH
        Stujo::Git::CURRENT_BRANCH
      else
        'unknown'
      end
    end
    def self.current_commit
      if defined? Stujo::Git::CURRENT_COMMIT
        Stujo::Git::CURRENT_COMMIT
      else
        'unknown'
      end
    end
    def self.updated_on
      if defined? Stujo::Git::UPDATED_ON
        Stujo::Git::UPDATED_ON
      else
        'unknown'
      end
    end
  end
end

