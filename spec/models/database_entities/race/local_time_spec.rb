require 'rails_helper'

describe Race do
  describe '#local_time' do
    context 'time has a value' do
      let(:race){ described_class.new(time: DateTime.new(2017,2,18,9,5,6,'+7'))}
      it 'should return conversion' do
        expect(race.local_time).to eq('Saturday, 18 Feb 2017  2:05 AM')
      end
    end

    context 'time is blank' do
      let(:race){ described_class.new(time: nil)}
      it 'should return empty string' do
        expect(race.local_time).to eq('')
      end
    end
  end
end
