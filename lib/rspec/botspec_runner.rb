require 'rspec'
require 'load_dialogs.rb'

module BotSpec
    class BotSpecRunner < RSpec::Core::Runner

      def configure_rspec
        config = ::RSpec.configuration
      end

      def self.run(args, err=$stderr, out=$stdout)
        trap_interrupt
        options = RSpec::Core::ConfigurationOptions.new({})

        if options.options[:runner]
          options.options[:runner].call(options, err, out)
        else
          new(options).run(args, err, out)
        end
      end

      def run(args, out, err)
        setup(err, out)

        botname = args[:botname]
        return @configuration.reporter.exit_early(@configuration.failure_exit_code) if RSpec.world.wants_to_quit
        dialogs_path = args[:dialogs_path]

        run_specs(LoadDialogs.run_dialogs(botname, dialogs_path).map{|dialog| dialog.examples}.flatten).tap do
          persist_example_statuses
        end
      end
    end
end

