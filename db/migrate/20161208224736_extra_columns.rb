class ExtraColumns < ActiveRecord::Migration
  def change
    add_column :albums, :recording, :string
    add_column :tracks, :location, :string
    add_column :tracks, :lyrics, :text
  end
end
