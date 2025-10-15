#include "\a3\ui_f\hpp\definecommongrids.inc"

import RscStructuredText;

#define ST_CENTER	 0x02
#define ST_UPPERCASE 0xC0

class welcomeScreen
{
	idd = 9000;

	class controls
	{
		class MRTMHeaderBackground: IGUIBackMRTM
		{
			idc = -1;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};

			x = GUI_GRID_CENTER_X + 5 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 30 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		class MRTMHeaderTextLeft: RscStructuredTextMRTM
		{
			idc = -1;
			text = "Warlords Reloaded";
			colorBackground[] = {0,0,0,0};

			x = GUI_GRID_CENTER_X + 5 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 15 * GUI_GRID_CENTER_W;
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
		// class welcomeFrame: IGUIBackMRTM
		// {
		// 	idc = 9001;
		// 	deletable = 0;

		// 	x = 0.250656 * safezoneW + safezoneX;
		// 	y = 0.171 * safezoneH + safezoneY;
		// 	w = 0.499688 * safezoneW;
		// 	h = 0.671 * safezoneH;

		// 	colorText[] = {1,1,1,1};
		// };

		// class welcomeMain: IGUIBackMRTM
		// {
		// 	idc = -1;
		// 	deletable = 0;
		// 	x = 0.257656 * safezoneW + safezoneX;
		// 	y = 0.181 * safezoneH + safezoneY;
		// 	w = 0.484688 * safezoneW;
		// 	h = 0.649 * safezoneH;
		// 	colorText[] = {1,1,1,1};
		// 	colorActive[] = {1,1,1,1};
		// };

		class welcomeMainImg: RscPictureMRTM
		{
			idc = -1;
			type = CT_STATIC;
			text = "a3\map_altis\data\picturemap_ca.paa";
			style = ST_TILE_PICTURE;

			x = GUI_GRID_CENTER_X + 5 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1.1 * GUI_GRID_CENTER_H;
			w = 30 * GUI_GRID_CENTER_W;
			h = 22.8 * GUI_GRID_CENTER_H;

			// x = 0.257656 * safezoneW + safezoneX;
			// y = 0.181 * safezoneH + safezoneY;
			// w = 0.484688 * safezoneW;
			// h = 0.649 * safezoneH;

			tileW = 1;
			tileH = 0.76;

			colorBackground[] = {0,0,0,0.6};
		};

		class welcomeMainImgDim: IGUIBackMRTM
		{
			x = GUI_GRID_CENTER_X + 5 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1.1 * GUI_GRID_CENTER_H;
			w = 30 * GUI_GRID_CENTER_W;
			h = 22.8 * GUI_GRID_CENTER_H;

			colorBackground[] = {0,0,0,0.3};
		};

		class A: RscToolboxMRTM
		{
			idc = -1;
			style = ST_UPPERCASE;

			x = GUI_GRID_CENTER_X + 5 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1.1 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;

			class TextPos
			{
				left = 0.25 * GUI_GRID_W;
				top = (GUI_GRID_H - 1 * GUI_GRID_CENTER_H) / 2;
				right = 0.005;
				bottom = 0;
			};

			checked_strings[] = {"[Entry 1]","[Entry 2]","[Entry 3]"};
			strings[] = { "[Entry 1]","[Entry 2]","[Entry 3]" };
			rows = 1;
			columns = 3;

			font = "PuristaLight";
			size = 1 * GUI_GRID_CENTER_H;
			sizeEx = 1 * GUI_GRID_CENTER_H;
		};

		// class welcomeText: RscStructuredTextMRTM
		// {
		// 	idc = 9005;
		// 	deletable = 0;
		// 	text = "Warlords Redux v2.6.10";
		// 	x = 0.288594 * safezoneW + safezoneX;
		// 	y = 0.225 * safezoneH + safezoneY;
		// 	w = 0.149531 * safezoneW;
		// 	h = 0.033 * safezoneH;
		// };

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

		class MRTMCloseButton: RscButtonMenuMRTM
		{
			idc = 1;
			text = "$STR_A3_WL2_welcome_screen_close";
			style = ST_UPPERCASE;

			x = GUI_GRID_CENTER_X + 5 * GUI_GRID_CENTER_W;
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
			action =  "(findDisplay 9000) closeDisplay 1;";
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
			font = "EtelkaMonospacePro";
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
				font = "EtelkaMonospacePro";
			};
		};
		class MRTMReturnReadOnly: RscEditMRTM
		{
			idc = 2003;
			font = "EtelkaMonospacePro";
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