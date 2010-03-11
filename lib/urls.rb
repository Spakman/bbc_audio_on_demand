# Copyright (C) 2010 Mark Somerville <mark@scottishclimbs.com>
# Released under the Lesser General Public License (LGPL) version 3.
# See COPYING

module BBCAudioOnDemand
  module LiveStreaming
    UK_STATIONS = {}
    UK_STATIONS["BBC Radio 1"] = "r1.asx"
    UK_STATIONS["BBC 1Xtra"] = "r1x.asx"
    UK_STATIONS["BBC Radio 2"] = "r2.asx"
    UK_STATIONS["BBC Radio 3"] = "r3.asx"
    UK_STATIONS["BBC Radio 4"] = "r4.asx"
    UK_STATIONS["BBC Radio 5 live"] = "r5l.asx"
    UK_STATIONS["BBC Radio 5 live sports extra"] = "r5lsp.asx"
    UK_STATIONS["BBC Radio 6"] = "r6.asx"
    UK_STATIONS["BBC Radio 7"] = "r7.asx"
    UK_STATIONS["BBC Asian Network"] = "ran.asx"

    UK_STATIONS["BBC Radio Cymru"] = "rc.asx"
    UK_STATIONS["BBC Radio Foyle"] = "rf.asx"
    UK_STATIONS["BBC Radio nan Gaidheal"] = "rng.asx"
    UK_STATIONS["BBC Radio Scotland"] = "rs.asx"
    UK_STATIONS["BBC Radio Ulster"] = "ru.asx"
    UK_STATIONS["BBC Radio Wales"] = "rw.asx"
    UK_STATIONS["BBC Berkshire"] = "bbcberkshire.asx"
    UK_STATIONS["BBC Bristol"] = "bbcbristol.asx"
    UK_STATIONS["BBC Cambridgeshire"] = "bbccambridgeshire.asx"
    UK_STATIONS["BBC Cornwall"] = "bbccornwall.asx"
    UK_STATIONS["BBC Coventry & Warwickshire"] = "bbccoventryandwarwickshire.asx"
    UK_STATIONS["BBC Cumbria"] = "bbccumbria.asx"
    UK_STATIONS["BBC Derby"] = "bbcderby.asx"
    UK_STATIONS["BBC Devon"] = "bbcdevon.asx"
    UK_STATIONS["BBC Essex"] = "bbcessex.asx"
    UK_STATIONS["BBC Gloucestershire"] = "bbcgloucestershire.asx"
    UK_STATIONS["BBC Guernsey"] = "bbcguernsey.asx"
    UK_STATIONS["BBC Hereford & Worcester"] = "bbcherefordandworcester.asx"
    UK_STATIONS["BBC Humberside"] = "bbchumberside.asx"
    UK_STATIONS["BBC Jersey"] = "bbcjersey.asx"
    UK_STATIONS["BBC Kent"] = "bbckent.asx"
    UK_STATIONS["BBC Lancashire"] = "bbclancashire.asx"
    UK_STATIONS["BBC Leeds"] = "bbcleeds.asx"
    UK_STATIONS["BBC Leicester"] = "bbcleicester.asx"
    UK_STATIONS["BBC Lincolnshire"] = "bbclincolnshire.asx"
    UK_STATIONS["BBC London"] = "bbclondon.asx"
    UK_STATIONS["BBC Manchester"] = "bbcmanchester.asx"
    UK_STATIONS["BBC Merseyside"] = "bbcmerseyside.asx"
    UK_STATIONS["BBC Newcastle"] = "bbcnewcastle.asx"
    UK_STATIONS["BBC Norfolk"] = "bbcnorfolk.asx"
    UK_STATIONS["BBC Northampton"] = "bbcnorthampton.asx"
    UK_STATIONS["BBC Nottingham"] = "bbcnottingham.asx"
    UK_STATIONS["BBC Oxford"] = "bbcoxford.asx"
    UK_STATIONS["BBC Sheffield"] = "bbcsheffield.asx"
    UK_STATIONS["BBC Shropshire"] = "bbcshropshire.asx"
    UK_STATIONS["BBC Solent"] = "bbcsolent.asx"
    UK_STATIONS["BBC Somerset"] = "bbcsomerset.asx"
    UK_STATIONS["BBC Stoke"] = "bbcstoke.asx"
    UK_STATIONS["BBC Suffolk"] = "bbcsuffolk.asx"
    UK_STATIONS["BBC Surrey"] = "bbcsurrey.asx"
    UK_STATIONS["BBC Sussex"] = "bbcsussex.asx"
    UK_STATIONS["BBC Tees"] = "bbctees.asx"
    UK_STATIONS["BBC Three Counties"] = "bbcthreecounties.asx"
    UK_STATIONS["BBC Wiltshire"] = "bbcwiltshire.asx"
    UK_STATIONS["BBC WM"] = "bbcwm.asx"
    UK_STATIONS["BBC York"] = "bbcyork.asx"

    INTERNATIONAL_STATIONS = {}
    INTERNATIONAL_STATIONS["BBC World Service"] = "http://www.bbc.co.uk/worldservice/meta/tx/nb/live_infent_au_nb.asx"
    INTERNATIONAL_STATIONS["BBC World Service - English News"] = "http://www.bbc.co.uk/worldservice/meta/tx/nb/live_news_au_nb.asx"
    INTERNATIONAL_STATIONS["BBC Arabic"] =  "http://www.bbc.co.uk/arabic/meta/tx/nb/arabic_live_au_nb.asx"
    INTERNATIONAL_STATIONS["BBC Russian"] = "http://www.bbc.co.uk/russian/meta/tx/nb/russian_live_au_nb.asx"

    def streaming_playlist_url
      if UK_STATIONS[@name]
        "http://www.bbc.co.uk/radio/listen/live/#{UK_STATIONS[@name]}"
      else
        INTERNATIONAL_STATIONS[@name]
      end
    end
  end

  module ScheduleFeeds
    STATIONS = {}
    STATIONS["BBC Radio 1"] = "radio1.xml"
    STATIONS["BBC 1Xtra"] = "1xtra.xml"
    STATIONS["BBC Radio 2"] = "radio2.xml"
    STATIONS["BBC 6Music"] = "6music.xml"
    STATIONS["BBC Radio 3"] = "radio3.xml"
    STATIONS["BBC Radio 4"] = "radio4.xml"
    STATIONS["BBC Radio 7"] = "bbc7.xml"
    STATIONS["BBC 5live"] = "fivelive.xml"
    STATIONS["BBC 5live Sports Extra"] = "sportsextra.xml"

    STATIONS["BBC Radio nan Gaidheal"] = "alba.xml"
    STATIONS["BBC Radio Scotland"] = "radioscotland.xml"
    STATIONS["BBC Radio Ulster"] = "radioulster.xml"
    STATIONS["BBC Radio Foyle"] = "radiofoyle.xml"
    STATIONS["BBC Radio Wales"] = "radiowales.xml"
    STATIONS["BBC Radio Cymru"] = "radiocymru.xml"

    STATIONS["BBC London"] = "bbc_london.xml"
    STATIONS["BBC Radio Berkshire"] = "bbc_radio_berkshire.xml"
    STATIONS["BBC Radio Bristol"] = "bbc_radio_bristol.xml"
    STATIONS["BBC Radio Cambridge"] = "bbc_radio_cambridge.xml"
    STATIONS["BBC Radio Cornwall"] = "bbc_radio_cornwall.xml"
    STATIONS["BBC Radio Coventry_warwickshire"] = "bbc_radio_coventry_warwickshire.xml"
    STATIONS["BBC Radio Cumbria"] = "bbc_radio_cumbria.xml"
    STATIONS["BBC Radio Derby"] = "bbc_radio_derby.xml"
    STATIONS["BBC Radio Devon"] = "bbc_radio_devon.xml"
    STATIONS["BBC Radio Essex"] = "bbc_radio_essex.xml"
    STATIONS["BBC Radio Gloucestershire"] = "bbc_radio_gloucestershire.xml"
    STATIONS["BBC Radio Guernsey"] = "bbc_radio_guernsey.xml"
    STATIONS["BBC Radio Hereford_worcester"] = "bbc_radio_hereford_worcester.xml"
    STATIONS["BBC Radio Humberside"] = "bbc_radio_humberside.xml"
    STATIONS["BBC Radio Jersey"] = "bbc_radio_jersey.xml"
    STATIONS["BBC Radio Kent"] = "bbc_radio_kent.xml"
    STATIONS["BBC Radio Lancashire"] = "bbc_radio_lancashire.xml"
    STATIONS["BBC Radio Leeds"] = "bbc_radio_leeds.xml"
    STATIONS["BBC Radio Leicester"] = "bbc_radio_leicester.xml"
    STATIONS["BBC Radio Lincolnshire"] = "bbc_radio_lincolnshire.xml"
    STATIONS["BBC Radio Manchester"] = "bbc_radio_manchester.xml"
    STATIONS["BBC Radio Merseyside"] = "bbc_radio_merseyside.xml"
    STATIONS["BBC Radio Newcastle"] = "bbc_radio_newcastle.xml"
    STATIONS["BBC Radio Norfolk"] = "bbc_radio_norfolk.xml"
    STATIONS["BBC Radio Northampton"] = "bbc_radio_northampton.xml"
    STATIONS["BBC Radio Nottingham"] = "bbc_radio_nottingham.xml"
    STATIONS["BBC Radio Oxford"] = "bbc_radio_oxford.xml"
    STATIONS["BBC Radio Sheffield"] = "bbc_radio_sheffield.xml"
    STATIONS["BBC Radio Shropshire"] = "bbc_radio_shropshire.xml"
    STATIONS["BBC Radio Solent"] = "bbc_radio_solent.xml"
    STATIONS["BBC Radio Somerset_sound"] = "bbc_radio_somerset_sound.xml"
    STATIONS["BBC Radio Stoke"] = "bbc_radio_stoke.xml"
    STATIONS["BBC Radio Suffolk"] = "bbc_radio_suffolk.xml"
    STATIONS["BBC Radio Swindon"] = "bbc_radio_swindon.xml"
    STATIONS["BBC Radio Wiltshire"] = "bbc_radio_wiltshire.xml"
    STATIONS["BBC Radio York"] = "bbc_radio_york.xml"
    STATIONS["BBC Southern Counties Radio"] = "bbc_southern_counties_radio.xml"
    STATIONS["BBC Tees"] = "bbc_tees.xml"
    STATIONS["BBC Three Counties Radio"] = "bbc_three_counties_radio.xml"
    STATIONS["BBC Birmingham"] = "bbc_wm.xml"

    STATIONS["BBC World Service"] = "worldservice.xml"

    def schedule_feed_url
      "http://www.bbc.co.uk/radio/aod/availability/#{STATIONS[@name]}"
    end
  end
end
