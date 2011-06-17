class bushidoCreate<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    create_table(:<%= table_name %>) do |t|
      t.string :bushido_id
      t.string :bushido_version

<% for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps
    end

    add_index :<%= table_name %>, :bushido_id, :unique => true
  end

  def self.down
    drop_table :<%= table_name %>
  end
end
