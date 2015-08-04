// (function() {
  // var Snake = window.Snake = window.Snake || {};

 function Snake() {
   this.segments = [[5,4],[5,5]];
   this.direction = "N";
  }

  Snake.DIR = ["N","E","S","W"];

  Snake.prototype.turn = function(dir) {
    this.direction = dir;
  }

  Snake.prototype.move = function () {
    this.segments = this.segments.splice(-1).concat(this.segments);
    this.segments[0][0] = this.segments[1][0] + Snake.VECTORS[direction][0];
    this.segments[0][1] = this.segments[1][1] + Snake.VECTORS[direction][1];
  };

  Snake.VECTORS = {
    "N": [0,1],
    "S": [0,-1],
    "E": [1,0],
    "W": [-1,0]
  }

  module.exports = Snake;
//
// })();
