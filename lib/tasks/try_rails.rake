# encoding: utf-8

namespace :main do

  desc "最新トラックの取得"
  task :get_new_tracks => :environment do
    @count = 0
    require "my_spotify"
    RSpotify.authenticate("64c53ef52397425abe86863d281d25fb", "8c91939166924e51a0ef100fa54a6d1f")
    new_albums = RSpotify::Album.new_releases(limit:2, offset:0, country: "JP")
    new_albums.each do |album|
      tracks = album.tracks.flatten
      tracks.each do |track|
        unless Track.find_by_t_id(track.id)
          t = Track.new(
              name: track.name,
              t_id: track.id,
              artist_name: track.artists.map{|artist| artist.name}.join(","),
              preview_url: track.preview_url,
              track_number: track.track_number,
              album_name: album.name,
              album_id: album.id,
              album_img_url: album.images[-1]["url"],
              release_date: album.release_date.length > 4 ? DateTime.parse(album.release_date) : DateTime.parse(album.release_date + "-01-01")
          )
          if t.save
            p "saved #{track.name}"
            @count += 1
          else
            p "error"
            p t.errors
          end
        end
      end
    end
    p "finished count: #{@count}"
  end

end