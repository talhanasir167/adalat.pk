class CreateUserSummaries < ActiveRecord::Migration[7.0]
  def change
    create_table :user_summaries do |t|
      t.string :qualification,      null: false, default: ''
      t.float :experience,          null: false, default: 1
      t.text :description,          null: false, default: ''
      t.string :province,           null: false, default: ''
      t.string :district,           null: false, default: ''
      t.string :tehsil_bar,         null: false, default: ''
      t.datetime :verified_at
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
