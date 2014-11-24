class Thunderflow.Views.Answer extends Backbone.View

  className: -> "row answer answer-" + @model.id

  template: HandlebarsTemplates['answer']

  render: ->
    @$el.html(@template(@model.toJSON()))
    @