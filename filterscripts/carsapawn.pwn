/*-------------------------------------------------------------------------------------------------------

|--[Easy Attach FS by Primes]--|
|
|Relase date:	31/12/2017
|Last Updated: 	31/12/2017
|Version: 		1.0

* Please donot remove the credits.
* This script is provided to public as is without any conditions or agreement.
* You are permitted to edit until and unless you retain the credits.
* You can't re-release the script untill you have got the permission from the real owner (Primes007).

-------------------------------------------------------------------------------------------------------*/


#include <a_samp>   //Thanks to Samp Team
#include <zcmd>     //Thanks to Zeex
#include <sscanf2>  //Thanks to Lord Y_Less

new sstr[256],ProjectName[32];
new Float:NudgeVal = 0.05;
new EditOX,EditOY,EditOZ,EditRX,EditRY,EditRZ;

new ObjName[][]=
{
	{},
	{"Object 1"},
	{"Object 2"},
	{"Object 3"},
	{"Object 4"},
	{"Object 5"},
	{"Object 6"},
	{"Object 7"},
	{"Object 8"},
	{"Object 9"},
	{"Object 10"}
};

enum Obj
{
	Model,
	AT,
	OID,
	Float:OX,
	Float:OY,
	Float:OZ,
	Float:RX,
	Float:RY,
	Float:RZ
};

new Objects[11][Obj];


public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" >>    Easy Attach by Primes   << Loaded");
	print("--------------------------------------\n");

	for(new i = 0; i <= 10; i++)
	{
	    Objects[i][Model] = 0;
	    Objects[i][AT] = 0;
		Objects[i][OID] = 0;
	    Objects[i][OX] = 0;
	    Objects[i][OY] = 0;
	    Objects[i][OZ] = 0;
	    Objects[i][RX] = 0;
	    Objects[i][RY] = 0;
	    Objects[i][RZ] = 0;
	}

	new ran = random(9999);
	format(ProjectName,32,"Attachment%d",ran); //In case Project Name is not provided.

	SetSVarInt("currobj",-1);

	return 1;
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
	print(">>   Easy Attach by Primes   << Unloaded");
	print("--------------------------------------\n");

	DeleteSVar("currobj");
	DeleteSVar("currobjno");

	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(EditOX || EditOY || EditOZ || EditRX || EditRY || EditRZ)	GetPlayerHoldingKey(playerid);

	return 1;
}

stock GetPlayerHoldingKey(playerid)
{
	new key,lr,ud;
	new objno = GetSVarInt("currobjno");

	GetPlayerKeys(playerid,key,lr,ud);

	if(key == KEY_ANALOG_RIGHT)
	{
		if(EditOX)	Objects[objno][OX] += NudgeVal;
  		else if(EditOY)	Objects[objno][OY] += NudgeVal;
  		else if(EditOZ)	Objects[objno][OZ] += NudgeVal;
  		else if(EditRX)	Objects[objno][RX] += NudgeVal;
  		else if(EditRY)	Objects[objno][RY] += NudgeVal;
  		else if(EditRZ)	Objects[objno][RZ] += NudgeVal;
	}
	else if(key == KEY_YES)
	{
		if(EditOX)	Objects[objno][OX] += NudgeVal;
  		else if(EditOY)	Objects[objno][OY] += NudgeVal;
  		else if(EditOZ)	Objects[objno][OZ] += NudgeVal;
  		else if(EditRX)	Objects[objno][RX] += NudgeVal;
  		else if(EditRY)	Objects[objno][RY] += NudgeVal;
  		else if(EditRZ)	Objects[objno][RZ] += NudgeVal;
	}
	else if(key == KEY_ANALOG_LEFT)
	{
	    if(EditOX)	Objects[objno][OX] -= NudgeVal;
  		else if(EditOY)	Objects[objno][OY] -= NudgeVal;
  		else if(EditOZ)	Objects[objno][OZ] -= NudgeVal;
  		else if(EditRX)	Objects[objno][RX] -= NudgeVal;
  		else if(EditRY)	Objects[objno][RY] -= NudgeVal;
  		else if(EditRZ)	Objects[objno][RZ] -= NudgeVal;
	}
	else if(key == KEY_NO)
	{
	    if(EditOX)	Objects[objno][OX] -= NudgeVal;
  		else if(EditOY)	Objects[objno][OY] -= NudgeVal;
  		else if(EditOZ)	Objects[objno][OZ] -= NudgeVal;
  		else if(EditRX)	Objects[objno][RX] -= NudgeVal;
  		else if(EditRY)	Objects[objno][RY] -= NudgeVal;
  		else if(EditRZ)	Objects[objno][RZ] -= NudgeVal;
	}
 	else if(key == KEY_SECONDARY_ATTACK)
	{
	    EditOX = 0;
		EditOY = 0;
		EditOZ = 0;
		EditRX = 0;
		EditRY = 0;
		EditRZ = 0;
		ShowPlayerDialog(playerid, playerid,20004,DIALOG_STYLE_LIST,"Edit Position","Edit X\nEdit Y\nEdit Z\nEdit X Rotation\nEdit Y Rotation\nEdit Z Rotation\nNudge Value","Select","Back");
	}
	else if(key == KEY_SUBMISSION)
	{
	    EditOX = 0;
		EditOY = 0;
		EditOZ = 0;
		EditRX = 0;
		EditRY = 0;
		EditRZ = 0;
		ShowPlayerDialog(playerid, playerid,20004,DIALOG_STYLE_LIST,"Edit Position","Edit X\nEdit Y\nEdit Z\nEdit X Rotation\nEdit Y Rotation\nEdit Z Rotation\nNudge Value","Select","Back");
	}

	if(Objects[objno][AT] == 1)	AttachObjectToPlayer(Objects[objno][OID],playerid,Objects[objno][OX],Objects[objno][OY],Objects[objno][OZ],Objects[objno][RX],Objects[objno][RY],Objects[objno][RZ]);
	else if(Objects[objno][AT] == 2)   AttachObjectToVehicle(Objects[objno][OID],GetPlayerVehicleID(playerid),Objects[objno][OX],Objects[objno][OY],Objects[objno][OZ],Objects[objno][RX],Objects[objno][RY],Objects[objno][RZ]);

	return 1;
}


