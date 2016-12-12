class AddValueConstraintToMark < ActiveRecord::Migration[5.0]
  def up
    execute %{
      ALTER TABLE
        marks
      ADD CONSTRAINT
        value_must_be_in_1_5
      CHECK (value > 0 AND value < 6)
    }
  end
  def down
    execute %{
      ALTER TABLE
        marks
      DROP CONSTRAINT
        value_must_be_in_1_5
    }
  end
end
