class CreateLawServices < ActiveRecord::Migration[7.0]
  def change
    create_table :law_services do |t|
      t.references :user, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
