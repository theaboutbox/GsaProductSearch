require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @data_file_path = File.join Rails.root, 'doc/gsa-prices.csv'
    @row = {
      'tnsn '         => '7045-01-365-2069',
      'titem_name '   => '3.5" Disks',
      'titem_price '  => '5.41',
      'tdescription ' => %q{Formatted. High-quality, error-free floppy disks for data processing applications.}
    }
  end

  test "Imports a csv row" do
    Product.import_row(@row)
    p = Product.find_by_sku(@row['tnsn '])
    assert_not_nil p
    assert_equal @row['tnsn '], p.sku
    assert_equal @row['titem_name '], p.name
    assert_equal @row['tdescription '], p.description
  end

  test "imports a csv file" do
    Product.import_csv @data_file_path
    assert Product.count > 100
    results = Product.search 'disk'
    assert results.count > 0
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

