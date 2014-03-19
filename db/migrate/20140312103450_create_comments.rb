class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :issue_id
      t.text :content

      t.timestamps
      t.userstamps
    end
  end
end
