# Copyright (C) 2010 Mark Somerville <mark@scottishclimbs.com>
# Released under the Lesser General Public License (LGPL) version 3.
# See COPYING

module BBCAudioOnDemand
  module LiveStreaming
    URLS = {}
    URLS["BBC Radio 1"] = "r1.asx"
    URLS["BBC 1Xtra"] = "r1x.asx"
    URLS["BBC Radio 2"] = "r2.asx"
    URLS["BBC Radio 3"] = "r3.asx"
    URLS["BBC Radio 4"] = "r4.asx"
    URLS["BBC Radio 5 live"] = "r5l.asx"
    URLS["BBC Radio 5 live sports extra"] = "r5lsp.asx"
    URLS["BBC Radio 6"] = "r6.asx"
    URLS["BBC Radio 7"] = "r7.asx"
    URLS["BBC Asian Network"] = "ran.asx"

    def streaming_playlist_url
      "http://www.bbc.co.uk/radio/listen/live/#{URLS[@name]}"
    end
  end

  module ScheduleFeeds
    URLS = {}
    URLS["BBC Radio 1"] = "radio1.xml"
    URLS["BBC 1Xtra"] = "1xtra.xml"
    URLS["BBC Radio 2"] = "radio2.xml"
    URLS["BBC 6Music"] = "6music.xml"
    URLS["BBC Radio 3"] = "radio3.xml"
    URLS["BBC Radio 4"] = "radio4.xml"
    URLS["BBC Radio 7"] = "bbc7.xml"
    URLS["BBC 5live"] = "fivelive.xml"
    URLS["BBC 5live Sports Extra"] = "sportsextra.xml"

    URLS["BBC Radio nan Gaidheal"] = "alba.xml"
    URLS["BBC Radio Scotland"] = "radioscotland.xml"
    URLS["BBC Radio Ulster"] = "radioulster.xml"
    URLS["BBC Radio Foyle"] = "radiofoyle.xml"
    URLS["BBC Radio Wales"] = "radiowales.xml"
    URLS["BBC Radio Cymru"] = "radiocymru.xml"

    def schedule_feed_url
      "http://www.bbc.co.uk/radio/aod/availability/#{URLS[@name]}"
    end
  end
end
