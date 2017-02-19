require 'rails_helper'

describe WebApi::Tracker do
  let(:tracker){ described_class.instance }

  after(:each){
    Config::RaceApi.all.destroy_all
  }

  describe '#pol_api' do

    context 'when live_update is enabled' do
      context 'when the api tracker is enabled twice in a tow' do
        let(:create_api){ Config::RaceApi.create(key: 'next_race', url: 'https://www.tipona.horse/next-race', live_update: true)}
        before(:each){
          allow_any_instance_of(Config::RaceApi).to receive(:start_tracking).and_return(true) # just so we don't actually start the tracking process
          allow_any_instance_of(WebApi::TrackerInterface).to receive(:track_resource).and_return(true)
          allow(tracker).to receive(:active_tracking?).and_return(true)

          create_api
          # poll_api called twice in concession
          tracker.poll_api(Config::RaceApi.first)
          tracker.poll_api(Config::RaceApi.first)
        }
        after(:each){
          described_class.instance.kill_threads
        }

        it 'should only ever create one active thread' do
          expect(tracker.threads.count).to eq(1)
        end

        it 'should be alive' do
          tracker.threads.each do |thread|
            expect(thread.alive?).to be_truthy
          end
        end
      end
    end
  end

end
