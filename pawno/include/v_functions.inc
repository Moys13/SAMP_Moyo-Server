/*
    Extended vehicle functions by Emmet_

	Thanks to:

	- [uL]Pottus -> GetVehicleTopSpeed idea
	- kvann -> SetVehicleInterior idea
	- Hanger -> Top speed data
*/

#if !defined INVALID_SEAT_ID
	#define INVALID_SEAT_ID -1
#endif

#define GetVehicleInterior(%0) \
	(CallRemoteFunction("EVF_GetVehicleInterior", "i", (%0)))

#define GetVehicleSeats(%0) \
	(GetVehicleModelSeats(GetVehicleModel(%0)))

#define GetVehicleBoot(%0,%1,%2,%3) \
	(GetVehicleOffset((%0), VEHICLE_OFFSET_BOOT, %1, %2, %3))

#define GetVehicleHood(%0,%1,%2,%3) \
	(GetVehicleOffset((%0), VEHICLE_OFFSET_HOOD, %1, %2, %3))
	
#define GetVehicleRoof(%0,%1,%2,%3) \
	(GetVehicleOffset((%0), VEHICLE_OFFSET_ROOF, %1, %2, %3))

#if !defined IsValidVehicle
	native IsValidVehicle(vehicleid);
#endif

static s_VehicleTrailer[MAX_VEHICLES];
static s_VehicleInterior[MAX_VEHICLES];

// Called when a vehicle is created.
forward OnVehicleCreated(vehicleid);
// Called when a vehicle is deleted.
forward OnVehicleDestroyed(vehicleid);
// Called when a trailer is hooked.
forward OnTrailerHooked(playerid, vehicleid, trailerid);
// Called when a trailer is unhooked.
forward OnTrailerUnhooked(playerid, vehicleid, trailerid);
// Called when a player shoots at a vehicle.
forward OnPlayerShootVehicle(playerid, vehicleid, weaponid);

enum e_ParamTypes {
	VEHICLE_TYPE_ENGINE,
	VEHICLE_TYPE_LIGHTS,
 	VEHICLE_TYPE_ALARM,
	VEHICLE_TYPE_DOORS,
	VEHICLE_TYPE_BONNET,
	VEHICLE_TYPE_BOOT,
	VEHICLE_TYPE_OBJECTIVE
};

enum e_OffsetTypes {
	VEHICLE_OFFSET_BOOT,
	VEHICLE_OFFSET_HOOD,
	VEHICLE_OFFSET_ROOF
};

static s_TopSpeed[212] = {
    157, 147, 186, 110, 133, 164, 110, 148, 100, 158, 129, 221, 168, 110, 105, 192, 154, 270,
    115, 149, 145, 154, 140, 99, 135, 270, 173, 165, 157, 201, 190, 130, 94, 110, 167, 0, 149,
    158, 142, 168, 136, 145, 139, 126, 110, 164, 270, 270, 111, 0, 0, 193, 270, 60, 135, 157,
    106, 95, 157, 136, 270, 160, 111, 142, 145, 145, 147, 140, 144, 270, 157, 110, 190, 190,
    149, 173, 270, 186, 117, 140, 184, 73, 156, 122, 190, 99, 64, 270, 270, 139, 157, 149, 140,
    270, 214, 176, 162, 270, 108, 123, 140, 145, 216, 216, 173, 140, 179, 166, 108, 79, 101, 270,
    270, 270, 120, 142, 157, 157, 164, 270, 270, 160, 176, 151, 130, 160, 158, 149, 176, 149, 60,
    70, 110, 167, 168, 158, 173, 0, 0, 270, 149, 203, 164, 151, 150, 147, 149, 142, 270, 153, 145,
    157, 121, 270, 144, 158, 113, 113, 156, 178, 169, 154, 178, 270, 145, 165, 160, 173, 146, 0, 0,
    93, 60, 110, 60, 158, 158, 270, 130, 158, 153, 151, 136, 85, 0, 153, 142, 165, 108, 162, 0, 0,
    270, 270, 130, 190, 175, 175, 175, 158, 151, 110, 169, 171, 148, 152, 0, 0, 0, 108, 0, 0
};

