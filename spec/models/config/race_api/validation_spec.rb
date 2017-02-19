require 'rails_helper'

describe Config::RaceApi do
  let(:race_api){ described_class }
  let(:key){ 'next_race' }
  let(:url){ 'http://www.some_domain.horse/next_race' }
  let(:save_api){ race_api_instance.save }

  describe '#validations' do
    context 'when a RaceApi record is invalid' do
      context 'when the key has not been specified' do
        let(:race_api_instance){ race_api.new(url: url)}
        let(:errors){ ["Key can't be blank", "Key must specify 'next_race' as API key"] }

        it 'should be invalid' do
          expect(race_api_instance.valid?).to be_falsey
        end

        it 'should block the record from being persisted' do
          result = save_api
          expect(result).to be_falsey
        end

        it 'should have appropriate error message' do
          save_api
          expect(race_api_instance.errors.full_messages).to eq(errors)
        end
      end

      context 'when the key is not next_race' do
        let(:something_invalid){ 'previous_race' }
        let(:race_api_instance){ race_api.new(key: something_invalid, url: url)}
        let(:errors){ ["Key must specify 'next_race' as API key"] }

        it 'should be invalid' do
          expect(race_api_instance.valid?).to be_falsey
        end

        it 'should block the record from being persisted' do
          result = save_api
          expect(result).to be_falsey
        end

        it 'should have appropriate error message' do
          save_api
          expect(race_api_instance.errors.full_messages).to eq(errors)
        end
      end

      context 'when the key is not unique' do
        let(:race_api_instance){ race_api.new(key: key, url: url)}
        let(:errors){ ["Key has already been taken"] }

        before(:each){ described_class.create(key: key, url: url) }
        after(:each){ described_class.where(key: key).delete_all }

        it 'should be invalid' do
          expect(race_api_instance.valid?).to be_falsey
        end

        it 'should block the record from being persisted' do
          result = save_api
          expect(result).to be_falsey
        end

        it 'should have appropriate error message' do
          save_api
          expect(race_api_instance.errors.full_messages).to eq(errors)
        end
      end

      context 'when the url has not been specified' do
        let(:race_api_instance){ race_api.new(key: key)}
        let(:errors){ ["Url can't be blank"] }

        it 'should be invalid' do
          expect(race_api_instance.valid?).to be_falsey
        end

        it 'should block the record from being persisted' do
          result = save_api
          expect(result).to be_falsey
        end

        it 'should have appropriate error message' do
          save_api
          expect(race_api_instance.errors.full_messages).to eq(errors)
        end
      end
    end
  end
end
