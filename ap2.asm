;***************************************************************************************
; Aluno: Eleandro Alves de Araujo
; RU:   1195881
; Nome do arquivo: ap2.asm
; Nome do programa: ESCREVE_RU_DISPLAY_7SEGMENTOS
; Objetivo do programa: Acender uma �nica vez o �ltimo n�mero do RU no display de 7 segmentos identificado como DISP1 no Kit Senai, o n�mero exibido dever ser 1.

;*********************  Defini��es do microcontrolador **********************************

	#include p16F877a.inc  ; Inclui o arquivo de defini��o espec�fico para o microcontrolador PIC16F877A

	__config _HS_OSC & _WDT_OFF & _LVP_OFF & _PWRTE_ON 
                           ; Define as configura��es de configura��o (fuses) do microcontrolador:
                           ; _HS_OSC  : Seleciona o oscilador de alta velocidade (High-Speed Oscillator)
                           ; _WDT_OFF : Desliga o Watchdog Timer (WDT)
                           ; _LVP_OFF : Desativa a Programa��o em Baixa Tens�o (Low Voltage Programming)
                           ; _PWRTE_ON: Ativa o Power-up Timer (PWRTE), que proporciona um atraso na inicializa��o para estabilizar a alimenta��o

;********************* In�cio do programa ************************************************

	ORG 0                  ; Posiciona o ponteiro para o endere�o 0x0 de mem�ria, onde o vetor de reset est� localizado

;********************* Defini��o de Registradores e Porta *********************************  

	BSF     STATUS,RP0  	; Seleciona o Banco 1 (Register Page 0) colocando em n�vel alto para manipula��o dos ports TRISD e TRISE
 	MOVLW   b'00000000' 	; Carrega '00000000' no registrador W 
 	MOVWF   TRISE       	; Configura PORTE como sa�da (todos os bits em 0), porta onde est� ligado o transistor de chaveamento do DISP1
 	MOVLW   b'00000000' 	; Carrega '00000000' no registrador W 
 	MOVWF   TRISD       	; Configura PORTD como sa�da (todos os bits em 0), porta onde est� ligado o display de 7 segmentos      
 	BCF     STATUS,RP0  	; Limpa o bit RP0 no registrador STATUS, definindo-o em n�vel baixo encerrando a manipula��o dos ports TRISD e TRISE
 	BSF     PORTE,0     	; Coloca 5V (n�vel l�gico 1) no pino RE0, pino onde est� conectada a base do transistor de chaveamento e acionando-o

;********************* Fun��o (ou Rotina) MAIN *********************************************  
 
LOOP                		; Bloco principal do programa
	MOVLW b'00000110'  		; Carrega '00000110' no registrador W  para ligar os segmentos b e c formando o n�mero 1 
    MOVWF PORTD        		; Envia o conte�do de W para o registrador PORTD, ligando os seguimentos b e c do display para acender o n�mero 1 

    END                		; Marcador de �ltima linha do programa
