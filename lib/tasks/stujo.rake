require 'erb'

namespace :stujo do

  desc "Git"
  namespace :git do

    TAG_PREFIX = 'sgv'

    def tag_info_lookup
      latest_tag = `git describe --abbrev=0 --tags`
      next_tag = Time.now.to_i.to_s

      {
          full: "#{TAG_PREFIX}{#{next_tag}",
          next: next_tag,
          latest: latest_tag
      }
    end


    desc "Tag Current Branch"
    task :pre_commit, [:remote, :url] => :environment do |t, args|

    end

    desc "Tag Current Branch"
    task :tag, [:remote, :url] => :environment do |t, args|

      tag_info = tag_info_lookup

      CURRENT_REMOTE = 'local'
      CURRENT_REMOTE = "#{args[:remote]}" if args.has_key? :remote

      #
      # latest_tag = `git describe --abbrev=0 --tags`
      # next_tag = 1
      # match = latest_tag[/sgv(.*)/, 1]
      # next_tag = 1 + match.to_i unless match.blank?
      # SGV_TAG = "sgv#{next_tag}"
      #

      puts "Next Auto Tag: #{tag_info[:full]}"


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
      SGV_TAG = tag_info[:full]

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

      info = "#{Stujo::Git.current_tag},#{Stujo::Git.current_remote},#{Stujo::Git.current_branch},#{Stujo::Git.current_commit},#{Stujo::Git.current_update}"

      puts "Git Update: #{info}"

      puts `git add #{rb_file}`
      puts `git commit -m'Version #{info}'`

      puts adding_tag = `git tag -a #{SGV_TAG} -m 'AutoTag #{tag_info[:full]}'`

    end
  end
end
