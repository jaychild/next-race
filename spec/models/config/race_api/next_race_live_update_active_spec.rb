require 'rails_helper'

describe Config::RaceApi do
  let(:race_api){ described_class }
  let(:key){ 'next_race' }

  describe '#next_race_live_update_active?' do
    context 'next_race api has not been added to configuration table' do
      it 'should return false' do
        expect(described_class.next_race_live_update_active?).to be_falsey
      end
    end

    context 'next_race api has been added to configuration table' do
      let(:test_api_url){ 'http://www.some_domain.horse/next_race' }
      after(:each){ described_class.where(key: key).delete_all }
      context 'and live update is not active' do
        before(:each){
          described_class.create(key: key, url: test_api_url)
        }
        it 'should return false' do
          expect(described_class.next_race_live_update_active?).to be_falsey
        end
      end

      context 'and live update is active' do
        before(:each){
          described_class.create(key: key, url: test_api_url, live_update: true)
        }
        it 'should return true' do
          expect(described_class.next_race_live_update_active?).to be_truthy
        end
      end
    end
  end
end
