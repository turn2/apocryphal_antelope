$(function() {
  $('#testimonials').sortable(
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
        data: $('#testimonials').sortable('serialize'),
        dataType: 'script',
        complete: function(request) {
          $('#testimonials').effect('highlight');
          },
        url: '/testimonials/published/sort'
      })
    }
  })
})
