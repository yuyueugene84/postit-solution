class AddTimestampToAll < ActiveRecord::Migration
  def change
    add_column(:users, :created_at, :datetime)
    add_column(:users, :updated_at, :datetime)
    add_column(:posts, :created_at, :datetime)
    add_column(:posts, :updated_at, :datetime)
    add_column(:comments, :created_at, :datetime)
    add_column(:comments, :updated_at, :datetime)
    add_column(:categories, :created_at, :datetime)
    add_column(:categories, :updated_at, :datetime)
  end
end
