class Thunderflow.Routers.QuestionRouter extends Backbone.Router
  routes:
    "": "index"

  initialize: ->
    @answersView = new Thunderflow.Views.AnswersView({collection: new Thunderflow.Collections.AnswersCollection()})

  index: ->
    @renderAnswers()

  renderAnswers: ->
    $('#answers').html(@answersView.render().el)

