namespace :deploy do
  desc 'Deploy the app'
  task :release do
    app = "addybook"
    remote = "heroku"

    puts "Pushing release #{app} to #{remote}"
    system "heroku maintenance:on --app #{app}"
    system "git push --force #{remote} release:master"
    system "heroku run rake db:migrate --app #{app}"
    system "heroku run rake db:seed --app #{app}"
    system "heroku maintenance:off --app #{app}"
  end
end


