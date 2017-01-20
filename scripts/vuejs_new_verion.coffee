# Description:
#   Post a new version to #news channel when get a new version

unpkgVue = 'https://unpkg.com/vue'

q = require 'q'

lastVersion = null
delay = 600000 # 10 mins

module.exports = (robot) ->
  getVersion robot

getVersion = (robot) ->
  robot.http(unpkgVue).get() (err, res) ->

    if res.statusCode is 302 and lastVersion isnt res.headers.location
      lastVersion = res.headers.location
      robot.adapter.client.web.chat.postMessage('#news', "New version!! #{lastVersion.substring 1}")

    setTimeout () ->
      getVersion robot
    , delay
