class CreateGalleryImages < ActiveRecord::Migration[7.0]
  def change
    create_table :gallery_images do |t|
      t.string :title, null: false, default: ''

      t.timestamps
    end
  end
end
