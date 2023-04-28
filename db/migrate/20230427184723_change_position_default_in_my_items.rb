class ChangePositionDefaultInMyItems < ActiveRecord::Migration[7.0]
  def change
  	change_column_default :my_items, :position, 1
  end
end
