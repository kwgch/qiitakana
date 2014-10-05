ActiveRecord::Base.send(:define_singleton_method , "union", proc { |*queries|
#   binding.pry
  from "(#{ queries.map { |q| q.ast.to_sql }.join(' UNION ') }) AS #{self.table_name}"
})