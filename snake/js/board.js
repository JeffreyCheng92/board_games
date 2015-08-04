// (function() {
  // var Snake = window.Snake = window.Snake || {};
  var Snake = require("./snake");

  function Board() {
    this.snake = new Snake();
    this.grid = Board.generateGrid();
  }

  Board.generateGrid = function() {
    var results = [];
    for (var i = 0; i < 10; i++) {
      results.push([]);
      for (var j = 0; j < 10; j++) {
        results[i].push(".");
      }
    }

    return results;
  }

  Board.prototype.render = function() {
    this.makeSnake()
    for (var i = 0; i < 10; i++) {
      console.log(this.grid[i].join(" "));
    }
  }

  Board.prototype.makeSnake = function() {
    var that = this;
    this.snake.segments.forEach( function(segment) {
      that.grid[segment[0]][segment[1]] = "~";
    })
  }

var b = new Board();
b.render();
  // })();
