#include <a_samp>
#include <DOF2>
#include <zcmd>
#include <sscanf2>
#include <core>
#include <float>
#include <streamer>

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


native strcpy(dest[], size, const src[]);

#define MAX_CASAS 10

//VARIAVEIS
new PlayerText:text_logo[MAX_PLAYERS][6];
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

//========= sistema penintenciaria ============
new nivel_procurado[MAX_PLAYERS] = 0;
new cela_aberta = false;
new cela2_aberta = false;
new cela1_prisao;
new cela1_2_prisao;
new cela2_prisao;
new cela2_2_prisao;

//=========== mapeação =========
new map_spawn[46];
//-------------
new garagem_map[46];
//------------
new g_Pickup[1];
new detran_map[20];
//------------
new org_polis_map[194];
new org_polis_pickup[1];
//------------------
new carro_poli_map[28];
new carro_poli_veiculo[1];

//====== detran se o player esta fazendo alguma prova====
//--index 0 carro, 1 moto, 2 caminhão
new licencas[MAX_PLAYERS][3];
new prova_licenca = 0;

//====== org/corp que o player esta ==========
new id_org[MAX_PLAYERS] = 0 ;
new id_corp[MAX_PLAYERS] = 0 ;
new carro_org_corp_spawnado[MAX_PLAYERS] = 0;
//--cargo 1 e membro 2 sub 3 lider--
new cargo_org_corp[MAX_PLAYERS] = 0;

//===== destruir o carro =======
new carro_destruir = 0;

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
	//========LOGO DO SERVER========
	CriarLogoEldorado(playerid);
	obj();
	remove_obj(playerid);
	clt_mec(playerid);

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
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	org_polis(playerid, 0, dialogid, response, listitem);

	//======== info licenças detran ==========
	if (dialogid == 250)
	{
		if(response)
		{
			//--carro
			if(listitem == 0)
			{
				if(licencas[playerid][0] == 0)
				{
					SetPlayerInterior(playerid,0);
					SetPlayerPos(playerid, 1924.2418,720.1313,10.8203);
					carro_destruir = CreateVehicle(589, 1924.1528,716.9359,10.8203,96.7309, 4, 4, 0);
					
					SendClientMessage(playerid, COR_AZULVERDE, "  |PEGA O VEICULO E SEGUA OS CHECK POINT");
					SendClientMessage(playerid, COR_AZULVERDE, "  |VOCE TEM 3m PARA FAZER A PROVA!!!");
					SetPlayerCheckpoint(playerid, 1878.0602,703.3523,10.4214, 10.0);
					GivePlayerMoney(playerid, -1500);
					prova_licenca = 1;
					SetTimerEx("timer_licenca", 180000, false, "1", playerid);
					return 1;
				}
				SendClientMessage(playerid, COR_AMARELO, " |VOCE JA TEM ESSA LICENCA!!");
				
			}
			//--moto
			if(listitem == 1)
			{
				if(licencas[playerid][1] == 0)
				{
					SetPlayerInterior(playerid,0);
					SetPlayerPos(playerid, 1924.2418,720.1313,10.8203);
					carro_destruir = CreateVehicle(461, 1924.1528,716.9359,10.8203,96.7309, 4, 4, 0);
					
					SendClientMessage(playerid, COR_AZULVERDE, "  |PEGA O VEICULO E SEGUA OS CHECK POINT");
					SendClientMessage(playerid, COR_AZULVERDE, "  |VOCE TEM 3m PARA FAZER A PROVA!!!");
					SetPlayerCheckpoint(playerid, 1878.0602,703.3523,10.4214, 10.0);
					GivePlayerMoney(playerid, -1500);
					prova_licenca = 1;
					SetTimerEx("timer_licenca", 180000, false, "1", playerid);
					return 1;
				}
				SendClientMessage(playerid, COR_AMARELO, " |VOCE JA TEM ESSA LICENCA!!");
			}
			//--caminhao
			if(listitem == 2)
			{
				if(licencas[playerid][2] == 0)
				{
					SetPlayerInterior(playerid, 0);
					SetPlayerPos(playerid, 1924.2418,720.1313,10.8203);
					carro_destruir = CreateVehicle(514, 1924.1528,716.9359,10.8203,96.7309, 4, 4, 0);
					
					SendClientMessage(playerid, COR_AZULVERDE, "  |PEGA O VEICULO E SEGUA OS CHECK POINT");
					SendClientMessage(playerid, COR_AZULVERDE, "  |VOCE TEM 3m PARA FAZER A PROVA!!!");
					SetPlayerCheckpoint(playerid, 1878.0602,703.3523,10.4214, 10.0);
					GivePlayerMoney(playerid, -3500);
					prova_licenca = 1;
					SetTimerEx("timer_licenca", 180000, false, "1", playerid);
					return 1;
				}
				SendClientMessage(playerid, COR_AMARELO, " |VOCE JA TEM ESSA LICENCA!!");
			}
		}
	}

	//======= GPS ================================================================================
	if (dialogid == 776)
	{
		if(response)
		{
			//===== los santos =========
			if(listitem == 0)
			{
				ShowPlayerDialog(playerid, 777, DIALOG_STYLE_LIST, "LOS SANTOS","Empregos\nPrefeitura\nPenitenciaria\nGaragem", "IR", "SAIR");
			}
			//===== san fierro =========
			if(listitem == 1)
			{
				ShowPlayerDialog(playerid, 778, DIALOG_STYLE_LIST, "LOS SANTOS", "", "IR", "SAIR");
			}
			//===== las ventura =========
			if(listitem == 2)
			{
				ShowPlayerDialog(playerid, 779, DIALOG_STYLE_LIST, "LOS SANTOS", "Detran", "IR", "SAIR");
			}
			//=====locais ilegis=======
			if (listitem == 3)
			{
				ShowPlayerDialog(playerid, 7777, DIALOG_STYLE_LIST, "LOCAIS ILEGAIS", "Fabricar armas\nMercado Negro", "IR", "SAIR");
			}
			//--org
			if (listitem == 4)
			{
				ShowPlayerDialog(playerid, 232, DIALOG_STYLE_LIST, "ORG", "Polis", "IR", "SAIR");
			}
			//--corp
			if (listitem == 5)
			{
				ShowPlayerDialog(playerid, 121, DIALOG_STYLE_LIST, "CORP", "", "IR", "SAIR");
			}
		}
	}
	//--corp gps
	if (dialogid == 121)
	{
		if (response)
		{
			if(listitem == 0)
			{
				SetPlayerCheckpoint(playerid, 1713.5101,-1146.4460,23.9597, 3.0);
			}
		}
	}
	//--org gps
	if (dialogid == 232)
	{
		if (response)
		{
			if(listitem == 0)
			{
				SetPlayerCheckpoint(playerid, 840.4275,-2069.3472,12.7653, 3.0);
			}
		}
	}
	//--locais ilegal/fabrica de arma e mercado negro
	if (dialogid == 7777)
	{
		if (response)
		{
			if (listitem == 0)
			{
				SetPlayerCheckpoint(playerid, 2121.4824,-2274.1904,20.6719, 3.0);
			}
			if (listitem == 1)
			{
				SetPlayerCheckpoint(playerid, 2331.1633,44.6231,32.9884, 3.0);
			}
		}
	}
	//---gps/las ventura
	if (dialogid == 779)
	{
		if (response)
		{
			//--detran
			if (listitem == 0)
			{
				SetPlayerCheckpoint(playerid, 1922.5728,742.6204,10.8203, 3.0);
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
				ShowPlayerDialog(playerid, 7771, DIALOG_STYLE_LIST, "EMPREGOS", "Hacker\nFazendeiro\n Mecanico", "IR", "SAIR");
			}
			//--prefeitura
			if (listitem == 1)
			{
				SetPlayerCheckpoint(playerid, 1481.0450,-1771.6492,18.7958, 2.0);
			}
			//--penitenciaria
			if (listitem == 2)
			{
				SetPlayerCheckpoint(playerid, 1555.2206,-1675.5248,16.1953, 2.0);
			}
			//--garagem
			if (listitem == 3)
			{
				ShowPlayerDialog(playerid, 7772, DIALOG_STYLE_LIST, "GARAGEM", "Garagem 1", "IR", "SAIR");
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
	if (dialogid == 7772)
	{
		if (response)
		{
			//--garagem 1
			if (listitem == 0)
			{
				SetPlayerCheckpoint(playerid, 1090.0956,-1763.6310,13.4103, 2.0);
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

	//============tela de login=============

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

					format(string, sizeof(string), "Org/%s.ini", Nome(playerid));
					DOF2_CreateFile(string);
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
					CarregarDadosOrg(playerid);
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
	//======== sistema de tirar habilitação ========
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 1878.0602,703.3523,10.4214))
	{
		SetPlayerCheckpoint(playerid, 1870.4320,768.8286,10.3301 , 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 1870.4320,768.8286,10.3301))
	{
		SetPlayerCheckpoint(playerid, 1982.9958,771.1935,10.3299, 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 1982.9958,771.1935,10.3299))
	{
		SetPlayerCheckpoint(playerid,2143.3005,753.2479,10.5073 , 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 2143.3005,753.2479,10.5073))
	{
		SetPlayerCheckpoint(playerid, 2147.5435,971.4962,10.5198, 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 2147.5435,971.4962,10.5198))
	{
		SetPlayerCheckpoint(playerid, 2070.6824,974.0267,10.0879, 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 2070.6824,974.0267,10.0879))
	{
		SetPlayerCheckpoint(playerid, 2068.9585,1369.1177,10.3319, 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 2068.9585,1369.1177,10.3319 ))
	{
		SetPlayerCheckpoint(playerid, 2225.7043,1371.8855,10.5059, 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 2225.7043,1371.8855,10.5059))
	{
		SetPlayerCheckpoint(playerid, 2226.8958,1200.0815,10.4399, 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 2226.8958,1200.0815,10.4399))
	{
		SetPlayerCheckpoint(playerid,2048.5071,1190.2308,10.3300 , 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 2048.5071,1190.2308,10.3300))
	{
		SetPlayerCheckpoint(playerid,2048.9407,834.0981,6.3968 , 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0,2048.9407,834.0981,6.3968 ))
	{
		SetPlayerCheckpoint(playerid,2177.1599,815.9423,6.3630 , 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 2177.1599,815.9423,6.3630))
	{
		SetPlayerCheckpoint(playerid,2278.6060,764.4591,10.3897 , 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 2278.6060,764.4591,10.3897))
	{
		SetPlayerCheckpoint(playerid, 2286.1572,636.2357,10.6514, 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 2286.1572,636.2357,10.6514))
	{
		SetPlayerCheckpoint(playerid, 2144.4758,669.3519,10.4503, 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0,2144.4758,669.3519,10.4503 ))
	{
		SetPlayerCheckpoint(playerid,1997.3311,673.6219,10.3580 , 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0,1997.3311,673.6219,10.3580 ))
	{
		SetPlayerCheckpoint(playerid,1979.0760,702.0841,10.3852 , 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 1979.0760,702.0841,10.3852))
	{
		SetPlayerCheckpoint(playerid, 1919.7979,708.2623,10.4782, 10.0);
		return 1;
	}
	if (IsPlayerInRangeOfPoint(playerid, 10.0, 1919.7979,708.2623,10.4782))
	{
		new idcar = GetPlayerVehicleID(playerid);
		new idmodelo = GetVehicleModel(idcar);

		if (idmodelo == 589)//carro
		{
			licencas[playerid][0] = 1;
			
		}
		if (idmodelo == 461)//moto
		{
			licencas[playerid][1] = 1;
			
		}
		if (idmodelo == 514)//caminhao
		{
			licencas[playerid][2] = 1;
			
		}
		SendClientMessage(playerid, COR_VERDE, "  |PARABENS VOCE PASSOU NO TESTE!!");
		DestroyVehicle(carro_destruir);
		prova_licenca = 0;
		DisablePlayerCheckpoint(playerid);
		return 1;
	}

	//============== FIM HABILITAÇÂO =========

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
	org_polis(playerid, newkeys, 0, 0, 0);
	//========== sistema de entrar nodetran ====
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		if (IsPlayerInRangeOfPoint(playerid, 2.0, 1922.5728,742.6204,10.8203))
		{
			SetPlayerInterior(playerid, 3);
			SetPlayerPos(playerid, -2031.11,-115.82,1035.17);
		}
	}
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		if (IsPlayerInRangeOfPoint(playerid, 2.0, -2029.5670,-119.5585,1035.1719))
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerPos(playerid, 1922.5728,742.6204,10.8203);
		}
	}
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		if (prova_licenca == 1 && IsPlayerInRangeOfPoint(playerid, 2.0, -2033.4343,-117.4267,1035.1719)) 
		{
			SendClientMessage(playerid, COR_VERMELHO, "  |VOCE JA TEM UM VEICULO CRIADO!!!");
			return 1;
		}
		if (IsPlayerInRangeOfPoint(playerid, 2.0, -2033.4343,-117.4267,1035.1719))
		{
			ShowPlayerDialog(playerid, 250, DIALOG_STYLE_LIST, "LICENÇAS", "CARRO  [R$ 1.500]\nMOTO  [R$ 1.500]\nCAMINHAO  [R$ 3.500]", "FAZER TESTE", "SAIR");
			return 1;
		}
	}
	//============ FIM DETRAN ==========

	//========== sistema de abrir e fechar sela==========
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		//--cela 1
		if (IsPlayerInRangeOfPoint(playerid, 2.0, 320.7723,311.5896,999.1484) && id_corp[playerid] != 1 && cela_aberta == false)
		{
			MoveObject(cela1_prisao, 320.7723,311.5896,990.1484, 10.0);
			MoveObject(cela1_2_prisao, 320.7723,311.5896,990.1484, 10.0);
			cela_aberta = true;

			SendClientMessage(playerid, COR_VERDE, " |VOCE ESTA ABRINDO A CELA!");
			return 1;
		}
		if (IsPlayerInRangeOfPoint(playerid, 2.0, 320.7723,311.5896,999.1484) && id_corp[playerid] > 0 && cela_aberta == true)
		{
			MoveObject(cela1_prisao, 320.7723,311.5896,999.1484, 10.0);
			MoveObject(cela1_2_prisao, 320.7173,312.9832,999.1484, 10.0);
			cela_aberta = false;

			SendClientMessage(playerid, COR_VERDE, " |VOCE ESTA FECHANDO A CELA!");
			return 1;
		}
		//--cela 2
		if (IsPlayerInRangeOfPoint(playerid, 2.0, 321.1540,316.4138,999.1484) && id_corp[playerid] > 0 && cela2_aberta == false)
		{
			MoveObject(cela2_prisao, 320.7173,312.9832,990.1484, 10.0);
			MoveObject(cela2_2_prisao, 320.6675,317.1631,990.1484, 10.0);
			cela2_aberta = true;

			SendClientMessage(playerid, COR_VERDE, " |VOCE ESTA ABRINDO A CELA!");
			return 1;
		}
		if (IsPlayerInRangeOfPoint(playerid, 2.0, 321.1540,316.4138,999.1484) && id_corp[playerid] > 0 && cela2_aberta == true)
		{
			MoveObject(cela2_prisao, 320.7824,315.5038,999.1484, 10.0);
			MoveObject(cela2_2_prisao, 320.6675,317.1631,999.1484, 10.0);
			cela2_aberta = false;

			SendClientMessage(playerid, COR_VERDE, " |VOCE ESTA FECHANDO A CELA!");
			return 1;
		}


		if (IsPlayerInRangeOfPoint(playerid, 2.0, 320.7723,311.5896,999.1484))
		{
			SendClientMessage(playerid, COR_VERMELHO, " |VOCE NAO TEM PERMISSAO PARA ABRIR A CELA!");
		}
	}
	//=== fim prisao ====


	//==========sistema da penitenciaria ============
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		if (IsPlayerInRangeOfPoint(playerid, 3.0, 1555.2206,-1675.5248,16.1953))
		{
			SetPlayerInterior(playerid,5);
			SetPlayerPos(playerid, 322.50,303.69,999.14);
			
		}
	}
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		if (IsPlayerInRangeOfPoint(playerid, 3.0, 322.2418,302.9979,999.1484))
		{
			SetPlayerInterior(playerid, 0);
			SetPlayerPos(playerid, 1555.2206,-1675.5248,16.1953);
		}
	}


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
stock CarregarDadosOrg(playerid)
{
	new Arquivo[70], sendername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, sendername, sizeof(sendername));
    format(Arquivo, sizeof(Arquivo), "Org/%s.ini", sendername);

    if(DOF2_FileExists(Arquivo))
	{

		//----org/corp
		id_org[playerid] = DOF2_GetInt(Arquivo, "org");
		id_corp[playerid] = DOF2_GetInt(Arquivo, "corp");
		cargo_org_corp[playerid] = DOF2_GetInt(Arquivo, "cargo_org_corp");
	}
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

		//===== licenças ====
		licencas[playerid][0] = DOF2_GetInt(Arquivo,"licenca_carro");
		licencas[playerid][1] = DOF2_GetInt(Arquivo,"licenca_moto");
		licencas[playerid][2] = DOF2_GetInt(Arquivo,"licenca_caminhao");

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

	//==== licenças ======
	DOF2_SetInt(Arquivo, "licenca_carro", licencas[playerid][0]);
	DOF2_SetInt(Arquivo, "licenca_moto", licencas[playerid][1]);
	DOF2_SetInt(Arquivo, "licenca_caminhao", licencas[playerid][2]);


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
	//========mostrar os text draw ========
	for(new i = 0; i < 6; i++)
	{
		PlayerTextDrawShow(playerid, text_logo[playerid][i]);
	}
	


	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerPos(playerid,1682.9510,-2299.3079,13.5466);

	return 1;
}




forward create_npc();
public create_npc() {
	
	CreateActor(33, 2331.1633,44.6231,32.9884,52.7999); //mercado negro
	CreateActor(215,2121.4824,-2274.1904,20.6719,221.9421); //menu armas
}

