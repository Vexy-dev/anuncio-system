//Sistema(COMANDO) de /anuncioserver identico Brasil Play Shox, melhorado por: Vexy#3333 and credito: Brazz#1533
//Adapte o sistema de acordo com a sua gamemode, pois eu refiz baseado em uma gamemode minha de testes, então pode conter definições diferentes da sua, portanto "Adapte", By: Vexy and Braz.

//------(INCLUDES)--------
#include <a_samp>
#include <zcmd>

#if defined FILTERSCRIPT

//------(DEFINES)--------
#define SCM SendClientMessage

//------(ENUM/VARIAVEIS)--------
enum anserver
{
    asMensagem[128],
    asTempo,
    asAtivo,
    asTimer,
};

new AnuncioServer[anserver];
#define ANUNCIO_SERVER_DIALOG        24502
#define ANUNCIO_SERVER_MENSAGEM     24503
#define ANUNCIO_SERVER_TEMPO         24504

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("* Sistema de anuncioserver(command) by: Vexy#3333 and Brazz#1533");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print("* Sistema de anuncioserver(command) by: Vexy#3333 and Brazz#1533");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
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

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    //dialog do comando /anuncioserver
    if(dialogid == ANUNCIO_SERVER_DIALOG)
    {
        if(response)
        {
            switch(listitem) //switch
            {
                case 0:{
                    ShowPlayerDialog(playerid, ANUNCIO_SERVER_MENSAGEM, DIALOG_STYLE_INPUT, "Mensagem Anuncio Server", "{FFFFFF}Voce esta prestes a alterar a mensagem!\n\
                    \n\n{A9A9A9}Digite abaixo a nova mensagem de ate 128 caracteres.", #Confirmar, #Voltar);

                }
                case 1:{
                    ShowPlayerDialog(playerid, ANUNCIO_SERVER_TEMPO, DIALOG_STYLE_INPUT, "Tempo Anuncio Server", "{FFFFFF}Voce esta prestes a alterar o tempo (Em segundos)!\n\
                    \n\n{A9A9A9}Digite abaixo o tempo da mensagem:", #Confirmar, #Voltar);
                }
                case 2:{
                    if(AnuncioServer[asAtivo] == 0) AnuncioServer[asAtivo] = 1, DialogAnuncioServer(playerid), AnuncioServer[asTimer] = SetTimer("EnviarMensagemAnuncioServer", AnuncioServer[asTempo]*1000, true);
                    else if(AnuncioServer[asAtivo] == 1) AnuncioServer[asAtivo] = 0, DialogAnuncioServer(playerid), KillTimer(AnuncioServer[asTimer]);
                }
            }
        }
    }
    if(dialogid == ANUNCIO_SERVER_MENSAGEM)
    {
        if(response)
        {
            if(strlen(inputtext) > 128) return SCM(playerid, COLOR_LIGHTRED, "* Digite um texto de ate 128 letras!");
            if(isnull(inputtext)) return SCM(playerid, COLOR_LIGHTRED, "* Digite algo na dialog!"), DialogAnuncioServer(playerid);
            strmid(AnuncioServer[asMensagem], inputtext, 0, strlen(inputtext), 255);
            SCM(playerid, COLOR_LIGHTRED, "* Voce trocou a mensagem do anuncio server com sucesso!");
            DialogAnuncioServer(playerid);
        }
        else return DialogAnuncioServer(playerid);
    }
    if(dialogid == ANUNCIO_SERVER_TEMPO)
    {
        if(response)
        {
            if(strval(inputtext) < 1) return SCM(playerid, COLOR_LIGHTRED, "* Digite algum numero!");
            if(isnull(inputtext)) return SCM(playerid, COLOR_LIGHTRED, "* Digite algo na dialog!"), DialogAnuncioServer(playerid);
            AnuncioServer[asTempo] = strval(inputtext);
            SCMf(playerid, COLOR_LIGHTRED, "* Voce trocou o tempo do anuncio server para: %d Segundos!",strval(inputtext));
            DialogAnuncioServer(playerid);
        }
        else return DialogAnuncioServer(playerid);
    }
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
DialogAnuncioServer(playerid)
{
    MEGAString[0] = EOS;
    strcat(MEGAString, "Sistema\tInformação\n");
    strcatEx(MEGAString, "{FFFFFF}Mensagem anunciada:\t{FF6347}[{FFFFFF}%s{FF6347}]\n", AnuncioServer[asMensagem]);
    strcatEx(MEGAString, "{FFFFFF}Tempo(Segundos):\t{FF6347}[{FFFFFF}%d{FF6347}]\n", AnuncioServer[asTempo]); 
    if(AnuncioServer[asAtivo] == 0) {
        strcat(MEGAString, "{FFFFFF}Ativo:\t{FF6347}[{FFFFFF}Nao{FF6347}]\n"); 
    }
    if(AnuncioServer[asAtivo] == 1){
        strcat(MEGAString, "{FFFFFF}Ativo:\t{FF6347}[{FFFFFF}Sim{FF6347}]\n");
    } 
    ShowPlayerDialog(playerid, ANUNCIO_SERVER_DIALOG, DIALOG_STYLE_TABLIST_HEADERS, "Anuncio Server", MEGAString, "Escolher", "Fechar");
    return 1;
}
function EnviarMensagemAnuncioServer()
{
    if(AnuncioServer[asAtivo] == 1)
    {
        new vexylindo[256];
        foreach(Player, i)
        {
            format(vexylindo, 256, "%s", AnuncioServer[asMensagem]);
            SCM(i, 0xFF69B4FF, vexylindo);
        }
    }
    return 1;
}
//---------------- (COMANDOS)-------------------//
CMD:anuncioserver(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 1340)//verificação se o player é maior ou igual o admin level: 1340+
    {
        DialogAnuncioServer(playerid);
    }
    else return SendClientMessage(playerid, 0xFF0000FF, "* Voce nao esta autorizado para utilizar este comando!");
    return 1;
}