index_block = proc do
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :qualification
    column :experience
    column :verified_at
    column :created_at
    actions
  end
end

filter_block = proc do
  filter :name
  filter :email
  filter :qualification
  filter :experience
  filter :province
  filter :district
  filter :tehsil_bar
  filter :services
  filter :verified_at
end

scope_block = proc do
  scope 'All Users', :all
  scope 'Admin Users', :admin
  scope 'Verified Users', :verified
  scope 'Unverified Users', :unverified
end

show_block = proc do
  show do
    attributes_table do
      row :name
      row :qualification
      row :experience
      row :province
      row :district
      row :tehsil_bar
      row :description
      row('User Profile') { |user| image_tag user.user_avatar, width: 100, height: 80 }
      row('User Id Card') { |user| image_tag user.id_card, width: 100, height: 80 }
      row('User Bar Concil Card') { |user| image_tag user.bar_concil_card, width: 100, height: 80 }
      row :services
      row :verified_at
      row :created_at
    end
  end
end

form_block = proc do
  form do |f|
    f.inputs do
      f.input :name
      f.input :qualification
      f.input :experience
      f.input :description
      f.input :province
      f.input :district
      f.input :tehsil_bar
      f.input :verified_at
      f.input :role
      f.input :id_card, as: :file
      f.input :bar_concil_card, as: :file
    end
    f.actions
  end
end

ActiveAdmin.register User do
  permit_params :name, :qualification, :experience, :description,
                :province, :district, :tehsil_bar, :verified_at, :role, :id_card, :bar_concil_card
  instance_eval(&index_block)
  instance_eval(&filter_block)
  instance_eval(&scope_block)
  instance_eval(&show_block)
  instance_eval(&form_block)
end
