#include <a_samp>
#include <DOF2>
#include <zcmd>
#include <sscanf2>
#include <core>
#include <float>

native strcpy(dest[], size, const src[]);

#define MAX_CASAS 10

//VARIAVEIS
new logado[MAX_PLAYERS];

//======= ARMAS CONF. ======
new pecas_arma [MAX_PLAYERS];

//==== index 0 deseart, 1 ak, 2 sub-metralhadora ======
new save_armas [MAX_PLAYERS][13];
new save_muni [MAX_PLAYERS][13];

//======= emprego do player =======
//- valor 1 e hacker, 2 e fazendeiro, 3 e mecanico
new emprego[MAX_PLAYERS];
//-- se for 1 ele ja tem um veiculo criado
new veiculoemprego[MAX_PLAYERS] = 0;

//======= staff nivel 1 helper, 2 adm, 3 superiores, 4 master, 5 supervisor, 6 gerente, 7 diretor, 8 fundador, 9 ceo ========
new staff[MAX_PLAYERS];

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
	//================EXCLUIR DEPOIS=====================
	CreateVehicle(411, 1693.0347,-2253.8489,13.3773,79.3827, 2, 2, 0);

	SetGameModeText("Roleplay");
	UsePlayerPedAnims();

	//========funçao de criar npc, pickups, lebal=================
	create_npc();
	create_pickups();
	create_lebal();

	//========LOGO DO SERVER========


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

	//=======save muni======
	for (new i = 0; i < 13; i++)
	{
		new weapon, ammo;
		GetPlayerWeaponData(playerid, i, weapon, ammo);
		save_armas[playerid][i] = weapon;
		save_muni[playerid][i] = ammo;
	}
	

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
	//=======GPS========
	if (dialogid == 776)
	{
		if(response)
		{
			//===== los santos =========
			if(listitem == 0){
				ShowPlayerDialog(playerid, 777, DIALOG_STYLE_LIST, "LOS SANTOS","EMPREGO\n PREFEITURA\n", "IR", "SAIR");
			}
			//===== san fierro =========
			if(listitem == 1){
				ShowPlayerDialog(playerid, 778, DIALOG_STYLE_LIST, "LOS SANTOS", "", "IR", "SAIR");
			}
			//===== las ventura =========
			if(listitem == 2){
				ShowPlayerDialog(playerid, 779, DIALOG_STYLE_LIST, "LOS SANTOS", "", "IR", "SAIR");
			}
		}
	}
	//---gps/los santos
	if (dialogid == 777)
	{
		if (response)
		{
			//--espregos
			if (listitem == 0)
			{
				ShowPlayerDialog(playerid, 7771, DIALOG_STYLE_LIST, "EMPREGOS", "HACKER\n FAZENDEIRO\n MECANICO", "IR", "SAIR");
			}
			if (listitem == 1)
			{
				SetPlayerCheckpoint(playerid, 1481.0450,-1771.6492,18.7958, 2.0);
			}
		}
	}
	//--gps/los santos/empregos
	if (dialogid == 7771)
	{
		if (response)
		{
			//--emprego de hacker
			if (listitem == 0)
			{
				SetPlayerCheckpoint(playerid, 1422.0435,-1487.2633,20.4325, 2.0);
			}
			//--emprego de fazendeiro
			if (listitem == 1)
			{
				SetPlayerCheckpoint(playerid, -382.9871,-1438.9064,26.3286, 2.0);
			}
			//--emprego de mecanico
			if (listitem == 2)
			{
				SetPlayerCheckpoint(playerid, 2820.6228,-1447.4827,16.2568, 2.0);
			}
		}
	}


	//======dialog empregos na prefeitura=====
	if (dialogid == 300)
	{
		if (response)
		{
			if (listitem == 0)
			{
				SendClientMessage(playerid, COR_BEJE, "  |PARABENS VOCE PEGOU O EMPREGO DE HACKER!");
				emprego[playerid] = 1;
				SetPlayerCheckpoint(playerid, 1422.0435,-1487.2633,20.4325, 2.0);
			}
			if (listitem == 1)
			{
				SendClientMessage(playerid, COR_BEJE, "  |PARABENS VOCE PEGOU O EMPREGO DE FAZENDEIRO!");
				emprego[playerid] = 2;
				SetPlayerCheckpoint(playerid, -382.9871,-1438.9064,26.3286, 2.0);
			}
			if (listitem == 2)
			{
				SendClientMessage(playerid, COR_BEJE, "  |PARABENS VOCE PEGOU O EMPREGO DE MECANICO!");
				emprego[playerid] = 3;
				SetPlayerCheckpoint(playerid, 2820.6228,-1447.4827,16.2568, 2.0);
			}
		}
	}
	

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
					load_arma_muni(playerid);

					

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

