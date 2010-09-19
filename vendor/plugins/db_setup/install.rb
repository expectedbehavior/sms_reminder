# Install hook code here
require 'fileutils'
FileUtils.cp File.join(File.dirname(__FILE__), "script", "db_setup"), File.join(RAILS_ROOT, "script", "db_setup")
