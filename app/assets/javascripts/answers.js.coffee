# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  answersCtrl = {
    showForm: (e) ->
      e.preventDefault();
      $(this).hide();
      $('.answer-form-' + $(this).data('answerId')).removeClass('hide');
  }
  $('.answer-edit').click answersCtrl.showForm

  $('.answers').on 'answer:updated', (e, answerId) ->
      $(".answer-edit[data-answer-id=#{answerId}]").click answersCtrl.showForm


