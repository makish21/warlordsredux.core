#include "..\..\warlords_constants.inc"

params ["_charge", "_timer", "_caller", "_target"];

[_charge, _target] call BIS_fnc_attachToRelative;

_charge setObjectScale 3;
_charge setVariable ["WL_demolishTime", _timer];
_charge setVariable ["WL_demolisher", _caller];
_charge setVariable ["WL_demolishable", _target];

private _targetChildren = _target getVariable ["WL2_children", []];
_targetChildren pushBack _charge;
_target setVariable ["WL2_children", _targetChildren];

if (isDedicated) exitWith {};

[
    _charge,
    "<t color='#00ff00'>Stop Demolition</t>",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",
    "speed player < 1",
    "speed player < 1",
    {},
    {
        private _disarmSounds = [
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_hard_01.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_hard_02.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_hard_03.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_hard_04.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_soft_01.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_soft_02.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_soft_03.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_metal_01.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_metal_02.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_metal_03.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_metal_04.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_plastic_01.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_plastic_02.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_plastic_03.wss",
            "a3\sounds_f_enoch\assets\arsenal\ugv_02\probingweapon_01\ugv_lance_impact_plastic_04.wss"
        ];
        playSound3D [selectRandom _disarmSounds, _target, false, getPosASL _target, 2, 1, 200, 0];
    },
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        private _demolishable = _target getVariable ["WL_demolishable", objNull];
        private _charges = _target getVariable ["WL2_children", []];
        _charges = _charges - [_demolishable];
        _target setVariable ["WL2_children", _charges, true];
        deleteVehicle _target;
    },
    {},
    [],
    10,
    100,
    false,
    false
] call BIS_fnc_holdActionAdd;

private _lightToggle = false;
private _lightPos = getPosATL _charge;
_lightPos set [2, _lightPos # 2 + 0.2];
private _lightPoint = createVehicle ["#lightpoint", _lightPos, [], 0, "FLY"];
_lightPoint setLightAttenuation [0.5, 0, 100, 0];
_lightPoint setLightDayLight true;
_lightPoint setLightFlareMaxDistance 500;
_lightPoint setLightColor[1, 0, 0];
_lightPoint setLightAmbient[1, 0, 0];
_lightPoint setLightIntensity 0;

private _asset = _charge getVariable ["WL_demolishable", objNull];
while { alive _charge && alive _asset } do {
    private _sleepTime = 0.5;
    private _demolishTime = _charge getVariable ["WL_demolishTime", -1];

    if (_lightToggle) then {
        _lightPoint setLightIntensity 200000;
    } else {
        _lightPoint setLightIntensity 0;
    };
    _lightToggle = !_lightToggle;

    playSound3D ["\a3\sounds_f\arsenal\tools\minedetector_beep_01.wss", _charge, false, getPosASL _charge, 2, 1, 200, 0, true];

    private _timeRemaining = (_demolishTime + WL_DEMOLISH_TIME) - serverTime;
    if (_timeRemaining <= 0) then {
        private _demolisher = _charge getVariable ["WL_demolisher", objNull];
        if (local _demolisher) then {
            [_asset, _demolisher] remoteExec ["WL2_fnc_killRewardHandle", 2];
            private _explosion = createVehicle ["M_Air_AA", getPosASL _charge, [], 0, "FLY"];
            _explosion setPosASL getPosASL _charge;
            hideObject _explosion;
            triggerAmmo _charge;
            sleep 0.5;
            // don't call FF script, this prevents runway griefing
            _asset setDamage 1;
        };
        deleteVehicle _charge;
        deleteVehicle _lightPoint;
        sleep 2;
        deleteVehicle _asset;
        playSound3D ["a3\sounds_f\sfx\special_sfx\building_destroy_01.wss", objNull, false, _lightPos, 2, 1, 200, 0, true];
    } else {
        _sleepTime = (_timeRemaining / WL_DEMOLISH_TIME) max 0.1;
    };

    sleep _sleepTime;
};

deleteVehicle _lightPoint;