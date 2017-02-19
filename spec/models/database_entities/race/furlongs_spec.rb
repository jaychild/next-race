require 'rails_helper'

describe Race do
  describe '#furlongs' do
    context 'distance has a value' do
      let(:race){ described_class.new(distance: 1000)}
      it 'should return conversion' do
        expect(race.furlongs).to eq(4.97)
      end
    end

    context 'distance is blank' do
      let(:race){ described_class.new(distance: nil)}
      it 'should return empty string' do
        expect(race.furlongs).to eq('')
      end
    end
  end
end
