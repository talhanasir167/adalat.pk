index_block = proc do
  index do
    selectable_column
    id_column
    column :name
    column :email
    column('Qualification') { |user| user.user_summary.qualification if user.user_summary.present? }
    column('Experience') { |user| user.user_summary.experience if user.user_summary.present? }
    column('Verified at') { |user| user.user_summary.verified_at if user.user_summary.present? }
    column :role
    actions
  end
end

filter_block = proc do
  filter :name
  filter :email
  # filter :qualification
  # filter :qualification
  # filter :experience
  # filter :province
  # filter :district
  # filter :tehsil_bar
  filter :services
  # filter :verified_at
end

scope_block = proc do
  scope 'All Users', :all
  scope 'Admins', :admin
  scope 'Lawyers', :lawyer
  scope 'Clients', :client
  scope 'Verified Lawyers', :verified
  scope 'Unverified Lawyers', :unverified
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

user_summary_attributes = proc do
  row('Qualification') { |user| user.user_summary.qualification }
  row('Experience') { |user| user.user_summary.experience }
  row('Province') { |user| user.user_summary.province }
  row('District') { |user| user.user_summary.district }
  row('Tehsil Bar') { |user| user.user_summary.tehsil_bar }
  row('Description') { |user| user.user_summary.description.html_safe }
  row('User Profile') { |user| image_tag user.user_avatar, width: 100, height: 80 }
  row('User Id Card') { |user| image_tag user.user_summary.id_card, width: 100, height: 80 }
  row('User Bar Concil Card') { |user| image_tag user.user_summary.bar_concil_card, width: 100, height: 80 }
  row('Verified at') { |user| user.user_summary.verified_at }
end

show_block = proc do
  show do
    attributes_table do
      row :name
      instance_eval(&user_summary_attributes) if user.user_summary.present?
      row :services
      row :created_at
    end
  end
end

form_block = proc do
  form do |f|
    f.inputs do
      f.input :name
      f.has_many :user_summary, heading: 'User details', new_record: false do |t|
        t.input :qualification
        t.input :experience
        t.input :description, as: :quill_editor, input_html: { data: { options: { modules: { toolbar: instance_eval(&tollbar_block) }, placeholder: 'User description...', theme: 'snow' } } }
        t.input :province
        t.input :district
        t.input :tehsil_bar
        t.input :verified_at
      end
      f.input :role
      f.input :avatar, as: :file, label: 'Profile Picture'
      f.input :id_card, as: :file, label: 'ID Card Picture'
      f.input :bar_concil_card, as: :file, label: 'Bar-concil Card Picture'
    end
    f.actions
  end
end

ActiveAdmin.register User do
  permit_params :name, :avatar, :role, user_summary_attributes: %i[id qualification experience description province district,
    tehsil_bar verified_at id_card bar_concil_card _destroy]
  instance_eval(&index_block)
  instance_eval(&filter_block)
  instance_eval(&scope_block)
  instance_eval(&show_block)
  instance_eval(&form_block)
end
