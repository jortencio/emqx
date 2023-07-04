require 'singleton'

class LitmusHelper
  include Singleton
  include PuppetLitmus
end

RSpec.configure do |c|
  c.before :suite do
    LitmusHelper.instance.apply_manifest(File.read(File.join(__dir__, 'setup_acceptance_node.pp')))
  end
end
