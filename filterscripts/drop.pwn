#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <mSelection>
#include <streamer>
#include <foreach>

enum PObject
{
    campFire,
    boomBox
}
new Object[MAX_PLAYERS][PObject];

new dropCampfire[MAX_PLAYERS][1];
new dropBoomBox[MAX_PLAYERS][1];
//Warna
#define COL_RED		(0xff0000FF)

// ITEM DROP:

// DIALOG:
#define DIALOG_DROP (47)
#define DIALOG_PLAYBB (22)

public OnFilterScriptInit()
{
    print("- Drop (by Moyo) succesfully loaded."); // credits
	return 1;
}

public OnPlayerConnect(playerid)
{
    Object[playerid][campFire] = 0;
    Object[playerid][boomBox] = 0;
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_DROP)//DIALOG LEAVE
	{
		if(response)
		{
            switch(listitem)
            {
                case 0:
                {
                    new Float:CFPos[4]; //CFPos adalah camp fire position.
                    GetPlayerPos(playerid, CFPos[0], CFPos[1], CFPos[2]);
                    GetPlayerFacingAngle(playerid, CFPos[3]);
                    dropCampfire[playerid][0] = CreateDynamicObject(19632, CFPos[0], CFPos[1], CFPos[2]-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid),  GetPlayerInterior(playerid));
                    Object[playerid][campFire] = 1;
                    SendClientMessage(playerid, COL_RED, "ERROR: Kamu sudah drop Campfire tidak bisa drop lagi!");
					return 1;
                }
                case 1:
				{
					if(Object[playerid][boomBox] == 1)
                        return SendClientMessage(playerid, COL_RED, "ERROR: Kamu sudah drop BoomBox tidak bisa drop lagi!");
                    
                    ShowPlayerDialog(playerid, DIALOG_PLAYBB, DIALOG_STYLE_INPUT, "Link Music kalian.", "Masukan Link disini!", "PLAY", "BATAL");
					return 1;
				}
            }
        }
    }

    if(dialogid == DIALOG_PLAYBB)//DIALOG play boombox menggunakan link
	{
		if(response)
		{
            if(Object[playerid][boomBox] == 0)
            {
                new Float:BBPos[4]; //BBPos adalah BoomBox Position.
                GetPlayerPos(playerid, BBPos[0], BBPos[1], BBPos[2]);
                GetPlayerFacingAngle(playerid, BBPos[3]);
                dropBoomBox[playerid][0] = CreateDynamicObject(2226, BBPos[0], BBPos[1], BBPos[2]-1, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid),  GetPlayerInterior(playerid));
                PlayAudioStreamForPlayer(playerid, inputtext, BBPos[0], BBPos[1], BBPos[2], 5.0, 1);
                Object[playerid][boomBox] = 1;
            }
            if(Object[playerid][boomBox] == 1)
            {
                DestroyDynamicObject(dropBoomBox[playerid][0]);
                StopAudioStreamForPlayer(playerid);
            }
			return 1;
		}
	}
    return 1;
}

CMD:drop(playerid, params[])
{
    ShowPlayerDialog(playerid, DIALOG_DROP, DIALOG_STYLE_LIST, "Pilih barang mana yang mau di drop", "Campfire\nBoombox",  "DROP", "BATAL");
    return 1;
}

