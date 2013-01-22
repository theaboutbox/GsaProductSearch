class AddFullTextIndexesToProduct < ActiveRecord::Migration
  def up
    execute "
      create index products_name_fulltext on products using gin(to_tsvector('english', name));
      create index products_description_fulltext on products using gin(to_tsvector('english', description));"
  end

  def down
    execute "
      drop index products_name_fulltext;
      drop index products_description_fulltext;"
  end
end
