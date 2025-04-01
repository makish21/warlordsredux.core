#include "..\warlords_constants.inc"

params ["_position", "_side"];

(allPlayers inAreaArray [
    _position, 
    /*x=*/100, 
    /*y=*/100, 
    /*angle=*/0, 
    /*isRectangle=*/false, 
    /*z=*/100
]) select {
    _side != side group _x &&
    alive _x &&
    lifeState _x != "INCAPACITATED"
};
