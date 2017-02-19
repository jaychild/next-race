require 'rails_helper'

class DummyClass
  include WebApi::RequestLogger
end

describe 'WebApi::RequestLogger' do
  let(:dummy_klass){ DummyClass.new }

  context 'class that include the module can log to the RequestLogger model' do
    it 'should log request' do
      expect(
          dummy_klass.log_failure(
              'some error', 1, 'http://www.some_domain/some_request',
              'some response', 200, 'OK'
          )
      ).to be_truthy
    end
  end
end