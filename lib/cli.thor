
require 'botspec/lex/lex_service.rb'
require 'botspec/version'
require 'thor'
require 'load_dialogs.rb'
require 'rspec/botspec_runner.rb'

class CLI < Thor

  desc 'verify', "Verify a chat suite"
  method_option :dialogs, aliases: "-f", desc: "Yaml file containing dialogs", :required => true
  method_option :botname, aliases: "-n", desc: "The name of the Amazon Web Services Lex chatbot"

  def verify()
    dialogs = options[:dialogs]

    bot_name = 'ElliottOrderFlowers'
    if options[:botname]
      bot_name = options[:botname]
    end

    puts "running specs in #{dialogs} for bot #{bot_name}"

    BotSpec::BotSpecRunner.run({dialogs_path: dialogs, botname: bot_name})
  end

end
