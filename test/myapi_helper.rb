module MyapiHelper
  def correct_api_answer
    @correct_api_answer ||=
      {
        items: [
          { id: 1000, url: 'http://www.host.com', avatar_url: 'http://avatar.com', login: 'login1' },
          { id: 2000, url: 'http://www.host2.com', avatar_url: 'http://avatar2.com', login: 'login2' }
        ]
      }.to_json
  end

  def bad_api_answer
    {
      items: [
        { id: 1000, url: nil, avatar_url: nil, login: nil },
        { id: 2000, url: nil, avatar_url: nil, login: nil }
      ]
    }.to_json
  end
end
