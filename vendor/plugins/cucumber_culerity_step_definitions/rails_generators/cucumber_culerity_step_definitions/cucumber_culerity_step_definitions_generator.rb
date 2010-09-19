class CucumberCulerityStepDefinitionsGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      m.directory 'features/step_definitions'
      m.file 'features/step_definitions/common_celerity_steps.rb', 'features/step_definitions/common_celerity_steps.rb'
      m.file 'features/step_definitions/model_steps.rb', 'features/step_definitions/model_steps.rb'
      m.file 'features/step_definitions/model_view_steps.rb', 'features/step_definitions/model_view_steps.rb'
    end
  end

protected

  def banner
    "Usage: #{$0} cucumber_culerity_step_definitions"
  end

end
