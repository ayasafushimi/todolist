class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.text :text
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
