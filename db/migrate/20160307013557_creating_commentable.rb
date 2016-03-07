class CreatingCommentable < ActiveRecord::Migration
  def change
    create_table :commentable do |t|
      t.references :comment, index: true
      t.references :commentable, polymorphic: true, index: true
      t.timestamps null: false
    end
    add_foreign_key :commentable, :comments
  end
end
