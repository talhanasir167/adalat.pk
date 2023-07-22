form_block = proc do
  form do |f|
    f.inputs do
      f.input :title
      f.input :avatar, as: :file, label: 'Image'
    end
    f.actions
  end
end

index_block = proc do
  index do
    selectable_column
    id_column
    column :title
    column :created_at
    actions
  end
end

show_block = proc do
  show do
    attributes_table do
      row :title
      row('Gallary Image') { |gallery_image| image_tag gallery_image.avatar, width: 100, height: 80 }
      row :created_at
    end
  end
end

filter_block = proc do
  filter :title
  filter :created_at
end

ActiveAdmin.register GalleryImage do
  permit_params :title, :avatar
  instance_eval(&form_block)
  instance_eval(&index_block)
  instance_eval(&show_block)
  instance_eval(&filter_block)
end
