const APIUtil = require('./api_util.js');

class UsersSearch {
  constructor(el) {
    this.$el = $(el);
    this.$input = $(el).children("input");
    this.$ul = $(el).children("ul");
    this.handleInput();
  }

  handleInput() {
    this.$input.keypress(event => {
      console.log(this.$input.val());
      APIUtil.searchUsers(this.$input.val())
      .then(results => this.renderResults(results));

    });
  }


  renderResults (searchResults){
    this.$ul.empty();
    searchResults.forEach((result) => {
      let li = $($('<li>')
      .text(result.username));
      li.appendTo(this.$ul);
    });
  }

}


module.exports = UsersSearch;
