;*****************************************************************************
; Aluno: Eleandro Alves de Araujo
; RU:   1195881
; Nome do arquivo: ap3.asm
; Nome do programa: ESCREVE_DISPLAY_7SEGMENTOS
; Objetivo do programa: Exibir uma única vez os caracteres de 0 a 9 e de A a F no display de 7 segmentos, no Kit Senai este display está identificado como DISP1 

;*********************  Definições do microcontrolador ***************************

	#include p16F877a.inc  ; Inclui o arquivo de definição específico para o microcontrolador PIC16F877A, que contém definições de registradores, bits de configuração, etc.

	__config _HS_OSC & _WDT_OFF & _LVP_OFF & _PWRTE_ON 
                           ; Define as configurações de configuração (fuses) do microcontrolador:
                           ; _HS_OSC  : Seleciona o oscilador de alta velocidade (High-Speed Oscillator)
                           ; _WDT_OFF : Desliga o Watchdog Timer (WDT)
                           ; _LVP_OFF : Desativa a Programação em Baixa Tensão (Low Voltage Programming)
                           ; _PWRTE_ON: Ativa o Power-up Timer (PWRTE), que proporciona um atraso na inicialização para estabilizar a alimentação


;********************* Início do programa ***************************************
	ORG 0                  ; Posiciona o ponteiro para o endereço 0x0 de memória, onde o vetor de reset está localizado

;********************* Declaração de variáveis **********************************   

DELAY EQU 0x20   			; Define o registrador DELAY no endereço de memória 0x20 (registrador de uso geral)
VEZES EQU 0x21    			; Define o registrador VEZES no endereço de memória 0x21 (registrador de uso geral)

;********************* Definição de Registradores e Porta **********************************  

	BSF     STATUS,RP0  	; Seleciona o Banco 1 (Register Page 0) colocando em nível alto para manipulação dos ports TRISD e TRISE
 	MOVLW   b'00000000' 	; Carrega '00000000' no registrador W 
 	MOVWF   TRISE       	; Configura PORTE como saída (todos os bits em 0), porta onde está ligado o transistor de chaveamento do DISP1
 	MOVLW   b'00000000' 	; Carrega '00000000' no registrador W 
 	MOVWF   TRISD       	; Configura PORTD como saída (todos os bits em 0), porta onde está ligado o display de 7 segmentos      
 	BCF     STATUS,RP0  	; Limpa o bit RP0 no registrador STATUS, definindo-o em nível baixo encerrando a manipulação dos ports TRISD e TRISE
 	BSF     PORTE,0     	; Coloca 5V (nível lógico alto) no pino RE0, pino onde está conectada a base do transistor de chaveamento e acionando-o

;********************* Função (ou Rotina) MAIN *********************************************  
 
LOOP                		; Bloco principal do programa

							; Início da escrita dos números de 0 a 9 no display de 7 segmentos

	MOVLW b'00111111'  		; Carrega '00111111' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, b, c, d, e e f
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere 0
                    		 
	MOVLW b'00000110'  		; Carrega '00000110' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos b e c
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere 1
                       		 
	MOVLW b'01011011'  		; Carrega '01011011' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, b, d, e e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere 2
                       		 
	MOVLW b'01001111'  		; Carrega '01001111' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, b, c, d e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere 3

	MOVLW b'01100110'  		; Carrega '01100110' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos b, c, f e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere 4

	MOVLW b'01101101'  		; Carrega '01101101' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, c, d, f e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere 5

	MOVLW b'01111101'  		; Carrega '01111101' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, b, c, d, f e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere 6

	MOVLW b'00000111'  		; Carrega '00000111' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, b e c
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere 7

	MOVLW b'01111111'  		; Carrega '01111111' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, b, c, d, e, f e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere 8

	MOVLW b'01101111'  		; Carrega '01101111' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, b, c, d e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere 9

							; Início da escrita das letras A, B, C, D, E e F no display de 7 segmentos

	MOVLW b'01110111'  		; Carrega '01110111' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, b, c, e, f e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere A

	MOVLW b'01111100'  		; Carrega '01111100' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos c, d, e, f e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere B

	MOVLW b'00111001'  		; Carrega '00111001' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, d, e e f
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere C

	MOVLW b'01011110'  		; Carrega '01011110' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos b, c, d, e e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere D

	MOVLW b'01111001'  		; Carrega '01111001' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, d, e, f e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere E

	MOVLW b'01110001'  		; Carrega '01110001' no registrador W
    MOVWF PORTD        		; Envia o conteúdo de W para o registrador PORTD, colocando nível lógico alto (+5V) nos segmentos a, e, f e g
    CALL PERDE_TEMPO   		; Chama o procedimento PERDE_TEMPO para poder visualizar o caractere F
                     		 

PERDE_TEMPO            		; Procedimento que força o PIC a perder tempo (delay)
    MOVLW d'1'        		; Carrega o valor decimal 10 no registrador W (Para gravar no PIC utilizar 80, no simulador SENAI use 1)
    MOVWF VEZES        		; Move o valor de W para o registrador VEZES

LOOP_VEZES					; Procedimento de loop utilizado para gerar tempo na instrução PERDE_TEMPO
    MOVLW d'1'		        ; Carrega o valor decimal 1 no registrador W (Para gravar no PIC utilizar 255, no simulador SENAI use 1)
    MOVWF DELAY        		; Move o valor de W para o registrador DELAY
    CALL DELAY_US      		; Chama a sub-rotina DELAY_US para gerar um atraso curto
    DECFSZ VEZES,1     		; Decrementa o registrador VEZES, pula a próxima instrução se o resultado for zero
    GOTO LOOP_VEZES    		; Volta para o início do loop LOOP_VEZES se VEZES não for zero
    RETURN             		; Retorna da rotina PERDE_TEMPO

DELAY_US					; Procedimento gerar tempo na instrução LOOP_VEZES
    NOP                		; No Operation: instrução que não faz nada, usada para ajustar o tempo
    NOP                		; No Operation: outra instrução NOP para ajustar o tempo
    DECFSZ DELAY,1     		; Decrementa o registrador DELAY, pula a próxima instrução se o resultado for zero
    GOTO DELAY_US      		; Volta para o início da sub-rotina DELAY_US se DELAY não for zero
    RETURN             		; Retorna da sub-rotina DELAY_US

    END                		; Marcador de última linha do programa

