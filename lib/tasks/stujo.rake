require 'erb'

namespace :stujo do
  desc "Update GIT Branch"
  task update_git_info: :environment do
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

    renderer = ERB.new(template)
    output = renderer.result()
    html_file = Rails.root.join('config/initializers/', "stujo_git_info.rb")
    File.open(html_file, 'w') { |file|

      file.write(output)

    }
  end

end
