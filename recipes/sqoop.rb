def role?(role_name)
  Mapr.role? node, role_name
end

if role?('sqoop')
  log "Installing sqoop on #{Mapr.hostalias(node)}"
  package 'mapr-sqoop' do
    version node['mapr']['versions']['sqoop']
  end

  if node['mapr']['jobs']
    node['mapr']['jobs'].each do |job_name, job_data|
      job_data['entities'].each do |entity_name, entity_data|
        options_content = entity_data['sqoop_options'].join("\n") + "\n"
        file "/opt/mapr/jobs/#{job_name}/conf/sqoop_#{entity_name}.options" do
          content options_content
          owner 'mapr'
          group 'mapr'
          mode '664'
        end
      end
    end
  end
end
