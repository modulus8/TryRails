# encoding: utf-8

namespace :main do

  desc "最新トラックの取得"
  task :get_new_tracks => :environment do
    @count = 0
    RSpotify.authenticate("64c53ef52397425abe86863d281d25fb", "8c91939166924e51a0ef100fa54a6d1f")
    new_albums = RSpotify::Album.new_releases(limit:50, offset:0, country: "JP")
    new_albums.each do |album|
      tracks = album.tracks.flatten
      tracks.each do |track|
        t = Track.find_or_create_by(t_id: track.id)
        t.name = track.name
        t.artist_name = track.artists.map{|artist| artist.name}.join(",")
        t.preview_url = track.preview_url
        t.track_number = track.track_number
        t.album_name = album.name
        t.album_id = album.id
        t.album_img_url = album.images[-1]["url"]
        t.release_date = album.release_date.length > 4 ? DateTime.parse(album.release_date) : DateTime.parse(album.release_date + "-01-01")
        begin
          # analyze
          feature = track.audio_features
          t.track_analyze = TrackAnalyze.new(:track_id => t.id) if t.track_analyze.blank?
          t.track_analyze.key = feature.key
          t.track_analyze.danceability = feature.danceability
          t.track_analyze.energy = feature.energy
          t.track_analyze.speechiness = feature.speechiness
          t.track_analyze.acousticness = feature.acousticness
          t.track_analyze.instrumentalness = feature.instrumentalness
          t.track_analyze.liveness = feature.liveness
          t.track_analyze.valence = feature.valence
          t.track_analyze.duration_ms = feature.duration_ms
          t.track_analyze.save!
        rescue
          p "エラー：#{t.name} => audio features 404 no found."
        end
        if t.save
          p "saved #{track.name}"
          @count += 1
        else
          p "error"
          p t.errors
        end
      end
    end
    p "finished count: #{@count}"
  end

  desc "拡散用ツイート"
  task :auto_tweet => :environment do
    time = Time.now
    begin
      require "twitter"
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "D59eNo6vGMhC3lUcOi7bNJevj"
        config.consumer_secret     = "CctoLN9nLR6pCj2fEOhvY5HwO0rPA3JGtjhvDOFstzJuEZkDEv"
        config.access_token        = "965386655824691200-xFOrQg2tBpGxQ9RfJfDOwjLoODtgoPJ"
        config.access_token_secret = "iQf2Xueh16HIuGmncnFI8mbVuTtrGmjbHzVxKI4JZYIBi"
      end
      track = Track.where("release_date >= ?", Time.now - 1.weeks).where("release_date <= ?", Time.now).order("RAND()").limit(1).first
      url = " https://open.spotify.com/track/#{track.t_id}"
      hash = " #NowPlaying #Spotify ##{track.artist_name} ##{track.album_name} ##{track.name}"
      comments = [
          "最新音楽をお届け！",
          "音楽聴き放題『Spotify』使ってますか？",
          "無料で聴き放題『Spotify』で音楽を楽しもう！",
          "おすすめミュージックを探すなら『Spotify』。"
      ]
      text = "#{comments.sample(1)[0]} comuptify.site \n" + url + hash
      client.update(text)
      p "ツイートされました。#{time}"
    rescue => e
      p "ツイートの際エラーが発生しました。#{time}"
    end
  end

end