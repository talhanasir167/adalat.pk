class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name, null: false, default: ''
      t.string :icon, null: false, default: ''
      t.text :description
      t.text :summary

      t.timestamps
    end
  end
end
