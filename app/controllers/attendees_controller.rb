class AttendeesController < InheritedResources:: Base
  def create
    @attendee = Attendee.new(params[:attendee])
    if @attendee.save
      presentation = Presentation.find(params['short_course'])
      @attendee.registrations.create! :presentation => presentation
      AttendeeMailer.pre_registration_email(@attendee).deliver
      render :template => 'attendees/show'
    else
      @short_course = params['short_course']
      render :action => 'new'
    end
  end
end

