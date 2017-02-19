require 'rails_helper'

  describe WebApi::NextRace::Service do
    let(:next_race_hash){
      {
          'course' => 'Ascot',
          'time' => '2017-02-19T14:00:00.000Z',
          'distance' => '3218.7',
          'runners' => [
              {
                  'number' => 1,
                  'horse_name' => 'All My Love',
                  'jockey_name' => 'Kielan Woods',
                  'form' => 'F',
                  'odds' => '2.6'
              },
              {
                  'number' => 2,
                  'horse_name' => 'Lavella Wells',
                  'jockey_name' => 'Danny Cook',
                  'form' => '5/6',
                  'odds' => '41.0'
              },
              {
                  'number' => 3,
                  'horse_name' => 'Queen Odessa',
                  'jockey_name' => 'Noel Fehily',
                  'form' => '31-0',
                  'odds' => '4.0'
              },
              {
                  'number' => 4,
                  'horse_name' => 'Squablin',
                  'jockey_name' => 'Stephen McCarthy',
                  'form' => '5676',
                  'odds' => '51.0'
              },
              {
                  'number' => 5,
                  'horse_name' => 'Treackle Tart',
                  'jockey_name' => 'Richard Johnson',
                  'form' => '4592',
                  'odds' => '4.0'
              },
              {
                  'number' => 7,
                  'horse_name' => 'Want The Fairytale',
                  'jockey_name' => 'Wayne Hutchinson',
                  'form' => '',
                  'odds' => '7.5'
              }
          ]
      }
    }

  describe '#request_next_race' do
    let(:service){ described_class.new}

      context 'resource returns next_race JSON hash' do
      before(:each){ allow(service).to receive(:get_resource).and_return(next_race_hash) }
      it 'should successfully create records' do
        expect(service.request_next_race[:persisted]).to be_truthy
      end
    end

    context 'empty hash returns by API' do
      before(:each){ allow(service).to receive(:get_resource).and_return({}) }
      it 'should not have persisted any records' do
        expect(service.request_next_race[:persisted]).to be_falsey
      end

     it 'should have returned errors' do
        expect(service.request_next_race[:error].any?).to be_truthy
      end

      it 'should have logged failed persistence' do
        service.request_next_race
        expect(Logger::NextRaceLogger.all.any?).to be_truthy
      end
    end
  end
end