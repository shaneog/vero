require 'spec_helper'

describe Vero::Api::Events do
  let (:subject) { Vero::Api::Events }

  describe :track! do
    it "should call the TrackAPI object via the configured sender" do
      input = {:event_name => "test_event", :identity => {:email => "james@getvero.com"}, :data => {:test => "test"}}
      expected = input.merge(:auth_token => "abc123", :development_mode => true)

      mock_context = Vero::Context.new
      allow(mock_context.config).to receive(:configured?).and_return(true)
      allow(mock_context.config).to receive(:auth_token).and_return("abc123")
      allow(mock_context.config).to receive(:development_mode).and_return(true)

      allow(Vero::App).to receive(:default_context).and_return(mock_context)

      expect(Vero::Sender).to receive(:send).with(Vero::Api::Workers::Events::TrackAPI, true, "https://api.getvero.com", expected)

      subject.track!(input)
    end
  end
end

describe Vero::Api::Users do
  let (:subject) { Vero::Api::Users }

  describe :track! do
    it "should call the TrackAPI object via the configured sender" do
      input = {:email => "james@getvero.com", :data => {:age => 25}}
      expected = input.merge(:auth_token => "abc123", :development_mode => true)

      mock_context = Vero::Context.new
      allow(mock_context.config).to receive(:configured?).and_return(true)
      allow(mock_context.config).to receive(:auth_token).and_return("abc123")
      allow(mock_context.config).to receive(:development_mode).and_return(true)

      allow(Vero::App).to receive(:default_context).and_return(mock_context)

      expect(Vero::Sender).to receive(:send).with(Vero::Api::Workers::Users::TrackAPI, true, "https://api.getvero.com", expected)

      subject.track!(input)
    end
  end

  describe :edit_user! do
    it "should call the TrackAPI object via the configured sender" do
      input = {:email => "james@getvero.com", :changes => {:age => 25}}
      expected = input.merge(:auth_token => "abc123", :development_mode => true)

      mock_context = Vero::Context.new
      allow(mock_context.config).to receive(:configured?).and_return(true)
      allow(mock_context.config).to receive(:auth_token).and_return("abc123")
      allow(mock_context.config).to receive(:development_mode).and_return(true)

      allow(Vero::App).to receive(:default_context).and_return(mock_context)

      expect(Vero::Sender).to receive(:send).with(Vero::Api::Workers::Users::EditAPI, true, "https://api.getvero.com", expected)

      subject.edit_user!(input)
    end
  end

  describe :edit_user_tags! do
    it "should call the TrackAPI object via the configured sender" do
      input = {:add => ["boom"], :remove => ["tish"]}
      expected = input.merge(:auth_token => "abc123", :development_mode => true)

      mock_context = Vero::Context.new
      allow(mock_context.config).to receive(:configured?).and_return(true)
      allow(mock_context.config).to receive(:auth_token).and_return("abc123")
      allow(mock_context.config).to receive(:development_mode).and_return(true)

      allow(Vero::App).to receive(:default_context).and_return(mock_context)

      expect(Vero::Sender).to receive(:send).with(Vero::Api::Workers::Users::EditTagsAPI, true, "https://api.getvero.com", expected)

      subject.edit_user_tags!(input)
    end
  end

  describe :unsubscribe! do
    it "should call the TrackAPI object via the configured sender" do
      input = {:email => "james@getvero"}
      expected = input.merge(:auth_token => "abc123", :development_mode => false)

      mock_context = Vero::Context.new
      allow(mock_context.config).to receive(:configured?).and_return(true)
      allow(mock_context.config).to receive(:auth_token).and_return("abc123")

      allow(Vero::App).to receive(:default_context).and_return(mock_context)

      expect(Vero::Sender).to receive(:send).with(Vero::Api::Workers::Users::UnsubscribeAPI, true, "https://api.getvero.com", expected)

      subject.unsubscribe!(input)
    end
  end
end