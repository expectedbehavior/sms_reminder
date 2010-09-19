When /^I get that ([^\"]*)$/ do |klass|
  var_name = klass.downcase.gsub(/\s/,'_')
  instance_variable_set "@recent_#{var_name}", var_name.classify.constantize.last
end

Given /^there is (a|an) ([^\"]*)$/ do |bogus, klass|
  var_name = klass.down_under
  instance_variable_set "@recent_#{var_name}", Factory(var_name.to_sym)
end

Given /^that ([^\"]*) has "([^\"]*)" set to "([^\"]*)"$/ do |klass, field_, value|
  var_ = instance_variable_get "@recent_#{klass.classify.down_under}"
  var_.send("#{field_.down_under}=", value)
  var_.save!
end

Given /^that ([^\"]*) is reloaded$/ do |klass|
  var_ = instance_variable_get "@recent_#{klass.classify.down_under}"
  var_.reload
end

Given /^that ([^\"]*) belongs to the "([^\"]*)" ([^\"]*)$/ do |child_klass, parent_name, parent_klass|
  child = get_recent(child_klass)
  parent = parent_klass.classify.constantize.find_by_name(parent_name)
  child.send("#{parent_klass.down_under}=", parent)
  child.save!
end

Given /^there are ([0-9]+) ([^\"]*) with name containing "([^\"]*)"$/ do |number, klass, name|
  var_name = klass.down_under.singularize
  number.to_i.times do |i|
    create_object_with_name_using_factory(var_name, "#{name} #{i}")
  end
end

Given /^there is (a|an) ([^\"]*) whose name contains "([^\"]*)"$/ do |bogus, klass, name|
  var_name = klass.down_under
  instance_variable_set "@recent_#{var_name}", create_object_with_name_using_factory(var_name, "#{name} #{rand(500)}")
end

Given /^there is (a|an) ([^\"]*) with ([^\"]*) "([^\"]*)"$/ do |bogus, klass, key, value|
  var_name = klass.down_under
  instance_variable_set "@recent_#{var_name}", create_object_with_key_value_using_factory(var_name, key, value)
end

Given /^there is (a|an) ([^\"]*) named "([^\"]*)"$/ do |bogus, klass, name|
  var_name = klass.down_under
  instance_variable_set "@recent_#{var_name}", create_object_with_name_using_factory(var_name, name)
end

def create_object_with_key_value_using_factory(klass, key, value)
  Factory(klass.to_sym, key => value)
end

def create_object_with_name_using_factory(klass, name)
  oklass = Object.const_get(klass.classify)
  if oklass && !oklass.columns.map(&:name).include?("name")
    names = name.split(" ", 2)
    Factory(klass.to_sym, "first_name" => names[0], "last_name" => names[1])
  else
    create_object_with_key_value_using_factory(klass, "name", name)
  end
end

def get_recent(klass_name)
  instance_variable_get "@recent_#{klass_name.classify.down_under}"
end

Given /^that ([^\"]*) belongs to that ([^\"]*)$/ do |child_klass, parent_klass|
  child = instance_variable_get "@recent_#{child_klass.classify.down_under}"
  parent = instance_variable_get "@recent_#{parent_klass.classify.down_under}"
  child.send("#{parent_klass.down_under}=", parent)
  child.save!
end

When /^I get the last ([^\"]*)$/ do |klass_name|
  var_name = klass_name.down_under
  instance_variable_set "@recent_#{var_name}", var_name.classify.constantize.last
end

# Use: Then there should be a Story named "Foo"
# checks the db for a record with that name and sets @recent_<klass> to that record
Then /^there should be a ([^\"]*) named "([^\"]*)"$/ do |klass, name|
  print_page_on_error do
    var_ = Object.const_get(klass.classify).find_by_name(name)
    assert ! var_.blank?, "couldn't find a record with that name"
    instance_variable_set "@recent_#{klass.down_under}", var_
  end
end

# Use: Then "status" for that Task should be "unstarted"
# checks the db to make sure the field is set to the value for @recent_<klass>
Then /^"([^\"]*)" for that ([^\"]*) should be "([^\"]*)"$/ do |field_, klass, value|
  check_variable_field_klass_value(field_, klass, value)
end

Then /^"([^\"]*)" for that ([^\"]*) should be$/ do |field_, klass, value|
  check_variable_field_klass_value(field_, klass, value)
end

def check_variable_field_klass_value(field_, klass, value)
  value = nil if value.blank?
  value = value == "true" if ["true", "false"].include? value
  # "200" gets parsed as a date when I don't want it to be
  if(value.size >= 8 && Date.parse(value) rescue nil)
    value = Date.parse(value) 
  end
  var_ = instance_variable_get "@recent_#{klass.classify.down_under}"
  eval("var_.reload.#{field_}").should == value
end

When /^that ([^\"]*) is destroyed$/ do |klass|
  var_ = instance_variable_get "@recent_#{klass.classify.down_under}"
  var_.destroy
end