public OnPlayerEnterCheckpoint(playerid)
{
	//============verifica se o player esta pegando os chechepoint do emprego fazendeiro==============
	if (IsPlayerInRangeOfPoint(playerid, 10.0, -323.5716,-1432.6079,15.2656))
	{
		SendClientMessage(playerid, COR_VERDE, " |SEGUA O CHECKPOINT PARA ENTREGAR A MERCADORIA!!");
		SetPlayerCheckpoint(playerid, -258.8300,-2182.0342,29.0165, 8.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 8.0, -258.8300,-2182.0342,29.0165))
	{
		SendClientMessage(playerid, COR_VERDE, " |PARABENS VOCE COMPLETOU A EMPREGA");
		DisablePlayerCheckpoint(playerid);
		GivePlayerMoney(playerid, 100);
		SendClientMessage(playerid, COR_VERDE, "100R$");
		return 1;
	}
	//========== FIM ===========


	DisablePlayerCheckpoint(playerid);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	//========= sistema de spawn carro do emprego do fazendeiro==========
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		if (IsPlayerInRangeOfPoint(playerid, 3.0, -377.3354,-1443.5775,25.7266))
		{
			
			if (emprego[playerid] == 2 )
			{
				if (veiculoemprego[playerid] == 1)
				{
					return SendClientMessage(playerid, COR_VERMELHO, " |VOCE JA TEM UM VEICULO CRIADO!");
				}
				if (veiculoemprego[playerid] == 0)
				{
					CreateVehicle(478, -377.3354,-1443.5775,25.7266, 355.2217, 1, 1, 0);
					veiculoemprego[playerid] = 1;
					SendClientMessage(playerid, COR_AMARELO, " |USE /INICIARROTA");
					return 1;
				}
			}
			SendClientMessage(playerid, COR_VERMELHO, "  |VOCE NAO E DESSE EMPREGO!");
		}
	}

	//============saida da base dos hacker========
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1133.3008,-14.4518,1000.6797))
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerPos(playerid, 1422.0435,-1487.2633,20.4325);
		}
		
	}
	//============sistema do hacker================
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0,1422.0435,-1487.2633,20.4325))
		{
			if (emprego[playerid]== 1 )
			{
				SetPlayerInterior(playerid, 12);
				SetPlayerPos(playerid, 1133.34,-7.84,1000.67);
				SendClientMessage(playerid, COR_AZULVERDE, "VOCE ENTROU NA BASE DOS HAKER!");
			}
			else{ return SendClientMessage(playerid, COR_VERMELHO, "  |VOCE NAO E HACKER!");}
		}
	}

	//======sistema da prefeitura======
	if (newkeys & KEY_SECONDARY_ATTACK )
	{
		if (IsPlayerInRangeOfPoint(playerid,3.0, 1481.0450,-1771.6492,18.7958))
		{
			SetPlayerInterior(playerid, 3);
			SetPlayerPos(playerid, 386.52,173.63,1008.38);
			SendClientMessage(playerid, COR_AZULVERDE, "VOCE ENTROU NA PREFEITURA!");
		}
		if (IsPlayerInRangeOfPoint(playerid, 3.0, 390.0310,173.7126,1008.3828))
		{
			SetPlayerPos(playerid, 1481.0450,-1771.6492,18.7958);
			SetPlayerInterior(playerid, 0);
		}
	}
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		if (IsPlayerInRangeOfPoint(playerid, 3.0, 361.8299,173.5468,1008.3828))
		{
			ShowPlayerDialog(playerid, 300, DIALOG_STYLE_LIST, "EMPREGO", "HACKER \n FAZENDEIRO \n MECANICO", "SER CLT", "SAIR");
		}
		
	}

	return 1;
}