/*
    native GetVehicleParams(vehicleid, type);
	native SetVehicleParams(vehicleid, type, status, delay = 0);
	native GetVehicleBoot(vehicleid, &Float:x, &Float:y, &Float:z);
	native GetVehicleHood(vehicleid, &Float:x, &Float:y, &Float:z);
	native GetVehicleRoof(vehicleid, &Float:x, &Float:y, &Float:z);
	native GetOffsetFromPosition(vehicleid, Float:x, Float:y, Float:z, &Float:fX, &Float:fY, &Float:fZ);
	native GetNearestVehicle(playerid);
	native GetVehicleDriver(vehicleid);
	native GetVehicleTopSpeed(vehicleid);
	native GetVehicleInterior(vehicleid);
	native GetVehicleSeats(vehicleid);
	native GetVehicleModelSeats(modelid);
	native IsSeatOccupied(vehicleid, seatid);
	native IsValidVehicle(vehicleid);
*/

forward EVF_SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
public EVF_SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective)
{
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
}

static stock EVF_ResetVehicle(vehicleid)
{
	s_VehicleInterior[vehicleid] = 0;
	s_VehicleTrailer[vehicleid] = INVALID_VEHICLE_ID;
}

stock GetVehicleParams(vehicleid, type)
{
	new
		params[7]
	;
	GetVehicleParamsEx(vehicleid, params[0], params[1], params[2], params[3], params[4], params[5], params[6]);

	return (!(params[type] <= 0));
}

stock SetVehicleParams(vehicleid, type, status, delay = 0)
{
	new
		params[7];

    if (GetVehicleParamsEx(vehicleid, params[0], params[1], params[2], params[3], params[4], params[5], params[6]))
	{
		params[type] = status;

		if (delay > 0)
		{
			SetTimerEx("EVF_SetVehicleParamsEx", delay, false, "iiiiiiii", vehicleid, params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
		}
		else
		{
			SetVehicleParamsEx(vehicleid, params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
		}
		return 1;
	}
	return 0;
}

stock GetVehicleOffset(vehicleid, type, &Float:x, &Float:y, &Float:z)
{
    new Float:zPos[4], Float:fSize[3];
	
	if (!IsValidVehicle(vehicleid))
	{
		x = 0.0;
		y = 0.0;
		z = 0.0;

		return 0;
	}
	else
	{
		GetVehiclePos(vehicleid, zPos[0], zPos[1], zPos[2]);
		GetVehicleZAngle(vehicleid, zPos[3]);
		GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]);
		
		switch (type)
		{
		    case VEHICLE_OFFSET_BOOT:
		    {
				x = zPos[0] - (floatsqroot(fSize[1] + fSize[1]) * floatsin(-zPos[3], degrees));
				y = zPos[1] - (floatsqroot(fSize[1] + fSize[1]) * floatcos(-zPos[3], degrees));
 				z = zPos[2];
			}
			case VEHICLE_OFFSET_HOOD:
			{
			    x = zPos[0] + (floatsqroot(fSize[1] + fSize[1]) * floatsin(-zPos[3], degrees));
				y = zPos[1] + (floatsqroot(fSize[1] + fSize[1]) * floatcos(-zPos[3], degrees));
	 			z = zPos[2];
			}
			case VEHICLE_OFFSET_ROOF:
			{
			    x = zPos[0];
			    y = zPos[1];
			    z = zPos[2] + floatsqroot(fSize[2]);
			}
		}
	}
	return 1;
}

stock GetOffsetFromPosition(vehicleid, Float:x, Float:y, Float:z, &Float:fX, &Float:fY, &Float:fZ)
{
    if (!IsValidVehicle(vehicleid))
	{
		fX = 0.0;
		fY = 0.0;
		fZ = 0.0;

		return 0;
	}
	else
	{
		new
		    Float:vX,
		    Float:vY,
		    Float:vZ;

		GetVehiclePos(vehicleid, vX, vY, vZ);

		fX = (x - vX);
		fY = (y - vY);
		fZ = (z - vZ);
	}
	return 1;
}

