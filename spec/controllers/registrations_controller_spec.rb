require 'spec_helper'

describe RegistrationsController do
  include Devise::TestHelpers

  before(:each) { sign_in Factory.create(:user) }

  describe 'GET request_confirm' do
    it 'assigns all unconfirmed registrations to @registrations' do
      Registration.stub(:unconfirmed).and_return([reg_stub = Factory.build(:registration)])
      get :request_confirm
      assigns[:registrations].should == [reg_stub]
    end
  end

  describe 'POST confirm' do
    before :each do
      Registration.stub(:find).with(1).and_return(@r1 = stub_model(Registration))
      Registration.stub(:find).with(2).and_return(@r2 = stub_model(Registration))
    end

    it 'confirm all received registrations with current time' do
      @r1.should_receive(:confirm!)
      @r2.should_receive(:confirm!)
      post :confirm, :registrations => [1, 2]
    end

    it 'assigns received registrations to @new_registrations' do
      [@r1, @r2].each {|r| r.stub(:confirm!) }
      post :confirm, :registrations => [1, 2]
      assigns[:new_registrations].should =~ [@r1, @r2]
    end
  end
end
