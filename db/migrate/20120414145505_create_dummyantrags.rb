class CreateDummyantrags < ActiveRecord::Migration
  def change
    create_table :dummyantrags do |t|
      t.string    :gotype
      t.string    :goowner
      t.string    :gotitle
      t.string    :gotext
      t.string    :goelaboration
      t.timestamps
    end
  end
end
