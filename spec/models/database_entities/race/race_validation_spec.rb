require 'rails_helper'

describe Race do
  before(:each){
    RaceCourse.create(name: 'Ascot')
  }

  let(:race){ RaceCourse.where(name: 'Ascot').first.races.new}

  context 'valid object' do
    it 'should be a valid object' do
      race.time = DateTime.now
      race.distance = 1234
      expect(race.valid?).to be_truthy
    end

    it 'should not have errors' do
      race.time = DateTime.now
      race.distance = 1234
      race.valid?
      expect(race.errors.full_messages.empty?).to be_truthy
    end

    it 'should save object' do
      race.time = DateTime.now
      race.distance = 1234
      expect(race.save).to be_truthy
    end
  end

  context 'invalid object' do
    context 'time is not specified' do
      it 'should not be valid' do
        race.distance = 1234
        expect(race.valid?).to be_falsey
      end

      it 'should have errors' do
        race.distance = 1234
        race.save
        expect(race.errors.full_messages).to eq(["Time can't be blank"])
      end

      it 'should not save' do
        race.distance = 1234
        expect(race.save).to be_falsey
      end
    end

    context 'distance is not specified' do
      it 'should not be valid' do
        race.time = DateTime.now
        expect(race.valid?).to be_falsey
      end

      it 'should have errors' do
        race.time = DateTime.now
        race.save
        expect(race.errors.full_messages).to eq(["Distance can't be blank"])
      end

      it 'should not save' do
        race.time = DateTime.now
        expect(race.save).to be_falsey
      end
    end
  end
end