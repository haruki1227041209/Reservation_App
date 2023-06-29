class RenameColumnInModel < ActiveRecord::Migration[6.1]
  def change
    rename_column :Users, :password, :password_digest
  end
end
