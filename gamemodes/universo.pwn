#include <a_samp>
#include <DOF2>
#include <zcmd>
#include <sscanf2>
#include <core>
#include <float>

#define MAX_CASAS 10

//VARIAVEIS
new logado[MAX_PLAYERS];

new arma_equipada;

//======= ARMAS CONF. ======
new pecas_arma [MAX_PLAYERS];
//==== index 0 deseart, 1 ak, 2 sub-metralhadora ======
new armas [MAX_PLAYERS][3];



enum pInfo{
	Dinheiro
}
new Pdados[MAX_PLAYERS][pInfo];

//DEFINES
#define varGet(%0)      getproperty(0,%0)
#define varSet(%0,%1)   setproperty(0, %0, %1)
#define new_strcmp(%0,%1) \
                (varSet(%0, 1), varGet(%1) == varSet(%0, 0))

#define DIALOG_SENHA 0
#define DIALOG_REGISTRO 1

//CORES
#define COL_BOX 0x000000EE
#define COL_RED 0xFF0000FF
#define COR_CINZA_AZUL 0x456EAF67
#define COR_PRETO 0x00000000
#define COR_NAO_SEI 0xFFFFFFFF
#define COR_MAGENTA 0xA587DE0BA354
#define COR_VERDEMEDIO 0x9CDE7180
#define COR_VERMELHOCLARO 0xFF99AADD
#define COR_DARKMAGENTA 0xA7105DEF
#define COR_LARANJAVERMELHO 0xE9370DFC
#define COR_DARKVERDE 0x12900BBF
#define COR_AZULMEDIO 0x63AFF00A
#define COR_DARKROXO 0x800080AA
#define COR_MARROMCLARO 0x99934EFA
#define COR_VIOLETA 0x9955DEEE
#define COR_CIANOCLARO 0xAAFFCC33
#define COR_AZULVERDECLARO 0x0FFDD349
#define COR_OURO 0xDEAD4370
#define COR_AZULCINZA 0x456EAF67
#define COR_AZULVERDE 0x46BBAA00
#define COR_AZULNEUTRO 0xABCDEF01
#define COR_AZUL 0x0000FFAA
#define COR_CINZA 0xAFAFAFAA
#define COR_VERDE 0x33AA33AA
#define COR_VERMELHO 0xAA3333AA
#define COR_AMARELO 0xFFFF00AA
#define COR_BRANCO 0xFFFFFFAA
#define COR_ROXO 0x9900FFAA
#define COR_MARROM 0x993300AA
#define COR_LARANJA 0xFF9933AA
#define COR_CIANO 0x99FFFFAA
#define COR_AMARELOCLARO 0xFFFFCCAA
#define COR_ROSA 0xFF66FFAA
#define COR_BEJE 0x999900AA
#define COR_LIMA 0x99FF00AA
#define COR_PRETO2 0x000000AA
#define COR_TURCA 0x00A3C0AA
#define COR_AZULCLARO 0x33CCFFAA
#define COR_GRADE1 0xB4B5B7FF
#define COR_GRADE2 0xBFC0C2FF
#define COR_GRADE3 0xCBCCCEFF
#define COR_GRADE4 0xD8D8D8FF
#define COR_GRADE5 0xE3E3E3FF
#define COR_GRADE6 0xF0F0F0FF
#define COR_VERDECLARO 0x9ACD32AA
#define COR_AMARELO2 0xF5DEB3AA
#define COR_FADA1 0xE6E6E6E6
#define COR_FADA2 0xC8C8C8C8
#define COR_FADA3 0xAAAAAAAA
#define COR_FADA4 0x8C8C8C8C
#define COR_FADA5 0x6E6E6E6E
#define COR_DARKAZUL 0x2641FEAA
#define COR_DEPARTE 0xFF8282AA
#define COR_NOVA 0xFFA500AA
#define COR_OPACO 0xE0FFFFAA
#define COR_ADICIONAL 0x63FF60AA
#define COR_SPIAO 0xBFC0C200
#define COR_INVISIVEL 0xAFAFAF00
#define COLOR_REDD 0xFF0000AA
#define BRANCO 0xFFFFFFAA

