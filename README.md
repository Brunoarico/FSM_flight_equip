# Descrição das Entidades VHDL

## DeBounce

A entidade `DeBounce` é um módulo utilizado para eliminar o fenômeno conhecido como "bouncing" que ocorre quando um botão é pressionado. Ela gera um pulso de saída limpo quando um botão é pressionado, garantindo que não haja múltiplos pulsos falsos devido a instabilidades no sinal do botão.

### Portas
- `Clk` (Entrada): Sinal de clock (STD_LOGIC).
- `button_in` (Entrada): Sinal do botão (STD_LOGIC).
- `pulse_out` (Saída): Pulso de saída limpo após a eliminação do bouncing (STD_LOGIC).

## bcd_converter

A entidade `bcd_converter` converte um número BCD (Binary Coded Decimal) de 4 bits em um sinal de saída correspondente para um display de 7 segmentos. Ela mapeia cada dígito BCD para os segmentos apropriados do display.

### Portas
- `BIN` (Entrada): Número BCD de 4 bits (STD_LOGIC_VECTOR).
- `SEGS` (Saída): Sinal de segmentos para o display de 7 segmentos (STD_LOGIC_VECTOR).

## conv_MMSS

A entidade `conv_MMSS` converte um valor inteiro de segundos em um formato de relógio de minutos e segundos. Ela separa os minutos e os segundos em unidades e dezenas e fornece as saídas correspondentes.

### Portas
- `segs_in` (Entrada): Valor inteiro de segundos (INTEGER).
- `min_u` (Saída): Unidade do minuto (0-9) (STD_LOGIC_VECTOR).
- `min_d` (Saída): Dezena do minuto (0-9) (STD_LOGIC_VECTOR).
- `seg_u` (Saída): Unidade do segundo (0-9) (STD_LOGIC_VECTOR).
- `seg_d` (Saída): Dezena do segundo (0-5) (STD_LOGIC_VECTOR).

## mux

A entidade `mux` é um multiplexador que seleciona um de quatro valores de entrada e os direciona para a saída com base em um sinal de seleção e um sinal de clock. Ela é frequentemente usada para exibir informações em displays de 7 segmentos.

### Portas
- `D_0`, `D_1`, `D_2`, `D_3` (Entradas): Valores de entrada a serem selecionados (STD_LOGIC_VECTOR).
- `CLK` (Entrada): Sinal de clock (STD_LOGIC).
- `SEG` (Saída): Sinal de segmentos para o display de 7 segmentos (STD_LOGIC_VECTOR).
- `DISP_EN` (Saída): Sinal de habilitação do display (STD_LOGIC_VECTOR).

## cronometer

A entidade `cronometer` é um cronômetro que conta o tempo em segundos. Ela pode ser controlada por um sinal de clock e tem funções de reset e pausa.

### Portas
- `CLK` (Entrada): Sinal de clock (STD_LOGIC).
- `RST` (Entrada): Sinal de reset (STD_LOGIC).
- `HOLD` (Entrada): Sinal de pausa (STD_LOGIC).
- `D_0`, `D_1`, `D_2`, `D_3` (Saídas): Saídas para exibir os dígitos do cronômetro (STD_LOGIC_VECTOR).

## conv_Temp

A entidade `conv_Temp` converte um valor de temperatura em formato binário em um display de 7 segmentos. Ela converte o valor binário para graus Celsius e exibe os dígitos correspondentes no display.

### Portas
- `temp8` (Entrada): Valor de temperatura em formato binário (STD_LOGIC_VECTOR).
- `D_0`, `D_1`, `D_2`, `D_3` (Saídas): Saídas para exibir os dígitos do display (STD_LOGIC_VECTOR).
- `ALARM` (Saída): Sinal de alarme se a temperatura estiver fora de um determinado intervalo (STD_LOGIC).

## conv_Alt

A entidade `conv_Alt` converte um valor de altitude em formato binário em um display de 7 segmentos. Ela converte o valor binário para metros e exibe os dígitos correspondentes no display.

### Portas
- `alt8` (Entrada): Valor de altitude em formato binário (STD_LOGIC_VECTOR).
- `D_0`, `D_1`, `D_2`, `D_3` (Saídas): Saídas para exibir os dígitos do display (STD_LOGIC_VECTOR).
- `ALARM` (Saída): Sinal de alarme se a altitude estiver fora de um determinado intervalo (STD_LOGIC).

## conv_Psi

A entidade `conv_Psi` converte um valor de pressão em formato binário em um display de 7 segmentos. Ela converte o valor binário para psi (libras por polegada quadrada) e exibe os dígitos correspondentes no display.

### Portas
- `psi8` (Entrada): Valor de pressão em formato binário (STD_LOGIC_VECTOR).
- `D_0`, `D_1`, `D_2`, `D_3` (Saídas): Saídas para exibir os dígitos do display (STD_LOGIC_VECTOR).
- `ALARM` (Saída): Sinal de alarme se a pressão estiver fora de um determinado intervalo (STD_LOGIC).

## displayCtrl

A entidade `displayCtrl` controla a exibição de diferentes informações em um display de 7 segmentos. Ela recebe sinais de diferentes sensores, como temperatura, altitude e pressão, e permite que o usuário selecione qual informação será exibida no display.

### Portas
- `CLK` (Entrada): Sinal de clock (STD_LOGIC).
- `SEL` (Entrada): Sinal de seleção para escolher a informação a ser exibida (STD_LOGIC_VECTOR).
- `BZ`, `BH` (Entradas): Sinais de botão para controle do cronômetro (STD_LOGIC).
- `SEG` (Saída): Sinal de segmentos para o display de 7 segmentos (STD_LOGIC_VECTOR).
- `DISP_EN` (Saída): Sinal de habilitação do display (STD_LOGIC_VECTOR).
