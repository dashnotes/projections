class Projection < ActiveRecord::Migration
  def self.up
    create_table :projections do |t|
        t.column :date, :timestamp
        t.column :description, :string
        t.column :value, :integer
    end
  end

  def self.down
    drop_table :projections
  end
end
