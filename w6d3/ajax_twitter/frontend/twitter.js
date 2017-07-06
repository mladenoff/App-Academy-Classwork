const FollowToggle = require('./follow_toggle.js');
const UsersSearch = require('./users_search.js');


$(() => {
  let $buttons = $('button.follow-toggle');
  $buttons.each(function(idx,button){
    new FollowToggle(button);
  });

  let $searches = $('nav.users-search');
  $searches.each(function(idx, search){
    new UsersSearch(search);
  });
});
