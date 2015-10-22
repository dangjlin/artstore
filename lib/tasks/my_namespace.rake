namespace :FEMG do
  desc "go to lookup data from FEMG website"
  task :get_FEMG_data do
  # the ruby file's path is in the project root, the file should be placed in there
  ruby "lookFEMG.rb"
  end
  
  desc  "go to lookup quote data from yahoo finance tw"
  task :get_quote_data do
  # the ruby file's path is in the project root, the file should be placed in there
  ruby "stockprice.rb"
  end
  
end