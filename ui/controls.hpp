import RscStructuredText;

#define ST_CENTER	 0x02
#define ST_UPPERCASE 0xC0

class welcomeScreen
{
	idd = 9000;

	class controls
	{
		class welcomeFrame: IGUIBackMRTM
		{
			idc = 9001;
			deletable = 0;
			x = 0.250656 * safezoneW + safezoneX;
			y = 0.171 * safezoneH + safezoneY;
			w = 0.499688 * safezoneW;
			h = 0.671 * safezoneH;
			colorText[] = {1,1,1,1};
		};

		class welcomeMain: IGUIBackMRTM
		{
			idc = -1;
			deletable = 0;
			x = 0.257656 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.484688 * safezoneW;
			h = 0.649 * safezoneH;
			colorText[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
		};

		class welcomeMainImg: RscPictureMRTM
		{
			idc = -1;
			type = CT_STATIC;
			text = "a3\map_altis\data\picturemap_ca.paa";
			style = ST_TILE_PICTURE;
			x = 0.257656 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.484688 * safezoneW;
			h = 0.649 * safezoneH;
			tileW = 1;
			tileH = (safezoneH min safeZoneW) / (safezoneH max safezoneW);
		};
		
		class welcomeMainImgDim: IGUIBackMRTM
		{
			idc = -1;
			x = 0.257656 * safezoneW + safezoneX;
			y = 0.181 * safezoneH + safezoneY;
			w = 0.484688 * safezoneW;
			h = 0.649 * safezoneH;
			colorBackground[] = {0,0,0,0.3};
		};
		
