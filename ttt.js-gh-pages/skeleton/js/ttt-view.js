(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var that = this;
    $(".square").on("click", function(event) {
      var currentTarget = event.currentTarget;
      var $currentTarget = $(currentTarget);
      that.makeMove($currentTarget);
    });
  };

  View.prototype.makeMove = function ($square) {
      var row = $square.data("row");
      var col = $square.data("col");

      var pos = [row - 1, col - 1]

      if (TTT.Board.isValidPos(pos) && this.game.board.isEmptyPos(pos)) {
        this.game.playMove(pos);
        $square.html(this.game.currentPlayer);
        if (this.game.currentPlayer === "x") {
          $square.addClass("clickedX")
        } else {
          $square.addClass("clickedO")
        }
        if (this.game.board.winner()) {
          alert("You win!");
        }
      } else {
        alert("Invalid Move");
      }
  };

  View.prototype.setupBoard = function () {
    for (var r = 1; r < 4; r++) {
      for (var c = 1; c < 4; c++) {
        var $div = $("<div>");
        $div.attr("class", "square");
        // $div.attr("mark", "");
        $div.data("row", r);
        $div.data("col", c);
        this.$el.append($div);
      }
    }

  };
})();
