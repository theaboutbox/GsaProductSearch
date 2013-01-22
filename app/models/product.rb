require 'csv'
require 'texticle/searchable'

class Product < ActiveRecord::Base
  # Only search name and description
  extend Searchable(:name, :description)

  monetize :price_cents

  # Import a csv file living at the specified path
  def self.import_csv(path)
    io = File.open(path, 'r')
    CSV.foreach(io,  headers: true) do |row|
      next if row['tnsn '].nil?
      next if row['tnsn '].strip == '----'
      self.import_row(row)
    end
  end

  # Import a csv row
  #
  # row   Hash of row data in the form
  #         tnsn: serial number,
  #         titem_name: item name,
  #         titem_price: Price
  #         tdescription: Description 
  #
  # Returns Product created
  def self.import_row(row)
    p = Product.new
    p.sku = row['tnsn '].strip
    p.name = row['titem_name '].strip
    p.price = row['titem_price '].strip
    p.description = row['tdescription '].strip unless row['tdescription '].nil?
    p.save! 
  end
end

# == Schema Information
#
# Table name: products
#
#  id             :integer          not null, primary key
#  sku            :string(255)
#  name           :string(255)
#  description    :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  price_cents    :integer          default(0), not null
#  price_currency :string(255)      default("USD"), not null
#

