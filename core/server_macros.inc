#define playerFunds ((serverNamespace getVariable "fundsDatabase") getOrDefault [(getPlayerUID _sender), 0])
#define variable (["actualIncomeBlu", "actualIncomeOpf"] select ([west, east] find (side group _x)))
#define WL_SPAWN_TRUCK_TYPES ["B_Truck_01_medical_F", "O_Truck_03_medical_F"]
#define WL_SPAWN_POD_TYPES ["B_Slingload_01_Medevac_F", "Land_Pod_Heli_Transport_04_medevac_F"]
#define getFTVehicle (WL_SPAWN_TRUCK_TYPES select ([west, east] find (side group _sender)))
#define getFTPod (WL_SPAWN_POD_TYPES select ([west, east] find (side group _sender)))


#include "..\..\mission_constants.ext"
