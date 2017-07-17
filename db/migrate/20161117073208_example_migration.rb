class ExampleMigration < ActiveRecord::Migration[5.0]
  def up
    
    create_table :subscription_roles do |t|
      t.integer :person_id
      t.integer :subscription_type_id

      t.timestamps
  end

  def down
   drop_table :subscription_roles
    end
  end
end