public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case 20001:
	    {
	        if(response)
	        {
	        	switch(listitem)
	        	{
	            	case 0:
	            	{
	                	ShowPlayerDialog(playerid, playerid,20002,DIALOG_STYLE_INPUT,"Enter project name","The final file will be created in the scriptfiles folder with this name:","Ok","");
						return 1;
	            	}
				 	case 1:
				 	{
				 	    sstr = "";
						for(new i = 1; i <= 10; i++)
						{
							if(Objects[i][Model] == 0) strcat(sstr,"+");
							else	strcat(sstr,ObjName[i]);
							strcat(sstr,"\n");
						}
						ShowPlayerDialog(playerid, playerid,20003,DIALOG_STYLE_LIST,"Objects",sstr,"Select","Back");
						return 1;
					}
					case 2:
					{
					    if(GetSVarInt("currobj") == -1)
						{
						    sstr = "";
							for(new i = 1; i <= 10; i++)
							{
								if(Objects[i][Model] == 0) strcat(sstr,"+");
								else	strcat(sstr,ObjName[i]);
								strcat(sstr,"\n");
							}
							ShowPlayerDialog(playerid, playerid,20003,DIALOG_STYLE_LIST,"Objects",sstr,"Select","Back");
						 	return SendClientMessage(playerid,0xFFFFFFC8,"{ffffff}No object selected!");
						}
					    if(GetPlayerState(playerid) == 	PLAYER_STATE_ONFOOT)
					    {
					        AttachObjectToPlayer(Objects[GetSVarInt("currobjno")][OID],playerid,0,0,1.5,0,0,0);
					        Objects[GetSVarInt("currobjno")][OZ] = 1.5;
					        Objects[GetSVarInt("currobjno")][AT] = 1;
							ShowPlayerDialog(playerid, playerid,20004,DIALOG_STYLE_LIST,"Edit Position","Edit X\nEdit Y\nEdit Z\nEdit X Rotation\nEdit Y Rotation\nEdit Z Rotation\nNudge Value","Select","Back");
						}
						else
						{
							SendClientMessage(playerid,0xFFFFFFC8,"{ffffff}You must be {61c5dd}on foot {ffffff}to do this");
							ShowPlayerDialog(playerid, playerid,20001,DIALOG_STYLE_LIST,"Menu","Project Name\nObjects\nAttach To Player\nAttach To Vehicle\nDestroy Object\nSave","Select","Cancel");
						}
						return 1;
					}
					case 3:
					{
					    if(GetSVarInt("currobj") == -1)
						{
						    sstr = "";
							for(new i = 1; i <= 10; i++)
							{
								if(Objects[i][Model] == 0) strcat(sstr,"+");
								else	strcat(sstr,ObjName[i]);
								strcat(sstr,"\n");
							}
							ShowPlayerDialog(playerid, playerid,20003,DIALOG_STYLE_LIST,"Objects",sstr,"Select","Back");
						 	return SendClientMessage(playerid,0xFFFFFFC8,"No object selected");
						}
						if(IsPlayerInAnyVehicle(playerid))
						{
						    new Float:opos[3],Float:vpos[3];
							new Float:ox,Float:oy,Float:oz;
							GetObjectPos(GetSVarInt("currobj"),opos[0],opos[1],opos[2]);
							GetVehiclePos(GetPlayerVehicleID(playerid),vpos[0],vpos[1],vpos[2]);
							ox = opos[0] - vpos[0];
							oy = opos[1] - vpos[1];
							oz = opos[2] - vpos[2];
					    	Objects[GetSVarInt("currobjno")][AT] = 2;
							Objects[GetSVarInt("currobjno")][OX] = ox;
							Objects[GetSVarInt("currobjno")][OY] = oy;
							Objects[GetSVarInt("currobjno")][OZ] = oz;
							AttachObjectToVehicle(Objects[GetSVarInt("currobjno")][OID],GetPlayerVehicleID(playerid),ox,oy,oz,0,0,0);
							ShowPlayerDialog(playerid, playerid,20004,DIALOG_STYLE_LIST,"Edit Position","Edit X\nEdit Y\nEdit Z\nEdit X Rotation\nEdit Y Rotation\nEdit Z Rotation\nNudge Value","Select","Back");
					    }
					    else
						{
							SendClientMessage(playerid,0xFFFFFFC8,"{ffffff}You must be {61c5dd}in a vehicle {ffffff}to do this");
    	                    ShowPlayerDialog(playerid, playerid,20001,DIALOG_STYLE_LIST,"Menu","Project Name\nObjects\nAttach To Player\nAttach To Vehicle\nDestroy Object\nSave","Select","Cancel");
						}
					    return 1;
					}
					case 4:
					{
					    sstr = "";
					    for(new i = 1; i <= 10; i++)
					    {
					        if(Objects[i][Model] != 0) strcat(sstr,ObjName[i]);
					        else strcat(sstr,"-");
					        strcat(sstr,"\n");
						}
						ShowPlayerDialog(playerid, playerid,20005,DIALOG_STYLE_LIST,"Delete Object",sstr,"Delete","Back");
						return 1;
					}
					case 5:
					{
					    new path[128];
						format(path, 128, "%s.pwn", ProjectName);
						new File:file = fopen(path,io_readwrite);
						for(new i = 1; i<=10; i++)
						{
							if(Objects[i][Model] != 0 && Objects[i][AT] == 1)
							{
						    	format(sstr,256,"AttachObjectToPlayer(%d,playerid,%f,%f,%f,%f,%f,%f); //%s\r\n",Objects[i][Model],Objects[i][OX],Objects[i][OY],Objects[i][OZ],Objects[i][RX],Objects[i][RY],Objects[i][RZ],ObjName[i]);
						    	fwrite(file,sstr);
							}
							else if(Objects[i][Model] != 0 && Objects[i][AT] == 2)
							{
                        	    format(sstr,256,"AttachObjectToVehicle(%d,vehicleid,%f,%f,%f,%f,%f,%f); //%s\r\n",Objects[i][Model],Objects[i][OX],Objects[i][OY],Objects[i][OZ],Objects[i][RX],Objects[i][RY],Objects[i][RZ],ObjName[i]);
                        	    fwrite(file,sstr);
							}
						}
						fwrite(file,"\r\n\r\n/* > Created through Easy Attach by Primes < */");
						fclose(file);
						format(sstr,256,"{ffffff}Project exported as {61c5dd}%s{ffffff}. You can find the file in your {61c5dd}scriptfiles {ffffff}folder.",path);
						SendClientMessage(playerid,0xFFFFFFC8,sstr);
					    return 1;
					}
				}
			}
			else return 0;
		}
		case 20002:
		{
		    if(response)
		    {
		    	format(ProjectName,sizeof(ProjectName),"%s",inputtext);
		    	return ShowPlayerDialog(playerid, playerid,20001,DIALOG_STYLE_LIST,"Menu","Project Name\nObjects\nAttach To Player\nAttach To Vehicle\nDestroy Object\nSave","Select","Cancel");
			}
			else return ShowPlayerDialog(playerid, playerid,20001,DIALOG_STYLE_LIST,"Menu","Project Name\nObjects\nAttach To Player\nAttach To Vehicle\nDestroy Object\nSave","Select","Cancel");
		}
		case 20003:
		{
		    if(response)
		    {
		    	if(Objects[listitem+1][Model] == 0)	ShowPlayerDialog(playerid, playerid,20006,DIALOG_STYLE_INPUT,"Object Model","Enter Object Model ID and desired Name for the object:\n\nSyntax: [ObjectID] <space> [DesiredName]\nExample: 1468 GreenBottle","Ok","");
				else
				{
			    	SetSVarInt("currobj",Objects[listitem+1][OID]);
			    	SetSVarInt("currobjno",listitem+1);
			    	SendClientMessage(playerid,0xFFFFFFC8,"{ffffff}Object Selected!");
					if(Objects[listitem+1][AT] == 0) ShowPlayerDialog(playerid, playerid,20001,DIALOG_STYLE_LIST,"Menu","Project Name\nObjects\nAttach To Player\nAttach To Vehicle\nDestroy Object\nSave","Select","Cancel");
					else ShowPlayerDialog(playerid, playerid,20004,DIALOG_STYLE_LIST,"Edit Position","Edit X\nEdit Y\nEdit Z\nEdit X Rotation\nEdit Y Rotation\nEdit Z Rotation\nNudge Value","Select","Back");
				}
			}
			else    ShowPlayerDialog(playerid, playerid,20001,DIALOG_STYLE_LIST,"Menu","Project Name\nObjects\nAttach To Player\nAttach To Vehicle\nDestroy Object\nSave","Select","Cancel");
			return 1;
		}
		case 20004:
		{
		    if(response)
		    {
		    	switch(listitem)
		    	{
		        	case 0:	EditOX = 1;
		        	case 1: EditOY = 1;
		        	case 2: EditOZ = 1;
		        	case 3: EditRX = 1;
      				case 4: EditRY = 1;
		        	case 5: EditRZ = 1;
					case 6:	ShowPlayerDialog(playerid, playerid,20007,DIALOG_STYLE_INPUT,"Nudge Value","Enter the value by which you want to increment the object movement:\n\nIdeal value for Offset: 0.05\nIdeal value for Rotation: 0.5","Set","Cancel");
				}
				if(listitem != 6)
				{
					if(!IsPlayerInAnyVehicle(playerid))
					{
						SendClientMessage(playerid,0xFFFFFFC8,"{ffffff}Press   {61c5dd}~k~~VEHICLE_TURRETLEFT~   {ffffff}and   {61c5dd}~k~~VEHICLE_TURRETRIGHT~   {ffffff}to move the object");
						SendClientMessage(playerid,0xFFFFFFC8,"{ffffff}Press   ~k~~VEHICLE_ENTER_EXIT~   {ffffff}to finish editing");
					}
					else
					{
					    SendClientMessage(playerid,0xFFFFFFC8,"{ffffff}Press   {61c5dd}~k~~CONVERSATION_YES~   {ffffff}and   {61c5dd}~k~~CONVERSATION_NO~   {ffffff}to move the object");
						SendClientMessage(playerid,0xFFFFFFC8,"{ffffff}Press   {61c5dd}~k~~TOGGLE_SUBMISSIONS~   {ffffff}to finish editing");
					}
				}
			}
			else
			{
			    sstr = "";
				for(new i = 1; i <= 10; i++)
				{
					if(Objects[i][Model] == 0) strcat(sstr,"+");
					else	strcat(sstr,ObjName[i]);
					strcat(sstr,"\n");
				}
				return ShowPlayerDialog(playerid, playerid,20003,DIALOG_STYLE_LIST,"Objects",sstr,"Select","Back");
			}
		}
		case 20005:
		{
		    if(response)
		    {
		    	if(Objects[listitem+1][Model] != 0)
				{
					Objects[listitem+1][Model] = 0;
	    			Objects[listitem+1][AT] = 0;
    				Objects[listitem+1][OX] = 0;
	   			 	Objects[listitem+1][OY] = 0;
	    			Objects[listitem+1][OZ] = 0;
	    			Objects[listitem+1][RX] = 0;
	    			Objects[listitem+1][RY] = 0;
	    			Objects[listitem+1][RZ] = 0;
					DestroyObject(Objects[listitem+1][OID]);
   				 	Objects[listitem+1][OID] = 0;
					format(sstr,256,"Object %d",listitem+1);
					format(ObjName[listitem+1],256,"%s",sstr);
					sstr = "";
					for(new i = 1; i <= 10; i++)
					{
						if(Objects[i][Model] != 0) strcat(sstr,ObjName[i]);
						else strcat(sstr,"-");
						strcat(sstr,"\n");
					}
					ShowPlayerDialog(playerid, playerid,20005,DIALOG_STYLE_LIST,"Delete Object",sstr,"Delete","Back");
				}
				else
				{
					SendClientMessage(playerid,0xFFFFFFC8,"{ffffff}No object is created for that slot");
					sstr = "";
			   		for(new i = 1; i <= 10; i++)
			   		{
			       		if(Objects[i][Model] != 0) strcat(sstr,ObjName[i]);
			       		else strcat(sstr,"-");
			       		strcat(sstr,"\n");
					}
					ShowPlayerDialog(playerid, playerid,20005,DIALOG_STYLE_LIST,"Delete Object",sstr,"Delete","Back");
				}
			}
   			else ShowPlayerDialog(playerid, playerid,20001,DIALOG_STYLE_LIST,"Menu","Project Name\nObjects\nAttach To Player\nAttach To Vehicle\nDestroy Object\nSave","Select","Cancel");
			return 1;
		}
		case 20006:
		{
		    new objno;
		    for(new i = 1; i <= 10; i++)
		    {
		        if(Objects[i][Model] == 0)
				{
					objno = i;
					break;
				}
			}
		    if(sscanf(inputtext,"is[32]",Objects[objno][Model],ObjName[objno]))
			{
			    Objects[objno][Model] = 0;
			    format(ObjName[objno],32,"Object %d",objno);
				SendClientMessage(playerid,0xFFFFFFC8,"{ffffff}Invalid Format!");
				return ShowPlayerDialog(playerid, playerid,20006,DIALOG_STYLE_INPUT,"Object Model","Enter Object Model ID:\n\nSyntax: [ObjectID] <space> [DesiredName]\nExample: 1468 GreenBottle","Ok","");
			}
			else
			{
				new Float:pos[3];
				GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
				Objects[objno][OID] = CreateObject(Objects[objno][Model],pos[0],pos[1],pos[2]+2,0.0,0.0,0.0,0);
				format(sstr,126,"{ffffff}Created Object ID: {61c5dd}%d",Objects[objno][OID]);
				SendClientMessageToAll(0xFFFFFFC8,sstr);
				sstr = "";
				for(new i = 1; i <= 10; i++)
				{
					if(Objects[i][Model] == 0) strcat(sstr,"+");
					else	strcat(sstr,ObjName[i]);
					strcat(sstr,"\n");
				}
				ShowPlayerDialog(playerid, playerid,20003,DIALOG_STYLE_LIST,"Objects",sstr,"Select","Back");
				return 1;
			}
		}
		case 20007:
		{
		    if(response)
		    {
				if(sscanf(inputtext,"f",NudgeVal))
				{
			    	SendClientMessage(playerid,0xFFFFFFC8,"{61c5dd}Nudge Value {ffffff}must be a {61c5dd}number{ffffff}. {61c5dd}Note: {ffffff}Float values also possible(Eg: 0.005)");
			    	return ShowPlayerDialog(playerid, playerid,20007,DIALOG_STYLE_INPUT,"Nudge Value","Enter the value by which you want to increment the object movement:\n\nIdeal value for Offset: 0.05\nIdeal value for Rotation: 0.5","Set","Cancel");
				}
				return ShowPlayerDialog(playerid, playerid,20004,DIALOG_STYLE_LIST,"Edit Position","Edit X\nEdit Y\nEdit Z\nEdit X Rotation\nEdit Y Rotation\nEdit Z Rotation\nNudge Value","Select","Back");
			}
			else return ShowPlayerDialog(playerid, playerid,20004,DIALOG_STYLE_LIST,"Edit Position","Edit X\nEdit Y\nEdit Z\nEdit X Rotation\nEdit Y Rotation\nEdit Z Rotation\nNudge Value","Select","Back");
		}
	}
	return 0;
}

CMD:ea(playerid)
{
	if(IsPlayerAdmin(playerid)) return ShowPlayerDialog(playerid, playerid,20001,DIALOG_STYLE_LIST,"Menu","Project Name\nObjects\nAttach To Player\nAttach To Vehicle\nDestroy Object\nSave","Select","Cancel");
	else return 0;
}

CMD:v(playerid,params[])
{
	if(IsPlayerAdmin(playerid))
	{
	    new vid;
	    if(sscanf(params,"i",vid) || (vid < 400 || vid > 611)) return SendClientMessage(playerid,0xFFFFFFC8,"Please enter a valid vehicle id. {61c5dd}(400-611)");
	    new Float:pos[4];
	    GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	    GetPlayerFacingAngle(playerid,pos[3]);
	    PutPlayerInVehicle(playerid,CreateVehicle(vid,pos[0],pos[1],pos[2],pos[3],-1,-1,0,0),0);
     	SendClientMessage(playerid, COL_,"Vehicle Spawned!");
	    return 1;
	}
	else return 0;
}
