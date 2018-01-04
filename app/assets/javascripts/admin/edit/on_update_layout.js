function registerOnUpdateLayout() {
  $('form.edit_grouping').submit(function () {
    $(this).append($('<input>', {
      type: 'hidden',
      name: 'layout',
      value: serializeLayout()
    }));
    return true;
  });
}

function serializeLayout() {
  let layout = {};
  $('.layout-area').children('.draggable').each(function(i) {
    let type = $(this).attr('data-type');
    layout[type] = layout[type] || {};

    let id = $(this).attr('data-id');
    layout[type][id] = {
      x: $(this).attr('data-x'),
      y: $(this).attr('data-y')
    };
  });
  return JSON.stringify(layout);
}
