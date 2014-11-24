class Thunderflow.Models.Answer extends Backbone.Model

class Thunderflow.Collections.AnswersCollection extends Backbone.Collection
  model: Thunderflow.Models.Answer
  url: -> window.config.answersPath
  rerender: ->
    console.log("Rerender!")