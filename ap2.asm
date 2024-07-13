;***************************************************************************************
; Aluno: Eleandro Alves de Araujo
; RU:   1195881
; Nome do arquivo: ap2.asm
; Nome do programa: ESCREVE_RU_DISPLAY_7SEGMENTOS
; Objetivo do programa: Acender uma única vez o último número do RU no display de 7 segmentos identificado como DISP1 no Kit Senai, o número exibido dever ser 1.

;*********************  Definições do microcontrolador **********************************

	#include p16F877a.inc  ; Inclui o arquivo de definição específico para o microcontrolador PIC16F877A

	__config _HS_OSC & _WDT_OFF & _LVP_OFF & _PWRTE_ON 
                           ; Define as configurações de configuração (fuses) do microcontrolador:
                           ; _HS_OSC  : Seleciona o oscilador de alta velocidade (High-Speed Oscillator)
                           ; _WDT_OFF : Desliga o Watchdog Timer (WDT)
                           ; _LVP_OFF : Desativa a Programação em Baixa Tensão (Low Voltage Programming)
                           ; _PWRTE_ON: Ativa o Power-up Timer (PWRTE), que proporciona um atraso na inicialização para estabilizar a alimentação

;********************* Início do programa ************************************************

	ORG 0                  ; Posiciona o ponteiro para o endereço 0x0 de memória, onde o vetor de reset está localizado

;********************* Definição de Registradores e Porta *********************************  

	BSF     STATUS,RP0  	; Seleciona o Banco 1 (Register Page 0) colocando em nível alto para manipulação dos ports TRISD e TRISE
 	MOVLW   b'00000000' 	; Carrega '00000000' no registrador W 
 	MOVWF   TRISE       	; Configura PORTE como saída (todos os bits em 0), porta onde está ligado o transistor de chaveamento do DISP1
 	MOVLW   b'00000000' 	; Carrega '00000000' no registrador W 
 	MOVWF   TRISD       	; Configura PORTD como saída (todos os bits em 0), porta onde está ligado o display de 7 segmentos      
 	BCF     STATUS,RP0  	; Limpa o bit RP0 no registrador STATUS, definindo-o em nível baixo encerrando a manipulação dos ports TRISD e TRISE
 	BSF     PORTE,0     	; Coloca 5V (nível lógico 1) no pino RE0, pino onde está conectada a base do transistor de chaveamento e acionando-o

;********************* Função (ou Rotina) MAIN *********************************************  
 
LOOP                		; Bloco principal do programa
	MOVLW b'00000110'  		; Carrega '00000110' no registrador W  para ligar os segmentos b e c formando o número 1 
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, ligando os seguimentos b e c do display para acender o número 1 

    END                		; Marcador de última linha do programa
