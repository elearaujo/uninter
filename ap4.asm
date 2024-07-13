;*****************************************************************************
; Aluno: Eleandro Alves de Araujo
; RU:   1195881
; Nome do arquivo: ap4.asm
; Nome do programa: TESTA_BOTAO
; Objetivo do programa: Ao pressionar o botão RB0 os LEDs D6, D8, D10 e D13 devem acender e os LEDs D7, D9, D11 e D14 devem ser apagados. 
;						Se o botão não estiver pressionado os LEDs D6, D8, D10 e D13 devem permanecer apagados e os LEDs D7, D9, D11 e D14 devem ser
;						acesos, este processo irá se repetir em loop infinito

;*********************  Definições do microcontrolador ***************************

    #include p16F877a.inc         ; Inclui o arquivo de definição específico para o microcontrolador PIC16F877A

    __config _HS_OSC & _WDT_OFF & _LVP_OFF & _PWRTE_ON 
                               ; Define as configurações de configuração (fuses) do microcontrolador:
                               ; _HS_OSC  : Seleciona o oscilador de alta velocidade (High-Speed Oscillator)
                               ; _WDT_OFF : Desliga o Watchdog Timer (WDT)
                               ; _LVP_OFF : Desativa a Programação em Baixa Tensão (Low Voltage Programming)
                               ; _PWRTE_ON: Ativa o Power-up Timer (PWRTE), que proporciona um atraso na inicialização para estabilizar a alimentação

;********************* Início do programa ***************************************

    ORG     0                  ; Posiciona o ponteiro para o endereço 0x0 de memória

;*************************** Declaração de variáveis ******************************   

DELAY   EQU 0x20             ; Define o endereço 0x20 para a variável DELAY
VEZES   EQU 0x21             ; Define o endereço 0x21 para a variável VEZES
     
;*************************** Configurações ****************************************
                   
    BSF     STATUS,RP0      ; Seleciona o Banco 1 (Register Page 0) colocando em nível alto para manipulação dos ports TRISA, TRISB e TRISD
    MOVLW   b'00000000'     ; Carrega '00000000' no registrador W
    MOVWF   TRISA           ; Configura PORTA como saída(todos os bits em 0), porta EN_LEDs
    MOVLW   b'00000000'     ; Carrega '00000000' no registrador W
    MOVWF   TRISD           ; Configura o PORTD como saída (todos os bits em 0), porta onde estão ligados os LEDs  
    MOVLW   b'11111111'     ; Carrega '11111111' no registrador W
    MOVWF   TRISB           ; Configura o PORTB como entrada (todos os bits em 1), porta onde está ligado o botão (switch RB0)
    BCF     STATUS,RP0      ; Limpa o bit RP0 no registrador STATUS, definindo-o em nível baixo encerrando a manipulação dos ports TRISA, TRISB e TRISD
    BSF     PORTA,5         ; Coloca 5V, nível lógico 1 no pino RA5 - Enable dos LEDs

;********************* Função (ou Rotina) MAIN *********************************************  

LOOP                       ; Bloco do principal do programa  
    BTFSC   PORTB,0        ; Verifica se o botão conectado ao RB0 está pressionado (RB0 = 0)
    GOTO    BOTAO_OFF      ; Se o botão não estiver pressionado, vai para BOTAO_OFF
    GOTO    BOTAO_ON       ; Se o botão estiver pressionado, vai para BOTAO_ON

BOTAO_OFF
    MOVLW   b'01010101'    ; Carrega '01010101' no registrador W
    MOVWF   PORTD          ; Envia o conteúdo de W para o registrador PORTD
    CALL    PERDE_TEMPO    ; Chama o procedimento PERDE_TEMPO para minimizar o efeito bounce
    GOTO    LOOP           ; Volta para o início do loop principal

BOTAO_ON
    MOVLW   b'10101010'    ; Carrega '10101010' no registrador W
    MOVWF   PORTD          ; Envia o conteúdo de W para o registrador PORTD
    CALL    PERDE_TEMPO    ; hama o procedimento PERDE_TEMPO para minimizar o efeito bounce
    GOTO    LOOP           ; Volta para o início do loop principal


PERDE_TEMPO                ; Procedimento que força o PIC a perder tempo (delay)
    MOVLW   d'1'          ; Para gravar no PIC utilizar 80, no simulador SENAI use 1
    MOVWF   VEZES          ; Carrega '10' no registrador VEZES
LOOP_VEZES
    MOVLW   d'1'           ; Para gravar no PIC utilizar 255, no simulador SENAI use 1
    MOVWF   DELAY          ; Carrega '1' no registrador DELAY
    CALL    DELAY_US       ; Chama o procedimento DELAY_US para criar um pequeno atraso
    DECFSZ  VEZES,1        ; Decrementa VEZES e pula a próxima instrução se VEZES = 0
    GOTO    LOOP_VEZES     ; Volta para o início do loop LOOP_VEZES
    RETURN                 ; Retorna do procedimento PERDE_TEMPO

DELAY_US
    NOP                    ; No Operation - instrução de preenchimento
    NOP                    ; No Operation - instrução de preenchimento
    DECFSZ  DELAY,1        ; Decrementa DELAY e pula a próxima instrução se DELAY = 0
    GOTO    DELAY_US       ; Volta para o início do loop DELAY_US
    RETURN                 ; Retorna do procedimento DELAY_US 

    END                    ; Marcador de última linha do programa
