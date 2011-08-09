require 'spec_helper'

describe RegistrationsController do
  include Devise::TestHelpers

  before(:each) { sign_in Factory.create(:user) }

  describe 'GET request_confirm' do
    it 'assigns all registrations that are available for confirmation to @registrations' do
      Registration.stub(:available_for_confirmation).and_return([reg_stub = Factory.build(:registration)])
      get :request_confirm
      assigns[:registrations].should == [reg_stub]
    end
  end

  describe 'POST confirm' do
    before :each do
      Registration.stub(:find).with(1).and_return(@r1 = stub_model(Registration,
        :attendee => stub_model(Attendee, :email => 'some@email.com'),
        :presentation => stub_model(Presentation, :title => 'Some title')))
      Registration.stub(:find).with(2).and_return(@r2 = stub_model(Registration))
    end

    def stub_mail
      AttendeeMailer.stub(:confirm_registration_email).and_return(stub(:deliver => nil))
    end

    it 'confirm all received registrations with current time' do
      stub_mail
      @r1.should_receive(:confirm!)
      @r2.should_receive(:confirm!)
      post :confirm, :registrations => [1, 2]
    end

    it 'assigns received registrations to @new_registrations' do
      stub_mail
      [@r1, @r2].each {|r| r.stub(:confirm!) }
      post :confirm, :registrations => [1, 2]
      assigns[:new_registrations].should =~ [@r1, @r2]
    end

    it 'renders index' do
      stub_mail
      post :confirm, :registrations => []
      response.should render_template 'registrations/index'
    end

    it 'sends confirmation mail' do
      mail_stub = stub
      AttendeeMailer.stub(:confirm_registration_email).with(@r1).and_return(mail_stub)
      mail_stub.should_receive(:deliver)
      post :confirm, :registrations => [1]
    end
  end

  describe 'DELETE destroy' do
    before :each do
      Registration.stub(:find).with(1).and_return(@reg_stub = stub_model(Registration))
    end

    it 'deletes given registration' do
      @reg_stub.should_receive(:delete)
      delete :destroy, :id => 1
    end

    it 'redirects to :index' do
      @reg_stub.stub(:delete)
      delete :destroy, :id => 1
      response.should redirect_to registrations_path
    end
  end
end

