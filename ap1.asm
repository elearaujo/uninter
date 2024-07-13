;***************************************************************************************
; Aluno: Eleandro Alves de Araujo
; RU:   1195881
; Nome do arquivo: ap1.asm
; Nome do programa: PISCA_LED
; Objetivo do programa: Piscar os leds D6, D9 e D11 sequencialmente em loop constante
;****************************************************************************************

;*********************  Definições do microcontrolador **********************************

	#include p16F877a.inc  
	; Inclui o arquivo de definição específico para o microcontrolador PIC16F877A, que contém definições de registradores, bits de configuração, etc.

	__config _HS_OSC & _WDT_OFF & _LVP_OFF & _PWRTE_ON 
   			 		; Define as configurações de configuração (fuses) do microcontrolador:
   					; _HS_OSC  : Seleciona o oscilador de alta velocidade (High-Speed Oscillator)
    					; _WDT_OFF : Desliga o Watchdog Timer (WDT)
    					; _LVP_OFF : Desativa a Programação em Baixa Tensão (Low Voltage Programming)
    					; _PWRTE_ON: Ativa o Power-up Timer (PWRTE), que proporciona um atraso na inicialização para estabilizar a alimentação


;********************* Início do programa ************************************************

	ORG 0				; Posiciona o ponteiro para o endereço 0x0 de memória, onde o vetor de reset está localizado

;********************* Declaração de variáveis ********************************************   

DELAY EQU 0x20   			; Define o registrador DELAY no endereço de memória 0x20 (registrador de uso geral)
VEZES EQU 0x21   			; Define o registrador VEZES no endereço de memória 0x21 (registrador de uso geral)


;********************* Definição de Registradores e Porta *********************************  

   BSF     STATUS,RP0		; Seleciona o Banco 1 (Register Page 0) colocando em nível alto para manipulação dos ports TRISA e TRISD
   MOVLW   b'00000000'		; Carrega '00000000' no registrador W (todos os bits em 0)
   MOVWF   TRISA		; Configura todos os pinos do PORTA como saída, porta onde estão ligados os LEDs
   MOVLW   b'00000000'		; Carrega '00000000' no registrador W (todos os bits em 0)
   MOVWF   TRISD		; Configura todos os pinos do PORTD como saída      
   BCF     STATUS,RP0		; Limpa o bit RP0 no registrador STATUS, definindo-o em nível baixo encerrando a manipulação dos ports TRISA e TRISD
   BSF     PORTA,5		; Coloca 5V (nível lógico 1) no pino RA5 - acionando o transistor que ativará os LEDs


;********************* Função (ou Rotina) MAIN *********************************************  
 
LOOP				; Bloco principal do programa
    MOVLW b'00000001'		; Carrega '00000001' no registrador W
    MOVWF PORTD			; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) somente no pino PORTD (RD0)
    CALL PERDE_TEMPO		; Chama o procedimento PERDE_TEMPO para poder visualizar o LED D6 aceso
                    		 
    MOVLW b'00001000'		; Carrega '00001000' no registrador W
    MOVWF PORTD			; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) somente no pino PORTD (RD3)
    CALL PERDE_TEMPO		; Chama o procedimento PERDE_TEMPO para poder visualizar o LED D9 aceso
                       		 
    MOVLW b'00100000'		; Carrega '00100000' no registrador W
    MOVWF PORTD			; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) somente no pino PORTD (RD5)
    CALL PERDE_TEMPO		; Chama o procedimento PERDE_TEMPO para poder visualizar o LED D11 aceso

    GOTO LOOP			; Manda o programa pular para o início do bloco LOOP mantendo o programa em execução eterna
                       		 

PERDE_TEMPO			; Procedimento que força o PIC a perder tempo (delay)
    MOVLW d'1'			; Carrega o valor decimal 1 no registrador W (Para gravar no PIC utilizar 80, no simulador SENAI use 1)
    MOVWF VEZES			; Move o valor de W para o registrador VEZES

LOOP_VEZES			; Procedimento de loop utilizado para gerar tempo na instrução PERDE_TEMPO
    MOVLW d'1'			; Carrega o valor decimal 1 no registrador W (Para gravar no PIC utilizar 255, no simulador SENAI use 1)
    MOVWF DELAY			; Move o valor de W para o registrador DELAY
    CALL DELAY_US		; Chama a sub-rotina DELAY_US para gerar um atraso curto
    DECFSZ VEZES,1		; Decrementa o registrador VEZES, pula a próxima instrução se o resultado for zero
    GOTO LOOP_VEZES		; Volta para o início do loop LOOP_VEZES se VEZES não for zero
    RETURN			; Retorna da rotina PERDE_TEMPO

DELAY_US			; Procedimento gerar tempo na instrução LOOP_VEZES
    NOP				; No Operation: instrução que não faz nada, usada para ajustar o tempo
    NOP				; No Operation: outra instrução NOP para ajustar o tempo
    DECFSZ DELAY,1		; Decrementa o registrador DELAY, pula a próxima instrução se o resultado for zero
    GOTO DELAY_US		; Volta para o início da sub-rotina DELAY_US se DELAY não for zero
    RETURN			; Retorna da sub-rotina DELAY_US

    END				; Marcador de última linha do programa
