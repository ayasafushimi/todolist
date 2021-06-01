class AddDoneToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :done, :boolean, :default => false, :null => false
    #Ex:- :null => false
    #Ex:- :default =>''
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
