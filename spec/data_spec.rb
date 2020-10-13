require_relative 'spec_helper'

describe 'data files' do
  let(:loader) { CR::SanctoraleLoader.new }

  Dir['*/**/*.txt'].each do |path|
    describe path do
      it 'can be loaded' do
        expect { loader.load_from_file path }
          .not_to raise_exception
      end
    end
  end
end
