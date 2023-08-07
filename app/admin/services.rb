index_block = proc do
  index do
    selectable_column
    id_column
    column :name
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
    row('Description') { |service| service.description.html_safe }
    row :summary
    row('Service Image') { |service| image_tag service.avatar, width: 100, height: 80 }
    row :icon
    row :created_at
  end
end

show_block = proc do
  show do
    tabs do
      tab :service_details do
        instance_eval(&show_attributes_block)
      end
    end
  end
end

tollbar_block = proc do
  [
    [{ 'font': [] }],
    %w[bold italic underline strike],
    ['blockquote'],
    [{ 'list': 'ordered' }, { 'list': 'bullet' }],
    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
    [{ 'color': [] }, { 'background': [] }],
    [{ 'align': [] }],
    ['link'],
    ['clean']
  ]
end

form_block = proc do
  form do |f|
    f.inputs do
      f.input :name
      f.input :description, as: :quill_editor, input_html: { data: { options: { modules: { toolbar: instance_eval(&tollbar_block) }, placeholder: 'Service description...', theme: 'snow' } } }
      f.input :summary
      f.input :icon
      f.input :avatar, as: :file, label: 'Service Image'
    end
    f.actions
  end
end

find_resource_block = proc do
  controller do
    def find_resource
      if resource_class.is_a?(FriendlyId)
        scoped_collection.friendly.find(params[:id])
      else
        scoped_collection.find(params[:id])
      end
    end
  end
end

ActiveAdmin.register Service do
  permit_params :name, :description, :avatar, :icon, :summary

  instance_eval(&index_block)
  instance_eval(&filter_block)
  instance_eval(&show_block)
  instance_eval(&form_block)
  instance_eval(&find_resource_block)
end
