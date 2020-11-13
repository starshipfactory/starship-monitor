defmodule WebappWeb.PageController do
  use WebappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end


  def spaceapi(conn, _params) do
    res = GenServer.call({:global, :door_interface}, :read_state)

    open = case res.open do
             :open -> true
             :closed -> false
           end
    time = res.timestamp

    json(conn,
      %{
        api: "0.13",
        space: "Starship Factory",
        logo: "https://starship-factory.ch/static/images/logo.png",
        url: "http://starship-factory.ch",
        location: %{
          address: "Klybeckstrasse 141, 4057 Basel, Switzerland",
          lon: 7.5894586,
          lat: 47.5748217
        },
        contact: %{
          email: "board@lists.starship-factory.ch",
          ml: "open@lists.starship-factory.ch",
        },
        state: %{
          #icon: {
          #  open: "http://shackspace.de/sopen.gif",
          #  closed: "http://shackspace.de/sopen.gif"
          #},
          open: open,
          lastchange: time
        },
        issue_report_channels: "ml",
        projects: [
          "http://github.com/starshipfactory",
          "http://wiki.starship-factory.ch/Projekte/"
        ]
      }
    )
  end
end
