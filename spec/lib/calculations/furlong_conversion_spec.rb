require 'spec_helper'
require 'rails_helper'
require_relative '../../../lib/calculations/furlong_conversion'

class DummyKlass
  include Calculations::FurlongConversion
end

describe 'Calculations::FurlongConversion' do
  describe '#metres_to_furlongs' do
    let(:dummy_klass){ DummyKlass.new }
    context 'passing the expected integer or decimal value' do
      context 'odd number of meters' do
        let(:odd){ 1007 }
        it 'should return correct furlong conversion' do
          expect(dummy_klass.metres_to_furlongs(odd)).to eq(5.01)
        end
      end

      context 'even number of meters' do
        let(:even){ 3582 }
        it 'should return correct furlong conversion' do
          expect(dummy_klass.metres_to_furlongs(even)).to eq(17.81)
        end
      end

      context 'meters as a decimal' do
        let(:decimal){ 1000.45 }
        it 'should return correct furlong conversion' do
          expect(dummy_klass.metres_to_furlongs(decimal)).to eq(4.97)
        end
      end
    end

    context 'passing a string value instead of the expected integer/ decimal' do
      let(:string_value){ '1234.54' }
      it 'should raise exception' do
        expect{ dummy_klass.metres_to_furlongs(string_value) }.to raise_error(NoMethodError)
      end
    end

  end
end