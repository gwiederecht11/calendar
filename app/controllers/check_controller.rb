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

    @event_list = service.list_events('primary', time_max: '2017-03-13T23:59:59-08:00' , time_min: '2017-03-13T00:00:00-08:00')



    calendar_list.items.each { |calendar|
      if not calendar.primary
        calendarid = calendar.id
        @event_list2 = service.list_events(calendarid, time_max: '2017-03-13T23:59:59-08:00' , time_min: '2017-03-13T00:00:00-08:00')
	     end 
    }

	end




    # instance = DateTime.parse("2014-01-01 16:35:45 -0800")
    # d1       = DateTime.parse("2013-12-25 04:45:00 -0800")
    # d2       = DateTime.parse("2015-12-25 5:00:01 -0800")
    # p instance.between?( d1, d2 )







  def new_event
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    today = Date.today

    event = Google::Apis::CalendarV3::Event.new({
      start: Google::Apis::CalendarV3::EventDateTime.new(date: today),
      end: Google::Apis::CalendarV3::EventDateTime.new(date: today + 1),
      summary: 'New event!'
    })

    service.insert_event(params[:calendar_id], event)

    redirect_to events_url(calendar_id: params[:calendar_id])
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
