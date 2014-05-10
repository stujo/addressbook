require 'erb'

namespace :stujo do

  desc "Git"
  namespace :git do

    TAG_PREFIX = 'sgv'

    def tag_info_lookup
      latest_tag = `git describe --abbrev=0 --tags`
      next_tag = Time.now.to_i.to_s
      match = latest_tag[/#{TAG_PREFIX}(.*)/, 1]

      {
          full: "#{TAG_PREFIX}#{next_tag}",
          next: next_tag,
          latest: latest_tag
      }
    end


    desc "Update Version Tag In Current Branch"
    task :tag, [:remote, :url] => :environment do |t, args|

      tag_info = tag_info_lookup

      puts "Next Auto Tag: #{tag_info[:full]}"

      rb_file = Rails.root.join('config/initializers/', "stujo_git_info.rb")
      puts "Info File: #{rb_file}"

      template = <<-eos
module Stujo
  module Git
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

      puts "Version: #{info}"
      puts `git add #{rb_file}`
    end
  end
end
