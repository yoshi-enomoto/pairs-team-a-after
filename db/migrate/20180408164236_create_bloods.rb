class CreateBloods < ActiveRecord::Migration[5.0]
  def change
    create_table :bloods do |t|
      t.string :blood_type, null:false
      t.timestamps
    end
  end
end
