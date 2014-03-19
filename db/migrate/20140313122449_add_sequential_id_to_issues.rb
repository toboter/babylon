class AddSequentialIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :sequential_id, :integer
  end
end
