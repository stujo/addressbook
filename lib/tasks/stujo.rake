require 'erb'

namespace :stujo do
  desc "Update GIT Branch"
  task update_git_info: :environment do

    rb_file = Rails.root.join('config/initializers/', "stujo_git_info.rb")
    puts "Info File: #{rb_file}"

    template = <<-eos

module Stujo
  module Git
    CURRENT_BRANCH = '<%= CURRENT_BRANCH %>'
    CURRENT_COMMIT = '<%= CURRENT_COMMIT %>'
    UPDATED_ON = '<%= UPDATED_ON %>'
  end
end

    eos
    CURRENT_BRANCH = "#{`git rev-parse --abbrev-ref HEAD`.strip}"
    CURRENT_COMMIT = "#{`git rev-parse --verify HEAD`.strip}"
    UPDATED_ON = Time.now

    puts "Git State : #{CURRENT_BRANCH},#{CURRENT_COMMIT},#{UPDATED_ON}"

    renderer = ERB.new(template)
    output = renderer.result()


    if File.exist? rb_file
      File.delete rb_file
      module Stujo
        module Git
          remove_const(:CURRENT_BRANCH) if defined? :CURRENT_BRANCH
          remove_const(:CURRENT_COMMIT) if defined? :CURRENT_COMMIT
          remove_const(:UPDATED_ON) if defined? :UPDATED_ON
        end
      end
    end

    File.open(rb_file, 'w') { |file|
      file.write(output)
    }

    load rb_file

    puts "Git Update: #{Stujo::Git::CURRENT_BRANCH},#{Stujo::Git::CURRENT_COMMIT},#{Stujo::Git::UPDATED_ON}"

  end

end