forward criar_deseart (playerid);
public criar_deseart (playerid){
	GivePlayerWeapon(playerid, 24, 10);
	SendClientMessage(playerid, COR_AZUL, "Sua Arma Foi Criada!!!");
	
	return 1;
}

forward criar_ak (playerid);
public criar_ak (playerid){
	GivePlayerWeapon(playerid, 30, 50);
	SendClientMessage(playerid, COR_AZUL, "Sua Arma Foi Criada!!!");
	
	return 1;
}

forward criar_sub (playerid);
public criar_sub (playerid){
	GivePlayerWeapon(playerid, 29, 25);
	SendClientMessage(playerid, COR_AZUL, "Sua Arma Foi Criada!!!");
	
	return 1;
}

public load_arma_muni(playerid)
{
	for (new i = 0; i < 13; i++)
	{
		if (save_armas[playerid][i] != 0)
		{
			GivePlayerWeapon(playerid, save_armas[playerid][i], save_muni[playerid][i]);
		}
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

		//==========carregar emprego do player========
		emprego[playerid] = DOF2_GetInt(Arquivo, "empregoproaa");

		//==========cargo staff========
		staff[playerid] = DOF2_GetInt(Arquivo, "cargo_staff");

		//=======carregar as minução e as armas===========
		new str[60];
		for (new i = 0; i< 13; i++)
		{
			format(str, sizeof(str), "arma%d", i);
			save_armas[playerid][i] = DOF2_GetInt(Arquivo, str);

			format(str, sizeof(str), "municao%d", i);
			save_muni[playerid][i] = DOF2_GetInt(Arquivo, str);
		}
    } 
	return 1;
}
stock SalvarDados(playerid)
{
	new Arquivo[70], sendername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, sendername, sizeof(sendername));
    format(Arquivo, sizeof(Arquivo), "Contas/%s.ini", sendername);
    Pdados[playerid][Dinheiro] = GetPlayerMoney(playerid);

	//===== salvar o emprego=====
	DOF2_SetInt(Arquivo, "empregoproaa", emprego[playerid]);

	//==== cargo staff ========
	DOF2_SetInt(Arquivo, "cargo_staff", staff[playerid]);


	//=======sistema para salvar as armas e munição e peças de arma=======
	new str[100];
	DOF2_SetInt(Arquivo, "Pecas_Armas", pecas_arma[playerid]);
	for (new i = 0; i<13; i++ )
	{
		format(str, sizeof(str), "arma%d", i);
		DOF2_SetInt(Arquivo, str, save_armas[playerid][i]);

		format(str, sizeof(str), "municao%d", i);
		DOF2_SetInt(Arquivo, str, save_muni[playerid][i]);
	}
	
	
    DOF2_SaveFile();
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid,1685.6267,-2239.1313,13.5469);
}




forward create_npc();
public create_npc() {
	CreateActor(33, 2331.1633,44.6231,32.9884,52.7999); //mercado negro
	CreateActor(215,-2789.2720,-52.5813,10.0625,91.5399); //menu armas
}

forward create_pickups();
public create_pickups()
{
	//=====entrada prefeitura=====
	CreatePickup(1318, 1, 1481.0450,-1771.6492,18.7958, 0);
	//=====saida prefeitura=====
	CreatePickup(1318, 1, 390.0310,173.7126,1008.3828, 0);
	//========maleta, dentro da prefeitura=====
	CreatePickup(1210, 1, 361.8299,173.5468,1008.3828, 0);
	//=======emprego hacker======
	CreatePickup(1581, 1, 1422.0435,-1487.2633,20.4325, 0);
	//=======sair da base hacker======
	CreatePickup(1318, 1, 1133.3008,-14.4518,1000.6797, 0);
	//=======emprego fazendeiro======
	CreatePickup(1581, 1, -382.9871,-1438.9064,26.3286, 0);
	//=======spawn carro fazendeiro========
	CreatePickup(19131, 1, -377.3354,-1443.5775,25.7266, 0);
	//=======emprego mecanico======
	CreatePickup(1581, 1, 2820.6228,-1447.4827,16.2568, 0);




	//======lugares para os hacker hackear=====
	CreatePickup(19198, 1, 1132.8978,-1.7272,1000.6797, 0);
	CreatePickup(19198, 1, 1128.0367,3.0072,1000.6797, 0);
	CreatePickup(19198, 1, 1125.8912,3.0072,1000.6797, 0);
	CreatePickup(19198, 1, 1124.8074,3.0072,1000.6797, 0);
	CreatePickup(19198, 1, 1126.9907,3.0071,1000.6797, 0);
	CreatePickup(19198, 1, 1134.9886,0.6538,1000.6797, 0);
	CreatePickup(19198, 1, 1135.0756,-3.8687,1000.6797, 0);
	return 1;
}

