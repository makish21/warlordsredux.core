params ["_projectile", "_camera"];
_projectile setMissileTarget [objNull, true];

private _yaw = getDir _projectile;

private _dir = vectorDir _projectile;
private _pitch = (_dir select 2) atan2 (sqrt ((_dir select 0)^2 + (_dir select 1)^2));

private _pitchVel = 0;
private _yawVel   = 0;

private _maxRotSpeed   = 1;
private _acceleration  = 0.01;
private _damping       = 0.95;
private _inputPerTime = 60;

private _nightVision = false;
private _projectileIsShell = _projectile isKindOf "ShellCore";

uiNamespace setVariable ["WL_waypointPosition", customWaypointPosition];

_camera switchCamera "INTERNAL";
cameraEffectEnableHUD true;
showHUD [true, true, true, true, true, true, true, true, true, true, true];

private _waypointDrawer = addMissionEventHandler ["Draw3D", {
    private _waypointPosition = uiNamespace getVariable ["WL_waypointPosition", []];
    if (count _waypointPosition == 0) exitWith {};
    drawIcon3D [
        "\A3\ui_f\data\IGUI\RscIngameUI\RscOptics\square.paa",
        [1, 1, 1, 1],
        _waypointPosition,
        0.3,
        0.3,
        0,
        "WAYPOINT",
        0,
        0.02,
        "TahomaB",
        "center",
        true,
        0,
        0.01
    ];
}];

"missileCamera" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
private _display = uiNamespace getVariable ["RscTitleDisplayEmpty", displayNull];
private _background = _display ctrlCreate ["RscPicture", -1];
_background ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, safeZoneH];
_background ctrlSetText "\a3\weapons_f\Reticle\data\optika_tv_CA.paa";
_background ctrlCommit 0;

private _reticle = _display ctrlCreate ["RscPicture", -1];
_reticle ctrlSetPosition [1 / 8, 0, 3 / 4, 1];
_reticle ctrlSetText "\a3\weapons_f\Reticle\data\Optics_Gunner_MBT_02_M_CA.paa";
_reticle ctrlCommit 0;

private _fuelDisplay = _display ctrlCreate ["RscStructuredText", -1];
_fuelDisplay ctrlSetPosition [0, 0, 1, 0.2];
_fuelDisplay ctrlSetTextColor [1, 1, 1, 1];
_fuelDisplay ctrlCommit 0;

