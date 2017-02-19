require 'rails_helper'

describe WebApi::NextRace::Recorder do
  let(:recorder){ described_class.new }

  let(:existing_course){ 'Ascot' }
  let(:new_course){ 'Market Rasen' }

  let(:ok_api_response){
    {
        'course' => existing_course,
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

  describe '#create_or_find_course' do
    context 'API successfully returns next race JSON hash' do
      context 'the course specified already exists' do
        before(:each){ RaceCourse.create(name: existing_course) }
        after(:each){ RaceCourse.where(name: existing_course).destroy_all }
        it 'should return persisted' do
          hash = recorder.send(:create_or_find_course, ok_api_response['course'])
          expect(hash[:persisted]).to be_truthy
        end

        it 'should return course name' do
          hash = recorder.send(:create_or_find_course, ok_api_response['course'])
          expect(hash[:object].name).to eq(existing_course)
        end

        it 'should not have errors' do
          hash = recorder.send(:create_or_find_course, ok_api_response['course'])
          expect(hash[:error].any?).to be_falsey
        end

      end

      context 'the course specified does not already exist' do
        let(:ok_api_response){
          {
              'course' => new_course,
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

        it 'should return persisted' do
          hash = recorder.send(:create_or_find_course, ok_api_response['course'])
          expect(hash[:persisted]).to be_truthy
        end

        it 'should return course name' do
          hash = recorder.send(:create_or_find_course, ok_api_response['course'])
          expect(hash[:object].name).to eq(new_course)
        end

        it 'should not have errors' do
          hash = recorder.send(:create_or_find_course, ok_api_response['course'])
          expect(hash[:error].any?).to be_falsey
        end
      end

    end

    context 'API returns empty JSON hash' do
      let(:not_found_api_response){ {} }
      it 'should return hash with errors' do
        hash = recorder.send(:create_or_find_course, not_found_api_response['course'])
        expect(hash[:error]).to eq(["Name can't be blank"])
      end

      it 'should not have persisted object' do
        hash = recorder.send(:create_or_find_course, not_found_api_response['course'])
        expect(hash[:persisted]).to be_falsey
      end

    end
  end

end