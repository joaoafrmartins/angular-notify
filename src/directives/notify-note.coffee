module.exports = (notifyOptions) ->
  restrict: "E"
  replace: true
  scope:
    note: "="
  controller: "NotifyController"
  template: """
  <article note='true' level='{{ level }}'>
    <legend title='true'>
      <i>{{ title | translate }}</i>
      <i icon='true'></i>
      <i close='true'></i>
    </legend>
    <div envelope='true'>
      <a message='true'>{{ message | translate }}</a>
    </div>
  </article>
  """
