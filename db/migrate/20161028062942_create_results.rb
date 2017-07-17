class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.integer :user_id
      t.integer :exam_id
      t.integer :mark

      t.timestamps
    end
  end
end
