require 'rails_helper'

class DummyKlass
  include Calculations::TimeConversion
end

describe 'Calculations::TimeConversion' do
  let(:time){ DateTime.new(2017,11,5,9,5,6,'+7')}
  let(:dummy_klass){ DummyKlass.new }
  describe '#pretty_local_time(time)' do
    it 'should print DateTime in nice string format, local time' do
      expect(dummy_klass.pretty_local_time(time)).to eq('Sunday, 05 Nov 2017  2:05 AM')
    end
  end
end