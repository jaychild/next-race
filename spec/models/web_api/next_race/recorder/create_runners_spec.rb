require 'rails_helper'

describe WebApi::NextRace::Recorder do
  let(:recorder){ described_class.new }

  let(:existing_course){ 'Ascot' }
  let(:create_course){ RaceCourse.create(name: existing_course)}
  let(:delete_course){ RaceCourse.where(name: existing_course).destroy_all }
  let(:course_object){ RaceCourse.where(name: existing_course)[0] }

  let(:create_race){ create_course.races.create(distance: 3218.7, time: DateTime.now)}
  let(:delete_race){ course_object.races.destroy_all }
  let(:race_object){ course_object.races.last }

  let(:next_race_hash){
    {
        'course' => existing_course,
        'time' => '2017-02-19T14:00:00.000Z',
        'distance' => 3218.7,
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

  describe '#create_runners(race, runners)' do
    before(:each){ create_course }
    after(:each){ delete_course } # this should intern destroy races and runners via dependent: :destroy
    context 'race object passed' do
      context 'with next_race JSON hash' do
        before(:each){ create_race }

        it 'should instantiate array of Runner objects' do
          result = recorder.send(:create_runners, race_object, next_race_hash['runners'])
          expect(result.count).to eq(next_race_hash['runners'].count)
          expect(result.first).to be_a_new Runner
        end
      end

      context 'with empty JSON hash' do
        it 'should return empty array' do
          result = recorder.send(:create_runners, race_object, [])
          expect(result).to be_empty
        end
      end
    end

    context 'unpersisted race object' do
      context 'with next_race JSON hash' do
        it 'should raise an error' do
          expect{recorder.send(:create_runners, race_object, next_race_hash['runners'])}.to raise_error NoMethodError
        end
      end

      context 'with empty JSON hash' do
        it 'should return empty array' do
          result = recorder.send(:create_runners, race_object, [])
          expect(result).to be_empty
        end
      end
    end
  end

end
