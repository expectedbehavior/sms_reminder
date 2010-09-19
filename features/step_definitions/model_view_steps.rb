When /^I view the "([^\"]*)" ([^\"]*)$/ do |name, klass_name|
  obj = klass_name.classify.constantize.find_by_name(name)
  print_page_on_error { visit @host + full_path_for_object(obj) }
end

When /^I (view) (that) ([^\"]*)$/ do |a,b,klass_name|
  obj = get_recent(klass_name)
  print_page_on_error { visit @host + full_path_for_object(obj) }
end

# return an array of the required variables in the route for this object
def parent_route_variables(obj)
  case obj
    when Phase
      [:project_id]
    else
      []
  end
end

# try to get objects for the route variables to pass them to polymorphic_path
def full_path_for_object(obj)
  parents = parent_route_variables(obj).map { |var| obj.send(var.to_s.sub("_id", '')) }
  polymorphic_path(parents + [obj])
end

def dom_id(obj)
  "#{obj.class.name.down_under}_#{obj.id}"
end