forward create_lebal();
public create_lebal()
{
	//====emprego hacker=====
	Create3DTextLabel("EMPREGO HACKER\n [F] para entrar", COR_BRANCO, 1422.0435,-1487.2633,20.4325, 10.0, 0, 0);
	//====emprego fazendeiro=====
	Create3DTextLabel("EMPREGO FAZENDEIRO", COR_BRANCO, -382.9871,-1438.9064,26.3286, 10.0, 0, 0);
	Create3DTextLabel("SPAWN CARRO \n aperte [F]", COR_BRANCO, -377.3354,-1443.5775,25.7266, 10.0, 0, 0);

	//====emprego mecanico=====
	Create3DTextLabel("EMPREGO MECANICO", COR_BRANCO, 2820.6228,-1447.4827,16.2568, 10.0, 0, 0);


	//============lugares dos hacker hackear=======
	Create3DTextLabel("/HACKEAR", COR_BRANCO, 1132.8978,-1.7272,1000.6797, 10.0, 0, 0);
	Create3DTextLabel("/HACKEAR", COR_BRANCO, 1128.0367,3.0072,1000.6797, 10.0, 0, 0);
	Create3DTextLabel("/HACKEAR", COR_BRANCO, 1125.8912,3.0072,1000.6797, 10.0, 0, 0);
	Create3DTextLabel("/HACKEAR", COR_BRANCO, 1124.8074,3.0072,1000.6797, 10.0, 0, 0);
	Create3DTextLabel("/HACKEAR", COR_BRANCO, 1126.9907,3.0071,1000.6797, 10.0, 0, 0);
	Create3DTextLabel("/HACKEAR", COR_BRANCO, 1134.9886,0.6538,1000.6797, 10.0, 0, 0);
	Create3DTextLabel("/HACKEAR", COR_BRANCO, 1135.0756,-3.8687,1000.6797, 10.0, 0, 0);

	return 1;
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

	if (strcmp(cmdtext, "/hackear", true) == 0)
	{
		if (IsPlayerInRangeOfPoint(playerid, 0.5, 1135.1835,-3.8678,1000.6797))
		{
			SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
			SetTimerEx("clt_hacker", 10000, false, "1", playerid);
			TogglePlayerControllable(playerid, 0);
		}
		if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1132.8978,-1.7272,1000.6797))
		{
			SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
			SetTimerEx("clt_hacker", 10000, false, "1", playerid);
			TogglePlayerControllable(playerid, 0);
		}
		if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1128.0367,3.0072,1000.6797))
		{
			SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
			SetTimerEx("clt_hacker", 10000, false, "1", playerid);
			TogglePlayerControllable(playerid, 0);
		}
		if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1125.8912,3.0072,1000.6797))
		{
			SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
			SetTimerEx("clt_hacker", 10000, false, "1", playerid);
			TogglePlayerControllable(playerid, 0);
		}
		if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1124.8074,3.0072,1000.6797))
		{
			SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
			SetTimerEx("clt_hacker", 10000, false, "1", playerid);
			TogglePlayerControllable(playerid, 0);
		}
		if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1126.9907,3.0071,1000.6797))
		{
			SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
			SetTimerEx("clt_hacker", 10000, false, "1", playerid);
			TogglePlayerControllable(playerid, 0);
		}
		if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1134.9886,0.6538,1000.6797))
		{
			SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
			SetTimerEx("clt_hacker", 10000, false, "1", playerid);
			TogglePlayerControllable(playerid, 0);
		}
		if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1135.0756,-3.8687,1000.6797))
		{
			SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
			SetTimerEx("clt_hacker", 10000, false, "1", playerid);
			TogglePlayerControllable(playerid, 0);
		}
		
	}

	if (strcmp(cmdtext, "/gps", true) == 0)
	{
		ShowPlayerDialog(playerid, 776, DIALOG_STYLE_LIST, "GPS", "LOS SANTOS\n SAN FIERRO\n LAS VENTURA","MARCAR", "SAIR");
		return 1;
	}

	if (strcmp(cmdtext, "/kick", true, 5) == 0)
    {
        new id, motivo[64];

        if (sscanf(cmdtext, "/kick %d %s[64]", id, motivo))
        {
            SendClientMessage(playerid, -1, "Uso correto: /kick [id] [motivo]");
            return 1;
        }

        if (!IsPlayerConnected(id))
        {
            SendClientMessage(playerid, -1, "Jogador nao conectado.");
            return 1;
        }

        //===========Verificação de permissão =========
        if (staff[playerid] < 0)
        {
            SendClientMessage(playerid, -1, "Voce nao tem permissao para usar este comando.");
            return 1;
        }

		new nomeAdmin[MAX_PLAYER_NAME], nomeAlvo[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, nomeAdmin, sizeof(nomeAdmin));
    	GetPlayerName(id, nomeAlvo, sizeof(nomeAlvo));

        new msgAdmin[144], msgAlvo[128];

    	//==============Mensagem para todos
		format(msgAdmin, sizeof(msgAdmin), "O jogador %s foi kickado por %s. Motivo: %s", nomeAlvo, nomeAdmin, motivo);
		SendClientMessageToAll(-1, msgAdmin);
		SendClientMessage(playerid, COR_VERMELHO, "olasasqq");

		//============Mensagem para o jogador que será kickado
		format(msgAlvo, sizeof(msgAlvo), "Você foi kickado por %s. Motivo: %s", nomeAdmin, motivo);
		SendClientMessage(id, -1, msgAlvo);

        Kick(id);
        return 1;
    }

    return 0;
}

