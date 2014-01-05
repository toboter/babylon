class CreatePredicates < ActiveRecord::Migration
  def change
    create_table :predicates do |t|
      t.string :name
      t.string :inverse_name
      t.text :description
      t.string :scope_type

      t.timestamps
      t.userstamps
    end
  end
end