private _unlockControls = if (_projectileIsShell) then {
    format ["[%1] Lock/Unlock Controls<br/>", (actionKeysNames ["lockTarget", 1, "Combo"]) regexReplace ["""", ""]];
} else {
    "";
};

private _instructionsDisplay = _display ctrlCreate ["RscStructuredText", -1];
_instructionsDisplay ctrlSetPosition [0.7, 0.9, 0.5, 0.2];
_instructionsDisplay ctrlSetTextColor [1, 1, 1, 1];
_instructionsDisplay ctrlSetStructuredText parseText format [
    "<t align='left' size='1.2'>[%1] Detonate<br/>%2[%3] Thermal Vision</t>",
    (actionKeysNames ["defaultAction", 1, "Combo"]) regexReplace ["""", ""],
    _unlockControls,
    (actionKeysNames ["nightVision", 1, "Combo"]) regexReplace ["""", ""]
];
_instructionsDisplay ctrlCommit 0;

private _mapDisplay = _display ctrlCreate ["RscMapControl", -1];
_mapDisplay ctrlCommit 0;
_mapDisplay ctrlMapSetPosition [safeZoneX + 0.1, 0.5, 0.6, 0.8];
_mapDisplay ctrlMapAnimAdd [0, 0.2, getPosASL _projectile];
ctrlMapAnimCommit _mapDisplay;
_mapDisplay mapCenterOnCamera true;
_mapDisplay ctrlAddEventHandler ["Draw", WL2_fnc_iconDrawMap];

sleep 1;

private _lastTime = serverTime;
private _startTime = serverTime;
private _timeToLive = getNumber (configFile >> "CfgAmmo" >> (typeOf _projectile) >> "timeToLive");
private _projectileSpeed = getNumber (configFile >> "CfgAmmo" >> (typeOf _projectile) >> "maxSpeed");

_projectile setVariable ["BIS_WL_ownerAssetSide", BIS_WL_playerSide];
_projectile setVariable ["WL_tvMunition", true];
[_projectile, player] spawn WL2_fnc_uavJammer;

private _fuelUsed = 0;
private _controlUnlocked = false;
while { alive _projectile && alive player } do {
    private _elapsedTime = serverTime - _lastTime;
    _lastTime = serverTime;

    private _pitchInput = (inputAction "AimUp") - (inputAction "AimDown");
    private _yawInput = (inputAction "AimLeft") - (inputAction "AimRight");

    private _projectilePosition = _projectile modelToWorld [0, 0, 0];
    private _altitude = _projectilePosition # 2;

    if (serverTime - _startTime < 1 && !_projectileIsShell) then {
        private _desiredPitch = 0;
        private _pitchError = _desiredPitch - _pitch;
        _pitchInput = (_pitchError min 10) max -10;
    };

    private _fuelRemaining = if (_projectileIsShell) then {
        100 - _fuelUsed;
    } else {
        100 * (_timeToLive - (serverTime - _startTime + 1)) / _timeToLive;
    };
    if (_fuelRemaining <= 0) then {
        _fuelRemaining = 0;
        _pitchInput = 0;
        _yawInput = 0;
        _controlUnlocked = false;
    };

    private _inputFactor = _inputPerTime * _elapsedTime;

    private _pitchFinalInput = (_pitchInput * _acceleration * _inputFactor);
    private _yawFinalInput = (_yawInput * _acceleration * _inputFactor);

    _pitchVel = _pitchVel + _pitchFinalInput;
    _yawVel = _yawVel + _yawFinalInput;

    if (_projectileIsShell && _controlUnlocked) then {
        private _fuelUsage = ((abs _pitchFinalInput) + (abs _yawFinalInput)) * 10;
        if (_altitude > 500 || _pitch > 0) then {
            _fuelUsage = _fuelUsage * 10;
        };
        _fuelUsed = _fuelUsed + (_fuelUsage max 0.1);
    };

    _pitchVel = _pitchVel max (-_maxRotSpeed) min _maxRotSpeed;
    _yawVel = _yawVel max (-_maxRotSpeed) min _maxRotSpeed;

    _pitch = _pitch + _pitchVel;
    _yaw = _yaw - _yawVel;

    _pitch = 89 min (_pitch max -80);

    _pitchVel = _pitchVel * _damping;
    _yawVel = _yawVel * _damping;

    private _cosPitch = cos _pitch;
    private _sinPitch = sin _pitch;
    private _cosYaw = cos _yaw;
    private _sinYaw = sin _yaw;

    private _forward = [
        _cosPitch * _sinYaw,
        _cosPitch * _cosYaw,
        _sinPitch
    ];
    private _right = _forward vectorCrossProduct [0, 0, 1];
    _right = vectorNormalized _right;

    private _up = _right vectorCrossProduct _forward;
    _up = vectorNormalized _up;

    private _unlockInput = inputAction "lockTarget";
    if (_unlockInput > 0) then {
        waitUntil {
            inputAction "lockTarget" == 0
        };
        _controlUnlocked = !_controlUnlocked;
    };

    private _zoomInMap = inputAction "zoomIn";
    if (_zoomInMap > 0) then {
        waitUntil {
            inputAction "zoomIn" == 0
        };
        private _currentZoom = ctrlMapScale _mapDisplay;
        _mapDisplay ctrlMapAnimAdd [0, _currentZoom / 2, getPosASL _projectile];
        ctrlMapAnimCommit _mapDisplay;
    };
    private _zoomOutMap = inputAction "zoomOut";
    if (_zoomOutMap > 0) then {
        waitUntil {
            inputAction "zoomOut" == 0
        };
        private _currentZoom = ctrlMapScale _mapDisplay;
        _mapDisplay ctrlMapAnimAdd [0, _currentZoom * 2, getPosASL _projectile];
        ctrlMapAnimCommit _mapDisplay;
    };

    if (_projectileIsShell && !_controlUnlocked) then {
        _dir = vectorDir _projectile;
        _pitch = (_dir select 2) atan2 (sqrt ((_dir select 0)^2 + (_dir select 1)^2));
        _yaw = getDir _projectile;

        _pitchVel = 0;
        _yawVel = 0;

        _projectileSpeed = velocityModelSpace _projectile # 1;
    } else {
        _projectile setVectorDirAndUp [_forward, _up];
        _projectile setVelocityModelSpace [0, _projectileSpeed, 0];
    };

    if (inputAction "nightVision" > 0) then {
        waitUntil {inputAction "nightVision" == 0};
        _nightVision = !_nightVision;
    };
    private _sensorsDisabled = _projectile getVariable ["WL_sensorsDisabled", false];
    if (_nightVision && !_sensorsDisabled) then {
        true setCamUseTI 0;
    } else {
        false setCamUseTI 0;
    };

    if (inputAction "defaultAction" > 0) then {
        triggerAmmo _projectile;
        break;
    };

    private _altitudeColor = if (_projectileIsShell && (_altitude > 500 || _pitch > 0)) then {
        " color = '#ff0000'";
    } else {
        ""
    };

    _fuelDisplay ctrlSetStructuredText parseText format [
        "<t align='left' size='1.2'>GPS: %1</t><t align='center' size='2'>Fuel: %2%%</t><t align='right' size='1.2'%3>ALT: %4M</t>",
        mapGridPosition _projectile,
        round _fuelRemaining,
        _altitudeColor,
        round _altitude
    ];

    sleep 0.001;
};

sleep 3;
deleteVehicle _projectile;

removeMissionEventHandler ["Draw3D", _waypointDrawer];
switchCamera player;
"missileCamera" cutText ["", "PLAIN"];
