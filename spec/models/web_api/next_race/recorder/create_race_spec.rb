require 'rails_helper'

describe WebApi::NextRace::Recorder do
  let(:recorder){ described_class.new }

  let(:existing_course){ 'Ascot' }
  let(:create_course){ RaceCourse.create(name: existing_course)}
  let(:delete_course){ RaceCourse.where(name: existing_course).destroy_all }
  let(:course_object){ RaceCourse.where(name: existing_course)[0] }
  let(:delete_race){ course_object.races.destroy_all }

  let(:next_race_hash){
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

  describe '#create_race' do
    context 'course object passed to method with JSON hash of next_race' do
      before(:each){ create_course }
      after(:each){ delete_course }
      it 'should create race object' do
        expect(recorder.send(:create_race, course_object, next_race_hash)[:persisted]).to be_truthy
      end

      it 'should not have errors' do
        expect(recorder.send(:create_race, course_object, next_race_hash)[:error].empty?).to be_truthy
      end
    end

    context 'unpersisted course object passed with JSON hash of next_race' do
      it 'should raise error' do
        expect{recorder.send(:create_race, course_object, next_race_hash)}.to raise_exception NoMethodError
      end
    end

    context 'course object passed with empty JSON hash' do
      before(:each){ create_course }
      after(:each){ delete_course }
      it 'should not persist race' do
        expect(recorder.send(:create_race, course_object, {})[:persisted]).to be_falsey
      end

      it 'should return errors' do
        expect(recorder.send(:create_race, course_object, {})[:error]).to eq(["Time can't be blank", "Distance can't be blank"])
      end
    end

    context 'unpersisted course object passed with empty JSON hash' do
      it 'should raise error' do
        expect{recorder.send(:create_race, course_object, {})}.to raise_exception NoMethodError
      end
    end
  end

end
