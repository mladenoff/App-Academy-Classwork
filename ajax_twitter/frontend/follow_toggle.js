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
    if (this.followState === "unfollowed") {
      this.$el.html("Follow!");
    } else if (this.followState === "followed") {
      this.$el.html("Unfollow!");
    }
  }

  handleClick(){
    this.$el.on("click", event => {
      event.preventDefault();
      const formData = $(event.currentTarget).serialize();
      console.log(event);
      $.ajax({
        url: "/users/:user_id/follow",
        type: this.followState === "followed" ? "DELETE" : "POST",
        data: formData,
        sucess(){

          this.followedState = this.followState === "followed" ? "unfollowed" : "followed";

          this.render();
        }
      });
    });
  }
}

module.exports = FollowToggle;