CMD:iniciarrota(playerid)
{
	if (IsPlayerInRangeOfPoint(playerid, 8.0, -377.3354,-1443.5775,25.7266))
	{
		SendClientMessage(playerid, COR_VERDE, " |SEGUA OS CHECKPOINT!! ");
		SetPlayerCheckpoint(playerid, -323.5716,-1432.6079,15.2656, 8.0);
		return 1;	
	}
	return SendClientMessage(playerid, COR_VERMELHO, " |VOCE NAO ESTA NA BASE DO FAZENDEIRO PARA INICIAR UMA ROTA!!! ");
}

CMD:hackear (playerid)
{
	if (IsPlayerInRangeOfPoint(playerid, 0.5, 1135.1835,-3.8678,1000.6797))
	{
		SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
		SetTimerEx("clt_hacker", 7000, false, "1", playerid);
		TogglePlayerControllable(playerid, 0);
	}
	if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1132.8978,-1.7272,1000.6797))
	{
		SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
		SetTimerEx("clt_hacker", 7000, false, "1", playerid);
		TogglePlayerControllable(playerid, 0);
	}
	if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1128.0367,3.0072,1000.6797))
	{
		SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
		SetTimerEx("clt_hacker", 7000, false, "1", playerid);
		TogglePlayerControllable(playerid, 0);
	}
	if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1125.8912,3.0072,1000.6797))
	{
		SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
		SetTimerEx("clt_hacker", 7000, false, "1", playerid);
		TogglePlayerControllable(playerid, 0);
	}
	if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1124.8074,3.0072,1000.6797))
	{
		SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
		SetTimerEx("clt_hacker", 7000, false, "1", playerid);
		TogglePlayerControllable(playerid, 0);
	}
	if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1126.9907,3.0071,1000.6797))
	{
		SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
		SetTimerEx("clt_hacker", 7000, false, "1", playerid);
		TogglePlayerControllable(playerid, 0);
	}
	if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1134.9886,0.6538,1000.6797))
	{
		SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
		SetTimerEx("clt_hacker", 7000, false, "1", playerid);
		TogglePlayerControllable(playerid, 0);
	}
	if ( IsPlayerInRangeOfPoint(playerid, 0.5, 1135.0756,-3.8687,1000.6797))
	{
		SendClientMessage(playerid, COR_AMARELO, "    |HACKEANDO A MAQUINA...");
		SetTimerEx("clt_hacker", 7000, false, "1", playerid);
		TogglePlayerControllable(playerid, 0);
	}

	return 1;
}

