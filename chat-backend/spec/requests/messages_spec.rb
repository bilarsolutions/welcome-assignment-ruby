require 'rails_helper'

RSpec.describe "/messages", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Message. As you add validations to Message, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { body: 'Hello world!' }
  }

  let(:invalid_attributes) {
    { body: nil }
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # MessagesController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    let!(:message) { create(:message) }

    it "renders a successful response" do
      get messages_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "anonymous" do
      it "creates a new Message" do
        expect {
          post messages_url,
               params: { message: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Message, :count).by(0)
      end

      it "renders a JSON response with the new message" do
        post messages_url,
             params: { message: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "registered user" do
      let(:user) { create(:user) }

      before do
        allow_any_instance_of(MessagesController).to receive(:current_user).and_return(user)
      end

      context "with valid parameters" do
        it "creates a new Message" do
          expect {
            post messages_url,
                 params: { message: valid_attributes }, headers: valid_headers, as: :json
          }.to change(Message, :count).by(1)
        end

        it "renders a JSON response with the new message" do
          post messages_url,
               params: { message: valid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including("application/json"))
        end

      end

      context "with invalid parameters" do
        it "does not create a new Message" do
          expect {
            post messages_url,
                 params: { message: invalid_attributes }, as: :json
          }.to change(Message, :count).by(0)
        end

        it "renders a JSON response with errors for the new message" do
          post messages_url,
               params: { message: invalid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq("application/json; charset=utf-8")
        end
      end
    end
  end
end
