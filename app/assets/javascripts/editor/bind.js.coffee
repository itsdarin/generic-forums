$( ()->
  allowedClasses = [
    "posts_edit", "posts_new", "posts_index", "ropes_new"
  ]
  doReturn = ( ()->
    d = true
    for c in allowedClasses
      d = d and not $("html").hasClass c
    d
  )()
  return if doReturn

  $format_selector = $ "form.for_editor div.format_select select"
  $editor          = $ "form.for_editor textarea.editor"
  return if $editor.length < 0

  window.editors ||= []
  format = $format_selector.val()

  editor = new Editor($editor, format, {
                      "iconContainer": $editor.parent().children(".high_bar").children(".icon_container"),
                      "output": $editor.parent().children(".output_wrapper")
  })
  window.editors.push editor
  $editor.focus()

  $format_selector.on("change", editor, (event)->
    editor.changeSyntax $(this).val()
  )

  if $("input#tag_input").length > 0
    window.taggers ||= []
    $taginput = $ "input#tag_input"
    window.taggers.push new Tagger($taginput, {"wrapper": $taginput.parent()})

)
