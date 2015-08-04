(function () {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupTowers();
    this.bindEvents();
  }

  View.prototype.bindEvents = function() {
    this.fromTower = false;

    $(".tower").on("click", this.clickCallback.bind(this));
  };

  View.prototype.clickCallback = function (event) {
    if (this.fromTower) {
      var $toTower = $(event.currentTarget);
      var fromT = parseInt(this.fromTower.attr("id").slice(-1));
      var toT = parseInt($toTower.attr("id").slice(-1));

      if (this.game.isValidMove(fromT, toT)) {
        this.game.move(fromT, toT);
        this.render();
      } else {
        alert("Invalid Move");
      }

      if (this.game.isWon()) {
        alert("Game over!");
        this.game.towers = [[3, 2, 1], [], []];
        this.render();
      }

      this.fromTower = false;
    } else {
      this.fromTower = $(event.currentTarget);
    }
  };

  View.prototype.render = function() {
    $(".show").removeClass("show").html("");
    for (var i = 0; i < 3; i++) {
      var tower = this.game.towers[i];
      var l = tower.length;
      for (var j = 0; j < l; j++) {
        var $disc = $("#tower" + i).children().eq(2 - j)
        $disc.addClass("show").html(tower[j]);
      }
    }
  }

  View.prototype.setupTowers = function() {
    for (var i = 0; i < 3; i++) {
      var $tower = $("<div>");
      $tower.addClass("tower");
      $tower.attr("id", "tower" + i);
      this.$el.append($tower);

      for (var j = 1; j < 4; j++) {
        var $disc = $("<div>");
        $disc.addClass("disc");

        switch (j) {
        case 1:
          $disc.addClass("top");
          break;
        case 2:
          $disc.addClass("middle");
          break;
        case 3:
          $disc.addClass("bottom");
          break;
        }

        $disc.addClass("")
        if (i === 0) {
          $disc.html(j);                                    //
          $disc.addClass("show");                               //
        }
        $tower.append($disc);
      }
    }
  };

})();
