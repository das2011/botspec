require 'yaml'
require 'hashie'
require 'botspec/lex/lex_service.rb'
require 'rspec'

require "bundler/setup"
require 'byebug'

class LoadDialogs

  def self.run_dialogs botname, dialogs_path
    @@botname = botname

    dialog_paths = Dir.glob(dialogs_path).select{ |e| File.file? e }
    #dialog_paths = Dir["#{dialogs_path}*\[yaml|yml\]"]
    dialog_yamls = dialog_paths.collect{ |dialog_file| Hashie.symbolize_keys YAML.load_file(dialog_file).merge!(file: dialog_file) }

    dialog_yamls.collect{ |dialog_content|
      dialog_content[:dialogs].collect{ |dialog|
        Dialog.new({describe: dialog_content[:description], name: dialog[:what], interactions:  dialog[:dialog], file: dialog_content[:file]})
      }.each{ |dialog|
        dialog.create_example_group
      }
    }.flatten
  end

  def self.botname
    @@botname
  end
end

class Dialog
  attr_reader :describe, :name, :interactions, :file

  def initialize args
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def file(file)
    @file = file
  end

  def interactions
    @interactions
  end


  def lex_chat
    @lex_chat ||= BotSpec::AWS::LexService.new({botname: LoadDialogs.botname})
  end

  def create_example_group()
    @examples = create_example(@interactions).flatten
  end

  def examples
    @examples
  end

  def create_example(interactions, examples=[])
    return if interactions.size == 0

    @@lex_chat = lex_chat()
    examples << ::RSpec.describe("#{@describe} #{@name}") do

      it @name do

        interactions.each_slice(2) do |spec, value|
          puts spec
          puts value
          resp = @@lex_chat.post_message(spec, 'user_id')

          expect(resp[:message]).to eql(value)
        end
      end
    end
    
    examples
  end
end
