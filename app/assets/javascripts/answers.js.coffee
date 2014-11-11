# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  answersCtrl =
    showForm: (e) ->
      e.preventDefault();
      $(this).hide();
      $('.answer-form-' + $(this).data('answerId')).removeClass('hide');
    findAnswerById: (id) ->
      $('.answer-' + id)
    insertOrUpdate: (answer) ->
      answerElm = $(".answer-" + answer.id)
      renderedAnswer = HandlebarsTemplates['answer'](answer)
      $(renderedAnswer).find('.timeago').timeago()
      if answerElm.length > 0
        answerElm.replaceWith(renderedAnswer)
        $('.answers').trigger('answer:updated', [answer.id])
      else
        $('.answers').append(renderedAnswer)

  $('.answer-edit').click answersCtrl.showForm

  $('.answers').on 'answer:updated', (e, answerId) ->
      $(".answer-edit[data-answer-id=#{answerId}]").click answersCtrl.showForm
      $('.timeago').timeago();

  #$('#new_answer').bind "ajax:success", (e, data, status, xhr) ->
  #  $('.answers').append(data.text);

  questionId = $('.question').data('id')
  PrivatePub.subscribe '/questions/' + questionId + '/answers', (data, channel) ->
    console.log(data)
    if data.answer
      answersCtrl.insertOrUpdate(data.answer)

