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

show_block = proc do
  show do
    attributes_table do
      row :name
      row :description
      row :created_at
    end
  end
end
ActiveAdmin.register Service do
  permit_params :name, :description

  instance_eval(&index_block)
  instance_eval(&filter_block)
  instance_eval(&show_block)

end
