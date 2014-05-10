require 'erb'

namespace :stujo do

  desc "Git"
  namespace :git do

    def tag_info_lookup
      {
          :now => Time.now.to_i.to_s,
          :branch => "#{`git rev-parse --abbrev-ref HEAD`.strip}"
      }
    end

    desc "Display Current Version Info"
    task :current, [] => :environment do |t, args|
      info = "#{Stujo::Git.current_timestamp},#{Stujo::Git.current_branch}"
      puts "Version: #{info}"
    end

    desc "Update Version Info In Current Branch"
    task :tag, [] => [:tag_impl, :current] do |t, args|
    end

    task :tag_impl, [] => :environment do |t, args|

      tag_info = tag_info_lookup
      rb_file = Rails.root.join('config/initializers/', "stujo_git_info.rb")

      template = <<-eos
module Stujo
  module Git
    def self.raw_current_branch
      '<%= tag_info[:branch] %>'
    end
    def self.raw_current_timestamp
      <%= tag_info[:now] %>
    end
  end
end
      eos

      File.open(rb_file, 'w') { |file|
        file.write(ERB.new(template).result(binding))
      }

      load rb_file

      puts `git add #{rb_file}`

      puts "Tagged File: #{rb_file}"
    end
  end
end
