states_pannel_block = proc do
  attributes_table_for('todays_status') do
    row('Total Lawyers') { User.lawyer.created_today.count }
    row('Total Clients') { User.client.created_today.count }
  end
end

lawyers_pannel_block = proc do
  panel "Today's Lawyers" do
    table_for User.lawyer.created_today do
      column('name') { |user| link_to user.name, admin_user_path(user.id) }
      column :verified_at
    end
  end
end

clients_pannel_block = proc do
  panel "Today's Clients" do
    table_for User.client.created_today do
      column('name') { |user| link_to user.name, admin_user_path(user.id) }
    end
  end
end

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    tabs do
      tab :todays_status do
        instance_eval(&states_pannel_block)
      end
      tab :todays_lawyers do
        instance_eval(&lawyers_pannel_block)
      end
      tab :todays_clients do
        instance_eval(&clients_pannel_block)
      end
    end
  end
end
