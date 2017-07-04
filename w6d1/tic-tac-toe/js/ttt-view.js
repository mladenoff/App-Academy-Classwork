class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
  }

  bindEvents() {
    $("li.square").on("click", (e) =>{
      const $clicked = $(e.currentTarget);
      this.makeMove($clicked);

      if (this.game.isOver()){
        if (this.game.winner()) {
          alert("The winner is: " + this.game.winner());
        } else {
          alert("It's a draw!!");
        }
        $("li.square").removeClass("unmoved");
        $("li.square").off("click");
      }
    });

  }


  makeMove($square) {
    try {
      const currentMark = this.game.currentPlayer;
      this.game.playMove($square.attr("data-pos").split(","));
      $square.text(currentMark);
      $square.removeClass("unmoved").addClass("moved");
    }
    catch(err) {
      alert(err.msg);
    }
  }

  setupBoard() {
    const $grid = $("<ul>").addClass("grid");
    for (var i = 0; i < 9; i++) {
      const pos = [Math.floor(i / 3), (i % 3)];
      const $square = $("<li>").addClass("square").addClass("unmoved").attr("data-pos", pos);
      // $square.on("mouseenter", (e) => {
      //   const $hovered = $(e.currentTarget);
      //   console.log($hovered.attr("data-pos"));
        // $hovered.css("background-color", "red");
      // });
      $grid.append($square);
    }
    this.$el.append($grid);
  }
}

module.exports = View;
