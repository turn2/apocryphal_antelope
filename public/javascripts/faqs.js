$(function() {
  $('#faqs').sortable(
  {
    axis: 'y',
    dropOnEmpty:false,
    handle: '.handle',
    cursor: 'crosshair',
    items: 'li',
    opacity: 0.6,
    scroll: true,
    scrollSpeed: 10,
    update: function() {
      $.ajax({
        type: 'post',
        data: $('#faqs').sortable('serialize'),
        dataType: 'script',
        complete: function(request) {
          $('#faqs').effect('highlight');
          },
        url: '/faqs/sort'
      })
    }
  })
})
