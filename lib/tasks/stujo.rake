require 'erb'

namespace :stujo do

  desc "Git"
  namespace :git do

    desc "Tag Current Branch"
    task :tag, [:remote, :url] => :environment do |t, args|

      CURRENT_REMOTE = 'local'
      CURRENT_REMOTE = "#{args[:remote]}" if args.has_key? :remote

      latest_tag = `git describe --abbrev=0 --tags`
      next_tag = 1
      match = latest_tag[/sgv(.*)/, 1]
      next_tag = 1 + match.to_i unless match.blank?
      SGV_TAG = "sgv#{next_tag}"
      puts "Next Auto Tag: #{SGV_TAG}"


      rb_file = Rails.root.join('config/initializers/', "stujo_git_info.rb")
      puts "Info File: #{rb_file}"

      template = <<-eos
module Stujo
  module Git
    def self.raw_current_remote
      '<%= CURRENT_REMOTE %>'
    end
    def self.raw_current_branch
      '<%= CURRENT_BRANCH %>'
    end
    def self.raw_current_commit
      '<%= CURRENT_COMMIT %>'
    end
    def self.raw_current_update
      '<%= UPDATED_ON %>'
    end
    def self.raw_current_tag
      '<%= SGV_TAG %>'
    end
  end
end
      eos
      CURRENT_BRANCH = "#{`git rev-parse --abbrev-ref HEAD`.strip}"
      CURRENT_COMMIT = "#{`git rev-parse --verify HEAD`.strip}"
      UPDATED_ON = Time.now

      puts "Git State : #{SGV_TAG},#{CURRENT_REMOTE},#{CURRENT_BRANCH},#{CURRENT_COMMIT},#{UPDATED_ON}"

      renderer = ERB.new(template)
      output = renderer.result()

      if File.exist? rb_file
        File.delete rb_file
      end

      File.open(rb_file, 'w') { |file|
        file.write(output)
      }

      load rb_file

      info = "#{Stujo::Git.current_tag},#{Stujo::Git.current_branch},#{Stujo::Git.current_commit},#{Stujo::Git.current_update}"

      puts "Git Update: #{info}"

      puts `git add #{rb_file}`
      puts `git commit -m'Version #{info}'`

      puts adding_tag = `git tag -a #{SGV_TAG} -m 'AutoTag #{next_tag}'`

    end
  end
end