		class welcomeText: RscStructuredTextMRTM
		{
			idc = 9005;
			deletable = 0;
			text = "Warlords Redux v2.6.10";
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class welcomeTextToRead: RscStructuredTextMRTM
		{
			idc = 9006;
			deletable = 0;
			text = "";
			font = "puristaMedium";
			x = 0.508594 * safezoneW + safezoneX;
			y = 0.801 * safezoneH + safezoneY;
			w = 0.189531 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class welcomeSlidePic: RscPictureMRTM
		{
			idc = 9007;
			style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.209 * safezoneH;
		};

		class welcomeListFrame: RscFrameMRTM
		{
			type = CT_STATIC;
			idc = -1;
			deletable = 0;
			style = ST_FRAME;
			colorBackground[] = {0,0,0,0};
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.286 * safezoneH;
		};

		class welcomeTextBlockFrame: RscFrameMRTM
		{
			type = CT_STATIC;
			sizeEx = "0.021 / (getResolution select 5)";
			idc = -1;
			deletable = 0;
			style = ST_FRAME;
			colorBackground[] = {0,0,0,0};
			x = 0.485469 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.245937 * safezoneW;
			h = 0.528 * safezoneH;
		};

		class welcomeControlGroup: RscControlsGroupMRTM
		{
			deletable = 0;
			fade = 0;
			class VScrollbar: ScrollBar
			{
				color[] = {1,1,1,1};
				height = 0.528;
				width = 0.021;
				autoScrollEnabled = 1;
			};

			class HScrollbar: ScrollBar
			{
				color[] = {1,1,1,1};
				height = 0;
				width = 0;
			};

			class Controls
			{
				class welcomeTextBlock: RscStructuredTextMRTM
				{
					idc = 9010;
					deletable = 0;
					type = CT_STRUCTURED_TEXT;
					style = ST_LEFT;
					w = 0.245937 * safezoneW;
					h = 4.6 * safezoneH;
				};
			};

			type = CT_CONTROLS_GROUP;
			idc = -1;
			x = 0.485469 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.255937 * safezoneW;
			h = 0.528 * safezoneH;
			shadow = 0;
			style = ST_MULTI;
		};

		class welcomeList: RscListboxMRTM
		{
			idc = 9011;
			deletable = 0;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.286 * safezoneH;
		};
		class welcomeCloseButton: RscButtonMRTM
		{
			idc = 1;
			type = CT_BUTTON;
			text = "Close";
			sizeEx = "0.021 / (getResolution select 5)";
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {1,1,1,0};
			soundEnter[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEnter", 0.09, 1};
			soundPush[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundPush", 0.0, 0};
			soundClick[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundClick", 0.07, 1};
			soundEscape[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEscape", 0.09, 1};
			style = 2;
			x = 0.678594 * safezoneW + safezoneX;
			y = 0.794 * safezoneH + safezoneY;
			w = 0.059531 * safezoneW;
			h = 0.033 * safezoneH;
			shadow = 0;
			offsetX = 0.000;
			offsetY = 0.000;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			borderSize = 0;
			onLoad =  "(_this # 0) ctrlEnable false;";
			action = "[] call MRTM_fnc_updateViewDistance;";
		};
	};
};

class rearmMenu
{
	idd = 1000;

	class controls
	{
		class MRTMRearmBack: IGUIBackMRTM
		{
			idc = 1001;
			x = 0.247344 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.515625 * safezoneW;
			h = 0.495 * safezoneH;
		};
		class MRTMRearmOk: RscButtonMRTM
		{
			idc = 1;
			type = CT_BUTTON;
			text = "Rearm";
			sizeEx = "0.021 / (getResolution select 5)";
			x = 0.68975 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.0670312 * safezoneW;
			h = 0.033 * safezoneH;
			onLoad =  "(_this # 0) ctrlEnable true;";
		};
		class MRTMRearmCamoText: RscStructuredTextMRTM
		{
			idc = 1100;
			text = "Camo Netting:";
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRearmHullList: RscListboxMRTM
		{
			idc = 1500;
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.187 * safezoneH;
		};
		class MRTMRearmHullText: RscStructuredTextMRTM
		{
			idc = 1101;
			text = "SLAT armor:";
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRearmCamoList: RscListboxMRTM
		{
			idc = 1501;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.187 * safezoneH;
		};
		class MRTMRearmOtherText: RscStructuredTextMRTM
		{
			idc = 1103;
			text = "Other customizations:";
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRearmOtherList: RscListboxMRTM
		{
			idc = 1503;
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.143 * safezoneH;
		};
		class MRTMRearmCustomAmmoText: RscStructuredTextMRTM
		{
			idc = 1104;
			text = "Custom ammo: Soon™";
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRearmLiveryText: RscStructuredTextMRTM
		{
			idc = 1102;
			text = "Liveries:";
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class MRTMRearmLiveryList: RscListboxMRTM
		{
			idc = 1502;
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.187 * safezoneH;
		};
		class RscFrame_1800: RscFrameMRTM
		{
			idc = 1800;
			x = 0.265905 * safezoneW + safezoneX;
			y = 0.5066 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.198 * safezoneH;
		};
		class RscFrame_1801: RscFrameMRTM
		{
			idc = 1801;
			x = 0.265907 * safezoneW + safezoneX;
			y = 0.2536 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.242 * safezoneH;
		};
		class RscFrame_1802: RscFrameMRTM
		{
			idc = 1802;
			x = 0.420594 * safezoneW + safezoneX;
			y = 0.2536 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.242 * safezoneH;
		};
		class RscFrame_1803: RscFrameMRTM
		{
			idc = 1803;
			x = 0.576313 * safezoneW + safezoneX;
			y = 0.2536 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.242 * safezoneH;
		};
		class RscFrame_1804: RscFrameMRTM
		{
			idc = 1804;
			x = 0.420593 * safezoneW + safezoneX;
			y = 0.5066 * safezoneH + safezoneY;
			w = 0.144375 * safezoneW;
			h = 0.198 * safezoneH;
		};
		// class MRTMRearmCustomAmmoClassified: RscPictureMRTM
		// {
		// 	idc = 69691;
		// 	text = "src\img\classified_ca.paa";
		// 	sizeEx = "0.021 / (getResolution select 5)";
		// 	style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
		// 	x = 0.422656 * safezoneW + safezoneX;
		// 	y = 0.530 * safezoneH + safezoneY;
		// 	w = 0.139219 * safezoneW;
		// 	h = 0.187 * safezoneH;
		// };
		/*class MRTMRearmLiveryClassified: RscPictureMRTM
		{
			idc = 69691;
			text = "src\img\classified_ca.paa";
			sizeEx = "0.021 / (getResolution select 5)";
			style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
			x = 0.577344 * safezoneW + safezoneX;
			y = 0.302 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.187 * safezoneH;
		};*/
	};
};

#include "\a3\ui_f\hpp\definecommongrids.inc"

class MRTM_settingsMenu
{
	idd = 8000;

	class controls
	{
		class MRTMBackground: IGUIBackMRTM
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.8};

			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1.1 * GUI_GRID_CENTER_H;
			w = 40 * GUI_GRID_CENTER_W;
			h = 22.8 * GUI_GRID_CENTER_H;
		};
		class MRTMHeaderBackground: IGUIBackMRTM
		{
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};

			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 40 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		class MRTMHeaderTextLeft: RscStructuredTextMRTM
		{
			idc = -1;
			text = "$STR_A3_WL_settings_title";
			colorBackground[] = {0,0,0,0};

			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;

			size = 0.9 * GUI_GRID_CENTER_H;
			
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMHeaderTextRight: RscStructuredTextMRTM
		{
			idc = 8001;
			colorBackground[] = {0,0,0,0};
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;

			size = 0.9 * GUI_GRID_CENTER_H;

			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "right";
				shadow = 1;
			};
		};
		// class MRTMdiscordImg: RscPictureMRTM
		// {
		// 	idc = -1;
		// 	text = "src\img\discord_ca.paa";
		// 	style = ST_MULTI + ST_TITLE_BAR;
		// 	x = 0.493344 * safezoneW + safezoneX;
		// 	y = 0.236 * safezoneH + safezoneY;
		// 	w = 0.014244 * safezoneW;
		// 	h = 0.022 * safezoneH;
		// };
		class MRTMMainCtrlsGroup: RscControlsGroupMRTM
		{
#define CTRLS_GROUP_WIDTH (40 * GUI_GRID_CENTER_W)
#define CTRLS_GROUP_CENTER (CTRLS_GROUP_WIDTH * 0.5)

			type = CT_CONTROLS_GROUP;
			idc = 8999;

			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1.1 * GUI_GRID_CENTER_H;
			w = CTRLS_GROUP_WIDTH;
			h = 22.8 * GUI_GRID_CENTER_H;

			style = ST_MULTI;

			deletable = 0;
			fade = 0;
			class VScrollbar: ScrollBar
			{
				color[] = {1,1,1,1};
				height = 0.5;
				width = 0.021;
				autoScrollEnabled = 1;
			};

			class HScrollbar: ScrollBar
			{
				color[] = {1,1,1,1};
				height = 0;
				width = 0;
			};

			class Controls
			{
#define SPACE_W (0.2 * GUI_GRID_CENTER_W)
#define OPTION_TEXT_W (CTRLS_GROUP_CENTER - SPACE_W * 0.5)
#define OPTION_CONTROL_X (CTRLS_GROUP_CENTER + SPACE_W * 0.5)

#define SLIDER_W (7 * GUI_GRID_CENTER_W)
#define SLIDER_EDIT_X (OPTION_CONTROL_X + SLIDER_W + SPACE_W)
#define SLIDER_EDIT_W (3.5 * GUI_GRID_CENTER_W)
				class MRTMViewHeaderText: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_view_distance_title";
					colorBackground[] = {0.3,0.3,0.3,0.7};

					x = 0 * GUI_GRID_CENTER_W;
					y = 0 * GUI_GRID_CENTER_H;
					w = CTRLS_GROUP_WIDTH;
					h = 1 * GUI_GRID_CENTER_H;

					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes {
						shadow = 0;
					};
				};
				class RscLine: RscTextMRTM
				{
					idc = -1;
					style = ST_MULTI + ST_TITLE_BAR + ST_HUD_BACKGROUND;

					x = 0 * GUI_GRID_CENTER_W;
					y = 1 * GUI_GRID_CENTER_H;
					w = CTRLS_GROUP_WIDTH;
					h = 0.01 * GUI_GRID_CENTER_H;

					text = "";
					colorBackground[] = {0,0,0,0};
					colorText[] = {1,1,1,1};
				};
				class MRTMViewInfText: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_view_distance_on_foot";

					x = 0 * GUI_GRID_CENTER_W;
					y = 1.5 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;

					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMViewInfSlider: RscXSliderHMRTM
				{
					idc = 8003;
					text = "";
					onSliderPosChanged = "[0, _this select 1] call MRTM_fnc_onSliderChanged;";

					x = OPTION_CONTROL_X;
					y = 1.5 * GUI_GRID_CENTER_H;
					w = SLIDER_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMViewInfEdit: RscEditMRTM
				{
					idc = 8004;
					onKeyUp = "[_this select 0, 'inf', 0] call MRTM_fnc_onChar;";

					x = SLIDER_EDIT_X;
					y = 1.5 * GUI_GRID_CENTER_H;
					w = SLIDER_EDIT_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMViewGroundText: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_view_distance_in_vehicle";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 3 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;

					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMViewGroundlider: RscXSliderHMRTM
				{
					idc = 8005;
					text = "";
					onSliderPosChanged = "[1, _this select 1] call MRTM_fnc_onSliderChanged;";
					
					x = OPTION_CONTROL_X;
					y = 3 * GUI_GRID_CENTER_H;
					w = SLIDER_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMViewVehiclesEdit: RscEditMRTM
				{
					idc = 8006;
					onKeyUp = "[_this select 0, 'ground', 0] call MRTM_fnc_onChar;";
					
					x = SLIDER_EDIT_X;
					y = 3 * GUI_GRID_CENTER_H;
					w = SLIDER_EDIT_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMViewAirText: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_view_distance_in_aircraft";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 4.5 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;

					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMViewAirSlider: RscXSliderHMRTM
				{
					idc = 8007;
					text = "";
					onSliderPosChanged = "[2, _this select 1] call MRTM_fnc_onSliderChanged;";

					x = OPTION_CONTROL_X;
					y = 4.5 * GUI_GRID_CENTER_H;
					w = SLIDER_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMViewAirEdit: RscEditMRTM
				{
					idc = 8008;
					onKeyUp = "[_this select 0, 'air', 0] call MRTM_fnc_onChar;";

					x = SLIDER_EDIT_X;
					y = 4.5 * GUI_GRID_CENTER_H;
					w = SLIDER_EDIT_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMViewDronesText: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_view_distance_in_uav";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 6 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;

					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMViewDronesSlider: RscXSliderHMRTM
				{
					idc = 8009;
					text = "";
					onSliderPosChanged = "[4, _this select 1] call MRTM_fnc_onSliderChanged;";
					
					x = OPTION_CONTROL_X;
					y = 6 * GUI_GRID_CENTER_H;
					w = SLIDER_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMViewDronesEdit: RscEditMRTM
				{
					idc = 8010;
					onKeyUp = "[_this select 0, 'drones', 0] call MRTM_fnc_onChar;";

					x = SLIDER_EDIT_X;
					y = 6 * GUI_GRID_CENTER_H;
					w = SLIDER_EDIT_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMObjectsButtonText: RscStructuredTextMRTM
				{
					idc = 8011;
					text = "$STR_A3_WL_settings_view_distance_sync_objects";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 7.5 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;

					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMObjectsButton: RscCheckboxMRTM
				{
					idc = 8013;
					action = "profileNamespace setVariable ['MRTM_syncObjects', !(profileNamespace getVariable 'MRTM_syncObjects')]; 0 spawn MRTM_fnc_openMenu;";

					x = OPTION_CONTROL_X;
					y = 7.25 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMViewObjectsText: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_view_distance_objects";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 9 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;

					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMViewObjectsSlider: RscXSliderHMRTM
				{
					idc = 8012;
					text = "";
					onSliderPosChanged = "[3, _this select 1] call MRTM_fnc_onSliderChanged;";
					
					x = OPTION_CONTROL_X;
					y = 9 * GUI_GRID_CENTER_H;
					w = SLIDER_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMViewObjectsEdit: RscEditMRTM
				{
					idc = 8014;
					onKeyUp = "[_this select 0, 'objects', 0] call MRTM_fnc_onChar;";

					x = SLIDER_EDIT_X;
					y = 9 * GUI_GRID_CENTER_H;
					w = SLIDER_EDIT_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMRWRHeaderText: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_RWR_title";
					colorBackground[] = {0.3,0.3,0.3,0.7};
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 10.5 * GUI_GRID_CENTER_H;
					w = CTRLS_GROUP_WIDTH;
					h = 1 * GUI_GRID_CENTER_H;

					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes {
						shadow = 0;
					};
				};
				class RscLine2: RscTextMRTM
				{
					idc = -1;
					style = ST_MULTI + ST_TITLE_BAR + ST_HUD_BACKGROUND;
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 11.5 * GUI_GRID_CENTER_H;
					w = CTRLS_GROUP_WIDTH;
					h = 0.01 * GUI_GRID_CENTER_H;

					text = "";
					colorBackground[] = {0,0,0,0};
					colorText[] = {1,1,1,1};
				};
				class MRTMRWRSettingText: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_RWR_enable_voice";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 12 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMRWRButton: RscCheckboxMRTM
				{
					idc = 8023;
					action = "profileNamespace setVariable ['MRTM_EnableRWR', !(profileNamespace getVariable ['MRTM_EnableRWR', true])];";

					x = OPTION_CONTROL_X;
					y = 11.75 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMRWRText1: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_RWR_pull_up_volume";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 13.5 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMRWRPullUpSlider: RscXSliderHMRTM
				{
					idc = 8015;
					text = "";
					onSliderPosChanged = "[5, _this select 1] call MRTM_fnc_onSliderChanged;";
					
					x = OPTION_CONTROL_X;
					y = 13.5 * GUI_GRID_CENTER_H;
					w = SLIDER_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMRWREdit1: RscEditMRTM
				{
					idc = 8016;
					onKeyUp = "[_this select 0, 'RWR1', 1] call MRTM_fnc_onChar;";

					x = SLIDER_EDIT_X;
					y = 13.5 * GUI_GRID_CENTER_H;
					w = SLIDER_EDIT_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMRWRText2: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_RWR_altitude_volume";
										
					x = 0 * GUI_GRID_CENTER_W;
					y = 15 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMRWRAltSlider: RscXSliderHMRTM
				{
					idc = 8017;
					text = "";
					onSliderPosChanged = "[6, _this select 1] call MRTM_fnc_onSliderChanged;";
					
					x = OPTION_CONTROL_X;
					y = 15 * GUI_GRID_CENTER_H;
					w = SLIDER_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMRWREdit2: RscEditMRTM
				{
					idc = 8018;
					onKeyUp = "[_this select 0, 'RWR2', 1] call MRTM_fnc_onChar;";

					x = SLIDER_EDIT_X;
					y = 15 * GUI_GRID_CENTER_H;
					w = SLIDER_EDIT_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMRWRText3: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_RWR_warning_volume";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 16.5 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMRWRWarningSlider: RscXSliderHMRTM
				{
					idc = 8019;
					text = "";
					onSliderPosChanged = "[7, _this select 1] call MRTM_fnc_onSliderChanged;";
					toolTip = "$STR_A3_WL_settings_RWR_warning_volume_tooltip";
					
					x = OPTION_CONTROL_X;
					y = 16.5 * GUI_GRID_CENTER_H;
					w = SLIDER_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMRWREdit3: RscEditMRTM
				{
					idc = 8020;
					onKeyUp = "[_this select 0, 'RWR3', 1] call MRTM_fnc_onChar;";

					x = SLIDER_EDIT_X;
					y = 16.5 * GUI_GRID_CENTER_H;
					w = SLIDER_EDIT_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMRWRText4: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_RWR_other_volume";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 18 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMRWROtherSlider: RscXSliderHMRTM
				{
					idc = 8021;
					text = "";
					onSliderPosChanged = "[8, _this select 1] call MRTM_fnc_onSliderChanged;";
					
					x = OPTION_CONTROL_X;
					y = 18 * GUI_GRID_CENTER_H;
					w = SLIDER_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMRWREdit4: RscEditMRTM
				{
					idc = 8022;
					onKeyUp = "[_this select 0, 'RWR4', 1] call MRTM_fnc_onChar;";

					x = SLIDER_EDIT_X;
					y = 18 * GUI_GRID_CENTER_H;
					w = SLIDER_EDIT_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMGeneralSettingsHeaderText: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_general_title";
					colorBackground[] = {0.3,0.3,0.3,0.7};
										
					x = 0 * GUI_GRID_CENTER_W;
					y = 19.5 * GUI_GRID_CENTER_H;
					w = CTRLS_GROUP_WIDTH;
					h = 1 * GUI_GRID_CENTER_H;

					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes {
						shadow = 0;
					};
				};
				class RscLine3: RscTextMRTM
				{
					idc = -1;
					style = ST_MULTI + ST_TITLE_BAR + ST_HUD_BACKGROUND;
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 20.5 * GUI_GRID_CENTER_H;
					w = CTRLS_GROUP_WIDTH;
					h = 0.01 * GUI_GRID_CENTER_H;

					text = "";
					colorBackground[] = {0,0,0,0};
					colorText[] = {1,1,1,1};
				};
				class MRTMOtherText1: RscStructuredTextMRTM
				{
					idc = -1;
					onLoad = "(_this # 0) ctrlSetText format [localize 'STR_A3_WL_settings_general_3rd_person', [BIS_WL_playerSide] call WL2_fnc_getMoneySign];";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 21 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherText2: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_general_voice_informer";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 22.5 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherText3: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_general_kill_sound";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 24 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherText4: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_general_autonomous_mode";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 25.5 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherText5: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_general_small_announcer_font";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 27 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherText6: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_general_empty_vehicles";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 28.5 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherText7: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_general_missile_camera";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 30 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherText8: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_general_user_markers";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 31.5 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherText9: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_general_no_voice_speaker";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 33 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherText10: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_general_tasks_notifications";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 34.5 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherText11: RscStructuredTextMRTM
				{
					idc = -1;
					text = "$STR_A3_WL_settings_general_parachute_auto_deploy";
					
					x = 0 * GUI_GRID_CENTER_W;
					y = 36 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherText12: RscStructuredTextMRTM
				{
					idc = -1;
					text = "Map Refresh Rate:";

					x = 0 * GUI_GRID_CENTER_W;
					y = 37.5 * GUI_GRID_CENTER_H;
					w = OPTION_TEXT_W;
					h = 1 * GUI_GRID_CENTER_H;
					
					size = 0.9 * GUI_GRID_CENTER_H;

					class Attributes
					{
						align = "right";
						shadow = 0;
					};
				};
				class MRTMOtherButton1: RscCheckboxMRTM
				{
					idc = 8024;
					onLoad = "[(_this # 0), 'MRTM_3rdPersonDisabled'] call MRTM_fnc_onLoad;";
					onCheckedChanged = "[(_this # 0), 'MRTM_3rdPersonDisabled', 60] call MRTM_fnc_onCheckedChanged;";
					onUnload = "[(_this # 0)] call MRTM_fnc_onUnload;";
					
					x = OPTION_CONTROL_X;
					y = 20.75 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherButton2: RscCheckboxMRTM
				{
					idc = 8025;
					action = "profileNamespace setVariable ['MRTM_muteVoiceInformer', !(profileNamespace getVariable ['MRTM_muteVoiceInformer', false])];";

					x = OPTION_CONTROL_X;
					y = 22.25 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherButton3: RscCheckboxMRTM
				{
					idc = 8026;
					action = "profileNamespace setVariable ['MRTM_playKillSound', !(profileNamespace getVariable ['MRTM_playKillSound', true])];";
					
					x = OPTION_CONTROL_X;
					y = 23.75 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherButton4: RscCheckboxMRTM
				{
					idc = 8027;
					action = "profileNamespace setVariable ['MRTM_enableAuto', !(profileNamespace getVariable ['MRTM_enableAuto', true])]";
					
					x = OPTION_CONTROL_X;
					y = 25.25 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherButton5: RscCheckboxMRTM
				{
					idc = 8028;
					action = "profileNamespace setVariable ['MRTM_smallAnnouncerText', !(profileNamespace getVariable ['MRTM_smallAnnouncerText', false])];";
					
					x = OPTION_CONTROL_X;
					y = 26.75 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherButton6: RscCheckboxMRTM
				{
					idc = 8029;
					action = "profileNamespace setVariable ['MRTM_spawnEmpty', !(profileNamespace getVariable ['MRTM_spawnEmpty', false])];";
					
					x = OPTION_CONTROL_X;
					y = 28.25 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherButton7: RscCheckboxMRTM
				{
					idc = 8030;
					action = "profileNamespace setVariable ['MRTM_disableMissileCameras', !(profileNamespace getVariable ['MRTM_disableMissileCameras', false])];";
					
					x = OPTION_CONTROL_X;
					y = 29.75 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherButton8: RscCheckboxMRTM
				{
					idc = 8031;
					action = "profileNamespace setVariable ['MRTM_showMarkers', !(profileNamespace getVariable ['MRTM_showMarkers', true])];";
					
					x = OPTION_CONTROL_X;
					y = 31.25 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherButton9: RscCheckboxMRTM
				{
					idc = 8032;
					action = "profileNamespace setVariable ['MRTM_noVoiceSpeaker', !(profileNamespace getVariable ['MRTM_noVoiceSpeaker', false])];";
					
					x = OPTION_CONTROL_X;
					y = 32.75 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherButton10: RscCheckboxMRTM
				{
					idc = 8033;
					action = "profileNamespace setVariable ['MRTM_muteTaskNotifications', !(profileNamespace getVariable ['MRTM_muteTaskNotifications', false])];";
					
					x = OPTION_CONTROL_X;
					y = 34.25 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherButton11: RscCheckboxMRTM
				{
					idc = 8034;
					action = "profileNamespace setVariable ['MRTM_parachuteAutoDeploy', !(profileNamespace getVariable ['MRTM_parachuteAutoDeploy', true])];";
					
					x = OPTION_CONTROL_X;
					y = 35.75 * GUI_GRID_CENTER_H;
					w = 1.5 * GUI_GRID_CENTER_W;
					h = 1.5 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherSlider12: RscXSliderHMRTM
				{
					idc = 8035;
					text = "";
					onSliderPosChanged = "[9, _this select 1] call MRTM_fnc_onSliderChanged;";

					x = OPTION_CONTROL_X;
					y = 37.25 * GUI_GRID_CENTER_H;
					w = SLIDER_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
				class MRTMOtherEdit12: RscEditMRTM
				{
					idc = 8036;
					onEditChanged = "[_this select 0, 'mapRefresh', 2] call MRTM_fnc_onChar;";
					
					x = SLIDER_EDIT_X;
					y = 37.25 * GUI_GRID_CENTER_H;
					w = SLIDER_EDIT_W;
					h = 1 * GUI_GRID_CENTER_H;
				};
			};
		};

		class MRTMCloseButton: RscButtonMenuMRTM
		{
			idc = 1604;
			text = "$STR_A3_WL_settings_button_close";
			style = ST_UPPERCASE;
			
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 24 * GUI_GRID_CENTER_H;
			w = 5 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			
			class TextPos
			{
				left = 0.25 * GUI_GRID_W;
				top = (GUI_GRID_H - 1 * GUI_GRID_CENTER_H) / 2;
				right = 0.005;
				bottom = 0;
			};

			size = 1 * GUI_GRID_CENTER_H;
			sizeEx = 1 * GUI_GRID_CENTER_H;

			font = "PuristaLight";
			action =  "(findDisplay 8000) closeDisplay 1;";
		};
		// class MRTMGroupsButton: RscButtonMRTM
		// {
		// 	idc = 1605;
		// 	text = "$STR_A3_WL_settings_button_squads";
		// 	sizeEx = "0.021 / (getResolution select 5)";
		// 	x = 0.327969 * safezoneW + safezoneX;
		// 	y = 0.786 * safezoneH + safezoneY;
		// 	w = 0.0567187 * safezoneW;
		// 	h = 0.022 * safezoneH;
		// 	font = "PuristaMedium";
		// 	action =  "(findDisplay 8000) closeDisplay 1; [true] call SQD_fnc_menu;";
		// };
		class MRTMDebugButton: RscButtonMenuMRTM
		{
			idc = 1609;
			text = "$STR_A3_WL_settings_button_debug";
			style = ST_UPPERCASE;
			onLoad = "(_this # 0) ctrlShow (getPlayerUID player in getArray (missionConfigFile >> 'adminIDs'));";

			x = GUI_GRID_CENTER_X + 29.85 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 24 * GUI_GRID_CENTER_H;
			w = 5 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;

			class TextPos
			{
				left = 0.25 * GUI_GRID_W;
				top = (GUI_GRID_H - 1 * GUI_GRID_CENTER_H) / 2;
				right = 0.005;
				bottom = 0;
			};

			size = 1 * GUI_GRID_CENTER_H;
			sizeEx = 1 * GUI_GRID_CENTER_H;

			font = "PuristaLight";
			action =  "(findDisplay 8000) closeDisplay 1; 0 spawn MRTM_fnc_openDebugMenu;";
		};
		class MRTMReportButton: RscButtonMenuMRTM
		{
			idc = 1609;
			text = "$STR_A3_WL_settings_button_report";
			style = ST_UPPERCASE;
			
			x = GUI_GRID_CENTER_X + 35 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 24 * GUI_GRID_CENTER_H;
			w = 5 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;

			class TextPos
			{
				left = 0.25 * GUI_GRID_W;
				top = (GUI_GRID_H - 1 * GUI_GRID_CENTER_H) / 2;
				right = 0.005;
				bottom = 0;
			};

			size = 1 * GUI_GRID_CENTER_H;
			sizeEx = 1 * GUI_GRID_CENTER_H;

			font = "PuristaLight";
			action =  "(findDisplay 8000) closeDisplay 1; 0 spawn FXR_fnc_openReportMenu;";
		};
	};
};

class MRTM_debugMenu
{
	idd = 2000;

	class controls
	{
		class MRTMBackground: IGUIBackMRTM
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
			x = 0.26836 * safezoneW + safezoneX;
			y = 0.2646 * safezoneH + safezoneY;
			w = 0.45375 * safezoneW;
			h = 0.517 * safezoneH;
		};
		class MRTMHeaderBackground: IGUIBackMRTM
		{
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.235 * safezoneH + safezoneY;
			w = 0.45375 * safezoneW;
			h = 0.025 * safezoneH;
		};
		class MRTMHeaderTextLeft: RscStructuredTextMRTM
		{
			idc = -1;
			text = "Debug console";
			colorBackground[] = {0,0,0,0};
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.235 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
			};
		};
		class MRTMCloseButton: RscButtonMenuMRTM
		{
			idc = 2001;
			text = "CLOSE";
			sizeEx = "0.021 / (getResolution select 5)";
			x = 0.267969 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
			font = "PuristaMedium";
			action =  "(findDisplay 2000) closeDisplay 1; 0 spawn MRTM_fnc_openMenu;";
		};
		class MRTMExec: RscStructuredTextMRTM
		{
			idc = -1;
			text = "Execute";
			colorBackground[] = {0,0,0,0};
			x = 0.268969 * safezoneW + safezoneX;
			y = 0.2646 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
			};
		};
		class MRTMExecEdit: RscEditMRTM
		{
			idc = 2002;
			font = "PuristaMedium";
			colorBackground[] = {0,0,0,0};
			autocomplete = "scripting";
			type = CT_EDIT;
			style = ST_MULTI;
			canModify = 1;
			x = 0.268969 * safezoneW + safezoneX;
			y = 0.2876 * safezoneH + safezoneY;
			w = 0.274687 * safezoneW;
			h = 0.15 * safezoneH;
		};
		class MRTMReturn: RscStructuredTextMRTM
		{
			idc = -1;
			text = "Return value";
			colorBackground[] = {0,0,0,0};
			x = 0.268969 * safezoneW + safezoneX;
			y = 0.4416 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.033 * safezoneH;
			class Attributes
			{
				font = "PuristaMedium";
			};
		};
		class MRTMReturnReadOnly: RscEditMRTM
		{
			idc = 2003;
			font = "PuristaMedium";
			canModify = 0;
			colorBackground[] = {0,0,0,0};
			autocomplete = "";
			type = CT_EDIT;
			style = ST_MULTI;
			x = 0.268969 * safezoneW + safezoneX;
			y = 0.4646 * safezoneH + safezoneY;
			w = 0.274687 * safezoneW;
			h = 0.05 * safezoneH;
		};
		class MRTMServerExec: RscButtonMenuMRTM
		{
			idc = -1;
			text = "Server Exec";
			sizeEx = "0.021 / (getResolution select 5)";
			colorBackground[] = {1,0,0,1};
			x = 0.268969 * safezoneW + safezoneX;
			y = 0.5196 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
			font = "PuristaMedium";
			action = "[player, (ctrlText 2002)] remoteExec ['MRTM_fnc_execCode', 2];";
		};
		class MRTMLocalExec: RscButtonMenuMRTM
		{
			idc = -1;
			text = "Local Exec";
			sizeEx = "0.021 / (getResolution select 5)";
			colorBackground[] = {0,1,0,1};
			x = 0.485969 * safezoneW + safezoneX;
			y = 0.5196 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
			font = "PuristaMedium";
			action = "[player, (ctrlText 2002)] spawn MRTM_fnc_execCode;";
		};
	};
};
class Fxr_ReportDialog
{
	idd = 73000;//Idd & idc's should be replaced, temporary only until proper range is assigned.

	class Controls
	{
		class MRTMReportBackground: IGUIBackMRTM
		{
			idc = 73001;
			colorBackground[] = {0,0,0,0.75};

			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1.1 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 22.8 * GUI_GRID_CENTER_H;

			// x = 0.38836 * safezoneW + safezoneX;
			// y = 0.2646 * safezoneH + safezoneY;
			// w = 0.20375 * safezoneW;
			// h = 0.517 * safezoneH;
		};
		class MRTMReportHeaderBackground: IGUIBackMRTM
		{
			idc = 73002;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		class MRTMReportHeaderTextLeft: RscStructuredTextMRTM
		{
			idc = 73003;
			text = "$STR_A3_WL_report_menu_title";
			colorBackground[] = {0,0,0,0};
			
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;

			size = 0.9 * GUI_GRID_CENTER_H;
			
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};
		class MRTMReportList: RscListBoxMRTM
		{
			idc = 73004;
			deletable = 0;
			canDrag = 0;
			color[] = {0,1,0,1};
			type = CT_LISTBOX;
			
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1.1 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 22.8 * GUI_GRID_CENTER_H;

			autoScrollSpeed = -1;
			autoScrollDelay = 5;
			autoScrollRewind = 0;
			class ListScrollBar{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			};
			style = LB_TEXTURES;
		};
		class MRTMReportCloseButton: RscButtonMenuMRTM
		{
			idc = 73005;
			text = "$STR_A3_WL_report_menu_button_close";
			style = ST_UPPERCASE;
			
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 24 * GUI_GRID_CENTER_H;
			w = 5 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			
			class TextPos
			{
				left = 0.25 * GUI_GRID_W;
				top = (GUI_GRID_H - 1 * GUI_GRID_CENTER_H) / 2;
				right = 0.005;
				bottom = 0;
			};

			size = 1 * GUI_GRID_CENTER_H;
			sizeEx = 1 * GUI_GRID_CENTER_H;

			font = "PuristaLight";
			action = "0 spawn FXR_fnc_closeReportMenu;0 spawn MRTM_fnc_openMenu;";
		};
	};
};

class WL_Prompt_Dialog {
	idd = -1;
	movingEnable = true;
	class controls {
		class WL_Prompt_Draggable: IGUIBackMRTM {
			idc = 5701;
			x = 0.015;
			y = 0.263;
			w = 0.97;
			h = 0.05;
			colorBackground[] = {1, 0.5, 0, 1};
			moving = 1;
		};
		class WL_Prompt_Title : RscTextMRTM {
			idc = 5702;
			sizeEx = 0.04;
			x = 0.015;
			y = 0.263;
			w = 0.97;
			h = 0.05;
			font = "PuristaMedium";
			colorText[] = {1, 1, 1, 1};
			shadow = 0;
			style = ST_LEFT;
		};
		class WL_Prompt_Background: IGUIBackMRTM {
			idc = 5703;
			x = 0.015;
			y = 0.318;
			w = 0.97;
			h = 0.145;
			colorBackground[] = {0, 0, 0, 1};
		};
		class WL_Prompt_ConfirmButton: RscButtonMRTM {
			idc = 5704;
			sizeEx = 0.035;
			colorBackground[] = {0, 0, 0, 0.9};
			x = 0.015;
			y = 0.468;
			w = 0.145;
			h = 0.055;
			font = "PuristaMedium";
		};
		class WL_Prompt_ExitButton: RscButtonMRTM {
			idc = 5705;
			sizeEx = 0.035;
			colorBackground[] = {0, 0, 0, 0.9};
			x = 0.839;
			y = 0.469;
			w = 0.145;
			h = 0.055;
			font = "PuristaMedium";
		};
		class WL_Prompt_Text: RscStructuredText {
			idc = 5706;
			sizeEx = 0.035;
			x = 0.020;
			y = 0.328;
			w = 0.960;
			h = 0.145;
			font = "PuristaMedium";
			colorText[] = {1, 1, 1, 1};
			shadow = 0;
			style = ST_MULTI;
		};
		class WL_Prompt_MiddleBar: IGUIBackMRTM {
			idc = 5707;
			x = 0.165;
			y = 0.469;
			w = 0.669;
			h = 0.0545;
			colorBackground[] = {0, 0, 0, 1};
		};
	};
};

class WL_MapButtonDisplay {
	idd = -1;
	movingEnable = false;
	class controls {};
};