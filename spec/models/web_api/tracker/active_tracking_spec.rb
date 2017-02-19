require 'rails_helper'

describe WebApi::Tracker do
  let(:tracker){ described_class.instance }
  let(:create_api){ Config::RaceApi.create(key: 'next_race', url: 'https://www.tipona.horse/next-race')}

  before(:each){
    allow_any_instance_of(Config::RaceApi).to receive(:start_tracking).and_return(true) # just so we don't actually start the tracking process
    create_api
  }
  after(:each){  Config::RaceApi.all.destroy_all }

  describe '#active_tracking?' do
    context 'live_update set to true' do
      before(:each){
        inst = Config::RaceApi.all.first
        inst.live_update = true
        inst.save
      }
      it 'should return true' do
        expect(tracker.send(:active_tracking?, Config::RaceApi, 'next_race')).to be_truthy
      end
    end

    context 'live update set to false' do
      # false by default
      it 'should return false' do
        expect(tracker.send(:active_tracking?, Config::RaceApi, 'next_race')).to be_falsey
      end
    end
  end

end
