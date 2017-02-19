require 'rails_helper'

describe WebApi::NextRace::Recorder do
  let(:recorder){ described_class.new }

  let(:course_name){ 'Ascot' }
  let(:create_course){ RaceCourse.create(name: existing_course)}
  let(:delete_course){ RaceCourse.where(name: existing_course).delete_all }
  let(:course_object){ RaceCourse.where(name: existing_course)[0] }
  let(:delete_race){ course_object.races.delete_all }

  let(:next_race_hash){
    {
        'course' => course_name,
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

  describe '#persistrace' do

    context 'API responds with next_race JSON hash' do
      before(:each){ recorder.persist_race(next_race_hash)}
      after(:each){ RaceCourse.where(name: 'course_name').destroy_all }
      it 'should return success hash' do
        expect(recorder.persist_race(next_race_hash)[:persisted]).to be_truthy
      end

      it 'should have created the course' do
        expect(RaceCourse.exists?(name: course_name)).to be_truthy
      end

      it 'should have created the race' do
        course = RaceCourse.where(name: course_name).first
        expect(course.races.exists?(distance: 3218.7)).to be_truthy
      end

      it 'should have created all the runners' do
        course = RaceCourse.where(name: course_name).first
        race = course.races.where(distance: 3218.7).last
        next_race_hash['runners'].each do |runner|
          expect(race.runners.exists?(
              number: runner['number'], jockey_name: runner['jockey_name'],
              horse_name: runner['horse_name'], form: runner['form'], odds: runner['odds']
          )).to be_truthy
        end
      end
    end

    context 'API responses with empty JSON hash' do
      it 'should not persist anything' do
        expect(recorder.persist_race({})[:persisted]).to be_falsey
      end
    end

  end
end
