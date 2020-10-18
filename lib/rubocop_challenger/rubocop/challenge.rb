# frozen_string_literal: true

module RubocopChallenger
  module Rubocop
    # To execute Rubocop Challenge flow
    class Challenge
      def self.exec(file_path, mode)
        new(file_path, mode).send(:exec)
      end

      private

      attr_reader :mode, :command, :todo_reader, :todo_writer

      def initialize(file_path, mode)
        @mode = mode
        @command = Rubocop::Command.new
        @todo_reader = Rubocop::TodoReader.new(file_path)
        @todo_writer = Rubocop::TodoWriter.new(file_path)
      end

      # @raise [Errors::NoAutoCorrectableRule]
      def exec
        verify_target_rule
        todo_writer.delete_rule(target_rule)
        command.auto_correct_all
        target_rule
      end

      def verify_target_rule
        return unless target_rule.nil?

        raise Errors::NoAutoCorrectableRule
      end

      def target_rule
        @target_rule ||=
          case mode
          when 'least_occurrence' then todo_reader.least_occurrence_rule
          when 'random'           then todo_reader.any_rule
          when 'most_occurrence'  then todo_reader.most_occurrence_rule
          else raise "`#{mode}` is not supported mode"
          end
      end
    end
  end
end
