# Uninstall hook code here
require 'fileutils'
FileUtils.rm File.join(RAILS_ROOT, "script", "db_setup")
