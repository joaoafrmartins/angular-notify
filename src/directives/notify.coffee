module.exports = (notifyOptions, notifyService, $rootScope, $compile, $filter) ->
  restrict: "E"
  replace: true
  scope:
    notes: "="
  controller: "NotifyController"
  template: """
  <div notify='true'>
    <div notes='true'></ul>
  </div>
  """
  link: (scope, elem, attrs) ->

    list = elem.first()

    { vertical, horizontal } = notifyOptions

    list.attr "vertical", vertical

    list.attr "horizontal", horizontal

    scope.attach list

    timeout = notifyOptions.timeout

    $rootScope.$on "$onNotifyNoteAdded", (event, note) ->

      level = note.level

      title = $filter("translate")(note.title)

      message = $filter("translate")(note.message)

      el = $compile(
        """
        <article note='true' level='#{level}'>
          <legend title='true'>
            <i>#{title}</i>
            <i icon='true'></i>
            <i close='true'></i>
          </legend>
          <div envelope='true'>
            <a message='true'>#{message}</a>
          </div>
        </article>
        """
      )(note)

      elem.prepend el.hide().

      fadeIn(timeout * 0.1).

      delay(timeout * 0.7).

      fadeOut(timeout * 0.2)

      removeFn = (() -> @note.remove()).bind(note: el)

      setTimeout removeFn, timeout
