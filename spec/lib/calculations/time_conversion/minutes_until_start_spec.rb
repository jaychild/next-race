require 'rails_helper'

class DummyKlass
  include Calculations::TimeConversion
end

describe 'Calculations::TimeConversion' do
  let(:dummy_klass){ DummyKlass.new }
  describe '#minutes_until_start(time)' do
    before(:each){ allow(DateTime).to receive(:now).and_return(future_time) }

    context 'a time in the future' do
      let(:time){ DateTime.new(2017,2,18,9,5,6,'+7')}
      let(:future_time){ DateTime.new(2017,2,18,9,1,6,'+7') }
      it 'should return minutes until start' do
        expect(dummy_klass.minutes_until_start(time)).to eq(4)
      end
    end

    context 'a time in the past' do
      let(:time){ DateTime.new(2017,2,18,9,5,6,'+7')}
      let(:future_time){ DateTime.new(2017,2,18,9,5,7,'+7') }
      it 'should return 0' do
        expect(dummy_klass.minutes_until_start(time)).to eq(0)
      end
    end
  end
end