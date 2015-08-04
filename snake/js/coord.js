(function() {
  var Snake = window.Snake = window.Snake || {};

 function Coord() {

 }

 Coord.plus = function(coord1, coord2) {
   return [coord1[0] + coord2[0], coord1[1] + coord2[1]];
 }

 Coord.equals = function(coord1, coord2) {
   return (coord1[0] === coord2[0] && coord1[1] === coord2[1]);
 }



})();
