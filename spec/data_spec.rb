require_relative 'spec_helper'

describe 'data files' do
  let(:loader) { CR::SanctoraleLoader.new }

  dirs = Dir['*/*.txt'].collect {|f| File.dirname f }.uniq

  dirs.each do |dir|
    describe dir do
      Dir["#{dir}/*.txt"].each do |path|
        describe File.basename(path) do
          it 'can be loaded' do
            expect { loader.load_from_file path }
              .not_to raise_exception
          end

          it 'can be loaded with parents' do
            expect { CR::SanctoraleFactory.load_with_parents path }
              .not_to raise_exception
          end
        end
      end
    end
  end
end