stock GetNearestVehicle(playerid)
{
 	new Float:zPos[4], Float:fSize[3];

	for (new i = 1; i < MAX_VEHICLES; i ++)
	{
	    if (!IsValidVehicle(i))
		{
			continue;
	    }
	    else
	    {
			GetVehiclePos(i, zPos[0], zPos[1], zPos[2]);
			GetVehicleModelInfo(GetVehicleModel(i), VEHICLE_MODEL_INFO_SIZE, fSize[0], fSize[1], fSize[2]);

			if (IsPlayerInRangeOfPoint(playerid, floatsqroot(fSize[0] + fSize[1] + fSize[2]), zPos[0], zPos[1], zPos[2]) && GetPlayerInterior(playerid) == GetVehicleInterior(i) && GetPlayerVirtualWorld(playerid) == GetVehicleVirtualWorld(i))
			{
				return i;
			}
		}
	}
	return INVALID_VEHICLE_ID;
}

stock GetVehicleDriver(vehicleid)
{
	for (new i = 0; i < MAX_PLAYERS; i ++)
	{
	    if (GetPlayerState(i) == PLAYER_STATE_DRIVER && IsPlayerInVehicle(i, vehicleid))
		{
			return i;
		}
	}
	return INVALID_PLAYER_ID;
}

stock IsSeatOccupied(vehicleid, seatid)
{
	if (!GetVehicleModel(vehicleid))
	{
		return 0;
	}
	else
	{
		for (new i = 0; i < MAX_PLAYERS; i ++)
		{
	    	if (IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == seatid) return 1;
		}
	}
	return 0;
}

stock GetVehicleNextSeat(vehicleid, passenger = 1)
{
	new
	    seats = GetVehicleSeats(vehicleid);

	if (seats > 1)
	{
	    for (new i = passenger; i < GetVehicleSeats(vehicleid); i ++)
		{
		    if (!IsSeatOccupied(vehicleid, i))
			{
				return i;
			}
		}
	}
	return INVALID_SEAT_ID;
}

stock GetVehicleModelSeats(modelid)
{
    static const s_VehicleSeats[] =
	{
		4, 2, 2, 2, 4, 4, 1, 2, 2, 4, 2, 2, 2, 4, 2, 2, 4, 2, 4, 2, 4, 4, 2, 2, 2, 1, 4, 4, 4, 2,
		1, 7, 1, 2, 2, 0, 2, 7, 4, 2, 4, 1, 2, 2, 2, 4, 1, 2, 1, 0, 0, 2, 1, 1, 1, 2, 2, 2, 4,
		4, 2, 2, 2, 2, 1, 1, 4, 4, 2, 2, 4, 2, 1, 1, 2, 2, 1, 2, 2, 4, 2, 1, 4, 3, 1, 1, 1, 4, 2,
		2, 4, 2, 4, 1, 2, 2, 2, 4, 4, 2, 2, 1, 2, 2, 2, 2, 2, 4, 2, 1, 1, 2, 1, 1, 2, 2, 4, 2, 2,
		1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 4, 1, 1, 1, 2, 2, 2, 2, 7, 7, 1, 4, 2, 2, 2, 2, 2, 4, 4,
		2, 2, 4, 4, 2, 1, 2, 2, 2, 2, 2, 2, 4, 4, 2, 2, 1, 2, 4, 4, 1, 0, 0, 1, 1, 2, 1, 2, 2, 1, 2,
		4, 4, 2, 4, 1, 0, 4, 2, 2, 2, 2, 0, 0, 7, 2, 2, 1, 4, 4, 4, 2, 2, 2, 2, 2, 4, 2, 0, 0, 0,
		4, 0, 0
	};
	return (modelid < 400 || modelid > 611) ? (0) : (s_VehicleSeats[(modelid - 400)]);
}

stock GetVehicleTopSpeed(vehicleid)
{
	new model = GetVehicleModel(vehicleid);

	if (model)
	{
	    return s_TopSpeed[(model - 400)];
	}
	return 0;
}

stock EVF_LinkVehicleToInterior(vehicleid, interiorid)
{
	new
	    ret = LinkVehicleToInterior(vehicleid, interiorid);
	    
	if (ret)
	{
		s_VehicleInterior[vehicleid] = interiorid;
	}
	return ret;
}

stock EVF_CreateVehicle(modelid, Float:x, Float:y, Float:z, Float:a, color1, color2, respawn_delay, siren)
{
	new
		vehicleid = CreateVehicle(modelid, x, y, z, a, color1, color2, respawn_delay, siren);

	if (vehicleid != INVALID_VEHICLE_ID)
	{
	    EVF_ResetVehicle(vehicleid);
		CallLocalFunction("OnVehicleCreated", "d", vehicleid);
	}
	return vehicleid;
}

