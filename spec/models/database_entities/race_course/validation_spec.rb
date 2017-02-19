require 'rails_helper'

describe RaceCourse do
  context 'valid object' do
    it 'should be valid' do
      expect(described_class.new(name: 'Ascot').valid?).to be_truthy
    end

    it 'should save record' do
      course = described_class.new(name: 'Ascot')
      expect(course.save).to be_truthy
    end
  end

  context 'invalid object' do
    context 'name not specified' do
      it 'should not be valid' do
        course = described_class.new
        expect(course.valid?).to be_falsey
      end

      it 'should not save record' do
        course = described_class.new
        expect(course.save).to be_falsey
      end

      it 'should have errors' do
        course = described_class.new
        course.save
        expect(course.errors.full_messages).to eq(["Name can't be blank"])
      end
    end

    context 'name not unique' do
      before(:each){ described_class.create(name: 'Ascot') }
      after(:each){ described_class.delete_all }

      it 'should not be valid' do
        course = described_class.new(name: 'Ascot')
        expect(course.valid?).to be_falsey
      end

      it 'should not save record' do
        course = described_class.new(name: 'Ascot')
        expect(course.save).to be_falsey
      end

      it 'should have errors' do
        course = described_class.new(name: 'Ascot')
        course.save
        expect(course.errors.full_messages).to eq(["Name has already been taken"])
      end
    end
  end
end