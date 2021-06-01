class ChangeArticles < ActiveRecord::Migration[6.1]
  def change
    change_table :articles do |t|
      t.remove :date, :time
      t.datetime :datetime
    end
  end
end
