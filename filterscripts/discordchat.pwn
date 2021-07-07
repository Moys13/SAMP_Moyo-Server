#include <a_samp>
#include <discord-connector>
#include <sscanf2>
#include <zcmd>

new DCC_Channel:g_Discord_Chat;
#define COL_YELLOW	(0xd9ff00FF)
#define COL_ORANGE	(0xffaa00FF)
#define COL_PINK 	(0xff00aeFF)
#define COL_RED		(0xff0000FF)


new chatdc [MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("- DiscordChat (by Moyo) succesfully loaded."); // credits
	g_Discord_Chat = DCC_FindChannelById("856012335679143967"); // Discord channel ID
    return 1;
}
forward DCC_OnMessageCreate(DCC_Message:message);
public DCC_OnMessageCreate(DCC_Message:message)
{
	new realMsg[100];
    DCC_GetMessageContent(message, realMsg, 100);
    new bool:IsBot;
    new DCC_Channel:channel;
 	DCC_GetMessageChannel(message, channel);
    new DCC_User:author;
	DCC_GetMessageAuthor(message, author);
    DCC_IsUserBot(author, IsBot);
    if(channel == g_Discord_Chat && !IsBot) //!IsBot will block BOT's message in game
    {
        new user_name[32 + 1], str[152];
       	DCC_GetUserName(author, user_name, 32);
        format(str,sizeof(str), "{ff00ae}[DISCORD] {aa1bb5}%s: {ffffff}%s",user_name, realMsg);
        SendClientMessageToAll(-1, str);
    }
    return 1;
}
public OnPlayerText(playerid, text[])
{
    if(chatdc[playerid] == 1)
    {
    new name[MAX_PLAYER_NAME + 1];
    new pText[144];
    format(pText, sizeof (pText), "{ff00ae}[LIVE DISCORD] {aa1bb5}: {ffffff}%s", text);
    SendPlayerMessageToAll(playerid, pText);
    GetPlayerName(playerid, name, sizeof name);
    new msg[128];
    format(msg, sizeof(msg), "```%s: %s```", name, text);
    DCC_SendChannelMessage(g_Discord_Chat, msg);
    return 0;
    }
    return 1;
}
public OnPlayerConnect(playerid)
{
    chatdc[playerid] = 0;
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);
    if (_:g_Discord_Chat == 0)
    g_Discord_Chat = DCC_FindChannelById("856012335679143967"); // Discord channel ID
    new string[128];
    format(string, sizeof string, " ```%s telah memasuki server!```", name);
    DCC_SendChannelMessage(g_Discord_Chat, string);
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof name);
    if (_:g_Discord_Chat == 0)
    g_Discord_Chat = DCC_FindChannelById("856012335679143967"); // Discord channel ID
    new string[128];
    format(string, sizeof string, " ```%s telah keluar dari server!```", name);
    DCC_SendChannelMessage(g_Discord_Chat, string);
    return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

CMD:discord(playerid, params[])
{
    if(!strcmp(params, "live", true))
    {
        chatdc[playerid] = 1;
        SendClientMessage(playerid, COL_YELLOW, "Anda telah mengaktifkan chat discord!");
        return 1;
    }
    if(!strcmp(params, "mute", true))
    {
        chatdc[playerid] = 0;
        SendClientMessage(playerid, COL_YELLOW, "Anda telah membisukan obrolan discord!");
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COL_RED, "ERROR: chose Live or Mute!");
    }
    return 1;
}
