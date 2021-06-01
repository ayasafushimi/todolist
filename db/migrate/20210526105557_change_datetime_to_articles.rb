class ChangeDatetimeToArticles < ActiveRecord::Migration[6.1]
  def change
    change_column :articles, :datetime, :time
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
