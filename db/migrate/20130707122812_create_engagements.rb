class CreateEngagements < ActiveRecord::Migration
  def change
    create_table :engagements do |t|
      t.integer :person_id
      t.datetime :start
      t.datetime :end

      t.timestamps
      t.userstamps
    end
  end
end
