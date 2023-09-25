#include <Arduino.h>

const int pinoSelecao1 = 2; // Pino para o primeiro seletor
const int pinoSelecao2 = 3; // Pino para o segundo seletor
const int mode = 4; // Pino para o modo de operação

int bitpin[8] = {5, 6, 7, 8, 9, 10, 11, 12}; // Pinos para os BITS


unsigned long int alt = 0; 
unsigned long int lastTime = 0;
int increment, amount = 50;

int calcularTemperatura(int altitude) {
    float lapseRate = -3.5;
    int temperatura = 30 + (lapseRate * altitude / 1000.0);
    if (temperatura < -40) temperatura = -40;
    if (temperatura > 80) temperatura = 80; 
    return map(temperatura, -40, 80, 0, 255); 
}

float calcularUmidade(int altitude) {
  float lapseRate = 0.3;
  float umid = 10 + (lapseRate * altitude / 100.0);

  if(umid < 0) umid = 0; 
  if(umid > 100) umid = 100;
  
  return map(umid, 0,100, 0,255); 
}

float calcularFL(int altitude) {
  float fl = altitude / 100;
  if (fl < 0) fl = 0;
  if (fl > 120) fl = 120; 
  return map(fl, 0, 120, 0, 255); 
}

void intToBits(int num) {
    int mask = 1;
    for (int i = 0; i < 8; i++) {
      bool bit = (num & mask) ? 1 : 0;
      digitalWrite(bitpin[i], bit);
      mask <<= 1;
    }
}

void emulate () {
  int umid = calcularUmidade(alt);;
  int temp = calcularTemperatura(alt);;
  int fl = calcularFL(alt); ;
  int selecao1 = digitalRead(pinoSelecao1);
  int selecao2 = digitalRead(pinoSelecao2);

  if (selecao1 == LOW && selecao2 == LOW) {
    //temperatura
    intToBits(temp);
    //intToBits(map(20, -40, 80, 0, 255));
  }
  else if (selecao1 == HIGH && selecao2 == LOW) {
    //FL
    intToBits(fl);
    //intToBits(map(120, 0, 120, 0, 255));
  }
  else if (selecao1 == HIGH && selecao2 == HIGH) {
    //Umidade
    intToBits(umid);
    //intToBits(map(0, 0, 100, 0, 255));
  }

  if(millis() - lastTime > 200) {
    alt += increment;
    if (alt >= 12000) increment = -amount;
    else if (alt <= 0) increment = amount;
    
    lastTime = millis();
  }

  Serial.print("Sel: ");
  Serial.print(selecao1);
  Serial.print(selecao2);
  Serial.print(" Temp: ");
  Serial.print(map(temp, 0, 255, -40, 80));
  Serial.print(" Umid: ");
  Serial.print(map(umid, 0, 255, 0, 100));
  Serial.print(" FL: ");
  Serial.print(map(fl, 0, 255, 0, 120));
  Serial.print(" Alt: ");
  Serial.println(alt);
}

void stableSign () {
  int selecao1 = digitalRead(pinoSelecao1);
  int selecao2 = digitalRead(pinoSelecao2);

  if (selecao1 == LOW && selecao2 == LOW) {
    //temperatura
    int temp = 20;
    intToBits(map(temp, -40, 80, 0, 255));
  }
  else if (selecao1 == HIGH && selecao2 == LOW) {
    //FL
    int fl = 90;
    intToBits(map(90, 0, 120, 0, 255));
  }
  else if (selecao1 == HIGH && selecao2 == HIGH) {
    //Umidade
    int umid = 20;
    intToBits(map(umid, 0, 100, 0, 255));
  }
}

void setup() {
  Serial.begin(115200);
  pinMode(pinoSelecao1, INPUT); 
  pinMode(pinoSelecao2, INPUT); 
  pinMode(mode, INPUT_PULLUP);

  for (int i = 0; i < 8; i++) {
    pinMode(bitpin[i], OUTPUT);
  }

}

void loop() {
  int modeVal = digitalRead(mode);

  if(modeVal == LOW) emulate();
  else stableSign();

}

