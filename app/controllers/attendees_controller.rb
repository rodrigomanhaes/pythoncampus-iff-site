class AttendeesController < InheritedResources:: Base
  def create
    create! do |success, failure|
      success.html { render :template => 'attendees/show' }
      failure.html { render :action => 'new' }
    end
  end
end

