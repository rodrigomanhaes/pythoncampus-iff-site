require 'spec_helper'

describe HomeController do
  before :each do
    @valid_contact = {
      :name => 'Someone',
      :email => 'someone@somedomain.com',
      :subject => 'Some thing',
      :message => 'A lot of things'
    }

    @invalid_contact = {}
  end

  describe 'GET contact' do
    it 'assigns a new contact to @contact' do
      Contact.stub(:new).and_return(contact_stub = stub)
      get :contact
      assigns[:contact].should == contact_stub
    end
  end

  describe 'POST send_contact' do
    context 'with valid data' do
      it 'redirects to root' do
        post :send_contact, :contact => @valid_contact
        response.should redirect_to root_path
      end

      it 'delivers e-mail' do
        mailer_stub = stub
        AttendeeMailer.should_receive(:contact_email).and_return(mailer_stub)
        mailer_stub.should_receive(:deliver)
        post :send_contact, :contact => @valid_contact
      end
    end

    context 'with invalid data' do
      it 'renders :contact' do
        post :send_contact, :contact => @invalid_contact
        response.should render_template 'home/contact'
      end

      it 'does not send any mail' do
        ActionMailer.should_not_receive(:contact_email)
        post :send_contact, :contact => @invalid_contact
      end
    end
  end
end

