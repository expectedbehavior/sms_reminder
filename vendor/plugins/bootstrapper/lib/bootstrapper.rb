class Bootstrapper
  class_inheritable_accessor :tasks
  write_inheritable_attribute :tasks, HashWithIndifferentAccess.new

  def self.for(key, &block)
    tasks[key] = block
  end
  
  @depth = 0
  
  def self.run_start(key)
    print "\033[1;31;40mBootstrapping\e[0m >>" if @depth == 0
    print " [\033[1;33;40m:#{key}\e[0m"
    @depth += 1
  end
  
  def self.run_end(key)
    @depth -= 1
    print "]"
    puts "\r\n\033[1;31;40mBootstrapping\e[0m >> \033[1;32;40mDone\e[0m" if @depth == 0
  end
  
  def self.run(key)
    self.run_start(key)
    tasks[key].call(self)
    self.run_end(key)
  end

  def self.truncate_tables(*tables)
    options = tables.last.is_a?(Hash) ? tables.pop : {}
    if tables == [:all]
      except = options[:except] || []
      except = except.is_a?(Array) ? except.collect { |x| x.to_s } : [except.to_s]

      tables = ActiveRecord::Base.connection.tables.select do |table|
        table !~ /schema_(info|migrations)/ && !except.include?(table)
      end
    end

    tables.each do |table|
      ActiveRecord::Base.connection.truncate_table(table)
    end
  end

  def self.fixtures(*fixtures)
    Fixtures.create_fixtures(File.join(RAILS_ROOT, 'db', 'populate'), fixtures)

  end

  def self.sql(sql)
    ActiveRecord::Base.connection.execute(sql)
  end
end
