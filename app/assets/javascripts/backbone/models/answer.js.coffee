class Thunderflow.Models.Answer extends Backbone.Model
  url: ->
    '/answers/'+ this.id

  validate: (attrs, options) ->
    if attrs.text.length < 1
      "Text can not be blank."

class Thunderflow.Collections.AnswersCollection extends Backbone.Collection
  model: Thunderflow.Models.Answer
  url: ->
    window.config.answersPath

  rerender: ->
    console.log("Rerender!")

  initialize: ->
    PrivatePub.subscribe @url(), ->
      Thunderflow.Events.trigger('answers:updated')

    @listenTo(Thunderflow.Events, 'answers:updated', @answersUpdated)

  answersUpdated: ->
    @fetch({reset: true })


