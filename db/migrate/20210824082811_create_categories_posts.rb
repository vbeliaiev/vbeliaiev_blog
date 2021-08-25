class CreateCategoriesPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_posts do |t|
      t.belongs_to :category
      t.belongs_to :post
      t.timestamps
    end
  end
end
