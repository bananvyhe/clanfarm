class ChangeHpstringtoint < ActiveRecord::Migration[7.0]
  def up
    change_column :mobs, :hp, 'integer USING CAST(hp AS integer)'
    change_column :mobs, :loa, 'integer USING CAST(loa AS integer)'
  end

  def down
    change_column :mobs, :hp, :string
    change_column :mobs, :loa, :string
  end
end
