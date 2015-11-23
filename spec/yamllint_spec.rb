require 'spec_helper'
require_relative '../lib/yaml-lint'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures/'

describe 'YamlLint' do
  describe '.do_lint' do
    it 'accepts a good yaml file' do
      lint = YamlLint.new(FIXTURES_PATH + 'good.yaml')
      expect(lint.do_lint).to eq 0
    end

    it 'refuses a bad yaml file' do
      lint = YamlLint.new(FIXTURES_PATH + 'bad.yaml')
      expect(lint.do_lint).to eq 1
    end

    it 'checks both files in a dir' do
      lint = YamlLint.new(FIXTURES_PATH)
      expect(lint.do_lint).to be > 0
    end
  end

  describe 'the logging' do
    it 'writes OK and error when not quiet' do
      lint = YamlLint.new(FIXTURES_PATH)
      expect { lint.do_lint }.to output(/Syntax OK/).to_stdout
      expect { lint.do_lint }.to output(/error/).to_stdout
    end

    it 'does write only errors when quiet' do
      lint = YamlLint.new(FIXTURES_PATH, {:quiet => true})
      expect { lint.do_lint }.to_not output(/Syntax OK/).to_stdout
      expect { lint.do_lint }.to output(/error/).to_stdout
    end

    it 'does not write anything when very quiet' do
      lint = YamlLint.new(FIXTURES_PATH, {:veryquiet => true})
      expect { lint.do_lint }.to_not output(/Syntax OK/).to_stdout
      expect { lint.do_lint }.to_not output(/error/).to_stdout
    end
  end

  describe 'with different file extensions' do
    it 'is okay with known extensions' do
      lint = YamlLint.new(FIXTURES_PATH + 'good.yaml')
      expect(lint.do_lint).to eq 0
      lint = YamlLint.new(FIXTURES_PATH + 'good.yml')
      expect(lint.do_lint).to eq 0
    end

    it 'is not okay with an unknown extensions' do
      lint = YamlLint.new(FIXTURES_PATH + 'good.lmay')
      expect(lint.do_lint).to eq 1
    end

    it 'is okay with an unknown extensions when the extension is not checked' do
      lint = YamlLint.new(FIXTURES_PATH + 'good.lmay', {:nocheckfileext => true})
      expect(lint.do_lint).to eq 0
    end
  end

  describe 'the indentation' do
    it 'is okay with even number of whitespaces' do
      lint = YamlLint.new(FIXTURES_PATH + 'good.yaml')
      expect(lint.do_lint).to eq 0
    end

    it 'is not okay with odd number of whitespaces' do
      lint = YamlLint.new(FIXTURES_PATH + 'bad_indentation.yaml')
      expect(lint.do_lint).to eq 1
    end
  end

  describe 'the quotes' do
    it 'is okay with single quotes' do
      lint = YamlLint.new(FIXTURES_PATH + 'good_single_quotes.yaml')
      expect(lint.do_lint).to eq 0
    end

    it 'is okay with double quotes' do
      lint = YamlLint.new(FIXTURES_PATH + 'good_double_quotes.yaml')
      expect(lint.do_lint).to eq 0
    end

    it 'is not okay with just one single quote per element, even if there is a even count of quotes per line' do
      lint = YamlLint.new(FIXTURES_PATH + 'bad_single_quote_even.yaml')
      expect(lint.do_lint).to eq 1
    end

    it 'is not okay with just one single quote per element, if there is a add count of quotes per line' do
      lint = YamlLint.new(FIXTURES_PATH + 'bad_single_quote_odd.yaml')
      expect(lint.do_lint).to eq 1
    end
  end

  describe 'the colon' do
    it 'is not okay with a colon before a quote' do
      lint = YamlLint.new(FIXTURES_PATH + 'bad_colon.yaml')
      expect(lint.do_lint).to eq 1
    end
  end
end
