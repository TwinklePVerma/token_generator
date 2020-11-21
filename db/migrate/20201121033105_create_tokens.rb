class CreateTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.string :key, unique: true
      t.integer :status, default: 0
      t.boolean :keep_alive, default: false
      t.timestamps
    end
  end
end
