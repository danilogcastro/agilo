class CreateVisits < ActiveRecord::Migration[8.1]
  def change
    create_table :visits do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gym, null: false, foreign_key: true
      t.datetime :checked_in_at
      t.datetime :checked_out_at

      t.timestamps
    end
  end
end
