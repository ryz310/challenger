# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RubocopChallenger::Rubocop::Yardoc do
  let(:yardoc) { described_class.new(title) }
  let(:title) { 'Style/Alias' }

  describe '#initialize' do
    context 'with rubocop gem' do
      let(:title) { 'Layout/EmptyLineAfterGuardClause' }

      it 'finds a cop class from rubocop' do
        expect { yardoc }.not_to raise_error
      end
    end

    context 'with rubocop-performance gem' do
      let(:title) { 'Performance/Size' }

      it 'finds a cop class from rubocop/performance' do
        expect { yardoc }.not_to raise_error
      end
    end

    context 'with rubocop-rails gem' do
      let(:title) { 'Rails/SquishedSQLHeredocs' }

      it 'finds a cop class from rubocop/rails' do
        expect { yardoc }.not_to raise_error
      end
    end

    context 'with rubocop-rspec gem' do
      let(:title) { 'Capybara/CurrentPathExpectation' }

      it 'finds a cop class from rubocop/rspec' do
        expect { yardoc }.not_to raise_error
      end
    end
  end

  describe '#description' do
    let(:docstring) { <<~DOCSTRING.chomp }
      This cop enforces the use of either `#alias` or `#alias_method`
      depending on configuration.
      It also flags uses of `alias :symbol` rather than `alias bareword`.
    DOCSTRING

    it 'returns cop description using yardoc' do
      expect(yardoc.description).to eq docstring
    end
  end

  describe '#examples' do
    let(:example_1) { <<~EXAMPLE.chomp }
      # bad
      alias_method :bar, :foo
      alias :bar :foo

      # good
      alias bar foo
    EXAMPLE

    let(:example_2) { <<~EXAMPLE.chomp }
      # bad
      alias :bar :foo
      alias bar foo

      # good
      alias_method :bar, :foo
    EXAMPLE

    it 'returns Array which includes cop examples name and text using yardoc' do
      expect(yardoc.examples).to eq [
        ['EnforcedStyle: prefer_alias (default)', example_1],
        ['EnforcedStyle: prefer_alias_method',    example_2]
      ]
    end
  end
end
