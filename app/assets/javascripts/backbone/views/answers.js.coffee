class Thunderflow.Views.AnswersView extends Backbone.View

  className: "columns small-12 answers"

  initialize: ->
    @listenTo @collection, "reset", @render
    @collection.fetch({ reset: true })

  template: -> HandlebarsTemplates['answers']

  render: ->
    console.log("Rendering...")
    @$el.html(@template())
    @collection.forEach @renderAnswer, @
    @

  renderAnswer: (model) ->
    v = new Thunderflow.Views.Answer({ model: model })
    @$el.append(v.render().el)