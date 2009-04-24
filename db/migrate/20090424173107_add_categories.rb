class AddCategories < ActiveRecord::Migration
  def self.up
    add_column :posts, :categories, :integer
  end

  def self.down
    remove_column :posts, :categories
  end
end
