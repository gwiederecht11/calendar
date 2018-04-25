class CheckController < ApplicationController

  # CALENDAR_ID = Rails.application.secrets.calendarId

  def calendars

	  client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists

    # @event_list = service.list_events(params[:calendar_id])
  end

  def events

    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    calendar_list = service.list_calendar_lists

    # response = client.execute(api_method: @service.calendar_list.list) 
    # calendar_id = CALENDAR_ID

    # calendar_id = calendar_id()
    # @event_list = service.list_events(params[:calendar_id])
    # @event_list = service.list_events(calendar_id)


    calendar_list.items.each { |calendar| 
      if calendar.primary
        calendarid = calendar.id
        @event_list = service.list_events(calendarid)
      end 
    }



  end

  # def calendar_id()  
  #   client = Signet::OAuth2::Client.new(client_options)
  #   client.update!(session[:authorization])
  #   service = Google::Apis::CalendarV3::CalendarService.new
  #   service.authorization = client
  #   response = @client.execute(api_method:     
  #     service.calendar_list.list)
  #   calendars = JSON.parse(response.body)
  #   calendar = calendars["items"].select {|cal| 
  #     cal["primary"] == true}
  #   calendar["id"]
  # end 


  # def calendar_id(schedule)  
  # response = @client.execute(api_method:     
  #   @service.calendar_list.list)

  # calendars = JSON.parse(response.body)

  # calendar = calendars["items"].select {|cal| 
  #   cal["id"].downcase == schedule.calendar_id}
  # calendar["id"]
  # end  


  private

  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end

end
