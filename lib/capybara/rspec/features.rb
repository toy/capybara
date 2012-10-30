module Capybara
  module Features
    def self.included(base)
      base.instance_eval do
        alias :background :before
        alias :scenario :it
        alias_example_to :xscenario, :pending => "temporarily disabled with xscenario"
        alias :given :let
        alias :given! :let!
      end
    end
  end
end

def self.feature(*args, &block)
  options = if args.last.is_a?(Hash) then args.pop else {} end
  options[:capybara_feature] = true
  options[:type] = :feature
  options[:caller] ||= caller
  args.push(options)

  describe(*args, &block)
end

RSpec.configuration.include Capybara::Features, :capybara_feature => true