main()
{
	print("\n----------------------------------");
	print("TELA DE LOGIN CARREGADA COM SUCESSO!");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	DisableInteriorEnterExits();
	CreateVehicle(411, 1693.0347,-2253.8489,13.3773,79.3827, 2, 2, 0);
	SetGameModeText("Roleplay");
	UsePlayerPedAnims();


	create_npc();

	return 1;
}

public OnGameModeExit()
{
    DOF2_Exit();
	LoadCasa();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    new string[128];
	format(string, sizeof(string), "Contas/%s.ini", Nome(playerid));
	if(DOF2_FileExists(string))
	{
	    format(string, sizeof(string), "\n{FFFFFF}Conta: %s\n\nStatus: {00FF00}Registrado\n\n{FFFFFF}Digite sua senha para logar", Nome(playerid));
	    ShowPlayerDialog(playerid, DIALOG_SENHA, DIALOG_STYLE_PASSWORD, "Login", string, "Login", "Cancelar");
	}
	else
	{
	    format(string, sizeof(string), "\n{FFFFFF}Conta: %s\n\nStatus: {FF0000}Nao Registrado\n\n{FFFFFF}Digite uma senha para se registrar", Nome(playerid));
 		ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_PASSWORD, "Registro", string, "Registro", "Cancelar");
	}
	LimparChat(playerid, 20);
	SetSpawnInfo(playerid, -1, 2, 1153.9194,-1771.8367,16.5992,1.8648, 0, 0, 0, 0, 0, 0 );
	InterpolateCameraPos(playerid, 2233.7678, 2082.3232, 163.2898, 2215.3149, 2173.4766, 163.2898, 10000);
    InterpolateCameraLookAt (playerid, 2253.3149, 2101.3767, 158.2740, 2241.5039, 2177.4595, 158.3741, 10000);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	arma_equipada  = GetPlayerWeapon(playerid);

	if(logado[playerid] == 1)
	{
		SalvarDados(playerid);
		
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(logado[playerid] == 0)
	{
	    SendClientMessage(playerid, COR_VERMELHO, "[ERRO]Voce nao pode falar no chat agora!");
	    return 0;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	//criar armas
	if (dialogid == 100)
	{
		if (response)
		{

			//botao desert 20 pecas
			if (listitem == 0)
			{
				if (pecas_arma[playerid] < 20) return SendClientMessage(playerid, COR_VERMELHO, "Pecas Insuficiente!!!");
				pecas_arma[playerid] -= 15;
				SendClientMessage(playerid, COR_VERDE, "A Arma Esta Sendo Montada");
				SetTimerEx("criar_deseart", 15000, false, "1", playerid);

			}
			//botao ak 50 pecas
			if (listitem == 1)
			{
				if (pecas_arma[playerid] < 50) return SendClientMessage(playerid, COR_VERMELHO, "Pecas Insuficiente!!!");
				pecas_arma[playerid] -= 50;
				SendClientMessage(playerid, COR_VERDE, "A Arma Esta Sendo Montada");
				SetTimerEx("criar_ak", 15000, false, "1", playerid);
			}
			//botao sub-metralhadora 35 pecas
			if (listitem == 2)
			{
				if (pecas_arma[playerid] < 35) return SendClientMessage(playerid, COR_VERMELHO, "Pecas Insuficiente!!!");
				pecas_arma[playerid] -= 35;
				SendClientMessage(playerid, COR_VERDE, "A Arma Esta Sendo Montada");
				SetTimerEx("criar_sub", 15000, false, "1", playerid);
			}
		}
	}

	//botao pecas de arma, para comprar
	if (dialogid == 101) {
		if (response) {
			if (listitem == 0 ) {
				if (GetPlayerMoney(playerid) < 100) return SendClientMessage(playerid, COR_VERMELHO, "Dinheiro Insuficiente!!!");
				pecas_arma[playerid] += 5;
				GivePlayerMoney(playerid, -1000);
				SendClientMessage(playerid, COR_AMARELO, "voce comprou 5 pecas de arma");
			}
		}
	}


    if(dialogid == DIALOG_REGISTRO)
	{
		if(response)
		{
		    new string[128];
		    if(strlen(inputtext) >= 5 && strlen(inputtext) <= 20)
		    {
		        SendClientMessage(playerid, -1, "{00FF00}[INFO]Conta registrada com sucesso! Faca o login para jogar!");
		        format(string, sizeof(string), "Contas/%s.ini", Nome(playerid));
		        if(!DOF2_FileExists(string))
		        {
		            DOF2_CreateFile(string);
		            DOF2_SetString(string, "Nick", Nome(playerid));
		            DOF2_SetString(string, "Senha", inputtext);
		            DOF2_SaveFile();
		        }
		        format(string, sizeof(string), "\n{FFFFFF}Conta: %s\n\nStatus: {00FF00}Registrado\n\n{FFFFFF}Digite sua senha para logar", Nome(playerid));
	    		ShowPlayerDialog(playerid, DIALOG_SENHA, DIALOG_STYLE_PASSWORD, "Login", string, "Login", "Cancelar");
		    }
		    else
		    {
		        SendClientMessage(playerid, COR_VERMELHO, "[ERRO]A senha que voce digitou tem que ter de 5 a 20 caracteres");
		        format(string, sizeof(string), "\n{FF0000}Senha muito pequena ou muito grande\n\n{FFFFFF}Conta: %s\n\nStatus: {FF0000}Nao Registrado\n\n{FFFFFF}Digite uma senha para se registrar", Nome(playerid));
 				ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_PASSWORD, "Registro", string, "Registro", "Cancelar");
		    }
		}
		else
		{
      		SendClientMessage(playerid, COR_VERMELHO, "[ERRO]Voce cancelou o registro e foi kickado do servidor");
		    SetTimerEx("Kickar", 1000, false, "i", playerid);
		}
	}
	else if(dialogid == DIALOG_SENHA)
	{
		if(response)
		{
			new string[128];
		    if(strlen(inputtext) > 0)
		    {
			    format(string, sizeof(string), "Contas/%s.ini", Nome(playerid));
			    if(new_strcmp(inputtext, DOF2_GetString(string, "Senha")))
			    {
			        LimparChat(playerid, 20);
			        SendClientMessage(playerid, -1, "{00FFFF}[INFO]Senha correta! Voce foi spawnado com sucesso!");
			        CarregarDados(playerid);
			        logado[playerid] = 1;
			        SpawnPlayer(playerid);
                    SetSpawnInfo(playerid, -1, 2, 1153.9194,-1771.8367,16.5992,1.8648, 0, 0, 0, 0, 0, 0 );
			        SetPlayerInterior(playerid, 0);
			        GivePlayerMoney(playerid, Pdados[playerid][Dinheiro]);

					load_weapon(playerid);

			    }
			    else
			    {
			        SendClientMessage(playerid, COR_VERMELHO, "[ERRO]Senha Incorreta");
			        format(string, sizeof(string), "\n{FF0000}Senha Incorreta\n\n{FFFFFF}Conta: %s\n\nStatus: {00FF00}Registrado\n\n{FFFFFF}Digite sua senha para logar", Nome(playerid));
		    		ShowPlayerDialog(playerid, DIALOG_SENHA, DIALOG_STYLE_PASSWORD, "Login", string, "Login", "Cancelar");
			    }
			}
			else
			{
			    SendClientMessage(playerid, COR_VERMELHO, "[ERRO]Senha Incorreta");
       			format(string, sizeof(string), "\n{FF0000}Senha Incorreta\n\n{FFFFFF}Conta: %s\n\nStatus: {00FF00}Registrado\n\n{FFFFFF}Digite sua senha para logar", Nome(playerid));
		    	ShowPlayerDialog(playerid, DIALOG_SENHA, DIALOG_STYLE_PASSWORD, "Login", string, "Login", "Cancelar");
			}
		}
		else
		{
		    SendClientMessage(playerid, COR_VERMELHO, "[ERRO]Voce cancelou o login e foi kickado do servidor");
			SetTimerEx("Kickar", 1000, false, "i", playerid);
		}
	}
	return 1;
}

