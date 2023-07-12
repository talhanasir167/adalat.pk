index_block = proc do
  index do
    selectable_column
    id_column
    column :name
    column :description
    column :created_at
    actions
  end
end

filter_block = proc do
  filter :name
  filter :created_at
end

show_attributes_block = proc do
  attributes_table do
    row :name
    row :description
    row('Service Image') { |service| image_tag service.avatar, width: 100, height: 80 }
    row :icon
    row :created_at
  end
end

show_categories_panel = proc do
  panel 'Service Categories' do
    table_for service.categories do
      column :name
      column :created_at
    end
  end
end

show_block = proc do
  show do
    tabs do
      tab :service_details do
        instance_eval(&show_attributes_block)
      end
      tab :service_categories do
        instance_eval(&show_categories_panel)
      end
    end
  end
end

form_block = proc do
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :icon
      f.input :avatar, as: :file
    end
    f.actions
  end
end

ActiveAdmin.register Service do
  permit_params :name, :description, :avatar, :icon

  instance_eval(&index_block)
  instance_eval(&filter_block)
  instance_eval(&show_block)
  instance_eval(&form_block)
end
