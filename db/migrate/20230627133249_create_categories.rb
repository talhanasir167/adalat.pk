class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: ''
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