forward criar_deseart (playerid);
public criar_deseart (playerid){
	GivePlayerWeapon(playerid, 24, 10);
	SendClientMessage(playerid, COR_AZUL, "Sua Arma Foi Criada!!!");
	armas[playerid][0] = 1;
	return 1;
}

forward criar_ak (playerid);
public criar_ak (playerid){
	GivePlayerWeapon(playerid, 30, 50);
	SendClientMessage(playerid, COR_AZUL, "Sua Arma Foi Criada!!!");
	armas[playerid][1] = 1;
	return 1;
}

forward criar_sub (playerid);
public criar_sub (playerid){
	GivePlayerWeapon(playerid, 29, 25);
	SendClientMessage(playerid, COR_AZUL, "Sua Arma Foi Criada!!!");
	armas[playerid][2] = 1;
	return 1;
}

forward load_weapon(playerid);
public load_weapon(playerid)
{
	SendClientMessage(playerid, -1 , "fora do if");
	if (armas[playerid][0] == 1 ) {
		GivePlayerWeapon(playerid, 24, 10);
		SendClientMessage(playerid, -1, "load weapon carregada");
	}
	if (armas[playerid][1] == 1 ) {
		GivePlayerWeapon(playerid, 30, 50);
	}
	if (armas[playerid][2] == 1 ) {
		GivePlayerWeapon(playerid, 29, 25);
	}
	return 1;
}


