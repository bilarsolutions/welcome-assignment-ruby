require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe "POST #create" do
    context '[anonyous user]' do
      it "does not broadcast message" do
        expect { post :create, params: { message: { body: 'Hello world!' } } }.not_to have_broadcasted_to("messages")
      end
    end

    context '[auth user]' do
      let(:user) { create(:user) }

      before do
        cookies[:user_user] = user.id
        allow_any_instance_of(MessagesController).to receive(:current_user).and_return(user)
        Timecop.freeze(Time.local(2021, 8, 6, 19, 42, 0))
      end

      after do
        Timecop.return
      end

      it 'broadcasts message' do
        message = nil
        expect do
          post :create, params: { message: { body: 'Hello world!!' } }
        end.to \
          have_broadcasted_to("messages").with({
              "id": 1, "user_id":user.id, "body":"Hello world!!",
              "created_at":"2021-08-06T14:42:00.000Z","updated_at":"2021-08-06T14:42:00.000Z",
              "name":user.name
            })
      end
    end
  end
end
