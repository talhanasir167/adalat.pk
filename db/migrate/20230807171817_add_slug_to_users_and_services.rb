class AddSlugToUsersAndServices < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
    add_column :services, :slug, :string
    add_index :services, :slug, unique: true
  end
end
