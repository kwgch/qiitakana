exports = this
exports.validationSettings =
  settings:
    live: "enabled"
    feedbackIcons:
      valid: "glyphicon glyphicon-ok"
      invalid: "glyphicon glyphicon-remove"
      validating: "glyphicon glyphicon-refresh"

    fields: {}

  messages:
    notEmpty: "必須項目です"

  addValidator: (name, type) ->
    @settings.fields[name] = {} if !@settings.fields[name] 
    @settings.fields[name]["validators"] = {} if !@settings.fields[name]["validators"]
    @settings.fields[name]["validators"][type] = message: @messages[type]
    return

  init: (formName) ->
    $(formName).bootstrapValidator @settings
    return