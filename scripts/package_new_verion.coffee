# Description:
#   Post a new version to #news channel when get a new version

packages = {
  'vue': null,
  'vue-router': null,
  'vuex': null,
  'vue-resource': null,
  'axios': null,
}

unpkgUrl = 'https://unpkg.com/'
delay = 600000 # 10 mins

module.exports = (robot) ->
  robot.hear /^(.*) --latest$/i, (msg) ->
    name = msg.match[1]
    pkg = packages[name]
    msg.send pkg

  # start get version
  getVersion robot

getVersion = (robot) ->
  Object.keys(packages).forEach (pkg) ->
    robot.http(unpkgUrl + pkg).get() (err, res) ->
      if res.statusCode is 302 and packages[pkg] isnt res.headers.location
        if packages[pkg] isnt null
          robot.adapter.client.web.chat.postMessage('#news', "#{pkg} updated to #{res.headers.location}.")
        packages[pkg] = res.headers.location

  setTimeout () ->
    getVersion robot
  , delay
