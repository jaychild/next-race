require 'rails_helper'

describe Config::RaceApi do
  let(:race_api){ described_class }
  let(:key){ 'next_race' }
  describe '#next_race_url' do
    context 'when the next_race api is yet to be configured' do
      it 'should return nil' do
        expect(race_api.next_race_url).to eq(nil)
      end
    end

    context 'when the next_race api has been configured' do
      let(:test_api_url){ 'http://www.some_domain.horse/next_race' }
      before(:each){
        described_class.create(key: key, url: test_api_url)
      }
      after(:each){ described_class.where(key: key).delete_all }
      it 'should return value for url' do
        expect(race_api.next_race_url).to eq(test_api_url)
      end
    end
  end
end