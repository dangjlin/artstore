namespace :dev do
  
  desc "Rebuild system"
  task :build => [ "tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "db:seed" ]
  
  desc "demo"
  task :demo => :environment do
    for i in 1..10 do
      puts i 
    end 
  end
  
  desc "build_account"
  task :build_acc => :environment do
    for n in 1..10 do
      User.create!(:email => "abc#{n}@xxx.com", :password => "12345678", :password_confirmation => "12345678")
    end
  end
  
end

