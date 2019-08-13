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

module BotSpec
 module AWS
   class LexService
     def initialize(arg1)
     end
     def post_message(arg1, arg2)
       p '********'
       p 'NOT MOCKED!!!!'
       p '********'
       { arg: 1 }
     end
   end
 end
end

class Dialog
 attr_reader :describe, :name, :interactions
 attr_accessor :file
 def initialize args
   args.each do |k,v|
     instance_variable_set("@#{k}", v) unless v.nil?
   end
 end
 def interactions
   @interactions
 end
 def lex_chat
   @lex_chat ||= BotSpec::AWS::LexService.new(botname: 'Hello')
 end
 def create_example_group()
   @examples = create_example(@interactions).flatten
 end
 def examples
   @examples
 end
 def create_example(interactions, examples = [])
   return if interactions.size == 0
   dialog = self
   spec = ::RSpec.describe "#{@describe} #{@name}" do
           # allowing the caller to mock
           before do
             yield if block_given?
           end
           let(:resp) { dialog.lex_chat.post_message(interactions[0], 'user_id') }
           it interactions[0] do
             expect(resp[:message]).to match(interactions[1])
           end
         end
   examples << spec
   create_example(interactions.drop(2), examples)
   examples
 end
end
