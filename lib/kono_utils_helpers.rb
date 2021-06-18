require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.enable_reloading # you need to opt-in before setup
loader.setup
module KonoUtilsHelpers
  # Your code goes here...
end
loader.eager_load