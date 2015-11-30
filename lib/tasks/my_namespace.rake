namespace :FEMG do
  desc "go to lookup data from FEMG website"
  task :get_FEMG_data do
  # the ruby file's path is in the project root, the file should be placed in there
  ruby "lookFEMG.rb"
  end
 
  desc "go to lookup data from FEMG website"
  task :get_FEMG_data_c9 do
  # the ruby file's path is in the project root, the file should be placed in there
  ruby "lookFEMG-C9.rb"
  end

  desc "AUGgo to lookup data from FEMG website"
  task :get_FEMG_data_aug do
  # the ruby file's path is in the project root, the file should be placed in there
  ruby "lookFEMG-Aug.rb"
  end

  desc "Julygo to lookup data from FEMG website"
  task :get_FEMG_data_july do
  # the ruby file's path is in the project root, the file should be placed in there
  ruby "lookFEMG-July.rb"
  end

  desc "Novgo to lookup data from FEMG website"
  task :get_FEMG_data_nov do
  # the ruby file's path is in the project root, the file should be placed in there
  ruby "lookFEMG-Nov.rb"
  end
 
  desc  "go to lookup quote data from yahoo finance tw"
  task :get_quote_data do
  # the ruby file's path is in the project root, the file should be placed in there
  ruby "stockprice.rb"
  end
  
end