CMD:gps (playerid)
{
	ShowPlayerDialog(playerid, 776, DIALOG_STYLE_LIST, "GPS", "LOS SANTOS\n SAN FIERRO\n LAS VENTURA","MARCAR", "SAIR");
	return 1;
}

CMD:mercadonegro (playerid)
{
	if (IsPlayerInRangeOfPoint(playerid, 3.0, 2330.9500,44.5836,32.9884))
	{
		ShowPlayerDialog(playerid, 101, DIALOG_STYLE_LIST, "Mercado Negro" , "Pecas de armas \t [5 pecas] [1000]", "Comprar","Sair");
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

//============ COMANDOS STTAF ========================
//staff nivel 1 helper, 2 adm, 3 superiores, 4 master, 5 supervisor, 6 gerente, 7 diretor, 8 fundador, 9 ceo ========
CMD:ls(playerid)
{
	if (staff[playerid] > 0)
	{
		SetPlayerPos(playerid, 1476.1512,-1742.7393,13.5469);
		return 1;
	}
	SendClientMessage(playerid, COR_VERMELHO, " |VOCE NAO E UM ADM");
	return 1;
}
CMD:sf(playerid)
{
	if (staff[playerid] > 0)
	{
		SetPlayerPos(playerid, -1975.6886,137.1803,27.6875);
		return 1;
	}
	SendClientMessage(playerid, COR_VERMELHO, " |VOCE NAO E UM ADM");
	return 1;
}
CMD:lv(playerid)
{
	if (staff[playerid] > 0)
	{
		SetPlayerPos(playerid,1674.0798,1448.5024,10.7836);
		return 1;
	}
	SendClientMessage(playerid, COR_VERMELHO, " |VOCE NAO E UM ADM");

	return 1;
}
CMD:kick(playerid, params[])
{
    new id, motivo[64];

    //============Lê os parâmetros corretamente: ID do jogador e motivo
    if (sscanf(params, "us[64]", id, motivo))
    {
        SendClientMessage(playerid, -1, "Uso correto: /kick [id] [motivo]");
        return 1;
    }

    if (!IsPlayerConnected(id))
    {
        SendClientMessage(playerid, -1, "Jogador nao conectado.");
        return 1;
    }

    //======verifica permissão (ajuste conforme sua lógica de staff)
    if (staff[playerid] < 1) 
    {
        SendClientMessage(playerid, -1, "Você não tem permissão para usar este comando.");
        return 1;
    }

    new nomeAdmin[MAX_PLAYER_NAME], nomeAlvo[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nomeAdmin, sizeof(nomeAdmin));
    GetPlayerName(id, nomeAlvo, sizeof(nomeAlvo));

    new msgAdmin[144], msgAlvo[128];

    //==============Mensagem para todos
    format(msgAdmin, sizeof(msgAdmin), "O jogador %s foi kickado por %s. Motivo: %s", nomeAlvo, nomeAdmin, motivo);
    SendClientMessageToAll(-1, msgAdmin);

    //============Mensagem para o jogador que será kickado
    format(msgAlvo, sizeof(msgAlvo), "Você foi kickado por %s. Motivo: %s", nomeAdmin, motivo);
    SendClientMessage(id, -1, msgAlvo);

	SendClientMessage(playerid, COR_VERMELHO, "olasasqq");

    Kick(id);
    return 1;
}

//===================== EMPREGOS ===================

//--emprego de hacker
forward clt_hacker(playerid);
public clt_hacker(playerid)
{
	SendClientMessage(playerid, COR_ROSA, "   |MAQUINA HACKEADA COM SUCESSO!!!");
	GivePlayerMoney(playerid, 50);
	SendClientMessage(playerid, COR_VERDE, "50R$");
	TogglePlayerControllable(playerid, 1);
}