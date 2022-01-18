class RemoveAuthorFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :author, :string
  end
end
