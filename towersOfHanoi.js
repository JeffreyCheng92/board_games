var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame () {
  this.tower1 = [3, 2, 1];
  this.tower2 = [];
  this.tower3 = [];
}

HanoiGame.prototype.isWon = function () {
  return (this.tower2.toString() === [3,2,1].toString() ||
            this.tower3.toString() === [3,2,1].toString());
};

HanoiGame.prototype.isValidMove = function(startTower, endTower) {
  var valid = false;
  if (startTower[(startTower.length) - 1] > endTower[(endTower.length) - 1]) {
    valid = false;
  } else if (startTower.length === 0) {
    valid = false;
  } else {
    valid = true;
  }
  return valid;
};

HanoiGame.prototype.move = function(startTower, endTower) {
  // this points to the wrong thing
  if (this.isValidMove(startTower, endTower)) {
    endTower.push( startTower.pop() );
    console.log('\033[2J');
    // return true;
  } else {
    console.log("Invalid move buddy-o");
    // return false;
  }
};

HanoiGame.prototype.print = function() {
  var first = JSON.stringify(this.tower1);
  var second = JSON.stringify(this.tower2);
  var third = JSON.stringify(this.tower3);

  console.log(first + " " + second + " " + third);
};

HanoiGame.prototype.promptMove = function(callback) {
  this.print();
  var that = this;
  reader.question("Take from? \n", function (start) {
    reader.question("Put on? \n", function (end) {
      var startTower = parseInt(start);
      var endTower = parseInt(end);
      // need to convert integers into "this.tower1 or this.tower2"

      switch (startTower) {
      case 1:
        startTower = that.tower1;
        break;
      case 2:
        startTower = that.tower2;
        break;
      case 3:
        startTower = that.tower3;
        break;
      }

      switch (endTower) {
      case 1:
        endTower = that.tower1;
        break;
      case 2:
        endTower = that.tower2;
        break;
      case 3:
        endTower = that.tower3;
        break;
      }

      callback(startTower, endTower);
    });
  });
};

HanoiGame.prototype.run = function(completionCallback) {
  if (this.isWon()) {
    console.log("You've beaten the game!");
    completionCallback();
  } else {
    var that = this;
    this.promptMove(function(startTower, endTower) {
      that.move(startTower, endTower);
      that.run(completionCallback);
    });
  }
};

var game = new HanoiGame();
game.run(function() {
  reader.close();
});