stock Nome(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	return name;
}
stock LimparChat(playerid, linhas)
{
	for(new b = 0; b <= linhas; b++) SendClientMessage(playerid, -1, "");
	return 1;
}
forward Kickar(playerid);
public Kickar(playerid)
{
    Kick(playerid);
	return 1;
}
stock CarregarDados(playerid)
{
	new Arquivo[70], sendername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, sendername, sizeof(sendername));
    format(Arquivo, sizeof(Arquivo), "Contas/%s.ini", sendername);
    if(DOF2_FileExists(Arquivo))
	{
        Pdados[playerid][Dinheiro] = DOF2_GetInt(Arquivo, "Dinheiro");
		pecas_arma[playerid] = DOF2_GetInt(Arquivo,"Pecas_Armas");
		armas[playerid][0] = DOF2_GetInt(Arquivo, "Deseart" );
		armas[playerid][1] = DOF2_GetInt(Arquivo, "Ak");
		armas[playerid][2] = DOF2_GetInt(Arquivo, "Sub");
    } 
	return 1;
}
stock SalvarDados(playerid)
{
	new Arquivo[70], sendername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, sendername, sizeof(sendername));
    format(Arquivo, sizeof(Arquivo), "Contas/%s.ini", sendername);
    Pdados[playerid][Dinheiro] = GetPlayerMoney(playerid);
    DOF2_SetInt(Arquivo, "Dinheiro", Pdados[playerid][Dinheiro]);
	DOF2_SetInt(Arquivo,"Pecas_Armas",pecas_arma[playerid]);
	DOF2_SetInt(Arquivo, "Deseart", armas[playerid][0]);
	DOF2_SetInt(Arquivo, "Ak", armas[playerid][1]);
	DOF2_SetInt(Arquivo, "Sub", armas[playerid][2]);
	DOF2_SetInt(Arquivo, "armas_teste", arma_equipada);
    DOF2_SaveFile();
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerPos(playerid,1685.6267,-2239.1313,13.5469);
	
}


public OnPlayerCommandText(playerid, cmdtext[])
{
    if (strcmp(cmdtext, "/d", true) == 0)
    {
        GivePlayerMoney(playerid, 999999);
        SendClientMessage(playerid, -1, "Parabens Rafa Voc� acaba de Ganhar Muito Dinheiro");
        return 1;
    }

	if (strcmp(cmdtext, "/menuarmas", true) == 0)
    {
		if (IsPlayerInRangeOfPoint(playerid, 3.0, -2789.6240,-52.5912,10.0625))
		{
			ShowPlayerDialog(playerid, 100, DIALOG_STYLE_LIST, "Menu Armas", "Deseart Agle\t\t [20 pecas]\n Ak-47\t\t\t [50 pecas]\n Sub-Metralhadora\t\t [35 pecas]", "Montar", "sair");
        	return 1;
		}
        SendClientMessage(playerid, COR_BEJE, "VOCE NAO ESTA NO LOCAL CERTO, PROCURA EM SF PERTO DA PRAIA!!!");
    }

	if (strcmp(cmdtext, "/mercadonegro", true) == 0)
    {
        ShowPlayerDialog(playerid, 101, DIALOG_STYLE_LIST, "Mercado Negro", "Pecas de armas \t [5 pecas] [1000]", "Comprar","Sair");
		return 1;
    }

    return 0;
}


forward create_npc();
public create_npc() {
	CreateActor(33, 2331.1633,44.6231,32.9884,52.7999); //mercado negro
	CreateActor(215,-2789.2720,-52.5813,10.0625,91.5399); //menu armas
}


