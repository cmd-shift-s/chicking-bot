
randomImageUrl = "http://random-image.ga/info/google/"

module.exports = (robot) ->
  robot.hear /^(치킹|chicking)! ([^\s]+)$/i, (msg) ->
    searchUrl = randomImageUrl + encodeURIComponent(msg.match[0])
    msg.http(searchUrl).get() (err, res, body) ->
      data = JSON.parse body
      msg.send data.url

  robot.hear /^(치킹|chicking)!$/, (msg) ->
    searchUrl = randomImageUrl + encodeURIComponent('치킨')
    msg.http(searchUrl).get() (err, res, body) ->
      data = JSON.parse body
      msg.send data.url

  robot.hear /(치킨|chicken)/, (msg) ->
    searchUrl = randomImageUrl + encodeURIComponent('치킨')
    msg.http(searchUrl).get() (err, res, body) ->
      data = JSON.parse body
      msg.send data.url
