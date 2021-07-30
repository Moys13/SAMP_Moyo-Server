#include <a_samp>

new speedactive[MAX_PLAYERS];
new speedinfo[MAX_PLAYERS];
new PlayerText:speed[MAX_PLAYERS][4];


new VehicleNames[][] =
{
	"Landstalker",
	"Bravura",
	"Buffalo",
	"Linerunner",
	"Perenniel",
	"Sentinel",
	"Dumper",
	"Firetruck",
	"Trashmaster",
	"Stretch",
	"Manana",
	"Infernus",
	"Voodoo",
	"Pony",
	"Mule",
	"Cheetah",
	"Ambulance",
	"Leviathan",
	"Moonbeam",
	"Esperanto",
	"Taxi",
	"Washington",
	"Bobcat",
	"Mr Whoopee",
	"BF Injection",
	"Hunter",
	"Premier",
	"Enforcer",
	"Securicar",
	"Banshee",
	"Predator",
	"Bus",
	"Rhino",
	"Barracks",
	"Hotknife",
	"Article Trailer",
	"Previon",
	"Coach",
	"Cabbie",
	"Stallion",
	"Rumpo",
	"RC Bandit",
	"Romero",
	"Packer",
	"Monster",
	"Admiral",
	"Squallo",
	"Seasparrow",
	"Pizzaboy",
	"Tram",
	"Article Trailer 2",
	"Turismo",
	"Speeder",
	"Reefer",
	"Tropic",
	"Flatbed",
	"Yankee",
	"Caddy",
	"Solair",
	"Topfun Van (Berkley's RC)",
	"Skimmer",
	"PCJ-600",
	"Faggio",
	"Freeway",
	"RC Baron",
	"RC Raider",
	"Glendale",
	"Oceanic",
	"Sanchez",
	"Sparrow",
	"Patriot",
	"Quad",
	"Coastguard",
	"Dinghy",
	"Hermes",
	"Sabre",
	"Rustler",
	"ZR-350",
	"Walton",
	"Regina",
	"Comet",
	"BMX",
	"Burrito",
	"Camper",
	"Marquis",
	"Baggage",
	"Dozer",
	"Maverick",
	"SAN News Maverick",
	"Rancher",
	"FBI Racher",
	"Virgo",
	"Greenwood",
	"Jetmax",
	"Hotring Racer",
	"Sandking",
	"Blista Compact",
	"Police Maverick",
	"Boxville",
	"Benson",
	"Mesa",
	"RC Goblin",
	"Hotring Racer",
	"Hotring Racer",
	"Bloodring Banger",
	"Rancher",
	"Super GT",
	"Elegant",
	"Journey",
	"Bike",
	"Mountain Bike",
	"Beagle",
	"Cropduster",
	"Stuntplane",
	"Tanker",
	"Roadtrain",
	"Nebula",
	"Majestic",
	"Buccaneer",
	"Shamal",
	"Hydra",
	"FCR-900",
	"NRG-500",
	"HPV1000",
	"Cement Truck",
	"Towtruck",
	"Fortune",
	"Cadrona",
	"FBI Truck",
	"Willard",
	"Forklift",
	"Tractor",
	"Combine Hervester",
	"Feltzer",
	"Remington",
	"Slamvan",
	"Blade",
	"Freight (Train)",
	"Brownstreak (Train)",
	"Vortex",
	"Vincent",
	"Bullet",
	"Clover",
	"Sadler",
	"Firetruck LA",
	"Hustler",
	"Intruder",
	"Primo",
	"Cargobob",
	"Tampa",
	"Sunrise",
	"Merit",
	"Utility Van",
	"Nevada",
	"Yosemite",
	"Windsor",
	"Monster \"A\"",
	"Monster \"B\"",
	"Uranus",
	"Jester",
	"Sultan",
	"Stratum",
	"Elegy",
	"Raindance",
	"RC Tiger",
	"Flash",
	"Tahoma",
	"Savanna",
	"Bandito",
	"Freight Flat Tailer (Train)",
	"Streak Trailer (Train)",
	"Kart",
	"Mower",
	"Dune",
	"Sweeper",
	"Broadway",
	"Tornado",
	"AT-400",
	"DFT-30",
	"Huntley",
	"Stafford",
	"BF-400",
	"Newsvan",
	"Tug",
	"Petrol Trailer",
	"Emperor",
	"Wayfarer",
	"Euros",
	"Hotdog",
	"Club",
	"Freight Box Trailer (Train)",
	"Article Trailer 3",
	"Andromada",
	"Dodo",
	"RC Cam",
	"Launch",
	"Police Car (LSPD)",
	"Police Car (SFPD)",
	"Police Car (LVPD)",
	"Police Ranger",
	"Picador",
	"S.W.A.T.",
	"Alpha",
	"Phoenix",
	"Glendale Shit",
	"Sadler Shit",
	"Baggage Trailer \"A\"",
	"Baggage Trailer \"B\"",
	"Tug Stairs Trailer",
	"Boxville",
	"Farm Trailer",
	"Utility Trailer"
};

