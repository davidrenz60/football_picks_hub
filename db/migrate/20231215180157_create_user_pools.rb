class CreateUserPools < ActiveRecord::Migration[7.1]
  def change
    create_table :user_pools do |t|
      t.references :user, foreign_key: true
      t.references :pool, foreign_key: true

      t.timestamps
    end

      add_index :user_pools, [:user_id, :pool_id], unique: true
  end
end