stock LoadCasa()
{
	new file [150];
	for (new i = 0 ;i < MAX_CASAS; i++)
	{
		format(file, sizeof(file), "Casas/Casa%d.ini", i);
		if (DOF2_FileExists(file))
		{
			new Float:Pos[3];
			Pos[0] = DOF2_GetFloat(file,"CasaX");
			Pos[1] = DOF2_GetFloat(file,"CasaY");
			Pos[2] = DOF2_GetFloat(file,"CasaZ");
			if (DOF2_GetInt(file,"TemDono") == 0)
			{
				CreatePickup(1273, 1, Pos[0],Pos[1],Pos[2], 0);
				new Str[150];
				format(Str, sizeof(Str), "(0x33AA33AA)CasaID%d\nDono:%s\nValor:%d", i, DOF2_GetString(file,"Dono"), DOF2_GetInt(file,"Valor"));
				Create3DTextLabel(Str, 1, Pos[0],Pos[1],Pos[2], 30, 0, 0);
				continue;
			}
			CreatePickup(1272, 1, Pos[0],Pos[1],Pos[2], 0);
			new Str[150];
			format(Str, sizeof(Str), "(0x0000FFAA)CasaID%d\nDono:%s\nValor:%d", i, DOF2_GetString(file,"Dono"), DOF2_GetInt(file,"Valor"));
			Create3DTextLabel(Str, 1, Pos[0],Pos[1],Pos[2], 30, 0, 0);
			
		}
	}

	return 1;
}

CMD:mercadonegro (playerid)
{
	if (IsPlayerInRangeOfPoint(playerid, 3.0, 2330.9500,44.5836,32.9884))
	{
		ShowPlayerDialog(playerid, 101, DIALOG_STYLE_LIST, "Mercado Negro pecas_arma[playerid]" , "Pecas de armas \t [5 pecas] [1000]", "Comprar","Sair");
		return 1;
	}
	SendClientMessage(playerid, COR_BEJE, "VOCE NAO ESTA NO LOCAL CERTO, PROCURA EM PALOMINO CREEK, EM CIMA DAS COISAS!!!");
	return 1;
}

CMD:menuarmas (playerid)
{
	if (IsPlayerInRangeOfPoint(playerid, 3.0, -2789.6240,-52.5912,10.0625))
	{
		ShowPlayerDialog(playerid, 100, DIALOG_STYLE_LIST, "Menu Armas", "Deseart Agle\t\t [20 pecas]\n Ak-47\t\t\t [50 pecas]\n Sub-Metralhadora\t\t [35 pecas]", "Montar", "sair");
        return 1;
	}
    SendClientMessage(playerid, COR_BEJE, "VOCE NAO ESTA NO LOCAL CERTO, PROCURA EM SF PERTO DA PRAIA!!!");
	return 1;
}

CMD:criarcasa (playerid, params[])
{
	new Valor;
	if (sscanf(params, "i", Valor)) return SendClientMessage(playerid, -3, "|ERRO | USE: /criarcasa [id]");
	new file [150];
	new Float:Pos[3];
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	for (new i = 0 ;i < MAX_CASAS; i++)
	{
		format(file, sizeof(file), "Casas/Casa%d.ini", i);
		if (!DOF2_FileExists(file))
		{
			DOF2_CreateFile(file);
			DOF2_SetString(file,"Dono","nenhum");
			DOF2_SetInt(file,"TemDono",0);
			DOF2_SetInt(file,"Valor",Valor);
			DOF2_SetInt(file,"Trancada", 0);
			DOF2_SetInt(file, "InteriorID",2);
			DOF2_SetFloat(file,"InteriorX",225.57);
			DOF2_SetFloat(file, "InteriorY",1240.06);
			DOF2_SetFloat(file,"InteriorZ",1082.14);
			DOF2_SetFloat(file,"CasaX",Pos[0]);
			DOF2_SetFloat(file,"CasaY",Pos[1]);
			DOF2_SetFloat(file,"CasaZ",Pos[2]);
			DOF2_SaveFile();
			SendClientMessage(playerid, COR_VERMELHOCLARO, "|INFO |CASA CRIADA COM SUCESSO");
			break;
		}
	}
	
	return 1;
}
