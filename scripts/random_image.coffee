
randomImageUrl = "http://random-image.ga/info/google/"

module.exports = (robot) ->
  robot.hear /(치킨|chicken)/i, (msg) ->
    searchUrl = randomImageUrl + encodeURIComponent('치킨')
    msg.http(searchUrl).get() (err, res, body) ->
      data = JSON.parse body
      msg.send data.url
