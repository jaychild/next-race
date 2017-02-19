require 'rails_helper'

describe WebApi::Tracker do
  let(:tracker){ described_class.instance }
  let(:create_api){ Config::RaceApi.create(key: 'next_race', url: 'https://www.tipona.horse/next-race')}
  let(:api){  Config::RaceApi.first }

  before(:each){
    create_api
  }
  after(:each){  Config::RaceApi.destroy_all }

  describe '#live_thread?' do
    before(:each){
      allow_any_instance_of(WebApi::TrackerInterface).to receive(:track_resource).and_return(true)
    }

    context 'live tracking is enabled' do
      before(:each){
        allow(tracker).to receive(:active_tracking?).and_return(true)
      }

      after(:each){
        described_class.instance.kill_threads
      }

      it 'should return true' do
        tracker.poll_api(api)
        expect(tracker.send(:live_thread?)).to be_truthy
      end
    end

    context 'live tracking disabled' do
      before(:each){
        allow(tracker).to receive(:active_tracking?).and_return(false)
      }

      after(:each){
        described_class.instance.kill_threads
      }

      it 'should return true' do
        expect(tracker.send(:live_thread?)).to be_falsey
      end

    end
  end

end