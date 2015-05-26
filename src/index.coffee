angular = require "angular"

app = angular.module "app.notify", [ "pascalprecht.translate" ]

app.constant "notifyOptions", require "./constants/notify"

app.service "notifyService", require "./services/notify"

app.controller "NotifyController", require "./controllers/notify"

app.directive "notifyNote", require "./directives/notify-note"

app.directive "notify", require "./directives/notify"
