class MySpotify
  def self.say(name)
    p "hello, #{name}"
  end


  #自分で作ったやつ（未使用）
  def self.get_new_albums(token)
    require "open-uri"
    res = open("https://api.spotify.com/v1/browse/new-releases?limit=2",
         "Accept" => "application/json",
         "Content-Type" => "application/json",
         "Authorization" => "Bearer #{token}"
         )
    if res.status[0] == "200"
      p "ok"
      result = ActiveSupport::JSON.decode res.read
      return result
    else
      p "error###########################"
      p res.status
      return {}
    end
  end

end