describe CR::DataContrib::FeastIdMap do
  let(:map) { described_class.load_default }

  shared_examples 'all maps' do
    it 'is a Hash' do
      expect(subject).to be_a Hash
    end

    it 'has no empty values' do
      expect(subject.values.none? {|i| i.nil? || i.empty? }).to be true
    end
  end

  describe '#calendarium_romanum_to_cantus' do
    subject { map.calendarium_romanum_to_cantus }

    it_behaves_like 'all maps'

    describe 'CANTUS ID known' do
      it 'has it' do
        expect(subject[:agatha]).to eq '14020500'
      end
    end

    describe 'CANTUS ID not known' do
      it 'does not have the key at all' do
        expect(subject).not_to have_key :korean_martyrs
      end
    end
  end

  describe '#cantus_to_calendarium_romanum' do
    subject { map.cantus_to_calendarium_romanum }

    it_behaves_like 'all maps'

    it 'works' do
      expect(subject['14020500']).to eq :agatha
    end
  end

  describe '#calendarium_romanum_to_romcal' do
    subject { map.calendarium_romanum_to_romcal }

    it_behaves_like 'all maps'

    it 'works' do
      expect(subject[:agatha]).to eq 'saintAgathaVirginAndMartyr'
    end
  end

  describe '#romcal_to_calendarium_romanum' do
    subject { map.romcal_to_calendarium_romanum }

    it_behaves_like 'all maps'

    it 'works' do
      expect(subject['saintAgathaVirginAndMartyr']).to eq :agatha
    end
  end

  describe '#romcal_to_cantus' do
    subject { map.romcal_to_cantus }

    it_behaves_like 'all maps'

    it 'works' do
      expect(subject['saintAgathaVirginAndMartyr']).to eq '14020500'
    end
  end

  describe '#cantus_to_romcal' do
    subject { map.cantus_to_romcal }

    it_behaves_like 'all maps'

    it 'works' do
      expect(subject['14020500']).to eq 'saintAgathaVirginAndMartyr'
    end
  end
end
