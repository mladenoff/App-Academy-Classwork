class View {
  constructor(game, $el){
    this.game = game;
    this.$el = $el;
    this.setupTowers();
    this.render();
  }

  setupTowers(){
    for (var i = 0; i < 3; i++){
      const $tower = $("<ul>").addClass("tower");
      // for (var j = 0; j < this.game.towers[i].length; j++){
      //   const $disc = $("<li>").addClass("disc");
      //   $tower.append($disc);
      // }
      this.$el.append($tower);
    }
  }

  render (){
    const $towers = $("ul.tower");
    // console.log($towers);
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < this.game.towers[i].length ; j++) {
        const $disc = $("<li>").addClass("disc");
        console.log($disc);
        $($towers[i]).append($disc);
        console.log($towers[i]);
      }
    }
  }
}

module.exports = View;
