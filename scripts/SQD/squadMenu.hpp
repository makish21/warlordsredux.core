class SquadsMenu
{
	idd = 5000;

	class controls
	{
		class SquadsHeaderBackground: IGUIBackMRTM
		{
			idc = 5002;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};

			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 40 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		class SquadsHeaderTextLeft: RscStructuredTextMRTM
		{
			idc = 5003;
			text = $STR_SQUADS_squadMenuText;
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

		class SquadsRefreshButton: RscCheckboxMRTM
		{
			idc = 5008;
			// text = $STR_SQUADS_refreshSquads;
			action = "SQD_MENU_REFRESH = true;";
			colorBackgroundHover[] = {1, 1, 1, 0.3};
			tooltip = $STR_SQUADS_refreshSquads;

			x = GUI_GRID_CENTER_X + 39 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 1 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			
			size = 1 * GUI_GRID_CENTER_H;
			sizeEx = 1 * GUI_GRID_CENTER_H;

			textureUnChecked = "a3\missions_f_exp\data\img\lobby\ui_campaign_lobby_icon_player_connecting_ca.paa";
			textureChecked = "a3\missions_f_exp\data\img\lobby\ui_campaign_lobby_icon_player_connecting_ca.paa";
			textureFocusedChecked = "a3\missions_f_exp\data\img\lobby\ui_campaign_lobby_icon_player_connecting_ca.paa";
			textureFocusedUnchecked = "a3\missions_f_exp\data\img\lobby\ui_campaign_lobby_icon_player_connecting_ca.paa";
			textureHoverChecked = "a3\missions_f_exp\data\img\lobby\ui_campaign_lobby_icon_player_connecting_ca.paa";
			textureHoverUnchecked = "a3\missions_f_exp\data\img\lobby\ui_campaign_lobby_icon_player_connecting_ca.paa";
			texturePressedChecked = "a3\missions_f_exp\data\img\lobby\ui_campaign_lobby_icon_player_connecting_ca.paa";
			texturePressedUnchecked = "a3\missions_f_exp\data\img\lobby\ui_campaign_lobby_icon_player_connecting_ca.paa";
			textureDisabledChecked = "a3\missions_f_exp\data\img\lobby\ui_campaign_lobby_icon_player_connecting_ca.paa";
			textureDisabledUnchecked = "a3\missions_f_exp\data\img\lobby\ui_campaign_lobby_icon_player_connecting_ca.paa";
		};

		class SquadsBackground: IGUIBackMRTM
		{
			idc = 5001;
			colorBackground[] = {0, 0, 0, 0.8};
			
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1.1 * GUI_GRID_CENTER_H;
			w = 40 * GUI_GRID_CENTER_W;
			h = 22.8 * GUI_GRID_CENTER_H;
		};
		class SquadsInfoText: RscStructuredTextMRTM
		{
			idc = 5004;
			text = $STR_SQUADS_squads_title;
			style = ST_MULTI;
			colorBackground[] = {0, 0, 0, 0};

			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1.225 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;

			size = 0.9 * GUI_GRID_CENTER_H;

			class Attributes
			{
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};

        class SquadsSquadList: RscTreeWL
		{
			idc = 5005;
			deletable = 0;
			canDrag = 0;
			color[] = {1, 0, 0, 1};
			colorBackground[] = {0, 0, 0, 0.5};
			type = CT_TREE;
			rowHeight = 1 * GUI_GRID_CENTER_H;

			x = GUI_GRID_CENTER_X + 0.25 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 2.225 * GUI_GRID_CENTER_H;
			w = 19.625 * GUI_GRID_CENTER_W;
			h = 21.425 * GUI_GRID_CENTER_H;
			
			autoScrollSpeed = -1;
			autoScrollDelay = 5;
			autoScrollRewind = 0;
			class ListScrollBar {
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			};

			style = ST_KEEP_ASPECT_RATIO;
		};

		class SquadsPlayersText: RscStructuredTextMRTM
		{
			idc = 5007;
			text = $STR_SQUADS_players_title;
			colorBackground[] = {0, 0, 0, 0};

			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1.225 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;

			size = 0.9 * GUI_GRID_CENTER_H;
			
			class Attributes
			{
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "left";
				shadow = 1;
			};
		};

		class SquadsPlayersList: RscListboxMRTM
		{
			idc = 5006;
			deletable = 0;
			canDrag = 0;
			color[] = {0, 1, 0, 1};
			colorBackground[] = {0, 0, 0, 0.5};
			colorSelect[] = {1, 1, 1, 0.3};
			colorSelectBackground[] = {0, 0, 0, 0};
			type = CT_LISTBOX;
			rowHeight = 0.5 * GUI_GRID_CENTER_H;

			x = GUI_GRID_CENTER_X + 20.125 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 2.225 * GUI_GRID_CENTER_H;
			w = 19.625 * GUI_GRID_CENTER_W;
			h = 21.425 * GUI_GRID_CENTER_H;
			
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

		class SquadsCloseButton: RscButtonMenuMRTM
		{
			idc = 5009;
			text = "$STR_A3_WL_settings_button_close";
			style = ST_UPPERCASE;
			
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 24 * GUI_GRID_CENTER_H;
			w = 7 * GUI_GRID_CENTER_W;
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

			action = "(findDisplay 5000) closeDisplay 1;";
		};
		class SquadsRenameButton: RscButtonMenuMRTM
		{
			idc = 5011;
			text = $STR_SQUADS_buttonsRename;
			onLoad = "";
			action = "['rename'] spawn SQD_fnc_client;";

			x = GUI_GRID_CENTER_X + 7.1 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 24 * GUI_GRID_CENTER_H;
			w = 7 * GUI_GRID_CENTER_W;
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
		};

		class SquadsPromoteButton: RscButtonMenuMRTM
		{
			idc = 5013;
			text = $STR_SQUADS_buttonsPromote;
			onLoad = "(_this # 0) ctrlShow false;";
			action = "['promote'] spawn SQD_fnc_client;";

			x = GUI_GRID_CENTER_X + 18.8 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 24 * GUI_GRID_CENTER_H;
			w = 7 * GUI_GRID_CENTER_W;
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
		};
		class SquadsKickButton: RscButtonMenuMRTM
		{
			idc = 5015;
			text = $STR_SQUADS_buttonsKick;
			onLoad = "(_this # 0) ctrlShow false;";
			action = "['kick'] spawn SQD_fnc_client;";

			x = GUI_GRID_CENTER_X + 25.9 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 24 * GUI_GRID_CENTER_H;
			w = 7 * GUI_GRID_CENTER_W;
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
		};
		class SquadsInviteButton: RscButtonMenuMRTM
		{
			idc = 5010;
			text = $STR_SQUADS_buttonsInvite;
			onLoad = "(_this # 0) ctrlEnable false;";
			tooltip = $STR_SQUADS_noPlayerSelection;
			action = "['invite'] spawn SQD_fnc_client;";

			x = GUI_GRID_CENTER_X + 25.9 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 24 * GUI_GRID_CENTER_H;
			w = 7 * GUI_GRID_CENTER_W;
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
		};

		class SquadsLeaveButton: RscButtonMenuMRTM
		{
			idc = 5012;
			text = $STR_SQUADS_buttonsLeave;
			action = "['leave'] spawn SQD_fnc_client;";

			x = GUI_GRID_CENTER_X + 33 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 24 * GUI_GRID_CENTER_H;
			w = 7 * GUI_GRID_CENTER_W;
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
		};
		class SquadsCreateButton: RscButtonMenuMRTM
		{
			idc = 5014;
			text = $STR_SQUADS_buttonsCreate;
			action = "['create'] spawn SQD_fnc_client;";

			x = GUI_GRID_CENTER_X + 33 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 24 * GUI_GRID_CENTER_H;
			w = 7 * GUI_GRID_CENTER_W;
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
		};
	};
};


class SquadsMenu_Rename
{
	idd = 5100;

	class controls
	{
		class SquadsRenameBackground: IGUIBackMRTM
		{
			idc = 5101;
			colorBackground[] = {0.1, 0.1, 0.1, 0.9};

			x = GUI_GRID_CENTER_X + 12 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 10 * GUI_GRID_CENTER_H;
			w = 16 * GUI_GRID_CENTER_W;
			h = 5 * GUI_GRID_CENTER_H;
			
			class Attributes
			{
				font = "PuristaMedium";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "center";
				shadow = 1;
				size = 0.88;
			};
		};
		class SquadsRenameHeaderText: RscStructuredTextMRTM
		{
			idc = 5102;
			text = $STR_SQUADS_newSquadName;
			colorBackground[] = {0.2, 0.2, 0.2, 0.9};
			colorText[] = {1, 1, 1, 1};

			x = GUI_GRID_CENTER_X + 12 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 10 * GUI_GRID_CENTER_H;
			w = 16 * GUI_GRID_CENTER_W;
			h = 1.25 * GUI_GRID_CENTER_H;
			
			class Attributes
			{
				align = "center";
				shadow = 1;
				size = 1.25 * GUI_GRID_CENTER_H;
			};
		};
		class SquadsRenameEditBox: RscEditMRTM
		{
			idc = 5103;

			x = GUI_GRID_CENTER_X + 12.4 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 11.65 * GUI_GRID_CENTER_H;
			w = 15.2 * GUI_GRID_CENTER_W;
			h = 1.275 * GUI_GRID_CENTER_H;

			font = "PuristaMedium";
			sizeEx = 1.275 * GUI_GRID_CENTER_H;
			tooltip = $STR_SQUADS_enterNewSquadName;
			maxChars = 25;
		};
		class SquadsRenameOkButton: RscButtonMRTM
		{
			idc = 5104;
			text = $STR_SQUADS_buttonsSave;
			sizeEx = 0.04;
			action = "['renamed'] spawn SQD_fnc_client;";

			x = GUI_GRID_CENTER_X + 12.4 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 13.325 * GUI_GRID_CENTER_H;
			w = 15.2 * GUI_GRID_CENTER_W;
			h = 1.275 * GUI_GRID_CENTER_H;

			font = "PuristaMedium";
			tooltip = $STR_SQUADS_saveNewSquadName;
		};
	};
};

