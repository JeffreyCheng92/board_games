var Board = require("./board");

var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function Game (reader) {
  this.board = new Board();
  this.reader = reader;
}

Game.prototype.promptMove = function(callback) {
  this.board.render();
  // console.log(this);
  var that = this;
  that.reader.question("What row? \n", function(tempRow) {
    that.reader.question("What col? \n", function(tempCol) {
      var row = parseInt(tempRow);
      var col = parseInt(tempCol);

      if (that.board.isOnBoard(row, col) && that.board.isValidMove(row, col)) {
        // console.log("here i am");
        callback(row, col);
      } else {
        console.log("Invalid move");
      }
    });
  });
};


// Game.prototype.run = function(completionCallback) {
//   if (this.board.isWon()) {
//     console.log("You've beaten the game!");
//     completionCallback();
//   } else {
//     var that = this;
//     that.promptMove(function(row, col) {
//       that.board.mark(row, col, marker);
//       that.run(completionCallback);
//     }, "X");
//   }
// };
marker = "X";
var g = new Game(reader);
g.promptMove(g.board.mark);
