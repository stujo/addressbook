require 'erb'

namespace :stujo do

  desc "Git"
  namespace :git do

    desc "Tag Current Branch"
    task tag: :environment do


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
    CURRENT_BRANCH = '<%= CURRENT_BRANCH %>'
    CURRENT_COMMIT = '<%= CURRENT_COMMIT %>'
    UPDATED_ON = '<%= UPDATED_ON %>'
    SGV_TAG = '<%= SGV_TAG %>'
  end
end
      eos
      CURRENT_BRANCH = "#{`git rev-parse --abbrev-ref HEAD`.strip}"
      CURRENT_COMMIT = "#{`git rev-parse --verify HEAD`.strip}"
      UPDATED_ON = Time.now

      puts "Git State : #{SGV_TAG},#{CURRENT_BRANCH},#{CURRENT_COMMIT},#{UPDATED_ON}"

      renderer = ERB.new(template)
      output = renderer.result()


      if File.exist? rb_file
        File.delete rb_file
        module Stujo
          module Git
            remove_const(:CURRENT_BRANCH) if const_defined? :CURRENT_BRANCH
            remove_const(:CURRENT_COMMIT) if const_defined? :CURRENT_COMMIT
            remove_const(:UPDATED_ON) if const_defined? :UPDATED_ON
            remove_const(:SGV_TAG) if const_defined? :SGV_TAG
          end
        end
      end

      File.open(rb_file, 'w') { |file|
        file.write(output)
      }

      load rb_file

      puts "Git Update: #{Stujo::Git::SGV_TAG},#{Stujo::Git::CURRENT_BRANCH},#{Stujo::Git::CURRENT_COMMIT},#{Stujo::Git::UPDATED_ON}"

      puts `git add #{rb_file}`
      puts `git commit -m'Version #{Stujo::Git::SGV_TAG},#{CURRENT_BRANCH},#{CURRENT_COMMIT},#{UPDATED_ON}'`

      puts adding_tag = `git tag -a #{SGV_TAG} -m 'AutoTag #{next_tag}'`

    end
  end
end
