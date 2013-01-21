namespace :app do
  desc 'Import data file'
  task :import_data => :environment do
    file = File.join(Rails.root, 'doc/gsa-prices.csv')
    Product.import_csv(file)
  end
end
