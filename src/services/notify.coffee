module.exports = class NotifyService

  constructor: (@$rootScope, @$compile, notifyOptions) ->

    {

      levels: @levels,

      timelapse: @timelapse

    } = notifyOptions

    @initialize()

    if notifyOptions.global

      @printer.log = console.log

      global.console = @printer

    Object.defineProperty @, "notes", value: []

  attach: (elem) ->

    @elem = elem

    @$rootScope.$broadcast "$onNotifyElementAttached",

      elem: elem

  initialize: ->

    @queue ?= []

    @printer ?= {}

    @levels.map (l) =>

      if @debug and l of @printer

        _l = @printer[l].bind @printer

      @printer[l] = (

        (m, o={}) ->

          o.message = m

          o.level ?= @level

          o.title ?= @level

          @notify o

          if @debug and @log then @log m

      ).bind(

        log: _l,

        level: l,

        debug: @debug,

        printer: @printer,

        notify: @notify.bind(@)

      )

  notify: (note) ->

    @queue.push note

    return unless @queue.length is 1

    @interval = setInterval () =>

      if note = @queue.shift()

        @$rootScope.$broadcast "$onNotifyNoteAdded", note

      if not @queue.length then clearInterval @interval

    , @timelapse

  setNotes: (notes) -> @notes = notes

  getNotes: -> @notes
