class AttendeesController < InheritedResources:: Base
  def create
    create! do |format|
      format.html { render :template => 'attendees/show' }
    end
  end
end

