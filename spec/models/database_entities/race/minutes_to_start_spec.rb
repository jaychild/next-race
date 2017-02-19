require 'rails_helper'

describe Race do
  describe '#minutes_to_start' do
    context 'time has a value' do
      before(:each){ allow(DateTime).to receive(:now).and_return(future_time) }
      let(:future_time){ DateTime.new(2017,2,18,9,1,6,'+7') }
      let(:race){ described_class.new(time: DateTime.new(2017,2,18,9,5,6,'+7'))}
      it 'should return conversion' do
        expect(race.minutes_to_start).to eq(4)
      end
    end

    context 'time is blank' do
      let(:race){ described_class.new(time: nil)}
      it 'should return empty string' do
        expect(race.minutes_to_start).to eq('')
      end
    end
  end
end
