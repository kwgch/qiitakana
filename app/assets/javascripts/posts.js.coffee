$(document).on "change", "textarea#post_markdown", ->
    $.ajax
      url: "/preview"
      type: "POST"
      data:
        markdown: $("textarea#post_markdown").val()

      dataType: "html"
      success: (data) ->
        $(".bs-example").html data
        return

      error: (data) ->
        alert "error"
        return

    return

selectPublish = ->
  showBtn true, false, false
  return
selectDraft = ->
  showBtn false, true, false
  return
selectLimit = ->
  showBtn false, false, true
  return
showBtn = (publish, draft, limit) ->
  (if publish then $("#publish").removeClass("hide") else $("#publish").addClass("hide"))
  (if draft then $("#draft").removeClass("hide") else $("#draft").addClass("hide"))
  (if limit then $("#limit").removeClass("hide") else $("#limit").addClass("hide"))
  return

$(document).on "click", ".dropdown_draft", ->
    selectDraft()
$(document).on "click", ".dropdown_publish", ->
    selectPublish()
$(document).on "click", ".dropdown_limit", ->
    selectLimit()
