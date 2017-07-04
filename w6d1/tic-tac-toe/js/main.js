const View = require('./ttt-view.js'); // require appropriate file
const Game = require('../game/game.js'); // require appropriate file

$( () => {
  // Your code here
  const game = new Game();
  const $ttt = $('figure.ttt');

  const view = new View(game, $ttt);
  view.setupBoard();
  view.bindEvents();
});
