class AddPositionToEditorships < ActiveRecord::Migration
  def change
    add_column :editorships, :position, :integer
  end
end
