# Mapr module
module Mapr
  ### Publics
  def self.role?(node, role_name)
    # Returns True if this node should have that role
    fqdn = node['hostalias']
    role_fqdns = mapr_role_fqdns(node, role_name)
    role_fqdns.include?(fqdn)
  end

  def self.mapr_role_fqdns(node, role_name)
    # extract the role's data if it exists
    role_item = _role_item(node, role_name)
    if role_item.is_a?(Array)
      role_item
    elsif role_item == '*'
      [node['hostalias']]
    elsif role_item.is_a?(String)
      [role_item]
    else
      []
    end
  end

  ### Privates
  def self._role_item(node, role_name)
    if node['mapr'] && node['mapr'][role_name]
      node['mapr'][role_name]
    else
      []
    end
  end
end