stock EVF_DestroyVehicle(vehicleid)
{
	if (IsValidVehicle(vehicleid))
	{
		if (CallLocalFunction("OnVehicleDestroy", "d", vehicleid) > 0 || funcidx("OnVehicleDestroy") == -1)
		{
		    EVF_ResetVehicle(vehicleid);
		
		    return DestroyVehicle(vehicleid);
	    }
	}
	return 0;
}

stock EVF_AddStaticVehicle(modelid, Float:x, Float:y, Float:z, Float:a, color1, color2)
{
	new
		vehicleid = AddStaticVehicle(modelid, x, y, z, a, color1, color2);

	if (vehicleid != INVALID_VEHICLE_ID)
	{	
		EVF_ResetVehicle(vehicleid);
		CallLocalFunction("OnVehicleCreated", "d", vehicleid);
	}
	return vehicleid;
}

stock EVF_AddStaticVehicleEx(modelid, Float:x, Float:y, Float:z, Float:a, color1, color2, respawn_delay)
{
	new
		vehicleid = AddStaticVehicleEx(modelid, x, y, z, a, color1, color2, respawn_delay);

	if (vehicleid != INVALID_VEHICLE_ID)
	{
		EVF_ResetVehicle(vehicleid);
		CallLocalFunction("OnVehicleCreated", "d", vehicleid);
	}
	return vehicleid;
}

public OnPlayerUpdate(playerid)
{
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    new
			vehicleid = GetPlayerVehicleID(playerid),
			trailerid = GetVehicleTrailer(vehicleid)
		;

		if (s_VehicleTrailer[vehicleid] != trailerid)
	    {
	        if (trailerid != 0)
			{
				CallLocalFunction("OnTrailerHooked", "iii", playerid, vehicleid, trailerid);
			}
			else
			{
			    CallLocalFunction("OnTrailerUnhooked", "iii", playerid, vehicleid, s_VehicleTrailer[vehicleid]);
			}
			s_VehicleTrailer[vehicleid] = trailerid;
		}
	}
	#if defined EVF_OnPlayerUpdate
	    return EVF_OnPlayerUpdate(playerid);
	#else
		return 1;
	#endif
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if ((hittype == BULLET_HIT_TYPE_VEHICLE) && (22 <= weaponid <= 38))
	{
		CallLocalFunction("OnPlayerShootVehicle", "iii", playerid, hitid, weaponid);
	}
	#if defined EVF_OnPlayerWeaponShot
	    return EVF_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
	#else
	    return 1;
	#endif
}

forward EVF_GetVehicleInterior(vehicleid);
public EVF_GetVehicleInterior(vehicleid)
{
	if (IsValidVehicle(vehicleid))
	{
	    return s_VehicleInterior[vehicleid];
	}
	return 0;
}
	
#if defined _ALS_LinkVehicleToInterior
	#define LinkVehicleToInterior
#else
	#define _ALS_LinkVehicleToInterior
#endif

#if defined _ALS_CreateVehicle
	#define CreateVehicle
#else
	#define _ALS_CreateVehicle
#endif

#if defined _ALS_DestroyVehicle
	#define DestroyVehicle
#else
	#define _ALS_DestroyVehicle
#endif

#if defined _ALS_AddStaticVehicle
	#define AddStaticVehicle
#else
	#define _ALS_AddStaticVehicle
#endif

#if defined _ALS_AddStaticVehicleEx
	#define AddStaticVehicleEx
#else
	#define _ALS_AddStaticVehicleEx
#endif

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif

#if defined _ALS_OnPlayerWeaponShot
	#undef OnPlayerWeaponShot
#else
	#define _ALS_OnPlayerWeaponShot
#endif

#define LinkVehicleToInterior 	EVF_LinkVehicleToInterior
#define CreateVehicle 			EVF_CreateVehicle
#define DestroyVehicle          EVF_DestroyVehicle
#define AddStaticVehicle 		EVF_AddStaticVehicle
#define AddStaticVehicleEx 		EVF_AddStaticVehicleEx
#define OnPlayerUpdate          EVF_OnPlayerUpdate
#define OnPlayerWeaponShot      EVF_OnPlayerWeaponShot

#if defined EVF_OnPlayerUpdate
	forward EVF_OnPlayerUpdate(playerid);
#endif

#if defined EVF_OnPlayerWeaponShot
	forward EVF_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
#endif