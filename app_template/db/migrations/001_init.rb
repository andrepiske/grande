Sequel.migration do
  up do
    sql = <<-SQL
    -- initial stuff here
    SQL

    run sql
  end

  down do
    raise 'not implemented'
  end
end
