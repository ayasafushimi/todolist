class FromTimeToDatetime < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :datetime
    add_column :articles, :datetime, :datetime
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
