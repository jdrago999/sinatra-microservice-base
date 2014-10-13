class CreateFoobars < ActiveRecord::Migration
  def change
    create_table :foobars do |t|
      t.string :name
      t.timestamps
    end
  end
end
