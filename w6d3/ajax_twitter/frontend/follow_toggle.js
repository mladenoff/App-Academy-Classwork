const APIUtil = require('./api_util.js');

class FollowToggle {
  constructor(el) {
    console.log("hats");
    this.$el = $(el);
    this.userId = this.$el.data("user-id");

    if (this.$el.data("initial-follow-state")){
      this.followState = "followed";
    } else {
      this.followState = "unfollowed";
    }

    this.render();

    this.handleClick();
  }

  render(){
    this.$el.prop("disabled", false);
    if (this.followState === "unfollowed") {
      this.$el.html("Follow!");
    } else if (this.followState === "followed") {
      this.$el.html("Unfollow!");
    } else {
      this.$el.prop("disabled", true);
    }
  }

  handleClick(){

    this.$el.on("click", event => {

      event.preventDefault();

      if (this.followState === "followed" ) {
        this.followState = "unfollowing";
        this.render();
        APIUtil.unfollowUser(this.userId)
        .then(() => {
          this.followState = "unfollowed";
          this.render();
        });
      } else if (this.followState === "unfollowed") {
        this.followState = "following";
        this.render();
        APIUtil.followUser(this.userId)
          .then(() => {
            this.followState = "followed";
            this.render();
        });
      }
    });
  }
}

      // $.ajax({
      //   url: `/users/${this.userId}/follow`,
      //   type: this.followState === "followed" ? "DELETE" : "POST",
      //   dataType: "json",
      //   success: () => {
      //
      //     this.followState = this.followState === "followed" ? "unfollowed" : "followed";
      //
      //     console.log(this);
      //
      //     this.render();
      //   }
      // });
//     });
//   }
// }

module.exports = FollowToggle;
