const FollowToggle = require('./follow_toggle.js');

$(() => {
  let $buttons = $('button.follow-toggle');
  $buttons.each(function(idx,button){
    new FollowToggle(button);
  });
});