public OnFilterScriptInit()
{
    print("- speedometer (by Moyo) succesfully loaded."); // credits
	return 1;
}


public OnPlayerConnect(playerid)
{
	/////////////////////////////////////////////////////////////////////////////////////////
//speedometer
	speed[playerid][0] = CreatePlayerTextDraw(playerid, 528.982299, 183.216751, "box");
	PlayerTextDrawLetterSize(playerid, speed[playerid][0], 0.000000, 6.720351);
	PlayerTextDrawTextSize(playerid, speed[playerid][0], 640.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, speed[playerid][0], 1);
	PlayerTextDrawColor(playerid, speed[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, speed[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, speed[playerid][0], 255);
	PlayerTextDrawSetShadow(playerid, speed[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, speed[playerid][0], 255);
	PlayerTextDrawFont(playerid, speed[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, speed[playerid][0], 1);

	speed[playerid][1] = CreatePlayerTextDraw(playerid, 562.679992, 164.916641, "Turismo");
	PlayerTextDrawLetterSize(playerid, speed[playerid][1], 0.446851, 2.014167);
	PlayerTextDrawTextSize(playerid, speed[playerid][1], -3.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, speed[playerid][1], 1);
	PlayerTextDrawColor(playerid, speed[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, speed[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, speed[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, speed[playerid][1], 255);
	PlayerTextDrawFont(playerid, speed[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, speed[playerid][1], 1);

	speed[playerid][2] = CreatePlayerTextDraw(playerid, 531.757141, 190.583374, "Speed:_200_KM/H");
	PlayerTextDrawLetterSize(playerid, speed[playerid][2], 0.249604, 1.454166);
	PlayerTextDrawAlignment(playerid, speed[playerid][2], 1);
	PlayerTextDrawColor(playerid, speed[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, speed[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, speed[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, speed[playerid][2], 255);
	PlayerTextDrawFont(playerid, speed[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, speed[playerid][2], 1);

	speed[playerid][3] = CreatePlayerTextDraw(playerid, 532.388793, 217.416625, "HEALTH:_100");
	PlayerTextDrawLetterSize(playerid, speed[playerid][3], 0.231332, 1.494999);
	PlayerTextDrawAlignment(playerid, speed[playerid][3], 1);
	PlayerTextDrawColor(playerid, speed[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, speed[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, speed[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, speed[playerid][3], 255);
	PlayerTextDrawFont(playerid, speed[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, speed[playerid][3], 1);
	
	speedactive[playerid] = 1;
	return 1;
}

public OnPlayerStateChange(playerid,newstate,oldstate)
{
	if(speedactive[playerid] == 1)
	{
		if(newstate == PLAYER_STATE_DRIVER)
		{
			PlayerTextDrawShow(playerid, speed[playerid][0]);
			PlayerTextDrawShow(playerid, speed[playerid][1]);
			PlayerTextDrawShow(playerid, speed[playerid][2]);
			PlayerTextDrawShow(playerid, speed[playerid][3]);
	        speedinfo[playerid] = SetTimerEx("speedometer",1000,1,"d",playerid);
		}
		if(oldstate == PLAYER_STATE_DRIVER)
		{
			PlayerTextDrawHide(playerid, speed[playerid][0]);		
			PlayerTextDrawHide(playerid, speed[playerid][1]);
			PlayerTextDrawHide(playerid, speed[playerid][2]);
			PlayerTextDrawHide(playerid, speed[playerid][3]);
			KillTimer(speedinfo[playerid]);
		}
	}
	return 1;
}


forward speedometer(playerid);
public speedometer(playerid)
{
	new String[150];
	format(String,150,"~R~%s",VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400]);
    PlayerTextDrawSetString(playerid, speed[playerid][1], String);
	new Float:X;
	new Float:Y;
	new Float:Z;
	GetVehicleVelocity(GetPlayerVehicleID(playerid),X,Y,Z);
	format(String,150,"SPEED ~R~%d KM/H",floatround(floatsqroot(X * X + Y * Y + Z * Z) * 150.0000));
    PlayerTextDrawSetString(playerid, speed[playerid][2], String);
	new Float:Health;
	GetVehicleHealth(GetPlayerVehicleID(playerid),Health);
	format(String,150,"Health ~R~%d.0",floatround(Health / 10));
    PlayerTextDrawSetString(playerid, speed[playerid][3], String);
	return 1;
}
