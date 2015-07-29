function Board () {
  this.grid  = [["*","*","*"],
                ["*","*","*"],
                ["*","*","*"]];
}

Board.prototype.render = function() {
  var display = function(arr) {
    console.log(arr.join(" "));
  };

  this.grid.forEach(display);
};

Board.prototype.isOnBoard = function(row, col) {
  var valid = false;
  if (row >= 0 && row <= 2 && col >=0 && col <= 2) {
    valid = true;
  } else {
    valid = false;
  }
  return valid;
};

Board.prototype.isValidMove = function(row, col) {
  var valid = false;
  if (this.grid[row][col] === "*") {
    valid = true;
  } else {
    valid = false;
  }
  return valid;
};

Board.prototype.mark = function(row, col, marker) {
  if (this.isOnBoard(row, col) && this.isValidMove(row, col)) {
    this.grid[row][col] = marker;
  } else {
    console.log("Invalid move");
  }
};

Board.prototype.isWon = function() {
  // check rows, cols, diags
  var that = this;
  return (that.rowCheck() || that.colCheck() || that.diagCheck() );
};

Board.prototype.rowCheck = function() {
  for (var i = 0; i < this.grid.length; i++) {
    if (this.grid[i][0] === this.grid[i][1] &&
          this.grid[i][0] === this.grid[i][2] &&
          this.grid[i][0] !== "*") {
        return true;
    }
  }
  return false;
};

Board.prototype.colCheck = function() {
  for (var i = 0; i < this.grid.length; i++) {
    if (this.grid[0][i] === this.grid[1][i] &&
          this.grid[0][i] === this.grid[2][i] &&
          this.grid[0][i] !== "*") {
        return true;
    }
  }
  return false;
};

Board.prototype.diagCheck = function() {
  if (( (this.grid[0][0] === this.grid[1][1] &&
          this.grid[0][0] === this.grid[2][2]) ||
      (this.grid[0][2] === this.grid[1][1] &&
          this.grid[0][2] === this.grid[2][0]) ) &&
        this.grid[1][1] !== "*") {
    return true;
  } else {
    return false;
  }
};

module.exports = Board;
//
// var b = new Board();
// b.mark(0, 0, "X");
// b.mark(1, 1, "X");
// b.mark(2, 2, "X");
// b.render();
// console.log(b.isValidMove(0, 0));
// console.log(b.isWon());
// console.log(b.rowCheck());
// console.log(b.diagCheck());
