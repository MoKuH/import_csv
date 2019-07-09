# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->
  $('#user_list').dataTable({
    ordering: true,
    searching: true,
    paging: true,
    'columns': [
      null
      { 'searchable': false }
      { 'searchable': false }
      { 'searchable': false }
    ]
  })

  $('tr[data-link]').click ->
    window.location = $(this).data('link')

  return
