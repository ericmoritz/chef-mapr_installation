log "\n=========== Start MapR mapr_base.rb =============\n"

# Install NFS
is_nfs = (
  # If want to install NFS on all nodes
  node['mapr']['nfs'] == '*' || (
    node['mapr']['nfs'].is_a?(Array) &&
    node['mapr']['nfs'].contain?(node['hostalias'])
  )
)

package 'mapr-fileserver'
package 'mapr-nfs' if is_nfs
