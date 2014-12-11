class Thunderflow.Views.Answer extends Backbone.View

  className: ->
    "row answer answer-" + @model.id

  template: HandlebarsTemplates['answer']
  editTemplate: HandlebarsTemplates['edit_answer']

  events: {
    "click .answer-accept": "accept"
    "click .answer-edit": "edit"
    "click .answer-delete": "delete"
    "click .answer-save": "save"
  }

  save: (e) ->
    e.preventDefault()
    if @model.save {
        text: @$el.find('input:first').val()
      }, {
        success: ->
          $('.flash').html("<div class=\"alert-box success\">Answer was successfully updated.</div>")
      }
    else
      @$el.find('label, input').addClass('error')
      @$el.find('small.error').show()
    @

  accept: (e) ->
    e.preventDefault()
    @model.save {
        is_accepted: true
      }, {
        success: ->
          $('.flash').html("<div class=\"alert-box success\">You accepted an answer.</div>")
          Thunderflow.Events.trigger('answers:updated')
      }
    @

  edit: (e) ->
    e.preventDefault()
    @$el.html(@editTemplate(@model.toJSON()))
    @

  delete: (e) ->
    e.preventDefault()
    @model.destroy {
      success: ->
        $('.flash').html("<div class=\"alert-box success\">Answer was successfully destroyed.</div>")
        Thunderflow.Events.trigger('answers:updated')
    }
    @

  render: ->
    @$el.html(@template(@model.toJSON()))
    @