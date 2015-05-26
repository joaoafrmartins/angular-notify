module.exports = class NotifyController

  constructor: (
    @$scope,
    @$rootScope,
    $translatePartialLoader,
    notifyService
  ) ->

    $translatePartialLoader.addPart 'notify'

    @printer = notifyService.printer

    @$scope.attach = notifyService.attach.bind(notifyService)

    @$scope.$watch 'notes', @onUpdateNotes.bind(@)

    @$rootScope.$on "$onNotifyElementAttached", =>

      @$scope.notes ?= notifyService.getNotes()

  onUpdateNotes: (notes) ->

    notes.map (n) => @printer[n.level] n.message, n
