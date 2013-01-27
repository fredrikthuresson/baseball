# A sample Guardfile
# More info at https://github.com/guard/guard#readme

require 'guard/rspec'
guard :rspec do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})           { |m| "spec/lib/#{m[1]}_spec.rb" }
end
