require 'rails_helper'

describe Logger::ApiRequestLogger do
  context 'no validations so should accept any old garbage' do
    let(:log){ described_class.new(api_request: 'garbage', api_response: 'garbage', code: 1234, message: 'some garbage', api_id: 123)}
    it 'should be valid' do
      expect(log.valid?).to be_truthy
    end

    it 'should persist log' do
      expect(log.save).to be_truthy
    end
  end
end

describe Logger::NextRaceLogger do
  context 'no validations so should accept any old garbage' do
    let(:log){ described_class.new(error: 'garbage', logged_at: Time.now)}
    it 'should be valid' do
      expect(log.valid?).to be_truthy
    end

    it 'should persist log' do
      expect(log.save).to be_truthy
    end
  end
end