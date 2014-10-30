class AddCdliIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :cdli_id, :string
    add_column :items, :weight, :string
  end
end
