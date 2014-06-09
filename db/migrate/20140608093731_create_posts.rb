class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.column :title, :string, :null => false
      t.column :body, :text, :null => false

      t.timestamps
    end
  end
end