forward create_pickups();
public create_pickups()
{
	//=====entrada detran=====
	CreatePickup(1318, 1,  1922.5728,742.6204,10.8203, 0);
	CreatePickup(1318, 1,  -2029.5670,-119.5585,1035.1719, 0);
	CreatePickup(1239, 1,  -2033.4343,-117.4267,1035.1719, 0);
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

	//=======penitenciaria ======
	CreatePickup(1247, 1, 1555.2206,-1675.5248,16.1953, 0);
	//--saida
	CreatePickup(1247, 1,322.2418,302.9979,999.1484, 0);


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
	org_polis(0, 0, 0, 0, 0);
	
	//====== garagem ===========
	Create3DTextLabel("GARAGEM\n [F] para pegar o carro", COR_BRANCO, 1560.3824,-2221.8804,13.5469, 10.0, 0, 0);
	//======== detran ==========
	Create3DTextLabel("DETRAN\n [F] para entrar", COR_BRANCO, 1922.5728,742.6204,10.8203, 10.0, 0, 0);
	Create3DTextLabel("DETRAN\n [F] para sair", COR_BRANCO, -2029.5670,-119.5585,1035.1719, 10.0, 0, 0);
	Create3DTextLabel("LICENCAS\n [F] para acessar", COR_BRANCO, -2033.4343,-117.4267,1035.1719, 10.0, 0, 0);

	//=======penitenciaria ======
	Create3DTextLabel("PENITENCIARIA\n [F] para entrar", COR_BRANCO, 1555.2206,-1675.5248,16.1953, 10.0, 0, 0);
	Create3DTextLabel("PENITENCIARIA\n [F] para sair", COR_BRANCO, 322.2418,302.9979,999.1484, 10.0, 0, 0);
	Create3DTextLabel("PENITENCIARIA\n [F] para abrir/fechar", COR_BRANCO, 320.7723,311.5896,999.1484, 10.0, 0, 0);
	Create3DTextLabel("PENITENCIARIA\n [F] para abrir/fechar", COR_BRANCO, 320.7824,315.5038,999.1484, 10.0, 0, 0);

	//====maleta prefeitura==
	Create3DTextLabel("EMPREGOS\n aperte [F]", COR_BRANCO, 361.8299,173.5468,1008.3828, 10.0, 0, 0);


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
stock CriarLogoEldorado(playerid)
{
    text_logo[playerid][0] = CreatePlayerTextDraw(playerid, 300.000000, 24.000000, "box");
    PlayerTextDrawLetterSize(playerid, text_logo[playerid][0], 0.000000, -0.866666);
    PlayerTextDrawTextSize(playerid, text_logo[playerid][0], 365.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, text_logo[playerid][0], 1);
    PlayerTextDrawColor(playerid, text_logo[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, text_logo[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, text_logo[playerid][0], 791621476);
    PlayerTextDrawSetShadow(playerid, text_logo[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, text_logo[playerid][0], 255);
    PlayerTextDrawFont(playerid, text_logo[playerid][0], 2);
    PlayerTextDrawSetProportional(playerid, text_logo[playerid][0], 0);

    text_logo[playerid][1] = CreatePlayerTextDraw(playerid, 275.000000, 7.000000, "LD_BEAT:chit");
    PlayerTextDrawTextSize(playerid, text_logo[playerid][1], 24.000000, 33.000000);
    PlayerTextDrawAlignment(playerid, text_logo[playerid][1], 1);
    PlayerTextDrawColor(playerid, text_logo[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, text_logo[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, text_logo[playerid][1], 255);
    PlayerTextDrawFont(playerid, text_logo[playerid][1], 4);
    PlayerTextDrawSetProportional(playerid, text_logo[playerid][1], 0);

    text_logo[playerid][2] = CreatePlayerTextDraw(playerid, 301.000000, 6.000000, "eldorado");
    PlayerTextDrawLetterSize(playerid, text_logo[playerid][2], 0.400000, 1.600000);
    PlayerTextDrawAlignment(playerid, text_logo[playerid][2], 1);
    PlayerTextDrawColor(playerid, text_logo[playerid][2], -65281);
    PlayerTextDrawSetShadow(playerid, text_logo[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, text_logo[playerid][2], 255);
    PlayerTextDrawFont(playerid, text_logo[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, text_logo[playerid][2], 1);

    text_logo[playerid][3] = CreatePlayerTextDraw(playerid, 283.000000, 15.000000, "N");
    PlayerTextDrawLetterSize(playerid, text_logo[playerid][3], 0.400000, 1.600000);
    PlayerTextDrawAlignment(playerid, text_logo[playerid][3], 1);
    PlayerTextDrawColor(playerid, text_logo[playerid][3], -65281);
    PlayerTextDrawSetShadow(playerid, text_logo[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, text_logo[playerid][3], 255);
    PlayerTextDrawFont(playerid, text_logo[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, text_logo[playerid][3], 1);

    text_logo[playerid][4] = CreatePlayerTextDraw(playerid, 298.000000, 20.000000, "ROLEPLAY");
    PlayerTextDrawLetterSize(playerid, text_logo[playerid][4], 0.236000, 1.093924);
    PlayerTextDrawAlignment(playerid, text_logo[playerid][4], 1);
    PlayerTextDrawColor(playerid, text_logo[playerid][4], -1);
    PlayerTextDrawSetShadow(playerid, text_logo[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, text_logo[playerid][4], 255);
    PlayerTextDrawFont(playerid, text_logo[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, text_logo[playerid][4], 1);

    text_logo[playerid][5] = CreatePlayerTextDraw(playerid, 322.000000, -10.000000, "");
    PlayerTextDrawTextSize(playerid, text_logo[playerid][5], 48.000000, 72.000000);
    PlayerTextDrawAlignment(playerid, text_logo[playerid][5], 1);
    PlayerTextDrawColor(playerid, text_logo[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, text_logo[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, text_logo[playerid][5], 791621376);
    PlayerTextDrawFont(playerid, text_logo[playerid][5], 5);
    PlayerTextDrawSetProportional(playerid, text_logo[playerid][5], 0);
    PlayerTextDrawSetPreviewModel(playerid, text_logo[playerid][5], 519);
    PlayerTextDrawSetPreviewRot(playerid, text_logo[playerid][5], 15.000000, 0.000000, 60.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, text_logo[playerid][5], 2, 1);
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
	if (strcmp(cmdtext, "/setarorg", true) == 0)
	{
		new Arquivo[70], sendername[MAX_PLAYER_NAME];
    
		new id_org_setar, id_player;

		if (sscanf(cmdtext, "/setarorg %d %d[64]", id_player, id_org_setar))
		{
			SendClientMessage(playerid, COR_AMARELO, "Uso correto: /setarorg [id player] [id org]");
			return 1;
		}
		if (!IsPlayerConnected(id_player))
		{
			SendClientMessage(playerid, -1, "Jogador nao conectado.");
			return 1;
		}

		GetPlayerName(id_player, sendername, sizeof(sendername));
		format(Arquivo, sizeof(Arquivo), "Org/%s.ini", sendername);

		if (staff[playerid] > 0)
		{
			if (staff[playerid] > 6)
			{
				DOF2_SetInt(Arquivo, "org", id_org_setar);
				DOF2_SetInt(Arquivo, "cargo_org_corp", 3);
				DOF2_SaveFile();
				SendClientMessage(playerid, COR_VERDE, " |VOCE SETOU UMA ORG");
				return 1;
			}
			SendClientMessage(playerid, -1, "Voce nao tem permissao para usar este comando.");
			return 1;
		}
		return SendClientMessage(playerid, COR_VERMELHO, " |VOCE NAO E UM ADM!");
	}



    if (strcmp(cmdtext, "/d", true) == 0)
    {
        GivePlayerMoney(playerid, 999999);
        SendClientMessage(playerid, -1, "Parabens Rafa Voc� acaba de Ganhar Muito Dinheiro");
        return 1;
    }

	if (strcmp(cmdtext, "/menuarmas", true) == 0)
    {
		if (IsPlayerInRangeOfPoint(playerid, 3.0, 2121.4824,-2274.1904,20.6719))
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
		ShowPlayerDialog(playerid, 776, DIALOG_STYLE_LIST, "GPS", "LOS SANTOS\nSAN FIERRO\nLAS VENTURA\nLOCAIS ILEGAL\nORGANIZACOES\nCORPORACOES","IR", "SAIR");
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
	if (strcmp(cmdtext, "/veridcar", true) == 0)
	{
		if(staff[playerid] > 0)
		{
			new idcar = GetPlayerVehicleID(playerid);
			new idmodelo = GetVehicleModel(idcar);
			new mgs[60];
			format(mgs, sizeof(mgs), "O ID DESSE CARRO E: %d", idmodelo);
			SendClientMessage(playerid, COR_ROXO, mgs);
			return 1;
		}
		SendClientMessage(playerid, COR_VERMELHO, " |VOCE NAO E UM ADM");
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
	ShowPlayerDialog(playerid, 776, DIALOG_STYLE_LIST, "GPS", "LOS SANTOS\nSAN FIERRO\nLAS VENTURA\nLOCAIS ILEGAL\nORGANIZACOES\nCORPORACOES","MARCAR", "SAIR");
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
	if (IsPlayerInRangeOfPoint(playerid, 3.0, 2121.4824,-2274.1904,20.6719))
	{
		ShowPlayerDialog(playerid, 100, DIALOG_STYLE_LIST, "Menu Armas", "Deseart Agle\t\t [20 pecas]\n Ak-47\t\t\t [50 pecas]\n Sub-Metralhadora\t\t [35 pecas]", "Montar", "sair");
        return 1;
	}
    SendClientMessage(playerid, COR_BEJE, "VOCE NAO ESTA NO LOCAL CERTO, USE /GPS!!!");
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

CMD:veridcar(playerid)
{
	if(staff[playerid] > 0)
	{
		new idcar = GetPlayerVehicleID(playerid);
		new idmodelo = GetVehicleModel(idcar);
		new mgs[60];
		format(mgs, sizeof(mgs), "O ID DESSE CARRO E %d", idmodelo);
		SendClientMessage(playerid, COR_ROXO, mgs);
		return 1;
	}
	SendClientMessage(playerid, COR_VERMELHO, " |VOCE NAO E UM ADM");
	return 1;
}


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
        return SendClientMessage(playerid, COR_VERMELHO, " |VOCE NAO E UM ADM!");
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
CMD:setarorg(playerid, params[])
{
	new Arquivo[70], sendername[MAX_PLAYER_NAME];
    

	new id_org_setar, id_player;

	if (sscanf(params, "ii", id_player, id_org_setar))
	{
		SendClientMessage(playerid, COR_AMARELO, "Uso correto: /setarorg [id player] [id org]");
		return 1;
	}
	if (!IsPlayerConnected(id_player))
	{
		SendClientMessage(playerid, -1, "Jogador nao conectado.");
		return 1;
	}

	GetPlayerName(id_player, sendername, sizeof(sendername));
	format(Arquivo, sizeof(Arquivo), "Org/%s.ini", sendername);
	SendClientMessage(playerid, COR_ROXO, Arquivo);

	if (staff[playerid] > 0)
	{
		if (staff[playerid] > 6)
		{
			DOF2_SetInt(Arquivo, "org", id_org_setar);
			DOF2_SetInt(Arquivo, "cargo_org_corp", 3);
			DOF2_SaveFile();
			SendClientMessage(playerid, COR_VERDE, " |VOCE SETOU UMA ORG");
			return 1;
		}
		SendClientMessage(playerid, -1, "Voce nao tem permissao para usar este comando.");
		return 1;
	}
	return SendClientMessage(playerid, COR_VERMELHO, " |VOCE NAO E UM ADM!");
}

//=============== sistema de org ==========
//-- org polis id 1 ----------
forward org_polis(playerid, newkeys, dialogid, response, listitem);
public org_polis(playerid, newkeys, dialogid, response, listitem)
{
	new Arquivo[70], sendername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, sendername, sizeof(sendername));
    format(Arquivo, sizeof(Arquivo), "Org/%s.ini", sendername);
    

	//--cofre
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		if (IsPlayerInRangeOfPoint(playerid, 3.0, 807.5922,-2233.4729,12.8432))
		{
			if (DOF2_GetInt(Arquivo, "org") == 1)
			{
				if (DOF2_GetInt(Arquivo,"cargo_org_corp") > 2 )
				{
					ShowPlayerDialog(playerid, 989, DIALOG_STYLE_LIST, "ORG POLIS", "GUARDAR\nPEGAR", "OK", "SAIR");
					return 1;
				}
				SendClientMessage(playerid, COR_VERDEMEDIO, "  |VOCE NAO TEM PERMISSAO!");
				return 1;
			}
			SendClientMessage(playerid, COR_VERDEMEDIO, "  |VOCE NAO E DESSA ORGANIZACAO!");
		}
	}

	Create3DTextLabel("Org Polis\nAperte [F]", COR_BRANCO, 854.6782,-2211.7029,12.6870, 10.0, 0);
	if (dialogid == 11)
	{
		if(response)
		{
			//--sultan
			if (listitem == 0)
			{
				CreateVehicle(560 , 854.6782,-2211.7029,12.6870,102.7967, 125, 125, 0);
				carro_org_corp_spawnado[playerid] = 1;
			}
			//--inferno
			if (listitem == 1)
			{
				CreateVehicle(411 , 854.6782,-2211.7029,12.6870,102.7967, 125, 125, 0);
				carro_org_corp_spawnado[playerid] = 1;
			}
			//--Nrg-500
			if (listitem == 2)
			{
				CreateVehicle(522 , 854.6782,-2211.7029,12.6870,102.7967, 125, 125, 0);
				carro_org_corp_spawnado[playerid] = 1;
			}
			//--pcj-600
			if (listitem == 3)
			{
				CreateVehicle(461 , 854.6782,-2211.7029,12.6870,102.7967, 125, 125, 0);
				carro_org_corp_spawnado[playerid] = 1;
			}
			//--Burrito
			if (listitem == 4)
			{
				CreateVehicle(482 , 854.6782,-2211.7029,12.6870,102.7967, 125, 125, 0);
				carro_org_corp_spawnado[playerid] = 1;
			}
		}
	}
	//=----------------------------------------
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
		if (IsPlayerInRangeOfPoint(playerid, 3.0, 854.6782,-2211.7029,12.6870))
		{
			if (DOF2_GetInt(Arquivo, "org") == 1)
			{
				if(carro_org_corp_spawnado[playerid] == 1) return SendClientMessage(playerid, COR_VERDEMEDIO, "  |VOCE TEM UM CARRO CRIADO!");
				ShowPlayerDialog(playerid, 11, DIALOG_STYLE_LIST, "CARROS", "Sultan\nInferno\nNrg-500\nPcj-600\nBurrito", "PEGAR", "SAIR");
				return 1;
			}
			SendClientMessage(playerid, COR_VERDEMEDIO, "  |VOCE NAO E DESSA ORGANIZACAO!");
		}
	}
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
//--emprego de mecanico
forward clt_mec(playerid);
public clt_mec(playerid)
{
	return 1;
}
forward timer_licenca(playerid);
public timer_licenca(playerid)
{
	if (prova_licenca == 1)
	{
		DestroyVehicle(carro_destruir);
		SendClientMessage(playerid, COR_VERMELHO, "  |VOCE REPROVOU NA PROVA!!!");
		DisablePlayerCheckpoint(playerid);
		SetPlayerPos(playerid, 1924.2418,720.1313,10.8203);
		prova_licenca = 0 ;
	}
	
	return 1;
}

forward remove_obj(playerid);
public remove_obj(playerid)
{
	RemoveBuildingForPlayer(playerid, 5762, 1315.369, -887.468, 41.703, 0.250);
	RemoveBuildingForPlayer(playerid, 5852, 1315.369, -887.468, 41.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1522, 1314.729, -897.265, 38.468, 0.250);

	//=====================================
	RemoveBuildingForPlayer(playerid, 1260, 591.726, -1508.930, 25.304, 0.250);
	RemoveBuildingForPlayer(playerid, 6100, 1251.790, -1541.280, 36.914, 0.250);
	RemoveBuildingForPlayer(playerid, 6107, 1251.790, -1541.280, 36.914, 0.250);
	RemoveBuildingForPlayer(playerid, 4718, 1760.160, -1127.270, 43.664, 0.250);
	RemoveBuildingForPlayer(playerid, 4719, 1760.160, -1127.270, 43.664, 0.250);
	RemoveBuildingForPlayer(playerid, 4748, 1760.160, -1127.270, 43.664, 0.250);
	RemoveBuildingForPlayer(playerid, 4719, 1760.160, -1127.270, 43.664, 0.250);
	RemoveBuildingForPlayer(playerid, 1215, 1721.119, -1142.839, 23.609, 0.250);
	RemoveBuildingForPlayer(playerid, 717, 1721.229, -1150.150, 23.093, 0.250);
	RemoveBuildingForPlayer(playerid, 1283, 1707.060, -1159.099, 25.835, 0.250);

	//================================

	RemoveBuildingForPlayer(playerid, 5782, 897.664, -1346.699, 14.531, 0.250);
	RemoveBuildingForPlayer(playerid, 5948, 897.664, -1346.699, 14.531, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 875.414, -1343.660, 14.085, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 870.148, -1343.660, 14.085, 0.250);
	RemoveBuildingForPlayer(playerid, 1462, 886.343, -1357.300, 12.554, 0.250);
	RemoveBuildingForPlayer(playerid, 5815, 877.164, -1361.199, 12.453, 0.250);
	RemoveBuildingForPlayer(playerid, 5949, 877.164, -1361.199, 12.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1462, 853.195, -1359.729, 12.554, 0.250);
	RemoveBuildingForPlayer(playerid, 1635, 860.914, -1359.800, 16.085, 0.250);
	RemoveBuildingForPlayer(playerid, 1297, 855.304, -1331.920, 15.640, 0.250);
	RemoveBuildingForPlayer(playerid, 1635, 868.062, -1340.609, 17.484, 0.250);
	RemoveBuildingForPlayer(playerid, 5816, 877.351, -1363.709, 21.156, 0.250);
	RemoveBuildingForPlayer(playerid, 1365, 861.984, -1380.459, 13.625, 0.250);
	RemoveBuildingForPlayer(playerid, 1260, 875.046, -1383.479, 28.164, 0.250);
	RemoveBuildingForPlayer(playerid, 1266, 875.046, -1383.479, 28.164, 0.250);
	RemoveBuildingForPlayer(playerid, 5780, 889.109, -1375.660, 18.851, 0.250);
	RemoveBuildingForPlayer(playerid, 5781, 887.976, -1372.410, 18.171, 0.250);
	RemoveBuildingForPlayer(playerid, 5965, 887.976, -1372.410, 18.171, 0.250);
	RemoveBuildingForPlayer(playerid, 1440, 857.375, -1381.160, 13.046, 0.250);
	RemoveBuildingForPlayer(playerid, 1438, 872.265, -1346.410, 12.531, 0.250);
	RemoveBuildingForPlayer(playerid, 1260, 907.765, -1374.650, 28.164, 0.250);
	RemoveBuildingForPlayer(playerid, 1266, 907.765, -1374.650, 28.164, 0.250);
	RemoveBuildingForPlayer(playerid, 5783, 908.539, -1384.329, 24.515, 0.250);
}

forward obj();
public obj()
{
	cela1_prisao = CreateObject(19303, 320.7723,311.5896,999.1484, 0.0, 0.0, 90.0);
	cela1_2_prisao = CreateObject(19303, 320.7173,312.9832,999.1484, 0.0, 0.0, 90.0);
	cela2_prisao = CreateObject(19303, 320.7824,315.5038,999.1484, 0.0, 0.0, 90.0);
	cela2_2_prisao = CreateObject(19303, 320.6675,317.1631,999.1484, 0.0, 0.0, 90.0);

	map_spawn[0] = CreateObject(1223, 1677.3580, -2264.3569, 12.6146, 0.0000, 0.0000, 0.0000); //lampost_coast
	map_spawn[1] = CreateObject(1223, 1677.3580, -2269.0913, 12.6146, 0.0000, 0.0000, 0.0000); //lampost_coast
	map_spawn[2] = CreateObject(1223, 1677.3580, -2273.2849, 12.5046, 0.0000, 0.0000, 0.0000); //lampost_coast
	map_spawn[3] = CreateObject(1223, 1677.3580, -2277.6391, 12.5046, 0.0000, 0.0000, 0.0000); //lampost_coast
	map_spawn[4] = CreateObject(1223, 1677.3580, -2281.9716, 12.5046, 0.0000, 0.0000, 0.0000); //lampost_coast
	map_spawn[5] = CreateObject(1223, 1677.3580, -2286.8359, 12.5046, 0.0000, 0.0000, 0.0000); //lampost_coast
	map_spawn[6] = CreateObject(1223, 1677.3580, -2292.7407, 12.5046, 0.0000, 0.0000, 0.0000); //lampost_coast
	map_spawn[7] = CreateObject(1223, 1677.3580, -2299.3852, 12.5046, 0.0000, 0.0000, 0.0000); //lampost_coast
	map_spawn[8] = CreateObject(1223, 1677.3580, -2306.1196, 12.5046, 0.0000, 0.0000, 0.0000); //lampost_coast
	map_spawn[9] = CreateObject(1223, 1688.1802, -2306.1196, 12.5046, 0.0000, 0.0000, 179.0998); //lampost_coast
	map_spawn[10] = CreateObject(1223, 1688.2955, -2298.7946, 12.5046, 0.0000, 0.0000, 179.0998); //lampost_coast
	map_spawn[11] = CreateObject(1223, 1688.2294, -2292.7976, 12.5046, 0.0000, 0.0000, 179.0998); //lampost_coast
	map_spawn[12] = CreateObject(1223, 1688.1350, -2286.7395, 12.5046, 0.0000, 0.0000, 179.0998); //lampost_coast
	map_spawn[13] = CreateObject(1223, 1688.2320, -2281.8459, 12.5046, 0.0000, 0.0000, 179.0998); //lampost_coast
	map_spawn[14] = CreateObject(1223, 1687.8737, -2277.8435, 12.5046, 0.0000, 0.0000, 179.0998); //lampost_coast
	map_spawn[15] = CreateObject(1223, 1687.9720, -2273.5424, 12.5046, 0.0000, 0.0000, 179.0998); //lampost_coast
	map_spawn[16] = CreateObject(1223, 1688.0447, -2268.9995, 12.5046, 0.0000, 0.0000, 179.0998); //lampost_coast
	map_spawn[17] = CreateObject(1223, 1688.1202, -2264.1086, 12.5046, 0.0000, 0.0000, 179.0998); //lampost_coast
	map_spawn[18] = CreateObject(1223, 1677.3580, -2264.3569, 12.6146, 0.0000, 0.0000, 0.0000); //lampost_coast
	map_spawn[19] = CreateObject(11327, 1682.4967, -2324.8283, 20.3160, 0.0000, 0.0000, -88.9999); //sfse_hub_grgdoor02
	SetObjectMaterialText(map_spawn[19], "ELDORADO", 0, 90, "Arial", 50, 1, 0xFF000000, 0xFFD78E10, 1);
	map_spawn[20] = CreateObject(2773, 1687.2620, -2263.6005, 13.0542, 0.0000, 0.0000, 90.7001); //CJ_AIRPRT_BAR
	map_spawn[21] = CreateObject(2773, 1686.2794, -2264.5241, 13.0542, 0.0000, 0.0000, 177.8002); //CJ_AIRPRT_BAR
	map_spawn[22] = CreateObject(2773, 1679.2871, -2264.6586, 13.0542, 0.0000, 0.0000, 0.0000); //CJ_AIRPRT_BAR
	map_spawn[23] = CreateObject(19741, 1682.7305, -2266.5698, 12.4841, 0.0000, 0.0000, 0.0000); //STubeFlat6_25m1
	map_spawn[24] = CreateObject(19741, 1682.7304, -2272.7548, 12.4841, 0.0000, 0.0000, 0.0000); //STubeFlat6_25m1
	map_spawn[25] = CreateObject(19741, 1682.7404, -2278.9992, 12.4841, 0.0000, 0.0000, 0.0000); //STubeFlat6_25m1
	map_spawn[26] = CreateObject(19741, 1682.7406, -2285.1330, 12.4841, 0.0000, 0.0000, 0.0000); //STubeFlat6_25m1
	map_spawn[27] = CreateObject(19741, 1682.7504, -2291.2255, 12.4841, 0.0000, 0.0000, 0.0000); //STubeFlat6_25m1
	map_spawn[28] = CreateObject(19741, 1682.7502, -2297.4291, 12.4841, 0.0000, 0.0000, 0.0000); //STubeFlat6_25m1
	map_spawn[29] = CreateObject(19741, 1682.7504, -2303.5339, 12.4841, 0.0000, 0.0000, 0.0000); //STubeFlat6_25m1
	map_spawn[30] = CreateObject(19741, 1682.7506, -2307.4890, 12.5141, 0.0000, 0.0000, 0.0000); //STubeFlat6_25m1
	map_spawn[31] = CreateObject(2773, 1679.2871, -2268.9812, 13.0542, 0.0000, 0.0000, 0.0000); //CJ_AIRPRT_BAR
	map_spawn[32] = CreateObject(2773, 1679.2871, -2273.3342, 13.0542, 0.0000, 0.0000, 0.0000); //CJ_AIRPRT_BAR
	map_spawn[33] = CreateObject(2773, 1679.2871, -2277.7277, 13.0542, 0.0000, 0.0000, 0.0000); //CJ_AIRPRT_BAR
	map_spawn[34] = CreateObject(2773, 1679.2871, -2281.9814, 13.0542, 0.0000, 0.0000, 0.0000); //CJ_AIRPRT_BAR
	map_spawn[35] = CreateObject(2773, 1679.2871, -2286.8859, 13.0542, 0.0000, 0.0000, 0.0000); //CJ_AIRPRT_BAR
	map_spawn[36] = CreateObject(2773, 1679.2871, -2292.9011, 13.0542, 0.0000, 0.0000, 0.0000); //CJ_AIRPRT_BAR
	map_spawn[37] = CreateObject(2773, 1679.2871, -2306.1125, 13.0542, 0.0000, 0.0000, 0.0000); //CJ_AIRPRT_BAR
	map_spawn[38] = CreateObject(2773, 1679.2871, -2299.3464, 13.0542, 0.0000, 0.0000, 0.0000); //CJ_AIRPRT_BAR
	map_spawn[39] = CreateObject(2773, 1686.1092, -2268.9726, 13.0542, 0.0000, 0.0000, 177.8002); //CJ_AIRPRT_BAR
	map_spawn[40] = CreateObject(2773, 1686.1645, -2273.5927, 13.0542, 0.0000, 0.0000, 177.8002); //CJ_AIRPRT_BAR
	map_spawn[41] = CreateObject(2773, 1686.1826, -2281.8273, 13.0542, 0.0000, 0.0000, -179.4996); //CJ_AIRPRT_BAR
	map_spawn[42] = CreateObject(2773, 1686.2242, -2286.6601, 13.0542, 0.0000, 0.0000, -179.4996); //CJ_AIRPRT_BAR
	map_spawn[43] = CreateObject(2773, 1686.2775, -2292.7746, 13.0542, 0.0000, 0.0000, -179.4996); //CJ_AIRPRT_BAR
	map_spawn[44] = CreateObject(2773, 1686.3300, -2298.8085, 13.0542, 0.0000, 0.0000, -179.4996); //CJ_AIRPRT_BAR
	map_spawn[45] = CreateObject(2773, 1686.3937, -2306.0834, 13.0542, 0.0000, 0.0000, -179.4996); //CJ_AIRPRT_BAR

 //==========================================================================================================================//

	garagem_map[0] = CreateObject(19465, 1081.6267, -1763.6726, 14.9153, 0.0000, 0.0000, 0.0000); //wall105
	SetObjectMaterialText(garagem_map[0], "GARAGEM", 0, 90, "Arial Black", 65, 1, 0xFFFFFFFF, 0xFF515459, 0);

	garagem_map[1] = CreateObject(19454, 1087.9934, -1768.1671, 17.3640, -0.2999, 89.1998, -0.5999); //wall094
	garagem_map[2] = CreateObject(19454, 1084.4809, -1768.1271, 17.3150, -0.2999, 89.1998, -0.5999); //wall094
	garagem_map[3] = CreateObject(19454, 1081.0096, -1768.0897, 17.2666, -0.2999, 89.1998, -0.5999); //wall094
	garagem_map[4] = CreateObject(19454, 1081.1075, -1758.8980, 17.2185, -0.2999, 89.1998, -0.5999); //wall094
	garagem_map[5] = CreateObject(19454, 1084.5784, -1758.9465, 17.2670, -0.2999, 89.1998, -0.5999); //wall094
	garagem_map[6] = CreateObject(19454, 1088.0601, -1758.9842, 17.3156, -0.2999, 89.1998, -0.5999); //wall094
	garagem_map[7] = CreateObject(19454, 1091.5833, -1759.0263, 17.3646, -0.2999, 89.1998, -0.5999); //wall094
	garagem_map[8] = CreateObject(19806, 1087.9887, -1764.0897, 17.1911, 0.0000, 0.0000, 0.0000); //Chandelier1
	garagem_map[9] = CreateObject(19806, 1087.9887, -1769.3432, 17.1911, 0.0000, 0.0000, 0.0000); //Chandelier1
	garagem_map[10] = CreateObject(19806, 1087.9887, -1758.1685, 17.1911, 0.0000, 0.0000, 0.0000); //Chandelier1
	garagem_map[11] = CreateObject(19825, 1093.0186, -1763.5856, 15.4084, 0.0000, 0.0000, -85.0999); //SprunkClock1
	garagem_map[12] = CreateObject(19943, 1076.7026, -1753.6508, 12.3481, 0.0000, 0.0000, 0.0000); //StonePillar1
	garagem_map[13] = CreateObject(19943, 1076.7026, -1772.9848, 12.3481, 0.0000, 0.0000, 0.0000); //StonePillar1
	garagem_map[14] = CreateObject(2480, 1092.9814, -1766.1683, 12.9388, 0.0000, 0.0000, -91.1999); //MODEL_BOX9
	garagem_map[15] = CreateObject(19303, 320.7723, 311.5895, 999.1483, 0.0000, 0.0000, 90.0000); //subbridge19

	garagem_map[16] = CreateObject(19303, 320.7172, 312.9831, 999.1483, 0.0000, 0.0000, 90.0000); //subbridge19
	garagem_map[17] = CreateObject(8660, 1050.8432, -1765.9603, 13.3254, 0.0000, 0.0000, -87.2000); //bush04_lvs
	garagem_map[18] = CreateObject(627, 1080.3081, -1770.8299, 14.1286, 0.0000, 0.0000, 0.0000); //veg_palmkb3
	garagem_map[19] = CreateObject(626, 1079.9689, -1756.2935, 14.3776, 0.0000, 0.0000, 0.0000); //veg_palmkb2
	garagem_map[20] = CreateObject(1344, 1057.6051, -1765.4359, 13.3476, 0.0000, 0.0000, 89.0999); //CJ_Dumpster2
	garagem_map[21] = CreateObject(955, 1092.5330, -1756.0074, 12.8184, 0.0000, 0.0000, -84.9000); //CJ_EXT_SPRUNK
	garagem_map[22] = CreateObject(2198, 1091.1275, -1764.0482, 12.3821, 0.0000, 0.0000, 88.8999); //MED_OFFICE2_DESK_3
	garagem_map[23] = CreateObject(3578, 1070.5004, -1777.7154, 13.0709, 0.0000, 0.0000, 0.0000); //DockBarr1_LA
	garagem_map[24] = CreateObject(3578, 1064.4703, -1777.7154, 13.0709, 0.0000, 0.0000, 0.0000); //DockBarr1_LA
	garagem_map[25] = CreateObject(3578, 1075.3576, -1777.7154, 13.0709, 0.0000, 0.0000, 0.0000); //DockBarr1_LA
	garagem_map[26] = CreateObject(1820, 1086.2630, -1769.1340, 12.4291, 0.0000, 0.0000, 0.0000); //COFFEE_LOW_4
	garagem_map[27] = CreateObject(1720, 1086.4809, -1769.8243, 12.4889, 0.0000, 0.0000, -167.0001); //rest_chair
	garagem_map[28] = CreateObject(1720, 1087.9072, -1769.0917, 12.4189, 0.0000, 0.0000, -123.3000); //rest_chair
	garagem_map[29] = CreateObject(18977, 1082.6940, -1755.1312, 14.1123, 0.0000, 0.0000, -83.5999); //MotorcycleHelmet3
	garagem_map[30] = CreateObject(18977, 1083.4083, -1755.0513, 14.1123, 0.0000, 0.0000, -83.5999); //MotorcycleHelmet3
	garagem_map[31] = CreateObject(18977, 1084.1457, -1755.1804, 14.1123, 0.0000, 0.0000, -83.5999); //MotorcycleHelmet3
	garagem_map[32] = CreateObject(18978, 1082.6894, -1755.1650, 14.5762, 0.0000, 0.0000, -91.4000); //MotorcycleHelmet4
	garagem_map[33] = CreateObject(18978, 1083.3992, -1755.1823, 14.5762, 0.0000, 0.0000, -91.4000); //MotorcycleHelmet4
	garagem_map[34] = CreateObject(18978, 1084.1998, -1755.2019, 14.5762, 0.0000, 0.0000, -91.4000); //MotorcycleHelmet4
	garagem_map[35] = CreateObject(19425, 1069.9659, -1767.4508, 12.4413, 0.0000, 0.0000, 0.0000); //speed_bump01
	garagem_map[36] = CreateObject(19425, 1069.9659, -1762.3474, 12.4413, 0.0000, 0.0000, 0.0000); //speed_bump01
	garagem_map[37] = CreateObject(19425, 1069.9659, -1758.5457, 12.4413, 0.0000, 0.0000, 0.0000); //speed_bump01
	garagem_map[38] = CreateObject(19425, 1069.9659, -1754.2922, 12.4413, 0.0000, 0.0000, 0.0000); //speed_bump01
	garagem_map[39] = CreateObject(19425, 1069.9659, -1773.1218, 12.4413, 0.0000, 0.0000, 0.0000); //speed_bump01
	garagem_map[40] = CreateObject(19303, 320.7824, 315.5038, 999.1483, 0.0000, 0.0000, 90.0000); //subbridge19

	garagem_map[41] = CreateObject(1083, 1087.5128, -1772.4633, 15.0709, 0.0000, 0.0000, 85.4999); //wheel_lr2
	garagem_map[42] = CreateObject(1085, 1091.3170, -1772.4866, 15.0973, 0.0000, 0.0000, 84.5999); //wheel_gn2
	garagem_map[43] = CreateObject(1085, 1084.0363, -1772.3760, 15.0930, 0.0000, 0.0000, 94.4999); //wheel_gn2
	garagem_map[44] = CreateObject(19454, 1091.4661, -1768.2060, 17.4124, -0.2999, 89.1998, -0.5999); //wall094
	garagem_map[45] = CreateObject(19959, 1066.5479, -1735.4095, 12.4581, 0.0000, 0.0000, 0.0000); //SAMPRoadSign12
	g_Pickup[0] = CreatePickup(19902, 1, 1091.1978, -1763.4194, 13.5643, -1); //EnExMarker4
	
	//=====================================================================================================================//

	detran_map[0] = CreateObject(19353, 1878.5273, 714.6995, 11.5375, 0.0000, 0.0000, 0.0000); //wall001
	detran_map[1] = CreateObject(1237, 1875.7113, 697.4777, 9.8041, 0.0000, 0.0000, 0.0000); //strtbarrier01
	detran_map[2] = CreateObject(3749, 1879.7246, 703.3566, 15.5682, 0.0000, 0.0000, 90.9998); //ClubGate01_LAx
	detran_map[3] = CreateObject(3749, 1972.3315, 702.7019, 15.5682, 0.0000, 0.0000, 90.9998); //ClubGate01_LAx
	detran_map[4] = CreateObject(1238, 1867.3944, 708.9077, 10.0531, 0.0000, 0.0000, 0.0000); //trafficcone
	detran_map[5] = CreateObject(1238, 1867.4244, 702.7343, 10.1431, 0.0000, 0.0000, 0.0000); //trafficcone
	detran_map[6] = CreateObject(1238, 1867.4244, 697.2534, 10.1431, 0.0000, 0.0000, 0.0000); //trafficcone
	detran_map[7] = CreateObject(19353, 1878.5273, 717.8707, 11.5375, 0.0000, 0.0000, 0.0000); //wall001
	detran_map[8] = CreateObject(19353, 1878.5273, 721.0717, 11.5375, 0.0000, 0.0000, 0.0000); //wall001
	detran_map[9] = CreateObject(19353, 1878.5273, 723.6420, 11.5375, 0.0000, 0.0000, 0.0000); //wall001
	detran_map[10] = CreateObject(19353, 1878.5273, 691.9901, 11.5375, 0.0000, 0.0000, 0.0000); //wall001
	detran_map[11] = CreateObject(19353, 1878.5273, 688.7886, 11.5375, 0.0000, 0.0000, 0.0000); //wall001
	detran_map[12] = CreateObject(19353, 1878.5273, 685.5875, 11.5375, 0.0000, 0.0000, 0.0000); //wall001
	detran_map[13] = CreateObject(19353, 1878.5273, 683.8167, 11.5375, 0.0000, 0.0000, 0.0000); //wall001
	detran_map[14] = CreateObject(19958, 1872.9365, 710.7886, 9.6112, 0.0000, 0.0000, 178.6999); //SAMPRoadSign11
	detran_map[15] = CreateObject(1237, 1875.7113, 709.0471, 9.8041, 0.0000, 0.0000, 0.0000); //strtbarrier01
	detran_map[16] = CreateObject(19425, 1870.1690, 711.9414, 9.7081, 0.0000, 0.0000, 0.0000); //speed_bump01
	detran_map[17] = CreateObject(19425, 1870.1690, 706.0184, 9.7581, 0.0000, 0.0000, 0.0000); //speed_bump01
	detran_map[18] = CreateObject(19425, 1870.1690, 701.5063, 9.8181, 0.0000, 0.0000, 0.0000); //speed_bump01
	detran_map[19] = CreateObject(19425, 1870.1690, 697.8933, 9.7481, 0.0000, 0.0000, 0.0000); //speed_bump01

	//=========================================================================================================================//

	org_polis_map[0] = CreateObject(16610, 833.0480, -2126.2202, 15.3044, 0.0000, 0.0000, 85.1999); //des_nbridgebit_02
	org_polis_map[1] = CreateObject(3853, 829.4726, -2064.1188, 13.8755, 0.0000, -0.3999, 177.4999); //Gay_lamppost
	org_polis_map[2] = CreateObject(3853, 843.4942, -2064.3752, 12.7133, 0.0000, 0.0000, 0.0000); //Gay_lamppost
	org_polis_map[3] = CreateObject(1422, 830.4129, -2082.6665, 12.2036, 0.0000, 0.0000, 0.0000); //DYN_ROADBARRIER_5
	org_polis_map[4] = CreateObject(1422, 833.1333, -2082.6564, 12.2136, 0.0000, 0.0000, 0.0000); //DYN_ROADBARRIER_5
	org_polis_map[5] = CreateObject(1422, 840.3280, -2092.3500, 12.2043, 0.0000, 0.0000, 0.0000); //DYN_ROADBARRIER_5
	org_polis_map[6] = CreateObject(1422, 837.6176, -2092.3500, 12.2043, 0.0000, 0.0000, 0.0000); //DYN_ROADBARRIER_5
	org_polis_map[7] = CreateObject(967, 843.7229, -2068.3203, 11.9605, 1.8000, 0.4000, 88.6997); //bar_gatebox01
	org_polis_map[8] = CreateObject(19996, 844.1543, -2068.3464, 11.9267, 0.0000, 0.0000, -95.1001); //CutsceneFoldChair1
	org_polis_map[9] = CreateObject(3092, 837.2899, -2075.2470, 19.0545, 0.0000, 0.0000, 0.0000); //dead_tied_cop
	org_polis_map[10] = CreateObject(19868, 832.1197, -2073.0603, 11.7822, 0.0000, 0.0000, 0.0000); //MeshFence1
	org_polis_map[11] = CreateObject(19868, 836.5512, -2073.0603, 11.7822, 0.0000, 0.0000, 0.0000); //MeshFence1
	org_polis_map[12] = CreateObject(19868, 843.8439, -2075.3818, 11.7822, 0.0000, 0.0000, 51.5999); //MeshFence1
	org_polis_map[13] = CreateObject(3524, 830.3795, -2071.7553, 11.7613, 0.0000, 0.0000, 140.4999); //skullpillar01_lvs
	org_polis_map[14] = CreateObject(926, 843.0923, -2073.2141, 12.1495, 0.0000, 0.0000, 0.0000); //RUBBISH_BOX2
	org_polis_map[15] = CreateObject(926, 841.7919, -2085.2644, 12.1495, 0.0000, 0.0000, 17.0000); //RUBBISH_BOX2
	org_polis_map[16] = CreateObject(926, 829.2248, -2084.1809, 12.1495, 0.0000, 0.0000, 17.0000); //RUBBISH_BOX2
	org_polis_map[17] = CreateObject(933, 829.5320, -2088.0812, 12.6318, -3.1999, -91.2998, -41.1000); //CJ_CABLEROLL
	org_polis_map[18] = CreateObject(3593, 835.9287, -2091.4233, 12.2335, 0.0000, 0.0000, -55.6999); //la_fuckcar2
	org_polis_map[19] = CreateObject(12957, 837.5485, -2114.2602, 12.4935, 0.0000, 0.0000, -139.1999); //sw_pickupwreck01
	org_polis_map[20] = CreateObject(5815, 830.8147, -2211.0256, 11.5933, 0.0000, 0.0000, -0.7999); //lawngrnda
	org_polis_map[21] = CreateObject(19456, 832.7153, -2192.8803, 13.4964, 0.0000, 0.0000, 0.0000); //wall096
	org_polis_map[22] = CreateObject(19456, 837.4309, -2206.6169, 13.5048, -0.3999, -0.2999, 86.3998); //wall096
	org_polis_map[23] = CreateObject(19856, 810.6271, -2223.2048, 11.0265, 0.0000, 0.0000, 87.6003); //MIHouse1IntWalls1
	org_polis_map[24] = CreateObject(19456, 832.7153, -2201.4626, 13.4964, 0.0000, 0.0000, 0.0000); //wall096
	org_polis_map[25] = CreateObject(19456, 846.9332, -2207.1945, 13.5713, -0.3999, -0.2999, 86.3998); //wall096
	org_polis_map[26] = CreateObject(19456, 856.4525, -2207.7751, 13.4681, 1.6000, 0.0999, 86.3998); //wall096
	org_polis_map[27] = CreateObject(19456, 859.7525, -2211.8117, 13.3428, -0.3999, -0.2999, 179.5995); //wall096
	org_polis_map[28] = CreateObject(19456, 855.9904, -2215.2563, 13.5714, 5.3999, 0.0000, 88.6998); //wall096
	org_polis_map[29] = CreateObject(19456, 846.4311, -2214.9863, 14.0900, 1.6000, 0.0000, 88.6998); //wall096
	org_polis_map[30] = CreateObject(19456, 836.9478, -2214.7529, 13.8388, -4.4999, -0.2999, 87.2998); //wall096
	org_polis_map[31] = CreateObject(19456, 827.3745, -2214.8776, 13.3049, -2.6000, -0.4000, 93.8998); //wall096
	org_polis_map[32] = CreateObject(19456, 825.4810, -2215.0078, 13.2187, -2.6000, -0.4000, 93.8998); //wall096
	org_polis_map[33] = CreateObject(19456, 821.3204, -2220.1347, 13.0662, 0.9999, -0.4000, 177.2997); //wall096
	org_polis_map[34] = CreateObject(19456, 820.8676, -2229.7358, 13.2340, 0.9999, -0.4000, 177.2997); //wall096
	org_polis_map[35] = CreateObject(19456, 815.8466, -2234.5383, 13.4324, -0.2000, -0.4000, -87.6003); //wall096
	org_polis_map[36] = CreateObject(19456, 806.3215, -2233.8991, 13.4584, -0.2000, -0.4000, -99.5002); //wall096
	org_polis_map[37] = CreateObject(19456, 801.1114, -2228.3315, 13.4730, -0.2000, -0.4000, -174.8003); //wall096
	org_polis_map[38] = CreateObject(19456, 801.1009, -2218.7968, 13.5007, -0.2000, -0.4000, 173.7996); //wall096
	org_polis_map[39] = CreateObject(19456, 801.9768, -2210.7346, 13.5290, -0.2000, -0.4000, 173.7996); //wall096
	org_polis_map[40] = CreateObject(19456, 807.1378, -2205.9921, 13.5425, -0.2000, -0.4000, -89.4003); //wall096
	org_polis_map[41] = CreateObject(19456, 816.3229, -2206.1679, 13.5123, -0.2000, -0.4000, -93.0003); //wall096
	org_polis_map[42] = CreateObject(19456, 821.1452, -2201.6096, 13.4992, -0.2000, 0.1999, -1.2003); //wall096
	org_polis_map[43] = CreateObject(19456, 821.3460, -2192.0058, 13.4657, -0.2000, 0.1999, -1.2003); //wall096
	org_polis_map[44] = CreateObject(19372, 806.3635, -2217.1884, 13.2469, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[45] = CreateObject(19372, 806.3635, -2216.5278, 13.2469, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[46] = CreateObject(19372, 806.3635, -2216.5278, 14.4669, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[47] = CreateObject(19372, 806.3635, -2217.1984, 14.4669, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[48] = CreateObject(19372, 806.3635, -2220.5007, 14.4669, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[49] = CreateObject(19372, 806.3635, -2223.6831, 14.4669, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[50] = CreateObject(19372, 806.3635, -2226.8659, 14.4669, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[51] = CreateObject(19372, 806.3635, -2226.8659, 13.2369, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[52] = CreateObject(19372, 806.3635, -2223.8627, 13.2369, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[53] = CreateObject(19372, 806.3635, -2220.7404, 13.2369, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[54] = CreateObject(19372, 806.3635, -2220.0698, 13.2369, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[55] = CreateObject(19372, 806.3635, -2229.9931, 13.2369, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[56] = CreateObject(19372, 806.3635, -2232.2749, 13.2369, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[57] = CreateObject(19372, 806.3635, -2229.9025, 14.4669, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[58] = CreateObject(19372, 806.3635, -2232.2233, 14.4669, 0.0000, 0.0000, 0.0000); //wall020
	org_polis_map[59] = CreateObject(19448, 808.0089, -2219.1245, 16.1524, 0.0000, -90.3999, 0.0000); //wall088
	org_polis_map[60] = CreateObject(19448, 811.4700, -2219.1245, 16.1766, 0.0000, -90.3999, 0.0000); //wall088
	org_polis_map[61] = CreateObject(19448, 814.9720, -2219.1320, 16.2010, 0.0000, -90.3999, 0.0000); //wall088
	org_polis_map[62] = CreateObject(19448, 814.9720, -2228.4829, 16.2010, 0.0000, -90.3999, 0.0000); //wall088
	org_polis_map[63] = CreateObject(19448, 811.5715, -2228.4829, 16.1773, 0.0000, -90.3999, 0.0000); //wall088
	org_polis_map[64] = CreateObject(19448, 808.0100, -2228.4829, 16.1524, 0.0000, -90.3999, 0.0000); //wall088
	org_polis_map[65] = CreateObject(19448, 808.1401, -2231.8461, 16.1533, 0.0000, -90.3999, 0.0000); //wall088
	org_polis_map[66] = CreateObject(19448, 811.5714, -2231.8461, 16.1773, 0.0000, -90.3999, 0.0000); //wall088
	org_polis_map[67] = CreateObject(19448, 814.9522, -2231.8461, 16.2009, 0.0000, -90.3999, 0.0000); //wall088
	org_polis_map[68] = CreateObject(19456, 806.3266, -2233.8955, 14.3484, -0.2000, -0.4000, -99.5002); //wall096
	org_polis_map[69] = CreateObject(19456, 810.0657, -2234.7749, 14.3426, -0.2000, -0.4000, -87.6003); //wall096
	org_polis_map[70] = CreateObject(2332, 806.8642, -2233.3703, 12.3213, -6.5999, 0.0000, 84.9000); //KEV_SAFE
	org_polis_map[71] = CreateObject(1516, 813.1654, -2233.9672, 12.0589, 0.0000, 0.0000, 3.2999); //DYN_TABLE_03
	org_polis_map[72] = CreateObject(2121, 814.2013, -2234.0129, 12.3348, 0.0000, 0.0000, -121.5000); //LOW_DIN_CHAIR_2
	org_polis_map[73] = CreateObject(2121, 812.2001, -2234.1755, 12.3348, 0.0000, 0.0000, 134.9000); //LOW_DIN_CHAIR_2
	org_polis_map[74] = CreateObject(346, 807.2625, -2227.7827, 13.8877, 0.0000, 0.0000, 0.0000); //colt45
	org_polis_map[75] = CreateObject(352, 807.7393, -2227.6801, 14.0065, 0.0000, 0.0000, 0.0000); //micro_uzi
	org_polis_map[76] = CreateObject(355, 808.3985, -2227.7333, 13.7307, -6.6999, -88.4999, 0.0000); //ak47
	org_polis_map[77] = CreateObject(351, 808.8437, -2227.8222, 13.7019, -6.9999, -83.9999, 0.3999); //shotgspa
	org_polis_map[78] = CreateObject(359, 808.0968, -2227.7177, 12.9371, 3.8000, -14.3000, 0.0000); //rocketla
	org_polis_map[79] = CreateObject(356, 807.1082, -2227.6887, 13.3075, 0.0000, 0.0000, 0.0000); //m4
	org_polis_map[80] = CreateObject(358, 808.6914, -2227.7578, 12.9399, 0.0000, 0.0000, 0.0000); //sniper
	org_polis_map[81] = CreateObject(2891, 813.4567, -2234.2753, 12.4803, 0.0000, 0.0000, 0.0000); //kmb_packet
	org_polis_map[82] = CreateObject(2891, 813.4281, -2234.2351, 12.6603, 0.0000, 0.0000, 25.6999); //kmb_packet
	org_polis_map[83] = CreateObject(2056, 810.5335, -2227.8999, 14.0302, 0.0000, 0.0000, 0.0000); //CJ_TARGET6
	org_polis_map[84] = CreateObject(19893, 813.3764, -2233.7109, 12.6372, 0.0000, 0.0000, 118.3000); //LaptopSAMP1
	org_polis_map[85] = CreateObject(19820, 812.9406, -2234.2119, 12.5537, 0.0000, 0.0000, 0.0000); //AlcoholBottle1
	org_polis_map[86] = CreateObject(18634, 813.1333, -2227.9772, 13.2876, 90.9999, 0.0000, -80.9000); //GTASACrowbar1
	org_polis_map[87] = CreateObject(2045, 812.8077, -2227.9025, 13.4939, 89.7999, -0.1000, 83.5000); //CJ_BBAT_NAILS
	org_polis_map[88] = CreateObject(19914, 813.4517, -2227.9653, 13.1399, 0.0000, -89.3000, 0.0000); //CutsceneBat1
	org_polis_map[89] = CreateObject(19631, 813.1321, -2227.8872, 14.0829, 0.0000, 0.0000, 88.6999); //SledgeHammer1
	org_polis_map[90] = CreateObject(2228, 813.7685, -2228.0424, 12.3415, -15.9000, 0.0000, 0.0000); //CJ_SHOVEL
	org_polis_map[91] = CreateObject(19626, 813.2845, -2228.0441, 12.6196, -19.7000, 0.0000, 0.0000); //Spade1
	org_polis_map[92] = CreateObject(2609, 806.8875, -2229.1604, 12.5384, 0.0000, 0.0000, 87.2999); //CJ_P_FILEING1
	org_polis_map[93] = CreateObject(2609, 806.8662, -2229.6103, 12.5384, 0.0000, 0.0000, 87.2999); //CJ_P_FILEING1
	org_polis_map[94] = CreateObject(1738, 806.5758, -2228.2351, 12.2870, 0.0000, 0.0000, 85.4999); //CJ_Radiator_old
	org_polis_map[95] = CreateObject(1744, 813.7731, -2234.6105, 14.0663, 0.0000, 0.0000, -176.3999); //MED_SHELF
	org_polis_map[96] = CreateObject(19940, 809.6839, -2234.2155, 13.3845, 0.0000, 0.0000, 80.7000); //MKShelf3
	org_polis_map[97] = CreateObject(1242, 806.5787, -2233.6613, 12.9471, 0.0000, 1.9000, -61.3999); //bodyarmour
	org_polis_map[98] = CreateObject(1242, 806.5740, -2233.4025, 12.9547, 0.0000, 1.9000, -61.3999); //bodyarmour
	org_polis_map[99] = CreateObject(335, 806.9981, -2233.2512, 12.7692, 74.4999, -91.0999, -37.1000); //knifecur
	org_polis_map[100] = CreateObject(339, 814.9143, -2231.2192, 13.1199, 0.0000, 0.0000, 82.3999); //katana
	org_polis_map[101] = CreateObject(339, 814.8864, -2231.4282, 13.2999, 0.0000, 0.0000, 82.3999); //katana
	org_polis_map[102] = CreateObject(339, 814.8584, -2231.6374, 13.1299, 0.0000, 0.0000, 82.3999); //katana
	org_polis_map[103] = CreateObject(331, 806.8371, -2233.6059, 12.8084, 92.7000, 0.0000, 0.0000); //brassknuckle
	org_polis_map[104] = CreateObject(341, 812.8459, -2234.4052, 14.6455, 0.0000, 35.3999, 0.0000); //chnsaw
	org_polis_map[105] = CreateObject(342, 810.3176, -2234.4455, 13.4535, 0.0000, 0.0000, 0.0000); //grenade
	org_polis_map[106] = CreateObject(343, 809.9007, -2234.3395, 13.4684, 0.0000, 0.0000, 0.0000); //teargas
	org_polis_map[107] = CreateObject(344, 810.1079, -2234.3703, 13.5934, 0.0000, 0.0000, 0.0000); //molotov
	org_polis_map[108] = CreateObject(344, 810.1779, -2234.4404, 13.5934, 0.0000, 0.0000, 0.0000); //molotov
	org_polis_map[109] = CreateObject(367, 808.7640, -2234.1796, 13.4162, 0.0000, 0.0000, 0.0000); //camera
	org_polis_map[110] = CreateObject(368, 809.1605, -2234.1386, 13.3481, 0.0000, -92.2999, 0.0000); //nvgoggles
	org_polis_map[111] = CreateObject(2116, 807.6394, -2226.8845, 11.6371, 0.0000, 0.0000, 0.0000); //LOW_DINNING_6
	org_polis_map[112] = CreateObject(14772, 808.6346, -2226.8020, 12.6084, 0.0000, 0.0000, 179.8000); //int3int_LOW_TV
	org_polis_map[113] = CreateObject(1790, 807.9116, -2226.8315, 12.4533, 0.0000, 0.0000, 0.0000); //SWANK_VIDEO_3
	org_polis_map[114] = CreateObject(19590, 814.8385, -2232.6542, 13.1490, 0.0000, 0.0000, 0.0000); //WooziesSword1
	org_polis_map[115] = CreateObject(19590, 814.8385, -2232.6542, 13.4290, 0.0000, 0.0000, 0.0000); //WooziesSword1
	org_polis_map[116] = CreateObject(19590, 814.8385, -2232.6542, 13.7490, 0.0000, 0.0000, 0.0000); //WooziesSword1
	org_polis_map[117] = CreateObject(1757, 807.0632, -2225.1530, 11.5820, 0.0000, 0.0000, 0.0000); //LOW_COUCH_5
	org_polis_map[118] = CreateObject(19914, 806.8013, -2226.7272, 11.8240, 0.0000, -60.7000, 0.0000); //CutsceneBat1
	org_polis_map[119] = CreateObject(2231, 809.2612, -2227.5451, 11.6614, 0.0000, 0.0000, -178.6999); //SWANK_SPEAKER_3
	org_polis_map[120] = CreateObject(2231, 809.2612, -2227.5451, 12.5514, 0.0000, 0.0000, -178.6999); //SWANK_SPEAKER_3
	org_polis_map[121] = CreateObject(2840, 808.3197, -2223.3046, 11.7629, 0.0000, 0.0000, 0.0000); //GB_takeaway05
	org_polis_map[122] = CreateObject(2840, 811.4105, -2220.4655, 11.7629, 0.0000, 0.0000, 22.3000); //GB_takeaway05
	org_polis_map[123] = CreateObject(2051, 811.5512, -2227.8515, 14.2428, 0.0000, 0.0000, 0.0000); //CJ_TARGET4
	org_polis_map[124] = CreateObject(2964, 809.5872, -2221.8425, 11.7101, 0.0000, 0.0000, 0.0000); //k_pooltablesm
	org_polis_map[125] = CreateObject(338, 808.9588, -2221.1318, 12.1400, 0.0000, 0.0000, 0.0000); //poolcue
	org_polis_map[126] = CreateObject(338, 809.8590, -2221.1318, 12.1400, 0.0000, 0.0000, 0.0000); //poolcue
	org_polis_map[127] = CreateObject(338, 809.8590, -2222.5124, 12.1400, 0.0000, 0.0000, 0.0000); //poolcue
	org_polis_map[128] = CreateObject(338, 809.1284, -2222.5124, 12.1500, 0.0000, 0.0000, 0.0000); //poolcue
	org_polis_map[129] = CreateObject(2995, 809.9627, -2221.4465, 12.6405, 0.0000, 0.0000, 0.0000); //k_poolballstp01
	org_polis_map[130] = CreateObject(2995, 809.2023, -2221.6467, 12.6405, 0.0000, 0.0000, 0.0000); //k_poolballstp01
	org_polis_map[131] = CreateObject(2995, 809.5024, -2221.9270, 12.6405, 0.0000, 0.0000, 0.0000); //k_poolballstp01
	org_polis_map[132] = CreateObject(2998, 809.7907, -2221.6906, 12.6495, 0.0000, 0.0000, 0.0000); //k_poolballstp04
	org_polis_map[133] = CreateObject(3104, 810.3426, -2221.9592, 12.6651, 0.0000, 0.0000, 0.0000); //k_poolballspt06
	org_polis_map[134] = CreateObject(2241, 815.9122, -2224.6667, 12.1775, 0.0000, 0.0000, 0.0000); //Plant_Pot_5
	org_polis_map[135] = CreateObject(2241, 815.9122, -2214.7565, 12.1775, 0.0000, 0.0000, 0.0000); //Plant_Pot_5
	org_polis_map[136] = CreateObject(2286, 809.3375, -2219.1967, 14.1987, 0.0000, 0.0000, 0.0000); //Frame_5
	org_polis_map[137] = CreateObject(1895, 815.0735, -2224.8559, 14.0519, 0.0000, 0.0000, -86.6999); //wheel_o_fortune
	org_polis_map[138] = CreateObject(912, 814.6656, -2226.8757, 12.3359, 0.0000, 0.0000, -93.2999); //BUST_CABINET_2
	org_polis_map[139] = CreateObject(1744, 813.0942, -2227.8664, 13.3686, 0.0000, 0.0000, 178.4999); //MED_SHELF
	org_polis_map[140] = CreateObject(19173, 806.5865, -2223.4191, 14.0599, 0.0000, 0.0000, -92.6999); //SAMPPicture2
	org_polis_map[141] = CreateObject(2737, 813.0954, -2219.3322, 14.0535, 0.0000, 0.0000, 0.0000); //POLICE_NB_car
	org_polis_map[142] = CreateObject(2162, 812.4941, -2219.2548, 11.8184, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_1
	org_polis_map[143] = CreateObject(1896, 812.5480, -2224.7246, 12.5957, 0.0000, 0.0000, 84.9999); //wheel_table
	org_polis_map[144] = CreateObject(1805, 811.5435, -2224.6315, 11.9171, 0.0000, 0.0000, 0.0000); //CJ_BARSTOOL
	org_polis_map[145] = CreateObject(1805, 812.6038, -2226.2932, 11.9171, 0.0000, 0.0000, 0.0000); //CJ_BARSTOOL
	org_polis_map[146] = CreateObject(1805, 813.1842, -2224.9519, 11.9171, 0.0000, 0.0000, 0.0000); //CJ_BARSTOOL
	org_polis_map[147] = CreateObject(1805, 812.5843, -2223.5812, 11.9171, 0.0000, 0.0000, 0.0000); //CJ_BARSTOOL
	org_polis_map[148] = CreateObject(2372, 807.1448, -2217.5493, 11.6987, 0.0000, 0.0000, 0.0000); //CLOTHES_RAIL2
	org_polis_map[149] = CreateObject(2381, 806.9172, -2216.9404, 12.3032, 0.0000, 0.0000, 90.0999); //CJ_8_SWEATER
	org_polis_map[150] = CreateObject(1704, 809.8602, -2215.6394, 11.6316, 0.0000, 0.0000, 0.0000); //kb_chair03
	org_polis_map[151] = CreateObject(1657, 810.1647, -2217.2031, 15.8755, 0.0000, 0.0000, 0.0000); //htl_fan_rotate_nt
	org_polis_map[152] = CreateObject(1657, 810.1647, -2223.4379, 15.8755, 0.0000, 0.0000, 0.0000); //htl_fan_rotate_nt
	org_polis_map[153] = CreateObject(1657, 810.1647, -2229.4528, 15.8755, 0.0000, 0.0000, 0.0000); //htl_fan_rotate_nt
	org_polis_map[154] = CreateObject(1808, 806.7180, -2219.2177, 11.7472, 0.0000, 0.0000, 0.0000); //CJ_WATERCOOLER2
	org_polis_map[155] = CreateObject(1828, 811.7481, -2217.3327, 11.8450, 0.0000, 0.0000, 0.0000); //man_sdr_rug
	org_polis_map[156] = CreateObject(1851, 814.4584, -2226.5898, 13.0982, 0.0000, 0.0000, 0.0000); //dice1
	org_polis_map[157] = CreateObject(2689, 808.4273, -2215.0673, 13.2502, 0.0000, 0.0000, 0.0000); //CJ_HOODIE_2
	org_polis_map[158] = CreateObject(2689, 807.5269, -2215.0673, 13.2502, 0.0000, 0.0000, 0.0000); //CJ_HOODIE_2
	org_polis_map[159] = CreateObject(2704, 808.0122, -2215.0617, 14.2861, 0.0000, 0.0000, 0.0000); //CJ_HOODIE_3
	org_polis_map[160] = CreateObject(2705, 806.5090, -2217.1992, 13.7829, 0.0000, 0.0000, 90.8998); //CJ_HOODIE_04
	org_polis_map[161] = CreateObject(2705, 806.5002, -2216.6486, 13.7829, 0.0000, 0.0000, 90.8998); //CJ_HOODIE_04
	org_polis_map[162] = CreateObject(2706, 806.4981, -2216.9069, 14.6418, 0.0000, 0.0000, 92.4999); //CJ_HOODIE_05
	org_polis_map[163] = CreateObject(2286, 812.7316, -2215.3422, 13.4682, 0.0000, 0.0000, -1.3000); //Frame_5
	org_polis_map[164] = CreateObject(1744, 809.1085, -2219.0187, 12.8935, 0.0000, 0.0000, 177.9000); //MED_SHELF
	org_polis_map[165] = CreateObject(1744, 812.5656, -2219.1530, 12.8935, 0.0000, 0.0000, 177.9000); //MED_SHELF
	org_polis_map[166] = CreateObject(18927, 812.4715, -2218.8999, 13.2699, 0.0000, -88.3998, 0.0000); //Hat2
	org_polis_map[167] = CreateObject(18961, 812.1426, -2224.9470, 10.1473, 0.0000, 0.0000, 0.0000); //CapTrucker1
	org_polis_map[168] = CreateObject(18961, 812.1426, -2218.7783, 13.2573, 0.0000, 0.0000, 0.0000); //CapTrucker1
	org_polis_map[169] = CreateObject(18968, 811.7308, -2218.7360, 13.2797, 0.0000, 0.0000, 0.0000); //HatMan2
	org_polis_map[170] = CreateObject(19139, 809.2260, -2218.7536, 13.2632, 0.0000, 0.0000, 0.0000); //PoliceGlasses2
	org_polis_map[171] = CreateObject(19006, 808.8937, -2218.7351, 13.2669, 0.0000, 0.0000, 33.2000); //GlassesType1
	org_polis_map[172] = CreateObject(19555, 808.5291, -2218.7839, 13.3405, 0.0000, 0.0000, 0.0000); //BoxingGloveL
	org_polis_map[173] = CreateObject(19555, 808.3489, -2218.7839, 13.3405, 0.0000, 0.0000, 0.0000); //BoxingGloveL
	org_polis_map[174] = CreateObject(1083, 859.4863, -2208.4975, 12.0000, 0.0000, -146.6999, 0.0000); //wheel_lr2
	org_polis_map[175] = CreateObject(19880, 859.7183, -2211.6530, 15.0039, 93.0000, -8.1999, 97.4999); //WellsFargoGrgDoor1
	org_polis_map[176] = CreateObject(928, 829.4430, -2214.2287, 11.9331, 0.0000, 0.0000, 0.0000); //RUBBISH_BOX1
	org_polis_map[177] = CreateObject(19880, 854.8650, -2211.5842, 15.2557, 93.0000, -8.1999, 97.4999); //WellsFargoGrgDoor1
	org_polis_map[178] = CreateObject(928, 823.9729, -2214.2287, 11.9331, 0.0000, 0.0000, 7.7999); //RUBBISH_BOX1
	org_polis_map[179] = CreateObject(1328, 826.9950, -2213.9641, 12.3680, 0.0000, 0.0000, 0.0000); //BinNt10_LA
	org_polis_map[180] = CreateObject(1357, 832.7485, -2206.8952, 11.9904, 0.0000, 0.0000, 0.0000); //CJ_FRUITCRATE3
	org_polis_map[181] = CreateObject(1327, 803.2167, -2207.2619, 12.5058, 0.0000, -14.0000, 0.0000); //junk_tyre
	org_polis_map[182] = CreateObject(1236, 805.6959, -2206.7172, 12.5181, 0.0000, 0.0000, 0.0000); //rcyclbank01
	org_polis_map[183] = CreateObject(1441, 811.1879, -2206.0527, 12.6616, 0.0000, 0.0000, 0.0000); //DYN_BOX_PILE_4
	org_polis_map[184] = CreateObject(1441, 811.7184, -2206.0527, 12.6616, 0.0000, 0.0000, 0.0000); //DYN_BOX_PILE_4
	org_polis_map[185] = CreateObject(1441, 810.4676, -2206.0527, 12.6616, 0.0000, 0.0000, 0.0000); //DYN_BOX_PILE_4
	org_polis_map[186] = CreateObject(1411, 833.7121, -2187.8190, 13.0675, 0.0000, 0.0000, 0.0000); //DYN_MESH_1
	org_polis_map[187] = CreateObject(1411, 821.7199, -2187.0639, 13.0675, 0.0000, 0.0000, -56.8000); //DYN_MESH_1
	org_polis_map[188] = CreateObject(1423, 823.1892, -2185.9643, 12.5752, 0.0000, 0.0000, 0.0000); //DYN_ROADBARRIER_4
	org_polis_map[189] = CreateObject(1423, 831.2698, -2175.7341, 12.5752, 0.0000, 0.0000, 0.0000); //DYN_ROADBARRIER_4
	org_polis_map[190] = CreateObject(1423, 828.9387, -2175.7341, 12.5752, 0.0000, 0.0000, 0.0000); //DYN_ROADBARRIER_4
	org_polis_map[191] = CreateObject(981, 830.1066, -2143.4082, 12.6884, 0.0000, 0.0000, 85.4999); //helix_barrier
	org_polis_map[192] = CreateObject(19868, 834.2838, -2188.0842, 11.7660, 0.0000, 0.0000, 0.0000); //MeshFence1
	org_polis_map[193] = CreateObject(19868, 822.0289, -2187.6376, 11.7660, 0.0000, 0.0000, -37.9999); //MeshFence1
	org_polis_pickup[0] = CreatePickup(1098, 1, 854.5042, -2211.7297, 12.3822, -1); //wheel_gn5

	//===========================================================
	carro_poli_map[0] = CreateObject(1447, 828.1455, -2045.7020, 11.8671, 0.0000, 0.0000, 0.0000); //DYN_MESH_4
	carro_poli_map[1] = CreateObject(1447, 828.1455, -2045.7020, 11.8671, 0.0000, 0.0000, 0.0000); //DYN_MESH_4
	carro_poli_map[2] = CreateObject(1447, 828.1455, -2045.7020, 11.8671, 0.0000, 0.0000, 0.0000); //DYN_MESH_4
	carro_poli_map[3] = CreateObject(1447, 828.1455, -2045.7020, 11.8671, 0.0000, 0.0000, 0.0000); //DYN_MESH_4
	carro_poli_map[4] = CreateObject(1411, 836.8659, -2039.8143, 12.2510, 0.0000, 0.0000, 0.0000); //DYN_MESH_1
	carro_poli_map[5] = CreateObject(1411, 836.8659, -2039.8143, 12.2510, 0.0000, 0.0000, 0.0000); //DYN_MESH_1
	carro_poli_map[6] = CreateObject(1411, 836.8659, -2039.8143, 12.2510, 0.0000, 0.0000, 0.0000); //DYN_MESH_1
	carro_poli_map[7] = CreateObject(1411, 836.8659, -2039.8143, 12.2510, 0.0000, 0.0000, 0.0000); //DYN_MESH_1
	carro_poli_map[8] = CreateObject(3475, 827.8796, -2047.0432, 12.1427, 0.0000, 0.0000, -32.0000); //vgsn_fncelec_pst
	carro_poli_map[9] = CreateObject(3475, 827.8796, -2047.0432, 12.1427, 0.0000, 0.0000, -32.0000); //vgsn_fncelec_pst
	carro_poli_map[10] = CreateObject(3475, 827.8796, -2047.0432, 12.1427, 0.0000, 0.0000, -32.0000); //vgsn_fncelec_pst
	carro_poli_map[11] = CreateObject(3092, 834.5933, -2031.3021, 11.7628, 0.0000, 0.0000, 0.0000); //dead_tied_cop
	carro_poli_map[12] = CreateObject(362, 832.5905, -2031.5570, 12.3937, 0.0000, 0.0000, 0.0000); //minigun
	carro_poli_map[13] = CreateObject(355, 833.0140, -2031.8284, 10.4129, 0.0000, 0.0000, 0.0000); //ak47
	carro_poli_map[14] = CreateObject(2905, 833.7327, -2032.9068, 12.7667, 0.0000, 0.0000, 0.0000); //kmb_deadleg
	carro_poli_map[15] = CreateObject(2908, 832.0805, -2030.3797, 12.3941, 0.0000, 0.0000, 0.0000); //kmb_deadhead
	carro_poli_map[16] = CreateObject(2908, 832.0805, -2030.3797, 12.3941, 0.0000, 0.0000, 0.0000); //kmb_deadhead
	carro_poli_map[17] = CreateObject(2905, 833.7327, -2032.9068, 12.7667, 0.0000, 0.0000, 0.0000); //kmb_deadleg
	carro_poli_map[18] = CreateObject(2905, 833.7327, -2032.9068, 12.7667, 0.0000, 0.0000, 0.0000); //kmb_deadleg
	carro_poli_map[19] = CreateObject(2907, 831.4205, -2032.5407, 12.3732, 0.0000, 0.0000, 0.0000); //kmb_deadtorso
	carro_poli_map[20] = CreateObject(2907, 831.4205, -2032.5407, 12.3732, 0.0000, 0.0000, 0.0000); //kmb_deadtorso
	carro_poli_map[21] = CreateObject(2907, 831.4205, -2032.5407, 12.3732, 0.0000, 0.0000, 0.0000); //kmb_deadtorso
	carro_poli_map[22] = CreateObject(2036, 834.4906, -2033.5343, 12.0086, 0.0000, 0.0000, 0.0000); //CJ_psg1
	carro_poli_map[23] = CreateObject(371, 832.1422, -2032.8459, 11.9623, 0.0000, 0.0000, 0.0000); //gun_para
	carro_poli_map[24] = CreateObject(360, 831.2772, -2033.4294, 12.2006, 0.0000, 0.0000, 0.0000); //heatseek
	carro_poli_map[25] = CreateObject(355, 833.0140, -2031.8284, 10.4129, 0.0000, 0.0000, 0.0000); //ak47
	carro_poli_map[26] = CreateObject(1238, 835.8474, -2027.0920, 10.8846, 0.0000, 0.0000, 0.0000); //trafficcone
	carro_poli_map[27] = CreateObject(1238, 835.8474, -2027.0920, 10.8846, 0.0000, 0.0000, 0.0000); //trafficcone
	carro_poli_veiculo[0] = CreateVehicle(431, 833.7493, -2033.8403, 12.9775, 347.6410, 248, 33, -1); //Bus
	AttachObjectToVehicle(carro_poli_map[0], carro_poli_veiculo[0], -1.4199, -3.0499, 0.4399, 0.0000, 0.0000, 88.8999);
	AttachObjectToVehicle(carro_poli_map[1], carro_poli_veiculo[0], -1.4199, 1.8799, 0.4399, 0.0000, 0.0000, 88.8999);
	AttachObjectToVehicle(carro_poli_map[2], carro_poli_veiculo[0], 1.4000, 1.8799, 0.4399, 0.0000, 0.0000, 271.4999);
	AttachObjectToVehicle(carro_poli_map[3], carro_poli_veiculo[0], 1.4000, -2.9700, 0.4399, 0.0000, 0.0000, 271.4999);
	AttachObjectToVehicle(carro_poli_map[4], carro_poli_veiculo[0], 1.2699, -2.7399, 1.1799, 348.7999, 0.0000, 270.1999);
	AttachObjectToVehicle(carro_poli_map[5], carro_poli_veiculo[0], 1.2699, 1.8700, 1.1799, 348.7999, 0.0000, 270.1999);
	AttachObjectToVehicle(carro_poli_map[6], carro_poli_veiculo[0], -1.2200, 1.8400, 1.1799, 348.7999, 0.0000, 89.7999);
	AttachObjectToVehicle(carro_poli_map[7], carro_poli_veiculo[0], -1.2200, -2.6199, 1.1799, 348.7999, 0.0000, 89.7999);
	AttachObjectToVehicle(carro_poli_map[8], carro_poli_veiculo[0], -0.5699, -4.2900, 0.0000, 0.0000, 0.0000, 0.0000);
	AttachObjectToVehicle(carro_poli_map[9], carro_poli_veiculo[0], 0.2199, -4.2900, 0.0000, 0.0000, 0.0000, 0.0000);
	AttachObjectToVehicle(carro_poli_map[10], carro_poli_veiculo[0], 1.0099, -4.2900, 0.0000, 0.0000, 0.0000, 0.0000);
	AttachObjectToVehicle(carro_poli_map[11], carro_poli_veiculo[0], 0.0000, 6.0999, 0.2300, 0.0000, 0.0000, 0.0000);
	AttachObjectToVehicle(carro_poli_map[12], carro_poli_veiculo[0], 0.0000, 5.1399, 2.3699, 0.0000, 21.9000, 94.5999);
	AttachObjectToVehicle(carro_poli_map[13], carro_poli_veiculo[0], 1.4700, 0.0000, 0.0000, 0.0000, 0.0000, 275.7999);
	AttachObjectToVehicle(carro_poli_map[14], carro_poli_veiculo[0], -1.4800, 2.4199, 0.6499, 313.6000, 87.8999, 0.0000);
	AttachObjectToVehicle(carro_poli_map[15], carro_poli_veiculo[0], -0.0200, -7.2499, 0.5199, 231.4999, 284.1000, 2.2000);
	AttachObjectToVehicle(carro_poli_map[16], carro_poli_veiculo[0], 0.7599, -7.2299, 1.5099, 231.4999, 284.1000, 2.2000);
	AttachObjectToVehicle(carro_poli_map[17], carro_poli_veiculo[0], -1.4800, -3.9400, 0.6499, 71.0999, 87.8999, 0.0000);
	AttachObjectToVehicle(carro_poli_map[18], carro_poli_veiculo[0], -1.4800, 3.3799, 1.0999, 39.5999, 87.8999, 0.0000);
	AttachObjectToVehicle(carro_poli_map[19], carro_poli_veiculo[0], -1.6700, 0.0000, 0.0000, 9.5000, 279.0000, 0.0000);
	AttachObjectToVehicle(carro_poli_map[20], carro_poli_veiculo[0], -0.0400, -6.9400, -0.5199, 336.6000, 279.0000, 0.0000);
	AttachObjectToVehicle(carro_poli_map[21], carro_poli_veiculo[0], -1.6700, -2.4599, 1.0499, 87.4999, 279.0000, 0.0000);
	AttachObjectToVehicle(carro_poli_map[22], carro_poli_veiculo[0], 1.5199, 0.0000, 0.7399, 19.3000, 98.9999, 0.0000);
	AttachObjectToVehicle(carro_poli_map[23], carro_poli_veiculo[0], 1.5599, 1.1299, 0.6999, 0.0000, 0.0000, 90.2999);
	AttachObjectToVehicle(carro_poli_map[24], carro_poli_veiculo[0], 1.6100, -1.9999, 0.6199, 3.5999, 5.6000, 84.6999);
	AttachObjectToVehicle(carro_poli_map[25], carro_poli_veiculo[0], 1.4700, 3.2099, 0.3599, 0.0000, 331.5000, 275.7999);
	AttachObjectToVehicle(carro_poli_map[26], carro_poli_veiculo[0], -0.9099, 6.1899, 0.0000, 271.7999, 357.0000, 0.0000);
	AttachObjectToVehicle(carro_poli_map[27], carro_poli_veiculo[0], 0.9000, 6.2299, -0.0099, 271.7999, 356.2999, 0.0000);

	//===================================================================================CIVIL =======================

	new tmpobjid, object_world = -1, object_int = -1;
	tmpobjid = CreateDynamicObject(19445, 1710.935668, -1136.663085, 27.789840, 89.999992, 270.000000, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1138.343750, 24.849838, 0.000007, 0.000014, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1138.343750, 28.339843, 0.000007, 0.000014, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1140.143554, 27.629837, -0.000007, 270.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1143.593750, 27.629837, 0.000007, 270.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.605224, -1146.093505, 27.629837, 0.000000, 270.000000, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1716.035522, -1146.093505, 27.629837, 0.000000, 270.000000, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.505249, -1146.093505, 27.629837, 0.000000, 270.000000, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.915283, -1146.093505, 27.629837, 0.000000, 270.000000, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1724.585327, -1146.093505, 28.469833, 0.000000, 180.000015, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1724.585327, -1146.093505, 25.189842, 0.000000, 180.000015, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1724.585327, -1146.093505, 24.359840, 0.000000, 180.000015, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1712.386352, -1136.663085, 27.789840, 89.999992, 270.000000, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1710.934692, -1139.733032, 31.839843, 0.000000, 360.000000, -179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19445, 1710.935668, -1142.103637, 31.839843, 0.000000, 360.000000, -179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19445, 1715.825439, -1146.903930, 31.839843, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19445, 1719.828735, -1146.901000, 31.839843, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1134.973144, 24.849838, 0.000007, 0.000014, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1134.973144, 28.299835, 0.000007, 0.000014, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1134.973144, 30.829833, 0.000007, 0.000014, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1712.386352, -1130.114624, 30.789840, 0.000000, 360.000000, -179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1712.386352, -1130.094604, 22.259841, 0.000000, 360.000000, -179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1710.885498, -1130.114624, 30.789840, 0.000000, 360.000000, -179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1712.386352, -1129.834228, 22.259841, 0.000000, 360.000000, -179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1125.143066, 24.849838, 0.000007, 0.000014, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1125.143066, 28.329833, 0.000007, 0.000014, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1121.151489, 24.849838, 0.000014, 0.000014, 89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1121.151489, 28.339843, 0.000014, 0.000014, 89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1712.386352, -1126.553466, 30.789840, 0.000000, 360.000000, -179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1710.885498, -1125.933715, 30.789840, 0.000000, 360.000000, -179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.955566, -1124.402832, 22.719825, 0.000000, 360.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.955566, -1122.852416, 22.719825, 0.000000, 360.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.955566, -1121.981811, 22.719825, 0.000000, 360.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.955566, -1124.402832, 29.679824, 0.000000, 360.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.955566, -1122.021728, 29.679824, 0.000000, 360.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1121.151489, 30.859832, 0.000014, 0.000014, 89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1729.435546, -1145.353149, 28.429840, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1729.435546, -1145.353149, 24.959838, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1729.435546, -1145.353149, 21.559844, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1725.305664, -1146.833740, 28.439834, 0.000007, 180.000015, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19426, 1725.305664, -1146.832763, 25.059837, 0.000007, 180.000015, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19426, 1725.305664, -1146.833740, 24.699836, 0.000007, 180.000015, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19426, 1726.066040, -1146.123291, 24.699836, 0.000000, 540.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19426, 1726.066040, -1146.123291, 28.099838, 0.000000, 540.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19426, 1726.067016, -1146.123291, 28.419830, 0.000000, 540.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19325, 1712.314575, -1139.140991, 26.739822, 89.999992, 450.000000, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(19325, 1712.314575, -1139.140991, 20.099822, 89.999992, 450.000000, -89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(19325, 1712.314575, -1143.250976, 26.739822, 89.999992, 450.000000, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(19325, 1721.000976, -1145.317993, 26.739822, 89.999992, 533.225952, -83.225975, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(19325, 1712.314575, -1143.250976, 20.099822, 89.999992, 450.000000, -89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(19325, 1721.000976, -1145.317993, 20.099822, 89.999992, 533.225952, -83.225975, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(19325, 1725.110961, -1145.317993, 26.739822, 89.999992, 533.225952, -83.225975, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(19325, 1725.110961, -1145.317993, 20.099822, 89.999992, 533.225952, -83.225975, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(19325, 1715.629028, -1145.317993, 27.709815, -0.000007, 540.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(1499, 1712.290649, -1145.273803, 23.149833, 0.000000, 0.000014, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 1715.230346, -1145.273803, 23.149841, 0.000000, -0.000014, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19325, 1717.130737, -1145.317993, 22.329811, 89.999992, 533.225952, -83.225975, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(14397, 1711.350830, -1144.934814, 14.819839, 0.000000, 90.000015, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(14397, 1711.350830, -1141.374877, 14.819839, 0.000000, 90.000015, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(14397, 1711.450683, -1137.974975, 14.819839, 0.000000, 90.000015, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(14397, 1714.750732, -1144.924804, 14.819839, 0.000000, 90.000015, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(14397, 1718.250732, -1144.924804, 14.819839, 0.000000, 90.000015, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(14397, 1721.750732, -1144.924804, 14.819839, 0.000000, 90.000015, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(14397, 1723.960937, -1144.924804, 14.819839, 0.000000, 90.000015, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1715.825439, -1146.902954, 29.339843, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19445, 1719.825805, -1146.903930, 29.339843, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19445, 1710.936645, -1142.103637, 29.339843, 0.000000, 360.000000, -179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19426, 1710.655761, -1140.143554, 27.629837, -0.000007, 270.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.655761, -1143.593750, 27.629837, 0.000007, 270.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.655761, -1145.265258, 27.629837, 0.000007, 270.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.605224, -1147.093505, 27.629837, 0.000000, 270.000000, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1716.035522, -1147.093505, 27.629837, 0.000000, 270.000000, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1133.143554, 29.139831, -0.000007, 270.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1129.703735, 29.139831, -0.000007, 270.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.655761, -1126.403198, 29.139831, -0.000007, 270.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1729.476928, -1145.334106, 30.789840, -0.000014, 360.000000, -89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.976074, -1130.943115, 24.849838, 0.000014, 0.000014, 89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.976074, -1129.333129, 24.849838, 0.000014, 0.000014, 89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.265747, -1130.103637, 24.849838, 0.000000, 360.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1713.676513, -1130.103637, 24.849838, 0.000000, 360.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.976074, -1130.943115, 27.849838, 0.000014, 0.000014, 89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.976074, -1129.333129, 27.849838, 0.000014, 0.000014, 89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.265747, -1130.103637, 27.849838, 0.000000, 360.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1713.676513, -1130.103637, 27.849838, 0.000000, 360.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1721.246337, -1146.902954, 31.839843, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(19426, 1726.066040, -1146.123291, 31.729843, 0.000000, 540.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 12980, "sw_block10", "sw_woodslats2", 0xFF333333);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1143.978393, 26.272033, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1140.518310, 26.272033, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1139.377929, 26.272033, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1142.688232, 26.272033, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1713.363037, -1145.338134, 26.272033, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1714.572631, -1145.358154, 26.272033, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1716.863037, -1145.338134, 26.272033, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1718.072631, -1145.358154, 26.272033, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1720.363037, -1145.338134, 26.272033, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1721.572631, -1145.358154, 26.272033, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1723.863037, -1145.338134, 26.272033, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1725.072631, -1145.358154, 26.272033, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1143.978393, 23.032035, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1140.518310, 23.032035, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1139.377929, 23.032035, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1142.688232, 23.032035, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1140.518310, 27.172035, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1139.377929, 27.172035, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1716.863037, -1145.338134, 23.032035, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1718.072631, -1145.358154, 23.032035, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1720.363037, -1145.338134, 23.032035, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1721.572631, -1145.358154, 23.032035, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1723.863037, -1145.338134, 23.032035, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1725.072631, -1145.358154, 23.032035, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1142.688232, 27.172035, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1713.363037, -1145.338134, 27.172035, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1714.572631, -1145.358154, 27.172035, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1716.863037, -1145.338134, 27.172035, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1718.072631, -1145.358154, 27.172035, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1720.363037, -1145.338134, 27.172035, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1721.572631, -1145.358154, 27.172035, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1723.863037, -1145.338134, 27.172035, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1725.072631, -1145.358154, 27.172035, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1143.978393, 27.162033, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1140.518310, 27.272033, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1139.377929, 27.272033, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1142.688232, 27.272033, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1713.363037, -1145.338134, 27.272033, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1714.572631, -1145.358154, 27.272033, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1716.863037, -1145.338134, 27.272033, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1718.072631, -1145.358154, 27.272033, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1720.363037, -1145.338134, 27.272033, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1721.572631, -1145.358154, 27.272033, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1723.863037, -1145.338134, 27.272033, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1725.072631, -1145.358154, 27.272033, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1143.978393, 27.262039, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1140.518310, 27.372032, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1139.377929, 27.372032, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1142.688232, 27.372032, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1713.363037, -1145.338134, 27.372032, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1714.572631, -1145.358154, 27.372032, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1716.863037, -1145.338134, 27.372032, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1718.072631, -1145.358154, 27.372032, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1720.363037, -1145.338134, 27.372032, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1721.572631, -1145.358154, 27.372032, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1723.863037, -1145.338134, 27.372032, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1725.072631, -1145.358154, 27.372032, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1143.978393, 27.362037, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1140.518310, 27.472030, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1139.377929, 27.472030, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1142.688232, 27.472030, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1713.363037, -1145.338134, 27.472030, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1714.572631, -1145.358154, 27.472030, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1716.863037, -1145.338134, 27.472030, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1718.072631, -1145.358154, 27.472030, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1720.363037, -1145.338134, 27.472030, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1721.572631, -1145.358154, 27.472030, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1723.863037, -1145.338134, 27.472030, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1725.072631, -1145.358154, 27.472030, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1143.978393, 27.462036, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1140.518310, 27.572036, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1139.377929, 27.572036, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.282348, -1142.688232, 27.572036, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1713.363037, -1145.338134, 27.572036, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1714.572631, -1145.358154, 27.572036, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1716.863037, -1145.338134, 27.572036, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1718.072631, -1145.358154, 27.572036, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1720.363037, -1145.338134, 27.572036, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1721.572631, -1145.358154, 27.572036, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1723.863037, -1145.338134, 27.572036, 89.999992, 0.000011, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1725.072631, -1145.358154, 27.572036, 89.999992, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.252319, -1143.978393, 27.562034, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.505249, -1147.093505, 27.629837, 0.000000, 270.000000, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.915283, -1147.093505, 27.629837, 0.000000, 270.000000, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.655761, -1146.156127, 27.629837, 0.000007, 270.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1722.643554, -1126.544677, 30.009841, 0.000000, 270.000000, 179.999771, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1720.265258, -1137.170776, 22.578125, 0.000000, 0.000000, 180.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19325, 1712.300415, -1127.256103, 26.248466, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(19325, 1712.300415, -1133.016845, 26.248466, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(1897, 1712.332153, -1133.807617, 28.912033, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.332153, -1128.127319, 28.912033, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.352172, -1126.197265, 28.912033, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.352172, -1132.077514, 28.912033, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.362182, -1134.988525, 27.882034, 0.000000, 180.000015, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.362182, -1134.988525, 25.872039, 0.000000, 180.000015, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.362182, -1134.988525, 25.092041, 0.000000, 180.000015, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.362182, -1129.297729, 25.092041, 0.000000, 180.000015, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.362182, -1129.297729, 27.292037, 0.000000, 180.000015, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.362182, -1129.297729, 28.042037, 0.000000, 180.000015, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1130.977539, 25.092041, 0.000000, 180.000015, 179.999786, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1125.176635, 25.092041, 0.000000, 180.000015, 179.999832, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1125.176635, 27.292037, 0.000000, 180.000015, 179.999832, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1125.176635, 28.042037, 0.000000, 180.000015, 179.999832, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1130.977539, 27.292037, 0.000000, 180.000015, 179.999786, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1130.977539, 28.042037, 0.000000, 180.000015, 179.999786, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.332153, -1133.807617, 27.912033, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.332153, -1128.127319, 27.912033, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.352172, -1126.197265, 27.912033, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.352172, -1132.077514, 27.912033, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.332153, -1133.807617, 23.912033, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.332153, -1128.127319, 23.912033, 89.999992, 89.999992, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.352172, -1126.197265, 23.912033, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.352172, -1132.077514, 23.912033, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.955566, -1123.382568, 29.679824, 0.000000, 360.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1129.176635, 25.092041, 0.000000, 540.000000, 179.999832, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1129.366821, 26.932037, 0.000000, 0.000037, -0.000105, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1129.366821, 27.922042, 0.000000, 0.000037, -0.000105, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1128.176635, 25.092041, 0.000000, 540.000000, 179.999832, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1128.366821, 26.932037, 0.000000, 0.000037, -0.000105, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1128.366821, 27.922042, 0.000000, 0.000037, -0.000105, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1127.176635, 25.092041, 0.000000, 540.000000, 179.999832, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1127.366821, 26.932037, 0.000000, 0.000037, -0.000105, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1127.366821, 27.922042, 0.000000, 0.000037, -0.000105, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1126.176635, 25.092041, 0.000000, 540.000000, 179.999832, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1126.366821, 26.932037, 0.000000, 0.000037, -0.000105, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1126.366821, 27.922042, 0.000000, 0.000037, -0.000105, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1131.976440, 25.092041, 0.000000, 540.000000, 179.999786, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1132.166625, 26.932037, 0.000000, 0.000044, -0.000103, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1132.166625, 27.922042, 0.000000, 0.000044, -0.000103, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1132.976440, 25.092041, 0.000000, 540.000000, 179.999786, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1133.166625, 26.932037, 0.000000, 0.000044, -0.000103, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1133.166625, 27.922042, 0.000000, 0.000044, -0.000103, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1133.976440, 25.092041, 0.000000, 540.000000, 179.999786, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1134.166625, 26.932037, 0.000000, 0.000044, -0.000103, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1712.342163, -1134.166625, 27.922042, 0.000000, 0.000044, -0.000103, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.135986, -1124.243041, 22.719825, 0.000000, 360.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.135986, -1122.643066, 22.719825, 0.000000, 360.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19325, 1710.960571, -1123.126342, 26.248466, 89.999992, -90.000000, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0xC8FFFFFF);
	tmpobjid = CreateDynamicObject(19426, 1710.955566, -1124.453247, 26.199821, 0.000000, 360.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.955566, -1121.872192, 26.199821, 0.000000, 360.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1710.913330, -1122.596557, 25.582031, 0.000000, 180.000015, 179.999832, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1710.913330, -1122.596557, 26.812034, 0.000000, 180.000015, 179.999832, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1710.943359, -1122.596557, 24.352035, 89.999992, 269.999938, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1710.943359, -1123.707031, 25.582031, 0.000000, 180.000015, -0.000060, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1710.943359, -1123.707031, 26.832038, 0.000000, 180.000015, -0.000060, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1710.943359, -1122.596557, 27.822036, 89.999992, 269.999938, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1710.943359, -1122.596557, 27.262023, 89.999992, 269.999938, -89.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1729.435546, -1145.373168, 22.179832, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1738.866210, -1145.373168, 22.179832, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1738.807495, -1145.353149, 28.429840, -0.000014, 360.000000, -89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1738.807495, -1145.353149, 24.959838, -0.000014, 360.000000, -89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1738.848876, -1145.334106, 30.789840, -0.000022, 360.000000, -89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1712.376708, -1130.124511, 22.179832, 0.000000, 0.000022, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1712.377685, -1129.814453, 22.179832, 0.000000, 0.000022, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.255737, -1130.083374, 22.219825, 0.000000, 360.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.255737, -1130.232543, 22.219825, 0.000000, 360.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.935791, -1124.432739, 22.219825, 0.000000, 360.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.935791, -1122.842773, 22.219825, 0.000000, 360.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1710.935791, -1121.871337, 22.219825, 0.000000, 360.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.636108, -1121.140869, 22.219825, -0.000014, 360.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1711.636108, -1125.161132, 22.219825, -0.000014, 360.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.245849, -1129.981445, 22.219825, 0.000000, 360.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1716.845703, -1121.152099, 24.799835, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1726.406005, -1121.152099, 24.799835, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1736.024902, -1121.152099, 24.799835, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.588623, -1140.573364, 24.959838, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.588623, -1130.953613, 24.959838, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.588623, -1125.873535, 24.959838, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1738.715576, -1121.152099, 24.799835, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.608642, -1140.502441, 22.159835, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.608642, -1130.953369, 22.159835, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.608642, -1125.942504, 22.159835, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1738.878417, -1121.133178, 22.199836, 0.000014, 360.000000, 89.999946, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1717.188232, -1121.133178, 22.199836, 0.000014, 360.000000, 89.999946, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1726.797851, -1121.133178, 22.199836, 0.000014, 360.000000, 89.999946, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1736.337524, -1121.133178, 22.199836, 0.000014, 360.000000, 89.999946, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19517, "noncolored", "bowlerwhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1716.845703, -1121.152099, 28.289825, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1716.845703, -1121.152099, 30.849838, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1726.435791, -1121.152099, 28.289825, -0.000014, 360.000000, -89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1726.435791, -1121.152099, 30.849838, -0.000014, 360.000000, -89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1736.085205, -1121.152099, 28.289825, -0.000022, 360.000000, -89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1736.085205, -1121.152099, 30.849838, -0.000022, 360.000000, -89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1738.666381, -1121.151977, 28.289825, -0.000029, 360.000000, -89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1738.666381, -1121.151977, 30.849838, -0.000029, 360.000000, -89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.588623, -1125.873535, 30.849853, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.587646, -1125.873535, 28.279846, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.588623, -1135.414184, 30.849853, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.587646, -1135.414184, 28.279846, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.588623, -1140.605712, 30.849853, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1743.587646, -1140.605712, 28.279846, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1740.440795, -1125.936523, 32.517791, 0.000000, 270.000000, -179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1740.440795, -1135.576293, 32.517791, 0.000000, 270.000000, -179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1740.440795, -1140.346313, 32.517684, 0.000000, 270.000000, -179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1734.041137, -1125.936523, 32.517791, 0.000000, 270.000000, -179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1734.041137, -1135.576293, 32.517791, 0.000000, 270.000000, -179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1734.041137, -1140.346313, 32.517684, 0.000000, 270.000000, -179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1727.670288, -1125.936523, 32.517791, 0.000000, 270.000000, -179.999847, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1727.670288, -1135.576293, 32.517791, 0.000000, 270.000000, -179.999847, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1727.670288, -1140.346313, 32.517684, 0.000000, 270.000000, -179.999847, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1721.280761, -1125.936523, 32.517791, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1721.280761, -1135.576293, 32.517791, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1721.280761, -1140.346313, 32.517684, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1714.900512, -1125.936523, 32.517791, 0.000000, 270.000000, -179.999755, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1714.900512, -1135.576293, 32.517791, 0.000000, 270.000000, -179.999755, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1714.900512, -1140.346313, 32.517684, 0.000000, 270.000000, -179.999755, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1714.069946, -1125.936523, 32.516784, 0.000000, 270.000000, -179.999710, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1714.069946, -1135.576293, 32.516784, 0.000000, 270.000000, -179.999710, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1714.069946, -1140.346313, 32.516693, 0.000000, 270.000000, -179.999710, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ws_rooftarmac1", 0x00000000);
	tmpobjid = CreateDynamicObject(2898, 1724.043090, -1142.324462, 29.752029, 0.000000, 179.999984, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "white32", 0x00000000);
	tmpobjid = CreateDynamicObject(2898, 1719.982543, -1142.324462, 29.752029, 0.000000, 540.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "white32", 0x00000000);
	tmpobjid = CreateDynamicObject(2898, 1715.903564, -1142.324462, 29.752029, 0.000000, 179.999984, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "white32", 0x00000000);
	tmpobjid = CreateDynamicObject(2898, 1714.382812, -1142.324462, 29.753021, 0.000000, 179.999984, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "white32", 0x00000000);
	tmpobjid = CreateDynamicObject(2898, 1714.402709, -1137.724365, 29.753021, 0.000000, 179.999984, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "white32", 0x00000000);
	tmpobjid = CreateDynamicObject(2898, 1718.393188, -1137.724365, 29.753021, 0.000000, 540.000000, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "white32", 0x00000000);
	tmpobjid = CreateDynamicObject(2898, 1722.472167, -1137.724365, 29.753021, 0.000000, 179.999984, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "white32", 0x00000000);
	tmpobjid = CreateDynamicObject(2898, 1724.042968, -1137.724365, 29.754028, 0.000000, 179.999984, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "white32", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1726.029418, -1140.374267, 28.059844, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1726.029418, -1140.454345, 24.589851, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1140.294433, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1140.294433, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1140.294433, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1140.294433, 29.659942, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1141.885131, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1141.885131, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1141.885131, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1141.885131, 29.659942, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1143.455688, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1143.455688, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1143.455688, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1143.455688, 29.659942, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1138.705810, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1138.705810, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1138.705810, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1138.685791, 29.659942, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1137.115356, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1137.115356, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1137.115356, 29.659835, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1137.115356, 29.659942, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1140.294433, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1140.294433, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1140.294433, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1140.294433, 29.559936, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1141.885131, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1141.885131, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1141.885131, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1141.885131, 29.559936, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1143.455688, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1143.455688, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1143.455688, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1143.455688, 29.559936, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1138.705810, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1138.705810, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1138.705810, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1138.685791, 29.559936, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1137.115356, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1137.115356, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1137.115356, 29.559844, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1137.115356, 29.559936, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1140.294433, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1140.294433, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1140.294433, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1140.294433, 29.459930, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1141.885131, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1141.885131, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1141.885131, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1141.885131, 29.459930, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1143.455688, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1143.455688, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1143.455688, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1143.455688, 29.459930, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1138.705810, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1138.705810, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1138.705810, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1138.685791, 29.459930, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1719.194213, -1137.115356, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.694213, -1137.115356, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.714599, -1137.115356, 29.459838, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1715.114257, -1137.115356, 29.459930, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1725.605590, -1135.505371, 27.359855, 0.000022, 360.000000, 89.999923, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1721.185668, -1135.505371, 28.459854, 0.000022, 360.000000, 89.999923, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1717.205200, -1135.505371, 28.459854, 0.000022, 360.000000, 89.999923, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1721.026489, -1135.503295, 21.689834, -0.000022, 360.000000, -89.999931, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1721.026489, -1135.503295, 25.189834, -0.000022, 360.000000, -89.999931, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.536132, -1135.503295, 24.989837, -0.000022, 360.000000, -89.999931, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.536132, -1135.503295, 21.689834, -0.000022, 360.000000, -89.999931, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1726.229614, -1133.892944, 21.089851, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1720.265258, -1140.361083, 22.578125, 0.000000, 0.000000, 180.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(18880, 1720.200805, -1135.480957, 26.757041, -0.000007, 179.999984, -0.000012, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 2, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19325, 1716.906738, -1135.509399, 24.687042, 0.000036, 0.000014, 89.999855, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(1897, 1719.013671, -1135.508178, 24.687034, 89.999992, 356.601196, -86.601173, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(18880, 1717.940063, -1135.480957, 26.747039, -0.000007, 179.999984, -0.000012, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 2, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1719.013671, -1135.508178, 23.027030, 89.999992, 356.601196, -86.601173, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1719.013671, -1135.508178, 26.607040, 89.999992, 356.601196, -86.601173, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1716.731933, -1135.508178, 26.607040, 89.999992, 356.601196, -86.601173, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(18880, 1715.589477, -1135.480957, 26.747039, -0.000007, 179.999984, -0.000012, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 2, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1716.723510, -1135.508178, 24.687034, 89.999992, 356.601196, -86.601173, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1716.723510, -1135.508178, 23.037033, 89.999992, 356.601196, -86.601173, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1714.363159, -1135.508178, 26.617034, 89.999992, 356.601196, -86.601173, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(18880, 1713.468383, -1135.480957, 26.747039, -0.000007, 179.999984, -0.000012, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 2, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1714.543212, -1135.508178, 24.687034, 89.999992, 356.601196, -86.601173, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(1897, 1714.543212, -1135.508178, 23.027030, 89.999992, 356.601196, -86.601173, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1721.775146, -1141.902099, 22.578125, 0.000000, 0.000000, 270.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1723.665527, -1141.901123, 22.578125, 0.000000, 0.000000, 270.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1715.441528, -1140.485107, 23.067787, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1721.820556, -1140.495117, 23.067787, 0.000000, 630.000000, 0.000103, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1728.130615, -1140.334960, 23.066787, 0.000000, 270.000000, 0.000103, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1715.441528, -1130.694824, 23.067787, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1715.441528, -1126.033813, 23.066787, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1721.841186, -1126.033813, 23.066787, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1721.841186, -1131.454467, 23.065689, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1728.110961, -1131.454467, 23.066688, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1734.500610, -1131.454467, 23.066688, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1740.350585, -1131.454467, 23.066589, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1740.350585, -1140.464965, 23.066589, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1734.460571, -1140.464965, 23.066490, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1740.351318, -1126.073120, 23.066490, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1733.971923, -1126.073120, 23.066490, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1727.861328, -1126.073120, 23.066390, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1725.506347, -1135.505371, 24.819854, 0.000022, 360.000000, 89.999923, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1725.869628, -1142.800048, 29.470291, 0.000000, -0.000014, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1725.869628, -1138.059814, 29.470291, 0.000000, -0.000014, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1723.370117, -1135.628906, 29.470291, -0.000014, 0.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1718.400146, -1135.628906, 29.470291, -0.000014, 0.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1714.889892, -1135.628906, 29.470291, -0.000014, 0.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1712.439208, -1137.939208, 29.470291, 0.000000, 0.000014, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1712.439208, -1142.689819, 29.470291, 0.000000, 0.000014, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1714.889770, -1145.080322, 29.470291, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1719.849365, -1145.080322, 29.470291, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1723.559570, -1145.080322, 29.470291, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1715.441528, -1140.185058, 23.057792, 0.000000, 270.000000, -179.999801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18031, "cj_exp", "mp_furn_floor", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1712.136962, -1122.022705, 22.719825, 0.000000, 360.000000, 179.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19815, 1720.632934, -1137.042114, 24.320281, 270.000000, 90.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(19815, 1720.632934, -1140.482666, 24.320281, 270.000000, 90.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(19815, 1720.632934, -1139.682861, 24.321281, 270.000000, 90.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(19815, 1721.633911, -1141.674316, 24.331283, 270.000000, 90.000000, 90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(19815, 1722.964599, -1141.674316, 24.331283, 270.000000, 90.000000, 90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1724.223388, -1134.654663, 29.729827, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1720.723388, -1134.654663, 29.729827, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1717.283447, -1134.654663, 29.729827, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1714.643554, -1134.654663, 29.729827, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1723.660522, -1133.949096, 28.980300, -0.000014, 0.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1720.723388, -1122.021606, 29.729827, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1717.283447, -1122.021606, 29.729827, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1714.213256, -1122.021606, 29.729827, 0.000000, 270.000000, -0.000044, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1723.394042, -1126.777465, 28.960296, 0.000000, -0.000014, 1169.999877, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1724.454223, -1129.144653, 29.609832, 0.000000, 270.000000, 179.999771, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1724.364013, -1134.645019, 29.039855, 0.000000, 270.000000, 359.999755, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1722.193115, -1134.645019, 29.039855, 0.000000, 270.000000, 359.999755, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1713.256713, -1124.087036, 29.729827, 0.000044, 270.000000, 89.999786, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1713.256591, -1127.587036, 29.729827, 0.000044, 270.000000, 89.999786, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1713.256591, -1131.027099, 29.729827, 0.000044, 270.000000, 89.999786, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1713.256469, -1133.687255, 29.729827, 0.000044, 270.000000, 89.999786, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1715.872314, -1129.144653, 30.009841, 0.000000, 270.000000, 179.999862, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1716.449707, -1133.949096, 29.680297, -0.000014, 0.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1721.179809, -1133.949096, 28.980300, -0.000014, 0.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1722.369873, -1133.949096, 28.980300, -0.000014, 0.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1726.001586, -1132.990234, 28.970291, 0.000000, 0.000036, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1726.001586, -1127.999755, 28.970291, 0.000000, 0.000036, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1721.961181, -1122.748413, 29.680297, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1717.061401, -1122.748413, 29.680297, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1716.011108, -1122.748413, 29.680297, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1713.981811, -1125.287963, 29.680297, 0.000000, -0.000014, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1713.981811, -1129.918212, 29.680297, 0.000000, -0.000014, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1713.981811, -1131.458496, 29.680297, 0.000000, -0.000014, 179.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1715.872314, -1127.384277, 30.009841, 0.000000, 270.000000, 179.999862, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19815, 1711.624267, -1123.546752, 24.452728, -89.999992, 90.197845, -179.802124, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19815, 1711.464111, -1123.546752, 24.451728, -89.999992, 90.197845, -179.802124, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19815, 1711.464111, -1122.706420, 24.449729, -89.999992, 90.197845, -179.802124, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19815, 1711.624267, -1122.706420, 24.448730, -89.999992, 90.197845, -179.802124, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 1721.801269, -1135.531738, 23.109832, 0.000000, 0.000022, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1725.165039, -1126.672485, 24.799835, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19815, 1724.444335, -1141.674316, 22.831275, 360.000000, 90.000000, 90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1721.775146, -1141.321533, 22.578125, -0.000007, 0.000000, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1723.665527, -1141.320556, 22.578125, -0.000007, 0.000000, -89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1720.895385, -1137.170776, 22.578125, 0.000000, -0.000007, 179.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19604, 1718.947631, -1140.301635, 29.359375, -0.000007, 179.999984, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14561, "triad_neon", "kbneon", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1720.895385, -1140.361083, 22.578125, 0.000000, -0.000007, 179.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 1724.740966, -1135.531738, 23.109832, 0.000000, -0.000022, 179.999862, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1725.165039, -1126.672485, 28.299835, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1726.185180, -1130.674682, 28.299835, -0.000007, 360.000000, 0.000014, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1720.355590, -1130.752563, 28.349838, 0.000014, 0.000014, 179.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1718.804687, -1129.391723, 28.349838, 0.000014, 0.000014, 269.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1715.614990, -1129.391723, 28.349838, 0.000014, 0.000014, 269.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1713.324340, -1129.391723, 28.349838, 0.000014, 0.000014, 269.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1718.804687, -1129.391723, 24.849838, 0.000014, 0.000014, 269.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1715.614990, -1129.391723, 24.849838, 0.000014, 0.000014, 269.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1713.324340, -1129.391723, 24.849838, 0.000014, 0.000014, 269.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19383, 1720.316162, -1130.991210, 24.849838, 0.000014, 0.000014, 359.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1720.316162, -1133.791992, 24.849838, 0.000014, 0.000014, 359.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1720.355590, -1125.710693, 28.349838, 0.000014, 0.000014, 179.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19383, 1720.316162, -1127.760375, 24.849838, 0.000014, 0.000014, 359.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19353, 1720.355590, -1122.768798, 24.849838, 0.000014, 0.000014, 179.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1720.355590, -1125.369262, 24.849838, 0.000014, 0.000014, 179.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1720.355590, -1124.278930, 24.849838, 0.000014, 0.000014, 179.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 1720.330566, -1131.721191, 23.109832, 0.000000, 0.000022, 90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 1720.330566, -1128.500366, 23.109832, 0.000000, 0.000022, 90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(2205, 1714.697387, -1132.817993, 23.038124, -0.000009, 0.000000, -89.999946, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1716, "cj_seating", "CJ_SHINYWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(11710, 1715.022583, -1132.822021, 23.890174, -30.000001, 0.000014, 100.000007, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14784, "genintwarehsint3", "sjmlawarwall4", 0x00000000);
	tmpobjid = CreateDynamicObject(1964, 1714.506958, -1133.268798, 24.118690, 0.000014, 0.000000, 89.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 5, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 6, 5150, "wiresetc_las2", "ganggraf01_LA_m", 0x00000000);
	tmpobjid = CreateDynamicObject(2265, 1714.422729, -1133.179565, 24.310447, -0.000059, 90.000007, -95.999855, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	tmpobjid = CreateDynamicObject(2265, 1715.314086, -1133.997070, 24.309448, 0.000059, 89.999992, 83.999725, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	tmpobjid = CreateDynamicObject(1788, 1714.635131, -1133.555175, 24.150436, -0.000059, 0.000004, -95.999855, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(2265, 1715.323608, -1133.998168, 24.309448, 0.000059, 89.999992, 83.999725, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	tmpobjid = CreateDynamicObject(18868, 1714.925415, -1133.575683, 24.040184, 81.099975, 179.999893, 83.999931, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	tmpobjid = CreateDynamicObject(19813, 1714.877807, -1133.590820, 23.986366, -89.999992, -175.233352, 88.766448, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 11631, "mp_ranchcut", "mpCJ_Black_metal", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(2248, 1712.841430, -1131.354003, 23.428359, 0.000023, 0.000003, 73.299926, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13059, "ce_fact03", "GB_truckdepot19", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1712.841430, -1131.354003, 23.528457, 0.000009, -0.000022, 155.299850, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19482, 1717.008789, -1129.485839, 25.200302, 0.000000, 0.000000, 90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19173, "samppictures", "samppicture3", 0x00000000);
	tmpobjid = CreateDynamicObject(2248, 1714.221557, -1130.163574, 23.428359, 0.000037, 0.000007, 118.299903, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13059, "ce_fact03", "GB_truckdepot19", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1714.221557, -1130.163574, 23.528457, 0.000014, -0.000036, -159.700164, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1714.150146, -1130.738281, 23.040290, 0.000000, 90.000000, 180.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19595, "lsappartments1", "carpet4-256x256", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1717.581054, -1130.738281, 23.040290, 0.000000, 90.000000, 180.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19595, "lsappartments1", "carpet4-256x256", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1718.601806, -1130.738281, 23.041290, 0.000000, 90.000000, 180.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19595, "lsappartments1", "carpet4-256x256", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1714.150146, -1126.037475, 23.039291, 0.000000, 89.999992, 179.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19595, "lsappartments1", "carpet4-256x256", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1717.581054, -1126.037475, 23.039291, 0.000000, 89.999992, 179.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19595, "lsappartments1", "carpet4-256x256", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1718.601806, -1126.037475, 23.040290, 0.000000, 89.999992, 179.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19595, "lsappartments1", "carpet4-256x256", 0x00000000);
	tmpobjid = CreateDynamicObject(19787, 1716.264526, -1121.236450, 25.120429, 2.899995, 0.000044, 0.000065, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 15040, "cuntcuts", "GB_phone02", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 10938, "skyscrap_sfse", "ws_skyscraperwin1", 0x00000000);
	tmpobjid = CreateDynamicObject(2662, 1716.264038, -1121.270385, 25.078193, 0.000000, 0.000044, 0.000068, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 17588, "lae2coast_alpha", "LAShad1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 17588, "lae2coast_alpha", "LAShad1", 0x00000000);
	tmpobjid = CreateDynamicObject(19383, 1726.187622, -1130.991210, 24.849838, 0.000012, 0.000020, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19482, 1720.258666, -1124.181518, 25.239295, 540.000000, 540.000000, 360.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19165, "gtamap", "gtasavectormap1", 0x00000000);
	tmpobjid = CreateDynamicObject(2248, 1719.823242, -1128.918701, 23.600227, 0.000015, 0.000003, 141.599914, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13059, "ce_fact03", "GB_truckdepot19", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1719.823242, -1128.918701, 23.700325, 0.000006, -0.000014, -136.400054, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(2789, 1710.892578, -1141.429443, 30.408020, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "POLICIA", 130, "Arial", 150, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2898, 1718.393188, -1137.724365, 29.753021, 0.000000, 540.000000, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "white32", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1719.363281, -1129.144653, 30.009841, 0.000000, 270.000000, 179.999816, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(2789, 1710.892578, -1140.398925, 29.188018, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "CIVIL", 130, "Arial", 150, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2789, 1710.892578, -1140.588989, 31.278015, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "DEPARTAMENTO DE", 130, "Arial", 40, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2789, 1710.892578, -1138.038940, 30.188018, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "1", 130, "Arial", 199, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2789, 1710.892578, -1138.559204, 30.768035, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "o", 130, "Arial", 30, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2789, 1710.892578, -1138.559204, 30.668029, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "_", 130, "Arial", 30, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2789, 1721.968750, -1146.896240, 30.408020, -0.000007, 0.000014, -0.000007, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "POLICIA", 130, "Arial", 150, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2789, 1720.938232, -1146.896240, 29.188018, -0.000007, 0.000014, -0.000007, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "CIVIL", 130, "Arial", 150, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2789, 1721.128295, -1146.896240, 31.278015, -0.000007, 0.000014, -0.000007, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "DEPARTAMENTO DE", 130, "Arial", 40, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2789, 1718.578247, -1146.896240, 30.188018, -0.000007, 0.000014, -0.000007, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "1", 130, "Arial", 199, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2789, 1719.098510, -1146.896240, 30.768035, -0.000007, 0.000014, -0.000007, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "o", 130, "Arial", 30, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2789, 1719.098510, -1146.896240, 30.668029, -0.000007, 0.000014, -0.000007, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "_", 130, "Arial", 30, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19445, 1726.030395, -1140.334228, 24.589851, 0.000000, 360.000000, -0.000006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1729.675048, -1145.243041, 24.789825, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1729.675048, -1145.243041, 28.729827, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(7313, 1712.270385, -1141.963012, 26.959648, 0.000000, 0.000000, 270.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(7313, 1715.360473, -1145.343139, 26.959648, 0.000000, 0.000000, 360.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(7313, 1721.450683, -1145.343139, 26.959648, 0.000000, 0.000000, 360.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1713.658691, -1138.218017, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1713.658691, -1137.617919, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1713.658691, -1137.017822, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1713.658691, -1141.798461, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1713.658691, -1141.198364, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1713.658691, -1140.598266, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1715.158691, -1138.218017, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1715.158691, -1137.617919, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1715.158691, -1137.017822, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1715.158691, -1141.798461, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1715.158691, -1141.198364, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1715.158691, -1140.598266, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1716.658691, -1138.218017, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1716.658691, -1137.617919, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1716.658691, -1137.017822, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1716.658691, -1141.798461, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1716.658691, -1141.198364, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1715, 1716.658691, -1140.598266, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1726.016723, -1140.405883, 24.690299, 90.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1726.016723, -1137.334960, 24.690299, 90.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19482, 1725.872558, -1138.732421, 26.254714, 0.000000, 0.000000, 180.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "POLICIA", 130, "Arial", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19445, 1719.363281, -1127.384277, 30.009841, 0.000000, 270.000000, 179.999816, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1722.293212, -1129.144653, 29.609832, 0.000000, 270.000000, 179.999771, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19482, 1725.872558, -1138.732421, 25.284713, 0.000000, 0.000000, 180.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "CIVIL", 130, "Arial", 120, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19866, 1720.929687, -1121.348632, 29.470291, -0.000014, 0.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1715.959960, -1121.348632, 29.470291, -0.000014, 0.000000, -89.999954, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1725.135131, -1135.515380, 27.789863, 0.000022, 360.000000, 89.999923, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1725.135131, -1135.515380, 27.339859, 0.000022, 360.000000, 89.999923, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1725.506347, -1135.495361, 24.819854, 0.000022, 360.000000, 89.999923, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1721.026489, -1135.493286, 25.189834, -0.000022, 360.000000, -89.999931, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1721.026489, -1135.493286, 21.689834, -0.000022, 360.000000, -89.999931, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1721.976074, -1135.505371, 28.459854, 0.000022, 360.000000, 89.999923, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(2265, 1721.018676, -1137.801879, 24.692329, 0.000014, 90.000007, 89.999847, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	tmpobjid = CreateDynamicObject(2265, 1720.047729, -1137.082641, 24.691329, -0.000014, 89.999992, -90.000015, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	tmpobjid = CreateDynamicObject(1788, 1720.768554, -1137.450805, 24.532318, 0.000014, 0.000007, 89.999847, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(2265, 1720.037719, -1137.082641, 24.691329, -0.000014, 89.999992, -90.000015, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	tmpobjid = CreateDynamicObject(18868, 1720.477539, -1137.460815, 24.422065, 81.099975, 179.999893, -89.999816, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	tmpobjid = CreateDynamicObject(19813, 1720.523193, -1137.440795, 24.368247, -89.999992, -62.742595, 27.257316, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 11631, "mp_ranchcut", "mpCJ_Black_metal", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(2265, 1721.018676, -1140.232177, 24.692329, 0.000022, 90.000007, 89.999824, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19787, "samplcdtvs1", "samplcdtv1screen", 0x00000000);
	tmpobjid = CreateDynamicObject(2265, 1720.047729, -1139.512939, 24.691329, -0.000022, 89.999992, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	tmpobjid = CreateDynamicObject(1788, 1720.768554, -1139.881103, 24.532318, 0.000022, 0.000007, 89.999824, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(2265, 1720.037719, -1139.512939, 24.691329, -0.000022, 89.999992, -89.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	tmpobjid = CreateDynamicObject(18868, 1720.477539, -1139.891113, 24.422065, 81.099975, 179.999893, -89.999794, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0xFFFFFFFF);
	SetDynamicObjectMaterial(tmpobjid, 1, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	tmpobjid = CreateDynamicObject(19813, 1720.523193, -1139.871093, 24.368247, -89.999992, -21.106826, 68.893074, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 11631, "mp_ranchcut", "mpCJ_Black_metal", 0xFFFFFFFF);
	tmpobjid = CreateDynamicObject(19353, 1726.187622, -1133.791992, 24.849838, 0.000012, 0.000020, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 1726.202026, -1131.721191, 23.109832, 0.000007, 0.000022, 89.999977, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14581, "ab_mafiasuitea", "cof_wood2", 0x00000000);
	tmpobjid = CreateDynamicObject(19383, 1726.187622, -1127.839477, 24.849838, 0.000012, 0.000029, -0.000029, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1731.085327, -1129.712890, 24.799835, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1731.085327, -1129.712890, 28.299835, -0.000007, 360.000000, -89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1731.085327, -1135.375366, 24.799835, -0.000014, 360.000000, -89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1731.085327, -1135.375366, 28.299835, -0.000014, 360.000000, -89.999961, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1731.085327, -1132.565673, 24.799835, -0.000022, 360.000000, 0.000030, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(19445, 1731.085327, -1132.565673, 28.299835, -0.000022, 360.000000, 0.000030, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
	tmpobjid = CreateDynamicObject(2248, 1720.988647, -1134.871337, 23.538131, 0.000016, 0.000003, 73.299926, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13059, "ce_fact03", "GB_truckdepot19", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1720.988647, -1134.871337, 23.638229, 0.000006, -0.000015, 155.299896, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(2248, 1725.389404, -1134.871337, 23.538131, 0.000023, 0.000005, 115.199897, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13059, "ce_fact03", "GB_truckdepot19", 0x00000000);
	tmpobjid = CreateDynamicObject(2010, 1725.389404, -1134.871337, 23.638229, 0.000009, -0.000022, -162.800079, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19911, 1729.233154, -1133.114379, 29.539855, 0.000000, 270.000000, 179.999771, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-60-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1716.491699, -1129.588378, 29.660293, 0.000000, -0.000014, 449.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1717.832641, -1129.588378, 29.660293, 0.000000, -0.000014, 449.999908, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1720.192871, -1129.588378, 29.660293, 0.000000, -0.000014, 719.999877, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1720.192871, -1133.027587, 29.660293, 0.000000, -0.000014, 719.999877, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1720.523193, -1133.027587, 28.960296, 0.000000, -0.000014, 899.999877, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1720.523193, -1129.037597, 28.960296, 0.000000, -0.000014, 899.999877, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19866, 1723.073852, -1126.777465, 28.960296, 0.000000, -0.000014, 1169.999877, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-50-percent", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(6100, 1252.790039, -1541.280029, 36.914093, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19808, 1714.529418, -1133.610961, 23.988075, -0.000003, 0.000000, -88.699981, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1703, 1719.611694, -1132.515380, 23.130287, 0.000000, 0.000000, 270.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1714, 1714.003784, -1133.448486, 23.078414, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2007, 1712.821899, -1134.629272, 23.078414, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2007, 1712.821899, -1133.649291, 23.078414, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2007, 1712.821899, -1132.649414, 23.078414, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 1715.751098, -1133.009399, 23.104591, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 1715.751098, -1134.079345, 23.104591, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2357, 1716.115844, -1123.381103, 23.660301, 0.000000, 0.000000, 90.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2357, 1716.115844, -1123.381103, 22.890289, 0.000000, 180.000000, 90.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2357, 1716.115844, -1125.562622, 23.660202, 0.000007, 0.000000, 89.999977, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2357, 1716.115844, -1125.562622, 22.890197, 0.000007, 180.000000, 89.999977, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19999, 1716.822265, -1122.743530, 23.129287, 0.000000, 0.000000, 270.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19999, 1717.092529, -1124.533081, 23.129287, 0.000000, 0.000000, -74.100006, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19999, 1717.743164, -1126.253417, 23.129287, 0.000000, 0.000000, 270.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19999, 1714.573242, -1126.253417, 23.129287, 0.000000, 0.000000, 450.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19999, 1714.573242, -1124.083007, 23.129287, 0.000000, 0.000000, 450.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19999, 1714.573242, -1122.172485, 23.129287, 0.000000, 0.000000, 450.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2161, 1712.022216, -1124.540771, 23.129287, 0.000000, 0.000000, 450.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2161, 1712.022216, -1123.239990, 23.129287, 0.000000, 0.000000, 450.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2161, 1712.022216, -1121.919311, 23.129287, 0.000000, 0.000000, 450.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1703, 1712.939331, -1128.916870, 23.110290, 0.000000, 0.000000, 90.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1713.658691, -1138.818115, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1713.658691, -1136.417724, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1713.658691, -1142.398559, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1713.658691, -1139.998168, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1715.158691, -1138.818115, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1715.158691, -1136.417724, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1715.158691, -1142.398559, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1715.158691, -1139.998168, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1716.658691, -1138.818115, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1716.658691, -1136.417724, 23.070274, 0.000014, -0.000007, 89.999938, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1716.658691, -1142.398559, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 1716.658691, -1139.998168, 23.070274, 0.000022, -0.000007, 89.999916, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2258, 1713.777465, -1130.150878, 25.640289, 0.000014, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19808, 1720.839843, -1137.539916, 24.380287, 0.000000, 0.000000, 86.299942, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19808, 1720.839843, -1139.970214, 24.380287, 0.000007, 0.000000, 86.299919, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1714, 1721.865234, -1140.041015, 23.130287, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1714, 1721.865234, -1137.461181, 23.130287, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(3109, 1726.202026, -1128.569458, 24.469848, 0.000014, 0.000022, 359.999938, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1730.896118, -1131.444335, 23.103752, -0.000015, 0.000000, -89.999923, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1730.896118, -1130.764038, 23.103752, -0.000015, 0.000000, -89.999923, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1726.384277, -1134.904785, 23.103752, 0.000022, 0.000000, 89.999931, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1726.384277, -1134.204833, 23.103752, 0.000022, 0.000000, 89.999931, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1726.384277, -1133.504882, 23.103752, 0.000022, 0.000000, 89.999931, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1726.384277, -1132.804931, 23.103752, 0.000022, 0.000000, 89.999931, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1726.384277, -1132.104980, 23.103752, 0.000022, 0.000000, 89.999931, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1730.896118, -1132.104980, 23.103752, -0.000015, 0.000000, -89.999923, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1730.896118, -1132.804931, 23.103752, -0.000015, 0.000000, -89.999923, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1730.896118, -1133.504882, 23.103752, -0.000015, 0.000000, -89.999923, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1730.896118, -1134.204833, 23.103752, -0.000015, 0.000000, -89.999923, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 1730.896118, -1134.904785, 23.103752, -0.000015, 0.000000, -89.999923, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2357, 1728.566528, -1134.122924, 23.103752, 0.000015, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11745, 1728.816040, -1133.118774, 23.664031, -0.000010, 0.000011, -41.899997, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2357, 1728.566528, -1135.342895, 23.104751, 0.000015, 0.000000, 89.999954, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(3109, 1726.203002, -1128.569458, 22.169837, 0.000014, 0.000022, 359.999938, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1713, 1722.055541, -1127.403686, 23.129287, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 

	//=====================================================
	
	tmpobjid = CreateDynamicObject(18981, 859.894714, -1372.711425, 12.660161, 0.000000, 90.200004, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 884.853820, -1372.722045, 12.573046, 0.000000, 90.200004, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 895.294189, -1372.722045, 12.536602, 0.000000, 90.200004, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 895.294189, -1349.481201, 12.536602, 0.000000, 90.200004, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 870.395202, -1349.890625, 12.623519, 0.000000, 90.200004, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 859.894714, -1360.681030, 12.660161, 0.000000, 90.200004, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 859.896240, -1396.442626, 7.675179, 23.799980, 90.200027, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(18981, 879.937255, -1325.859252, 8.159207, -20.900024, 90.200027, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 877.207092, -1385.246459, 14.180871, 0.000000, 0.000000, -90.000022, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 875.850158, -1385.299194, 14.221942, 0.199998, -52.299999, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 886.796752, -1385.246459, 14.180871, 0.000000, 0.000000, -90.000022, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 896.416320, -1385.246459, 14.180871, 0.000000, 0.000000, -90.000022, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 903.026123, -1385.246459, 14.180871, 0.000000, 0.000000, -90.000022, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 852.206542, -1385.246459, 14.180871, 0.000000, 0.000000, -90.000022, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 852.116455, -1359.235473, 14.180871, 0.000000, 0.000000, -90.000022, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 861.666381, -1359.235473, 14.180871, 0.000000, 0.000000, -90.000022, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 862.676635, -1359.235473, 14.180871, 0.000000, 0.000000, -90.000022, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 872.197387, -1337.345703, 14.180871, 0.000000, 0.000000, -90.000022, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 897.197570, -1337.345703, 14.180871, 0.000000, 0.000000, -90.000022, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 902.967834, -1337.345703, 14.180871, 0.000000, 0.000000, -90.000022, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 907.820373, -1342.084472, 14.180871, 0.000000, 0.000000, 179.599884, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 907.753173, -1351.693847, 14.180871, 0.000000, 0.000000, 179.599884, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 907.716186, -1361.293334, 14.180871, 0.000000, 0.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 907.716186, -1370.873168, 14.180871, 0.000000, 0.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 907.716186, -1380.443115, 14.180871, 0.000000, 0.000000, 179.999893, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 867.391418, -1342.201416, 14.180871, 0.000000, 0.000000, -179.900100, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 867.408142, -1351.831298, 14.180871, 0.000000, 0.000000, -179.900100, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 867.412780, -1354.501831, 14.180871, 0.000000, 0.000000, -179.900100, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 847.417907, -1380.516479, 14.180871, 0.000000, 0.000000, -179.900100, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 847.401184, -1370.936645, 14.180871, 0.000000, 0.000000, -179.900100, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19447, 847.384582, -1361.316894, 14.180871, 0.000000, 0.000000, -179.900100, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 882.709533, -1385.299194, 14.245882, 0.199998, -52.299999, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 889.559204, -1385.299194, 14.269790, 0.199998, -52.299999, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 896.389160, -1385.299194, 14.293634, 0.199998, -52.299999, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 903.208740, -1385.299194, 14.317438, 0.199998, -52.299999, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 904.409484, -1385.299194, 14.321632, 0.199998, -52.299999, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 853.570678, -1385.299194, 14.144172, 0.199998, -52.299999, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 850.750305, -1385.299194, 14.134325, 0.199998, -52.299999, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 850.750488, -1359.288574, 14.281185, 0.199998, -52.299999, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 857.610351, -1359.288574, 14.305130, 0.199998, -52.299999, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 864.069580, -1359.288574, 14.327667, 0.199998, -52.299999, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 870.879760, -1337.376098, 14.337894, 0.199998, -178.000061, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 873.559997, -1337.376098, 14.347246, 0.199998, -178.000061, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 895.809875, -1337.376098, 14.424909, 0.199998, -178.000061, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 902.649658, -1337.376098, 14.448782, 0.199998, -178.000061, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 904.420410, -1337.376098, 14.454971, 0.199998, -178.000061, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 904.490539, -1337.295288, 14.425663, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 897.681030, -1337.295288, 14.401897, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 895.820495, -1337.295288, 14.395398, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 873.570800, -1337.295288, 14.317740, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 870.821044, -1337.295288, 14.308147, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 875.821350, -1385.192749, 14.239731, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 853.561401, -1385.192749, 14.162027, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 850.871276, -1385.192749, 14.152639, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 882.680480, -1385.192749, 14.263672, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 889.540100, -1385.192749, 14.287617, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 896.389892, -1385.192749, 14.311529, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 903.219726, -1385.192749, 14.335364, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 904.160095, -1385.192749, 14.338647, 0.199998, -128.600067, -90.000053, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.647705, -1381.752685, 14.361351, 0.199998, -128.600067, -0.100064, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.659729, -1374.903076, 14.385261, 0.199998, -128.600067, -0.100064, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.663696, -1368.063720, 14.402899, 0.199998, -128.600067, -0.000063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.663696, -1361.224853, 14.426774, 0.199998, -128.600067, -0.000063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.663696, -1354.395141, 14.450613, 0.199998, -128.600067, -0.000063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.663696, -1347.604736, 14.474311, 0.199998, -128.600067, -0.000063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.663696, -1340.774902, 14.498149, 0.199998, -128.600067, -0.000063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.860290, -1340.694702, 14.391635, 0.199998, -177.900070, -0.400063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.812316, -1347.554565, 14.367692, 0.199998, -177.900070, -0.400063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.764343, -1354.414306, 14.343747, 0.199998, -177.900070, -0.400063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.754699, -1360.184692, 14.322140, 0.199998, -177.900070, -0.000063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.754699, -1367.034790, 14.298228, 0.199998, -177.900070, -0.000063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.754699, -1373.874633, 14.274353, 0.199998, -177.900070, -0.000063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.754699, -1380.694335, 14.250548, 0.199998, -177.900070, -0.000063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 907.754699, -1381.824951, 14.246599, 0.199998, -177.900070, -0.000063, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 847.440185, -1362.604492, 14.273744, 0.199998, -177.900070, 0.099935, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 847.451904, -1369.424194, 14.249940, 0.199998, -177.900070, 0.099935, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 847.463806, -1376.244506, 14.226136, 0.199998, -177.900070, 0.099935, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 847.473449, -1381.773315, 14.206830, 0.199998, -177.900070, 0.099935, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 867.453979, -1355.910644, 14.363249, 0.199998, -177.900070, 0.099935, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 867.442138, -1349.090698, 14.387052, 0.199998, -177.900070, 0.099935, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 867.430175, -1342.280761, 14.410820, 0.199998, -177.900070, 0.099935, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(1251, 867.427551, -1340.800415, 14.415986, 0.199998, -177.900070, 0.099935, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 832.639343, -1380.837036, 16.606468, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 842.439270, -1375.937744, 16.606468, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 837.499572, -1375.937744, 16.606468, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 842.439270, -1380.857299, 16.606468, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 837.509338, -1380.857299, 16.606468, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 832.639343, -1375.937744, 16.606468, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 832.639343, -1370.977905, 16.606468, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 837.559020, -1370.977905, 16.606468, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 842.438964, -1370.977905, 16.606468, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 866.649414, -1360.903198, 14.893444, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 865.096374, -1362.424926, 14.893444, 0.000000, 0.000000, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 865.099365, -1364.106079, 14.893444, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "black16", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 865.075500, -1359.394775, 14.893444, 0.000000, 0.000000, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 865.099365, -1367.285766, 14.893444, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "black16", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 865.099365, -1370.455444, 14.893444, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "black16", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 865.031982, -1371.977661, 13.132430, 0.000000, 0.000000, -179.199951, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 9, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 862.032775, -1372.049804, 13.132430, 0.000000, 0.000000, 1.000049, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 9, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 860.422912, -1372.038696, 14.893444, 0.000000, 0.000000, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 862.723571, -1370.695556, 17.368623, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 863.609436, -1371.561035, 15.779457, 0.000000, -89.499992, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 864.909179, -1371.552246, 15.779457, 0.000000, -89.499992, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 864.884704, -1368.052978, 15.748922, 0.000000, -89.499992, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 864.860534, -1364.593383, 15.718729, 0.000000, -89.499992, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 864.836181, -1361.113037, 15.688351, 0.000000, -89.499992, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 861.162719, -1372.044433, 14.234499, 0.000000, 0.000000, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 861.022583, -1372.044433, 14.234499, 0.000000, 0.000000, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 856.848083, -1371.635498, 14.832261, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 863.353576, -1370.695556, 17.369722, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 858.052429, -1372.044433, 11.614502, 0.000000, 0.000000, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 858.052429, -1372.044433, 15.094500, 0.000000, 0.000000, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 857.734436, -1370.885742, 17.169910, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 855.582763, -1372.044433, 11.604505, 0.000000, 0.000000, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 854.298217, -1371.635498, 14.832261, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 853.032531, -1372.044433, 11.594504, 0.000000, 0.000000, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 852.398742, -1371.635498, 14.832261, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 854.403869, -1370.885742, 17.164110, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 851.998901, -1370.455444, 14.893444, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "black16", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 851.998901, -1367.245727, 14.893444, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "black16", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 856.439086, -1370.455444, 14.893444, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "black16", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 853.688903, -1365.725952, 14.893444, 0.000000, 0.000000, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 854.928588, -1365.717895, 14.893444, 0.000000, 0.000000, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 856.439086, -1368.895751, 14.893444, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "black16", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 856.464721, -1367.308959, 13.132430, 0.000000, 0.000000, 89.600051, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 9, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 858.865661, -1365.709838, 13.132430, 0.000000, 0.000000, 179.700027, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 9, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 856.848083, -1365.295410, 14.832261, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 860.328613, -1367.385498, 11.713438, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "black16", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 859.622558, -1365.713745, 14.234499, 0.000000, 0.000000, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 860.328613, -1370.356079, 11.713438, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "black16", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 860.318603, -1370.346069, 14.163437, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 860.271057, -1366.594970, 14.234499, 0.000000, 0.000000, -0.100018, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 863.258972, -1370.356079, 13.060184, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2023, "bitsnbobs", "CJ_LIGHTWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 862.158386, -1370.356079, 13.064027, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2023, "bitsnbobs", "CJ_LIGHTWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 862.158386, -1367.146240, 13.064027, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2023, "bitsnbobs", "CJ_LIGHTWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 863.279052, -1367.146240, 13.060109, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2023, "bitsnbobs", "CJ_LIGHTWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 863.279052, -1363.945922, 13.060109, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2023, "bitsnbobs", "CJ_LIGHTWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 859.779296, -1363.945922, 13.072326, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2023, "bitsnbobs", "CJ_LIGHTWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 861.887207, -1362.547119, 14.893444, 0.000000, 0.000000, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 860.287475, -1365.596801, 13.132430, 0.000000, 0.000000, 89.600051, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 9, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 860.271484, -1366.385498, 14.234499, 0.000000, 0.000000, -0.100018, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 860.296997, -1362.776489, 13.132430, 0.000000, 0.000000, -90.799896, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 9, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 860.279052, -1361.985229, 14.234499, 0.000000, 0.000000, -0.100018, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 860.298583, -1367.946044, 14.164498, 0.000000, 0.000000, -0.100018, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 855.572204, -1372.044433, 15.094500, 0.000000, 0.000000, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 853.342102, -1372.044433, 15.094500, 0.000000, 0.000000, 89.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19325, "lsmall_shops", "lsmall_window01", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 851.998901, -1364.036376, 14.893444, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "black16", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 851.998901, -1360.846435, 14.893444, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13077, "cunte_bar1", "black16", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 853.644653, -1359.426635, 14.893444, 0.000000, 0.000000, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 856.824523, -1359.404296, 14.893444, 0.000000, 0.000000, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 859.974426, -1359.382080, 14.893444, 0.000000, 0.000000, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 862.374389, -1359.365234, 14.893444, 0.000000, 0.000000, 90.400001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 860.281860, -1360.415405, 14.234499, 0.000000, 0.000000, -0.100018, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 860.284606, -1358.835571, 14.234499, 0.000000, 0.000000, -0.100018, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 856.289245, -1363.945922, 13.084508, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2023, "bitsnbobs", "CJ_LIGHTWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 853.819091, -1363.945922, 13.093129, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2023, "bitsnbobs", "CJ_LIGHTWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 853.819091, -1361.076171, 13.093129, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2023, "bitsnbobs", "CJ_LIGHTWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 857.308898, -1361.076171, 13.080948, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2023, "bitsnbobs", "CJ_LIGHTWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 860.758789, -1361.076171, 13.068904, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2023, "bitsnbobs", "CJ_LIGHTWOOD", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 863.353576, -1367.725585, 17.369722, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 863.353576, -1364.736083, 17.369722, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 863.353576, -1361.775878, 17.369722, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 863.353576, -1360.505737, 17.369722, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 857.734436, -1367.916137, 17.169910, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 857.734436, -1364.925903, 17.169910, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 857.734436, -1361.946166, 17.169910, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 857.734436, -1358.966064, 17.169910, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 854.324096, -1358.966064, 17.163969, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 854.324096, -1361.955688, 17.163969, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 854.324096, -1364.925415, 17.163969, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 854.324096, -1367.885375, 17.163969, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 858.468872, -1367.146606, 13.076901, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18800, "mroadhelix1", "road1-3", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 854.978393, -1367.146606, 13.089085, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18800, "mroadhelix1", "road1-3", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 858.468872, -1370.336425, 13.076901, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18800, "mroadhelix1", "road1-3", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 855.009399, -1370.336425, 13.088972, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18800, "mroadhelix1", "road1-3", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 853.828918, -1370.336425, 13.093097, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18800, "mroadhelix1", "road1-3", 0x00000000);
	tmpobjid = CreateDynamicObject(19357, 853.828918, -1367.426147, 13.093097, 0.000000, -89.799987, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18800, "mroadhelix1", "road1-3", 0x00000000);
	tmpobjid = CreateDynamicObject(2169, 858.461791, -1370.106811, 13.155060, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "wood01", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 14652, "ab_trukstpa", "wood01", 0x00000000);
	tmpobjid = CreateDynamicObject(2263, 858.847900, -1370.253417, 14.080682, 0.000000, -0.000014, -0.400146, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2640, "cj_coin_op_2", "CJ_POKERSCREEN", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
	tmpobjid = CreateDynamicObject(2263, 858.894775, -1369.273559, 14.079682, 0.000000, 0.000014, 179.599853, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, -1, "none", "none", 0xFF000000);
	tmpobjid = CreateDynamicObject(19475, 858.709899, -1369.763183, 14.080672, 89.999992, 179.999984, 89.599876, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "_", 130, "Arial", 199, 1, 0xFF000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19579, 858.850524, -1369.694091, 13.930670, 89.999992, -90.000000, 89.599868, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(19475, 858.709899, -1369.763183, 14.020671, 89.999992, 179.999984, 89.599876, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19787, "samplcdtvs1", "samplcdtv1", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "_", 130, "Arial", 199, 1, 0xFF000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19475, 858.680847, -1370.025634, 13.960669, 0.000000, 270.000000, 89.599906, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19475, 859.131286, -1370.028808, 13.960669, 0.000000, 270.000000, 89.599906, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19475, 859.135192, -1370.032714, 13.959669, 0.000000, 270.000000, 89.599906, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19475, 858.678894, -1370.029541, 13.959669, 0.000000, 270.000000, 89.599906, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(19874, 859.203613, -1370.075561, 13.950699, 0.000007, 0.000000, -90.400077, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(11749, 859.212585, -1370.035522, 13.901842, 84.999969, 179.999984, 89.599906, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(19922, 853.648437, -1369.156738, 13.187625, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14650, "ab_trukstpc", "mp_CJ_WOOD5", 0x00000000);
	tmpobjid = CreateDynamicObject(2248, 857.008117, -1370.545410, 13.696741, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "BLUE_FABRIC", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "BLUE_FABRIC", 0x00000000);
	tmpobjid = CreateDynamicObject(2248, 857.778137, -1371.455566, 13.696741, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 1714, "cj_office", "BLUE_FABRIC", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 1714, "cj_office", "BLUE_FABRIC", 0x00000000);
	tmpobjid = CreateDynamicObject(2714, 852.187377, -1368.940551, 15.285499, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "Quem esta assistindo?", 120, "Arial", 50, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2714, 852.194152, -1369.911499, 15.385597, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "Netflix", 120, "Arial", 35, 1, 0xFFFF0000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2687, 852.195129, -1369.558349, 14.805153, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0xFFFF0000, 0);
	tmpobjid = CreateDynamicObject(2687, 852.190917, -1368.957763, 14.805153, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0xFF5AC597, 0);
	tmpobjid = CreateDynamicObject(2687, 852.186584, -1368.337158, 14.705057, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "+", 10, "Arial", 20, 0, 0xFFFFFFFF, 0x00000000, 0);
	tmpobjid = CreateDynamicObject(2687, 852.187011, -1368.397216, 14.415140, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "Adicionar", 60, "Arial", 20, 1, 0xFFFFFFFF, 0x00000000, 0);
	tmpobjid = CreateDynamicObject(2687, 852.190917, -1368.957763, 14.455422, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "{ffffff}Trevor", 60, "Arial", 35, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2687, 852.195129, -1369.558349, 14.455422, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "{ffffff}Gugu", 60, "Arial", 35, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2687, 852.205383, -1369.596679, 14.995460, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, ".", 90, "Arial", 90, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2687, 852.204101, -1369.416503, 14.995460, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, ".", 90, "Arial", 90, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2687, 852.191406, -1368.890747, 14.777994, -0.000000, 618.000000, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "(", 90, "Arial", 50, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2687, 852.201538, -1369.047119, 14.995460, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, ".", 90, "Arial", 90, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2687, 852.200317, -1368.866943, 14.995460, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, ".", 90, "Arial", 90, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(2687, 852.195495, -1369.478271, 14.755227, -0.000000, 618.000000, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_church_grass_alt", 0x00000000);
	SetDynamicObjectMaterialText(tmpobjid, 0, "(", 90, "Arial", 50, 1, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(18762, 860.905639, -1366.134399, 11.909355, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 861.885681, -1366.134399, 11.909355, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 862.875671, -1366.134399, 11.909355, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 862.865661, -1365.144409, 11.909355, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, 862.865661, -1364.154418, 11.909355, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14652, "ab_trukstpa", "CJ_WOOD6", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 858.395080, -1367.707397, 17.171043, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 858.395080, -1364.747314, 17.171043, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 858.395080, -1361.766845, 17.171043, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, 858.395080, -1358.796997, 17.171043, 0.000000, 89.900009, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "white", 0x00000000);
	tmpobjid = CreateDynamicObject(3928, 839.379760, -1375.645263, 21.772068, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18646, "matcolours", "red-4", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 18646, "matcolours", "red-4", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19325, 863.369384, -1372.257568, 17.618442, 0.000000, 0.000000, 90.099975, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "{ffffff}BOPE", 80, "Arial", 25, 1, 0x00000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19325, 862.023071, -1362.759399, 15.258451, 0.000000, 0.000000, 90.099975, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "{ffffff}BOPE", 80, "Arial", 25, 1, 0x00000000, 0x00000000, 1);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(1635, 860.914001, -1359.800048, 16.085899, 0.000000, 0.000000, 89.981842, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 856.017272, -1365.358398, 13.108829, 0.000000, 0.000000, -178.900009, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 855.347473, -1365.370727, 13.108829, 0.000000, 0.000000, -178.900009, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 854.677734, -1365.383300, 13.108829, 0.000000, 0.000000, -178.900009, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 854.028076, -1365.394775, 13.108829, 0.000000, 0.000000, -178.900009, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 853.388305, -1365.407226, 13.108829, 0.000000, 0.000000, -178.900009, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 852.738403, -1365.419921, 13.108829, 0.000000, 0.000000, -178.900009, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2311, 852.495605, -1362.497314, 13.161013, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 852.410888, -1359.781616, 13.108829, 0.000000, 0.000000, 0.499977, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 853.070678, -1359.775756, 13.108829, 0.000000, 0.000000, 0.499977, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 853.740722, -1359.769653, 13.108829, 0.000000, 0.000000, 0.499977, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 854.390686, -1359.763916, 13.108829, 0.000000, 0.000000, 0.499977, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 855.020812, -1359.758422, 13.108829, 0.000000, 0.000000, 0.499977, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11729, 855.680786, -1359.753051, 13.108829, 0.000000, 0.000000, 0.499977, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 860.746215, -1371.570678, 13.155042, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 861.576354, -1371.570678, 13.155042, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 861.576354, -1370.660766, 13.155042, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 860.746215, -1370.660766, 13.155042, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 860.746215, -1369.700683, 13.155042, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 860.746215, -1368.610839, 13.155042, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 860.746215, -1367.470581, 13.155042, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 861.596435, -1369.700683, 13.155042, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 861.596313, -1368.610839, 13.155042, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1722, 861.596008, -1367.470581, 13.155042, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2007, 859.723205, -1371.453125, 13.145056, 0.000000, 0.000000, -179.999969, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2007, 858.733154, -1371.453125, 13.145056, 0.000000, 0.000000, -179.999969, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1714, 859.009155, -1370.664428, 13.183403, 0.000000, 0.000000, 178.800003, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19808, 858.831176, -1370.075439, 13.970680, 0.000000, -0.000007, -0.400100, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1726, 852.978759, -1366.320800, 13.074451, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1704, 858.983215, -1366.306762, 13.157909, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1721, 859.327331, -1368.858032, 13.206747, 0.000000, 0.000000, 179.399993, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1721, 858.517333, -1368.849487, 13.206747, 0.000000, 0.000000, 179.399993, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2010, 857.797607, -1371.433593, 13.837537, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2010, 857.077575, -1370.543212, 13.877538, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 852.698486, -1370.467651, 13.157874, 0.000000, 0.000000, 178.600021, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 853.978271, -1370.498901, 13.157874, 0.000000, 0.000000, 178.600021, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 855.008056, -1370.524047, 13.157874, 0.000000, 0.000000, -169.099975, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 854.631042, -1367.959594, 13.157874, 0.000000, 0.000000, -0.100000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 853.691101, -1367.958007, 13.157874, 0.000000, 0.000000, -0.100000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1715, 852.841125, -1367.956298, 13.157874, 0.000000, 0.000000, -0.100000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19786, 852.021850, -1368.963134, 14.945167, -0.000007, 0.000014, 90.399963, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(11745, 853.926147, -1362.638793, 13.794269, 0.000000, 0.000000, 48.099998, object_world, object_int, -1, 300.00, 300.00); 

	//=====================================================================================================

	tmpobjid = CreateDynamicObject(19790, 1311.089233, -895.899291, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1316.079345, -895.899291, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1321.079223, -895.899291, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1326.079345, -895.899291, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.192993, -898.371032, 38.108367, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1326.079345, -890.909667, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1326.079345, -885.940063, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1321.129760, -890.960144, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1316.210083, -890.960144, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1311.200561, -890.960144, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1321.139404, -885.940063, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1321.139404, -880.960083, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1316.138916, -880.960083, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19790, 1316.138916, -885.950439, 33.638393, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18065, "ab_sfammumain", "gun_floor1", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.402587, -898.376525, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1326.973876, -898.400268, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.764770, -898.394714, 38.198394, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1319.594604, -898.387634, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.767333, -896.721130, 42.043411, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.566650, -896.724609, 41.362922, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.566650, -896.721313, 41.202957, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 1315.018798, -898.429626, 38.611148, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(1499, 1318.027832, -898.384216, 38.611148, 0.000000, 0.000000, -179.300003, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-70-percent", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19297, "matlights", "invisible", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.564819, -898.389404, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.566650, -896.728210, 41.532886, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.566650, -896.731628, 41.692848, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.566650, -896.734741, 41.842807, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.566650, -896.737731, 41.992782, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.566650, -896.738891, 42.042770, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.756835, -896.710021, 41.862812, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.756835, -896.706542, 41.702854, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-40-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1328.499633, -896.886108, 40.348400, 0.000000, 0.000000, -179.199920, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1328.455322, -893.686645, 40.348400, 0.000000, 0.000000, -179.199920, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1328.440429, -890.476989, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1328.429321, -887.267089, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1328.421508, -885.036682, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.701293, -885.088012, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.707275, -886.828308, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.689941, -881.888549, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.683471, -880.008361, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.574096, -880.063598, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.580200, -881.843627, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1308.728515, -890.045471, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1308.739624, -893.245239, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1308.750488, -896.405029, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1308.751464, -896.745117, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1312.211059, -888.414428, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.249755, -888.411193, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.409667, -888.420471, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.599365, -888.426086, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1321.779052, -888.431579, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.039306, -888.431945, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.056274, -878.541809, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.916381, -878.536437, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.736083, -878.530944, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.265747, -878.530212, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1326.907592, -883.520874, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1325.106567, -883.517822, 40.348400, 0.000000, 0.000000, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.584228, -882.933654, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.604370, -888.633728, 40.348400, 0.000000, 0.000000, -179.799942, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1326.758178, -885.480407, 42.057846, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.558959, -885.491333, 42.057846, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.359741, -885.502380, 42.057846, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.189208, -885.513427, 42.057846, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.389526, -885.519714, 42.057846, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.377685, -882.040649, 42.130718, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.371704, -880.321044, 42.166740, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.571777, -880.309997, 42.166740, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1321.752319, -880.298889, 42.166740, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1321.972534, -880.298156, 42.166740, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1321.978759, -882.017944, 42.130710, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.818847, -882.028991, 42.130710, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.278808, -882.034362, 42.130710, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.401611, -888.998840, 41.984985, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.581665, -888.987792, 41.984985, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1321.751831, -888.976501, 41.984985, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1324.941650, -888.965332, 41.984985, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1326.771362, -888.958984, 41.984985, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1326.783325, -892.428100, 41.912307, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1326.795288, -895.887329, 41.839843, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1326.797607, -896.567199, 41.825588, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.567626, -896.588989, 41.825588, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.627563, -896.595703, 41.825588, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-80-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.387573, -896.613830, 41.825588, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.398071, -896.624145, 41.825588, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.385864, -893.144836, 41.898475, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.375610, -890.265380, 41.958820, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.485595, -890.254638, 41.958820, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.495239, -893.194335, 41.897232, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.535034, -893.293884, 41.894924, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1319.724609, -893.282897, 41.894924, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.914306, -893.271728, 41.894924, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1325.304321, -893.263427, 41.894924, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1325.296752, -891.093933, 41.940376, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.127319, -891.104858, 41.940376, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.937255, -891.116027, 41.940376, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.937500, -891.126342, 41.940376, 0.000000, -91.200019, 90.199981, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "grey-90-percent", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.767089, -896.814392, 42.191482, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1326.947753, -896.819946, 42.191482, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.027832, -896.820068, 42.191482, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.577880, -896.808715, 42.191482, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.377685, -896.803100, 42.191482, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1314.176757, -896.797729, 42.191482, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.967407, -896.792297, 42.191482, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.137084, -896.790832, 42.191482, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.143310, -893.331787, 42.263935, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.353027, -893.337341, 42.263935, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.553100, -893.343017, 42.263935, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1319.753051, -893.348571, 42.263935, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.932739, -893.354064, 42.263935, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1326.122680, -893.359436, 42.263935, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.023437, -893.360778, 42.263935, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.029174, -889.861450, 42.337249, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.869140, -889.855773, 42.337249, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.679199, -889.850097, 42.337249, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.509277, -889.844604, 42.337249, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1314.339111, -889.839111, 42.337249, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1311.129638, -889.833312, 42.337249, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.149536, -889.831665, 42.337249, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.035766, -886.362304, 42.410560, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.826049, -886.356689, 42.410560, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.625732, -886.351135, 42.410560, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.435791, -886.345642, 42.410560, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.045776, -886.341491, 42.410560, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.051879, -882.862365, 42.483440, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.232055, -882.867675, 42.483440, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1321.401977, -882.873046, 42.483440, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.262329, -882.874511, 42.483440, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1325.458251, -885.039489, 42.438217, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.048339, -885.042236, 42.438217, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.207885, -879.953552, 42.474620, 0.000000, -91.100013, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1319.017822, -879.947937, 42.474620, 0.000000, -91.100013, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.847778, -879.942382, 42.474620, 0.000000, -91.100013, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.067138, -879.941101, 42.474620, 0.000000, -91.100013, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.031250, -896.823608, 42.371456, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.830200, -896.817749, 42.371456, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.630126, -896.811889, 42.371456, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.430541, -896.806213, 42.371456, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1314.230957, -896.800598, 42.371456, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1311.051391, -896.795104, 42.371456, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.131103, -896.793518, 42.371456, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.038452, -893.325073, 42.444713, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.868530, -893.319580, 42.444713, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.669677, -893.313964, 42.444713, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.460083, -893.308288, 42.444713, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1314.270385, -893.302673, 42.444713, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1311.060424, -893.296997, 42.444713, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.129760, -893.295654, 42.444713, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.135498, -889.796264, 42.518016, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.344970, -889.801818, 42.518016, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.525268, -889.807434, 42.518016, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1319.714843, -889.813049, 42.518016, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.904907, -889.818603, 42.518016, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1326.095092, -889.824340, 42.518016, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.045288, -889.826171, 42.518016, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.052368, -885.027038, 42.618572, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.051635, -886.356994, 42.590682, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.861572, -886.351562, 42.590682, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.661743, -886.345947, 42.590682, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.472167, -886.340209, 42.590682, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.051757, -886.335876, 42.590682, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.057739, -882.856872, 42.663562, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.217407, -882.862487, 42.663562, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1321.347167, -882.867980, 42.663562, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.267578, -882.869567, 42.663562, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1325.022460, -885.023376, 42.618572, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.272583, -879.970214, 42.724304, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1319.103393, -879.964965, 42.724304, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.903076, -879.959411, 42.724304, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.062622, -879.958007, 42.724304, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.031250, -896.827453, 42.541412, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.031250, -896.830810, 42.701385, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.821044, -896.821777, 42.541412, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.620971, -896.816223, 42.541412, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.411010, -896.810607, 42.541412, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1314.221313, -896.804809, 42.541412, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1311.041259, -896.799255, 42.541412, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.141113, -896.797729, 42.541412, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.841064, -896.825195, 42.701385, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.651123, -896.819396, 42.701385, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.461059, -896.813842, 42.701385, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1311.081665, -896.802490, 42.701385, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1314.271484, -896.808166, 42.701385, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.121459, -896.800781, 42.701385, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.027832, -896.834350, 42.881328, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.036743, -893.348022, 42.614322, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.043212, -889.888793, 42.686763, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.049560, -886.409790, 42.759643, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.051757, -885.029968, 42.788547, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.841186, -885.024353, 42.788547, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.267456, -881.542358, 42.861446, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.268676, -879.972229, 42.894374, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1319.098632, -879.966918, 42.894374, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.948730, -879.961547, 42.894374, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.057983, -879.959899, 42.894374, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.052001, -883.439025, 42.821491, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.045654, -886.908264, 42.748825, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1311.839843, -889.801879, 42.688083, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.139282, -889.798828, 42.688083, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.133300, -893.308227, 42.614559, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.133300, -893.311462, 42.774532, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.139770, -889.822204, 42.847625, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.299804, -889.828002, 42.847625, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.035766, -886.341613, 42.920726, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.041870, -882.852355, 42.993820, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.046997, -879.952819, 43.054557, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.226806, -879.958618, 43.054557, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1321.416381, -879.964355, 43.054557, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.276855, -879.965759, 43.054557, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.270507, -883.424621, 42.982105, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1325.447387, -885.040039, 42.948394, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.048095, -885.042724, 42.948394, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.041870, -888.461975, 42.876781, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.031982, -894.320800, 42.754043, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.035888, -891.951049, 42.803688, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18646, "matcolours", "red-4", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.837524, -896.828613, 42.881328, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.637695, -896.822998, 42.881328, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.457885, -896.817382, 42.881328, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1314.258178, -896.811767, 42.881328, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1311.058593, -896.806091, 42.881328, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.127807, -896.804504, 42.881328, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.134277, -893.315490, 42.954414, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1310.130615, -889.826477, 43.027492, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1313.330322, -889.832092, 43.027492, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.036621, -886.345642, 43.100597, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.043212, -882.846862, 43.173904, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1315.047851, -879.927246, 43.235080, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.257202, -879.932800, 43.235080, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1321.437011, -879.938476, 43.235080, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.277587, -879.939880, 43.235080, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.270996, -883.418945, 43.162208, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1325.479003, -885.034362, 43.128475, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.060302, -885.037231, 43.128475, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.053710, -888.506286, 43.055786, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.047485, -891.995422, 42.982700, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1327.042968, -894.624877, 42.927616, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.843872, -893.339294, 42.954441, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1320.643554, -893.333679, 42.954441, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1317.453247, -893.327941, 42.954441, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1314.262695, -893.322387, 42.954441, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1312.182617, -893.318725, 42.954441, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.448974, -889.867065, 43.026908, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1319.598510, -889.872863, 43.026908, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1322.708007, -889.878173, 43.026908, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1324.638427, -889.881652, 43.026908, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1324.644287, -886.642272, 43.094760, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1321.584594, -886.636840, 43.094760, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1318.424926, -886.631408, 43.094760, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.054687, -886.627319, 43.094760, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1319.240356, -883.293518, 43.164714, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1316.890258, -883.289306, 43.164714, 0.000000, -91.200019, 89.899986, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19130, "matarrows", "green", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1323.754150, -898.371093, 39.865158, 0.000000, 0.000000, 90.100036, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1309.369262, -898.358154, 40.478282, 0.000000, 0.000000, -89.699958, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1310.912597, -896.675781, 41.778163, 0.000000, 89.699958, -89.699958, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1311.002685, -896.675292, 41.778163, 0.000000, 89.699958, -89.699958, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1311.002685, -896.674438, 41.928161, 0.000000, 89.699958, -89.699958, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1310.932617, -896.674804, 41.928161, 0.000000, 89.699958, -89.699958, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1310.932617, -896.674255, 42.018154, 0.000000, 89.699958, -89.699958, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1311.132568, -896.673156, 42.018154, 0.000000, 89.699958, -89.699958, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3629, "arprtxxref_las", "dirtywhite", 0x00000000);
	tmpobjid = CreateDynamicObject(19426, 1310.979858, -898.349609, 40.478282, 0.000000, 0.000000, -89.699958, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 17588, "lae2coast_alpha", "plainglass", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tmpobjid = CreateDynamicObject(1331, 1329.159057, -884.571533, 39.124313, 0.000000, 0.000000, -90.899986, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1891, 1315.745483, -891.536437, 38.562328, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1891, 1311.565429, -891.536437, 38.562328, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1891, 1310.895263, -895.637451, 38.562328, 0.000000, 0.000000, 90.100006, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1891, 1315.745483, -895.256713, 38.562328, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1776, 1322.887939, -888.925903, 39.719673, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1776, 1321.687622, -888.925903, 39.719673, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19640, 1320.123901, -889.029846, 38.597583, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1994, 1325.513549, -897.779602, 38.639129, 0.000000, 0.000000, 89.499977, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1994, 1325.492187, -896.769531, 38.639129, 0.000000, 0.000000, -90.500045, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1885, 1318.480590, -897.792663, 38.612129, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1885, 1318.480590, -897.792663, 39.062129, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2541, 1318.560668, -888.964965, 38.571510, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2541, 1318.560668, -888.964965, 40.011497, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2541, 1317.560668, -888.964965, 38.571510, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2541, 1316.590209, -888.964965, 38.571510, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2541, 1316.590209, -888.964965, 40.001491, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2541, 1317.610229, -888.964965, 40.001491, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1514, 1325.417602, -896.646301, 39.735744, 0.000000, 0.000000, -89.199966, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2551, 1327.914550, -897.687927, 39.619369, 0.000000, 0.000000, -88.499984, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2496, 1328.025146, -897.958129, 40.714935, 0.000000, 0.000000, -91.500007, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2494, 1328.045898, -897.538574, 40.716537, 0.000000, 0.000000, -91.499969, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19638, 1323.203857, -882.697937, 38.627250, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2593, 1320.758422, -893.292724, 39.520793, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2594, 1320.748779, -893.272827, 39.641574, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19638, 1323.203857, -881.887817, 38.627250, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19638, 1323.203857, -881.887817, 38.797241, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19638, 1323.203857, -882.697937, 38.797241, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19638, 1323.203857, -882.697937, 38.967231, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19638, 1323.203857, -881.897827, 38.967231, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(3761, 1314.544799, -881.734985, 39.844753, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1271, 1314.104003, -885.527709, 38.952766, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1271, 1314.104003, -886.277709, 38.952766, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1271, 1314.104003, -887.027587, 38.952766, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1271, 1314.104003, -887.777893, 38.952766, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1271, 1314.104003, -887.427917, 39.622749, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1271, 1314.104003, -886.707946, 39.622749, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1271, 1314.104003, -885.577880, 39.622749, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1271, 1314.104003, -887.048034, 40.282752, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(1431, 1322.288085, -879.002319, 39.135353, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(3633, 1320.609375, -879.315734, 39.116523, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(3633, 1319.339721, -879.315734, 39.116523, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2332, 1317.051879, -879.064819, 39.084407, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19173, 1328.345825, -892.816528, 40.151348, 0.000000, 0.000000, -89.500007, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2267, 1328.294311, -890.256958, 39.821880, 0.000000, 0.000000, -88.899978, object_world, object_int, -1, 300.00, 300.00); 


	//============================================================================

	tmpobjid = CreateDynamicObject(19362, 1480.914916, -1772.744262, 42.365192, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "bandanagold", 0x00000000);
	tmpobjid = CreateDynamicObject(19604, 1480.006469, -1772.647705, 45.619338, 89.999931, -0.499998, -179.499969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "{ffffff}ELDORADO", 50, "Arial", 25, 1, 0x00000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(19362, 1479.114746, -1772.744262, 42.365192, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "bandanagold", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1479.114746, -1772.744262, 45.815200, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "bandanagold", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1479.114746, -1772.744262, 48.865207, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "bandanagold", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1480.906372, -1772.744262, 45.815200, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "bandanagold", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1480.906372, -1772.744262, 48.855194, 0.000000, 0.000000, -90.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "bandanagold", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1477.536376, -1773.976074, 48.875198, 0.000000, 0.000000, -176.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1477.536376, -1773.976074, 45.415180, 0.000000, 0.000000, -176.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1477.536376, -1773.976074, 42.365169, 0.000000, 0.000000, -176.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1482.628906, -1773.709106, 42.365169, 0.000000, 0.000000, -176.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1482.628906, -1773.709106, 45.815170, 0.000000, 0.000000, -176.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1482.628906, -1773.709106, 48.855163, 0.000000, 0.000000, -176.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1480.973632, -1773.796386, 50.652614, 0.000000, 90.199996, -176.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1479.186401, -1773.889770, 50.646358, 0.000000, 90.199996, -176.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1479.221435, -1773.887939, 40.686428, 0.000000, 90.199996, -176.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	tmpobjid = CreateDynamicObject(19362, 1480.969848, -1773.796508, 40.692516, 0.000000, 90.199996, -176.999969, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "black", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	return 1;
}
