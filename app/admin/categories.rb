filter_block = proc do
  filter :service
  filter :name
end

show_block = proc do
  show do
    attributes_table do
      row :name
      row :service
      row :created_at
    end
  end
end

ActiveAdmin.register Category do
  permit_params :name, :service_id

  instance_eval(&filter_block)
  instance_eval(&show_block)
end
