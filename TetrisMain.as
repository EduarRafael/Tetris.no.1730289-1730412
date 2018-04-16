package {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.net.*;
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;



	public class TetrisMain extends MovieClip {


		//VARIABLES TIEMPO
		var s: int = 0;
		var m: int = 0;
		var fx: int = 0;
		var tmp: int = 0;
		var izq: Boolean = false;
		var der: Boolean = false;
		var abajo: Boolean = false;
		var arriba: Boolean = false;
		var izqN: int = 37;
		var derN: int = 39;
		var abajoN: int = 40;
		var arribaN: int = 38;
		var cont1: int = 0;
		var nombre:String = "Guest"
		var cont2: int = 0;
		var puntos:int = 0;
		public var time: Timer = new Timer(1000, cont1++);
		public var time2: Timer = new Timer(1000, cont2++);
		var shpT: int = 0; //variable para la forma de los tetriminó
		var posAX: int; //posición inicial en X
		var posAY: int; //posición inicial en Y
		var random: int = 0; //variable para el random, figura a salir



		//ARRAYS CON LOS MC
		/*Los tetriminos se componen por cuatro cuatro cuadras iguales,
y con esos cuatro se forma cada tetriminó del respectivo color*/
		/*var figura1A: Array = new Array(celeste1, azul1, naranja1, amarillo1, verde1, rojo1, morado1);
		var figura2A: Array = new Array(celeste2, azul2, naranja2, amarillo2, verde2, rojo2, morado2);
		var figura3A: Array = new Array(celeste3, azul3, naranja3, amarillo3, verde3, rojo3, morado3);
		var figura4A: Array = new Array(celeste4, azul4, naranja4, amarillo4, verde4, rojo4, morado4);*/



		public function TetrisMain() {
			btnPlay.addEventListener(MouseEvent.CLICK, playF);
		}


		/*-------------------------------------------------------------------------------*/
		/*-----------------------------FUNCIONES DE BOTONES------------------------------*/
		/*-------------------------------------------------------------------------------*/

		//Función Botón siguiente del menú
		public function playF(event: MouseEvent): void {
			gotoAndStop(2);
			btnBack.addEventListener(MouseEvent.CLICK, backF);
			btnSingle.addEventListener(MouseEvent.CLICK, singleF);
			btnOpciones.addEventListener(MouseEvent.CLICK, optionF);
		}

		public function optionF(event: MouseEvent): void {
			gotoAndStop(3);
			btnBack2.addEventListener(MouseEvent.CLICK, backF2);
			ayudabtn.addEventListener(MouseEvent.CLICK, ayudar);
			btnGuardar.addEventListener(MouseEvent.CLICK,guardarF);
		}


		//Función Botón regresar al menú
		public function backF(event: MouseEvent): void {
			gotoAndStop(1);
			btnPlay.addEventListener(MouseEvent.CLICK, playF);
		}


		//EMPEZAR EL JUEGO
		public function singleF(event: MouseEvent): void {
			gotoAndStop(4);
			stage.focus = this;
			randomT();
			menupause();
			time.addEventListener(TimerEvent.TIMER, tiempo);
			time2.addEventListener(TimerEvent.TIMER, figuras);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, press);
			stage.addEventListener(KeyboardEvent.KEY_UP, soltar);
			time.start();
			txtPlayer.text = nombre;
			time2.start();
			btnPause.addEventListener(MouseEvent.CLICK, stopF);
			btnExit.addEventListener(MouseEvent.CLICK, exitF);
		}

		public function menupause() {
			trucochido.visible = false;
			pauseMenu.visible = false;
			btnContinue.visible = false;
			btnExit2.visible = false;
		}

		public function menupause2() {
			trucochido.visible = true;
			pauseMenu.visible = true;
			btnContinue.visible = true;
			btnExit2.visible = true;



			btnContinue.addEventListener(MouseEvent.CLICK, continueF);
			btnExit2.addEventListener(MouseEvent.CLICK, exitF2);
		}

		//CONTINUAR MENU PAUSA
		public function continueF(event: MouseEvent): void {
			menupause();
			time.start();
			stage.focus = this;
			stage.addEventListener(Event.ENTER_FRAME, colision);
			stage.addEventListener(Event.ENTER_FRAME, movement);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, press);
			stage.addEventListener(KeyboardEvent.KEY_UP, soltar);
			time2.start();
		}

		public function exitF(event: MouseEvent): void {
			time.stop();
			gotoAndStop(2);
			btnSingle.addEventListener(MouseEvent.CLICK, singleF);
			btnBack.addEventListener(MouseEvent.CLICK, backF);
			btnOpciones.addEventListener(MouseEvent.CLICK, optionF);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, press);
			stage.removeEventListener(KeyboardEvent.KEY_UP, soltar);
		}

		public function exitF2(event: MouseEvent): void {
			gotoAndStop(2);
			btnSingle.addEventListener(MouseEvent.CLICK, singleF);
			btnBack.addEventListener(MouseEvent.CLICK, backF);
			btnOpciones.addEventListener(MouseEvent.CLICK, optionF);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, press);
			stage.removeEventListener(KeyboardEvent.KEY_UP, soltar);
		}


		public function backF2(event: MouseEvent): void {
			gotoAndStop(2);
			btnSingle.addEventListener(MouseEvent.CLICK, singleF);
			btnBack.addEventListener(MouseEvent.CLICK, backF);
			btnOpciones.addEventListener(MouseEvent.CLICK, optionF);
		}
		public function regresarI(event: MouseEvent): void {
			gotoAndStop(2);
			btnSingle.addEventListener(MouseEvent.CLICK, singleF);
			btnBack.addEventListener(MouseEvent.CLICK, backF);
			btnOpciones.addEventListener(MouseEvent.CLICK, optionF);
		}


		/*-------------------------------------------------------------------*/
		/*-------------------------------------------------------------------*/
		/*-------------------------------------------------------------------*/


		public function stopF(event: MouseEvent): void {
			time.stop();
			menupause2();
			time2.stop();
		}

		/*---------------------------------------------------------*/
		/*----------------FRAME OPCIONES---------------------------*/
		/*---------------------------------------------------------*/

		public function guardarF(event: MouseEvent): void {
			if(txtPlayerName.text== ""){
				
			}else{
				nombre = txtPlayerName.text;
			}
			if(txtizquiera.text == "" ||txtDerecha.text == "" ||txtRota.text == "" ||txtVel.text =="" ){
				txtAlerta2.text = "Falta por llenar!"
			}else{
				izqN = Number(txtizquiera.text);
				derN = Number(txtDerecha.text);
				abajoN = Number(txtRota.text);
				arribaN = Number(txtVel.text);
				txtAlerta2.text ="Listo!"
			}
		}
		public function ayudar(e:MouseEvent):void{
			navigateToURL(new URLRequest ("https://help.adobe.com/es_ES/AS2LCR/Flash_10.0/help.html?content=00000525.html"));
		}



		/*---------------------------------------------------------*/
		/*----------------FUNCIÓN TIEMPO---------------------------*/
		/*---------------------------------------------------------*/

		//FUNCIÓN PARA EL TIEMPO
		public function tiempo(tiempoevent: TimerEvent): void {
			/*Si minutos (m) es igual a 0 entonces primero
		te muestra como si fueran segundos*/
			if (m == 0) {
				s++;
				tiempo_txt.text = 0 + s + " seg.";
				if (s >= 10) {
					tiempo_txt.text = s + " seg.";
				}
				/*Este if está para que no se muestre un 60 segundos en el marcador
			así ya no se cumple la condición del if y se saldría del ciclo*/
				if (s == 59) {
					m++;
					s = 0;
				}
			} else {
				/*Cuando minutos sea mayor a cero entonces
			el tiempo lo contará como minutos*/
				if (m > 0) {
					s++;
					tiempo_txt.text = 0 + m + ':' + 0 + s + " min";
					if (s >= 10) {
						tiempo_txt.text = 0 + m + ':' + s + " min.";
					}
					if (s == 59) {
						m++;
						s = 0;
					}
				}
			}
		}


		//Función para cuando se presiona la tecla
		public function press(event: KeyboardEvent): void {
			//Determinar la tecla iziquierda: ASCCI no. 37
			if (event.keyCode == izqN) {
				//Esta presionando
				izq = true
			} else {
				if (event.keyCode == derN) {
					der = true

				} else {
					if (event.keyCode == abajoN) {
						abajo = true
					} else {
						if (event.keyCode == arribaN) {
							arriba = true;
						}
					}
				}
			}
		}

		//Función para cuando se suelta la tecla
		public function soltar(event: KeyboardEvent): void {
			//Determinar la tecla iziquierda: ASCCI no. 37
			if (event.keyCode == izqN) {
				//No esta presinando
				izq = false
			} else {
				if (event.keyCode == derN) {
					der = false
				} else {
					if (event.keyCode == abajoN) {
						 abajo = false;
					} else {
						if (event.keyCode == arribaN) {
							arriba = false;
						}
					}
				}
			}
		}


		/*---------------------------------------------------------------*/
		/*-----------------FUNCIONES PARA EL JUEGO-----------------------*/
		/*---------------------------------------------------------------*/

		public function randomT() {
			random = Math.random() * 7;
			//random = 0;
			time2.start();
			stage.addEventListener(Event.ENTER_FRAME, colision);
			stage.addEventListener(Event.ENTER_FRAME, movement);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, press);
			stage.addEventListener(KeyboardEvent.KEY_UP, soltar);
			time2.addEventListener(TimerEvent.TIMER, figuras);
			posAX = 360;
			posAY = 0;
			shpT = 0;
			//Si el random arroja un 0 entonces se crea la primera figura y
			//así hasta el número 6
			if (random == 0) {
				figuraI();
			}
			if (random == 1) {
				figuraL();
			}
			if (random == 2) {
				figuraJ();
			}
			if (random == 3) {
				figuraO();
			}
			if (random == 4) {
				figuraS();
			}
			if (random == 5) {
				figuraZ();
			}
			if (random == 6) {
				figuraT();
			}
		}


		//Desplazamiento de las figuras
		public function figuras(tiempoevent: TimerEvent): void {
			tmp++;
			if (tmp == 1) {
				//Ponemos un timer para que caigan cada cierto tiempo y aquí vamos
				//bajando todas las piezas que forman el tetriminó
				figura1A[random].y = figura1A[random].y + 24;
				figura2A[random].y = figura2A[random].y + 24;
				figura3A[random].y = figura3A[random].y + 24;
				figura4A[random].y = figura4A[random].y + 24;
				tmp = 0;
			}
		}


		/*-----------------------------------------------------------*/
		/*--------FUNCIONES PARA LA GENERACIÓN DE LAS FIGURAS--------*/
		/*-----------------------------------------------------------*/

		//FUNCIÓN DE LA CREACIÓN DE LA FIGURA I (CELESTE O CIAN)
		public function figuraI() {
			/*Creación de la primera figura la cual es una I
		la variable shpT sirve para saber qué forma del
		tetriminó se va a generar. Para dar a entender mejor
		este punto ir al url para ver la imagen
		https://cms-assets.tutsplus.com/legacy-premium-tutorials/posts/13778/images/13778_402cf36c3b2daeef3aeb3d6e26ca2223.png
		Todas las figuras tienen cuatro formas y pues por eso se hace la condición
		para saber cuál se va a formar*/
			if (shpT == 0) {
				celeste3.x = posAX;
				celeste3.y = posAY;
				celeste2.x = celeste3.x - 24;
				celeste2.y = celeste3.y;
				celeste1.x = celeste3.x - 48;
				celeste1.y = celeste3.y;
				celeste4.x = celeste3.x + 24;
				celeste4.y = celeste3.y;
			}
			if (shpT == 1) {
				celeste2.x = celeste3.x;
				celeste2.y = celeste3.y - 24;
				celeste1.x = celeste3.x;
				celeste1.y = celeste3.y - 48;
				celeste4.x = celeste3.x;
				celeste4.y = celeste3.y + 24;
			}
			if (shpT == 2) {
				celeste3.x = celeste3.x - 24;
				celeste2.x = celeste3.x + 24;
				celeste2.y = celeste3.y;
				celeste1.x = celeste3.x + 48;
				celeste1.y = celeste3.y;
				celeste4.x = celeste3.x - 24;
				celeste4.y = celeste3.y;
			}
			if (shpT == 3) {
				celeste3.y = celeste3.y + 24;
				celeste2.y = celeste3.y + 24;
				celeste2.x = celeste3.x;
				celeste1.y = celeste3.y + 48;
				celeste1.x = celeste3.x;
				celeste4.y = celeste3.y - 24;
				celeste4.x = celeste3.x;
			}
		}

		///FIGURA L (COLOR AZUL)
		public function figuraL() {
			if (shpT == 0) {
				azul3.x = posAX;
				azul3.y = posAY + 24;
				azul2.x = azul3.x - 24;
				azul2.y = azul3.y;
				azul1.x = azul2.x;
				azul1.y = azul2.y - 24;
				azul4.x = azul3.x + 24;
				azul4.y = azul3.y;
			}
			if (shpT == 1) {
				azul2.x = azul3.x;
				azul2.y = azul3.y - 24;
				azul1.x = azul2.x + 24;
				azul1.y = azul2.y;
				azul4.y = azul3.y + 24;
				azul4.x = azul3.x;
			}
			if (shpT == 2) {
				azul2.x = azul3.x + 24;
				azul2.y = azul3.y;
				azul1.x = azul2.x;
				azul1.y = azul2.y + 24;
				azul4.y = azul3.y;
				azul4.x = azul3.x - 24;
			}
			if (shpT == 3) {
				azul2.x = azul3.x;
				azul2.y = azul3.y + 24;
				azul1.x = azul2.x - 24;
				azul1.y = azul2.y;
				azul4.y = azul3.y - 24;
				azul4.x = azul3.x;
			}
		}


		//FIGURA J (COLOR NARANJA)
		public function figuraJ() {
			if (shpT == 0) {
				naranja3.x = posAX;
				naranja3.y = posAY + 24;
				naranja2.x = naranja3.x - 24;
				naranja2.y = naranja3.y;
				naranja4.x = naranja3.x + 24;
				naranja4.y = naranja3.y;
				naranja1.y = naranja4.y - 24;
				naranja1.x = naranja4.x;
			}
			if (shpT == 1) {
				naranja2.y = naranja3.y - 24;
				naranja2.x = naranja3.x;
				naranja4.y = naranja3.y + 24;
				naranja4.x = naranja3.x;
				naranja1.x = naranja4.x + 24;
				naranja1.y = naranja4.y;
			}
			if (shpT == 2) {
				naranja2.x = naranja3.x + 24;
				naranja2.y = naranja3.y;
				naranja4.x = naranja3.x - 24;
				naranja4.y = naranja3.y;
				naranja1.y = naranja4.y + 24;
				naranja1.x = naranja4.x;
			}
			if (shpT == 3) {
				naranja4.y = naranja3.y + 24;
				naranja4.x = naranja3.x;
				naranja2.y = naranja3.y - 24;
				naranja2.x = naranja3.x;
				naranja1.x = naranja2.x - 24;
				naranja1.y = naranja2.y;
			}
		}

		/*CREACIÓN DE LA FIGURA O (COLOR AMARILLO)
	Esta noo cambia su forma debido a que es un cuadrado
	entonces sólo tenemos para formar la primera figura*/
		public function figuraO() {
			amarillo1.x = posAX;
			amarillo1.y = posAY;
			amarillo2.x = amarillo1.x + 24;
			amarillo2.y = amarillo1.y;
			amarillo3.y = amarillo2.y + 24;
			amarillo3.x = amarillo2.x;
			amarillo4.x = amarillo3.x - 24;
			amarillo4.y = amarillo3.y;
		}

		//FIGURA S (COLOR VERDE)
		public function figuraS() {
			if (shpT == 0) {
				verde1.x = posAX;
				verde1.y = posAY;
				verde3.x = verde1.x;
				verde3.y = verde1.y + 24;
				verde2.x = verde1.x + 24;
				verde2.y = verde1.y;
				verde4.x = verde3.x - 24;
				verde4.y = verde3.y;
			}
			if (shpT == 1) {
				verde1.x = verde3.x + 24;
				verde1.y = verde3.y;
				verde2.x = verde1.x;
				verde2.y = verde1.y + 24;
				verde4.x = verde3.x;
				verde4.y = verde3.y - 24;
			}
			if (shpT == 2) {
				verde1.x = verde3.x;
				verde1.y = verde3.y + 24;
				verde2.x = verde1.x - 24;
				verde2.y = verde1.y;
				verde4.x = verde3.x + 24;
				verde4.y = verde3.y;
			}
			if (shpT == 3) {
				verde1.y = verde3.y;
				verde1.x = verde3.x - 24;
				verde2.y = verde1.y - 24;
				verde2.x = verde1.x;
				verde4.x = verde3.x;
				verde4.y = verde3.y + 24;
			}
		}


		//FIGURA Z (COLOR ROJO)
		public function figuraZ() {
			if (shpT == 0) {
				rojo2.x = posAX;
				rojo2.y = posAY;
				rojo3.x = rojo2.x;
				rojo3.y = rojo2.y + 24;
				rojo1.x = rojo2.x - 24;
				rojo1.y = rojo2.y;
				rojo4.x = rojo3.x + 24;
				rojo4.y = rojo3.y;
			}
			if (shpT == 1) {
				rojo2.x = rojo3.x + 24;
				rojo2.y = rojo3.y;
				rojo1.x = rojo2.x;
				rojo1.y = rojo2.y - 24;
				rojo4.y = rojo3.y + 24;
				rojo4.x = rojo3.x;
			}
			if (shpT == 2) {
				rojo4.x = rojo3.x - 24;
				rojo4.y = rojo3.y;
				rojo2.x = rojo3.x;
				rojo2.y = rojo3.y + 24;
				rojo1.x = rojo2.x + 24;
				rojo1.y = rojo2.y;
			}
			if (shpT == 1) {
				rojo2.x = rojo3.x - 24;
				rojo2.y = rojo3.y;
				rojo1.x = rojo2.x;
				rojo1.y = rojo2.y + 24;
				rojo4.y = rojo3.y - 24;
				rojo4.x = rojo3.x;
			}
		}

		//FIGURA T (COLOR MORADO)
		public function figuraT() {
			if (shpT == 0) {
				morado1.x = posAX;
				morado1.y = posAY;
				morado2.x = morado1.x - 24;
				morado2.y = morado1.y + 24;
				morado3.x = morado1.x;
				morado3.y = morado1.y + 24;
				morado4.x = morado1.x + 24;
				morado4.y = morado1.y + 24;
			}
			if (shpT == 1) {
				morado2.x = morado3.x + 24;
				morado2.y = morado3.y;
				morado4.x = morado3.x;
				morado4.y = morado3.y + 24;
				morado1.x = morado3.x;
				morado1.y = morado3.y - 24;

			}
			if (shpT == 2) {
				morado1.y = morado3.y + 24;
				morado1.x = morado3.x;
				morado4.x = morado3.x - 24;
				morado4.y = morado3.y;
				morado2.x = morado3.x + 24;
				morado2.y = morado3.y;
			}
			if (shpT == 3) {
				morado1.x = morado3.x - 24;
				morado1.y = morado3.y;
				morado2.x = morado3.x;
				morado2.y = morado3.y + 24;
				morado4.x = morado3.x;
				morado4.y = morado3.y - 24;
			}
		}

		/*-----------------------------------------------------------*/
		/*-----------------------------------------------------------*/
		/*-----------------------------------------------------------*/

		//Función para el movimiento de los Tetrinominos
		public function movement(event: Event) {
			//Aqui le damos el límite para que no se salga del escenario
			if (izq == true && (figura1A[random].x > 240 && figura2A[random].x > 240 && figura3A[random].x > 240 && figura4A[random].x > 240)) {
				figura1A[random].x -= 24;
				figura2A[random].x -= 24;
				figura3A[random].x -= 24;
				figura4A[random].x -= 24;
			} else {
				//Para que no se salga a la derecha
				if (der == true && (figura1A[random].x < 456 && figura2A[random].x < 456 && figura3A[random].x < 456 && figura4A[random].x < 456)) {
					figura1A[random].x += 24;
					figura2A[random].x += 24;
					figura3A[random].x += 24;
					figura4A[random].x += 24;

				} else {
					if (abajo == true) {
						figura1A[random].y += 24;
						figura2A[random].y += 24;
						figura3A[random].y += 24;
						figura4A[random].y += 24;
					}
				}
			}
			if (arriba == true) {
				//Y AQUÍ ESTÁ LA CONDICIÓN POR SI SE CAMBIA DE FORMA
				//AL TETRINOMIO
				//Utilizamos la variable shpT para saber qué forma va a tomar la figura en juego
				shpT++;
				if (shpT <= 3) {
					if (random == 0) {
						posAX = figura3A[random].x;
						posAY = figura3A[random].y;
						figuraI();
					}
					if (random == 1) {
						posAX = figura3A[random].x;
						posAY = figura3A[random].y;
						figuraL();
					}
					if (random == 2) {
						posAX = figura3A[random].x;
						posAY = figura3A[random].y;
						figuraJ();
					}
					if (random == 3) {
						posAX = figura1A[random].x;
						posAY = figura1A[random].y;
						figuraO();
					}
					if (random == 4) {
						posAX = figura3A[random].x;
						posAY = figura3A[random].y;
						figuraS();
					}
					if (random == 5) {
						posAX = figura3A[random].x;
						posAY = figura3A[random].y;
						figuraZ();
					}
					if (random == 6) {
						posAX = figura3A[random].x;
						posAY = figura3A[random].y;
						figuraT();
					}
					if (shpT == 3) {
						shpT = -1;
					}
				}
			}
		}

		//Función para las colisiones
		public function colision(event: Event) {
			for (var v: int = 0; v < colisiones.length; v++) {
				if (figura1A[random].hitTestObject(colisiones[v]) || figura2A[random].hitTestObject(colisiones[v]) || figura3A[random].hitTestObject(colisiones[v]) || figura4A[random].hitTestObject(colisiones[v])) {
					stage.removeEventListener(Event.ENTER_FRAME, movement);
					generarFiguras();
					time2.stop();
					randomT();
					//Si una figura colisiona entonces se genera la nueva
				}
			}
			if (colisiones2.length > 1) {
				for (var v2: int = 0; v2 < colisiones2.length; v2++) {
					if(colisiones2[v2].hitTestObject(f19) || colisiones2[v2].hitTestObject(f20) || colisiones2[v2].hitTestObject(f18)){
						gotoAndStop(5);
						time2.stop();
						stage.removeEventListener(Event.ENTER_FRAME,movement);
						stage.removeEventListener(Event.ENTER_FRAME, colision);
						stage.removeEventListener(Event.ENTER_FRAME, movement);
						stage.removeEventListener(KeyboardEvent.KEY_DOWN, press);
						stage.removeEventListener(KeyboardEvent.KEY_UP, soltar);
						btnBMenu.addEventListener(MouseEvent.CLICK,regresarI);
						time.stop();
						for (var v2: int = 0; v2 < colisiones2.length; v2++) {
							removeChild(colisiones2[v2]);
						}
					}else{
						if ((figura1A[random].hitTestObject(colisiones2[v2]) && figura2A[random].hitTestObject(colisiones2[v2])) || (figura3A[random].hitTestObject(colisiones2[v2]) && figura4A[random].hitTestObject(colisiones2[v2])) ||
							(figura1A[random].hitTestObject(colisiones2[v2]) && figura3A[random].hitTestObject(colisiones2[v2])) || (figura1A[random].hitTestObject(colisiones2[v2]) && figura4A[random].hitTestObject(colisiones2[v2])) ||
							(figura3A[random].hitTestObject(colisiones2[v2]) && figura4A[random].hitTestObject(colisiones2[v2]))) {
							stage.removeEventListener(Event.ENTER_FRAME, movement);
							generarFiguras();
							time2.stop();
							randomT();
							//Si una figura colisiona entonces se genera la nueva
						}
					}
				}
			}
		}


		public function generarFiguras() {
			switch (random) {
				case 0:
					createI();
					break;
				case 1:
					createL();
					break;
				case 2:
					createJ();
					break;
				case 3:
					createO();
					break;
				case 4:
					createS();
					break;
				case 5:
					createZ();
					break;
				case 6:
					createT();
				break;
			}
		}

		public function createI() {
			var tetrisI_1: MovieClip = new MovieClip();
			tetrisI_1.graphics.beginFill(0x00ffff, 1);
			tetrisI_1.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisI_1);
			tetrisI_1.x = celeste1.x;
			tetrisI_1.y = celeste1.y;
			colisiones2.push(tetrisI_1)

			var tetrisI_2: MovieClip = new MovieClip();
			tetrisI_2.graphics.beginFill(0x00ffff, 1);
			tetrisI_2.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisI_2);
			tetrisI_2.x = celeste2.x;
			tetrisI_2.y = celeste2.y;
			colisiones2.push(tetrisI_2)

			var tetrisI_3: MovieClip = new MovieClip();
			tetrisI_3.graphics.beginFill(0x00ffff, 1);
			tetrisI_3.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisI_3);
			tetrisI_3.x = celeste3.x;
			tetrisI_3.y = celeste3.y;
			colisiones2.push(tetrisI_3)

			var tetrisI_4: MovieClip = new MovieClip();
			tetrisI_4.graphics.beginFill(0x00ffff, 1);
			tetrisI_4.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisI_4);
			tetrisI_4.x = celeste4.x;
			tetrisI_4.y = celeste4.y;
			colisiones2.push(tetrisI_4)
		}

		public function createL() {
			var tetrisL_1: MovieClip = new MovieClip();
			tetrisL_1.graphics.beginFill(0x0000FF, 1);
			tetrisL_1.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisL_1);
			tetrisL_1.x = azul1.x;
			tetrisL_1.y = azul1.y;
			colisiones2.push(tetrisL_1)

			var tetrisL_2: MovieClip = new MovieClip();
			tetrisL_2.graphics.beginFill(0x0000FF, 1);
			tetrisL_2.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisL_2);
			tetrisL_2.x = azul2.x;
			tetrisL_2.y = azul2.y;
			colisiones2.push(tetrisL_2)

			var tetrisL_3: MovieClip = new MovieClip();
			tetrisL_3.graphics.beginFill(0x0000FF, 1);
			tetrisL_3.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisL_3);
			tetrisL_3.x = azul3.x;
			tetrisL_3.y = azul3.y;
			colisiones2.push(tetrisL_3)

			var tetrisL_4: MovieClip = new MovieClip();
			tetrisL_4.graphics.beginFill(0x0000FF, 1);
			tetrisL_4.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisL_4);
			tetrisL_4.x = azul4.x;
			tetrisL_4.y = azul4.y;
			colisiones2.push(tetrisL_4)
		}

		public function createJ() {
			var tetrisJ_1: MovieClip = new MovieClip();
			tetrisJ_1.graphics.beginFill(0xFF8040, 1);
			tetrisJ_1.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisJ_1);
			tetrisJ_1.x = naranja1.x;
			tetrisJ_1.y = naranja1.y;
			colisiones2.push(tetrisJ_1)

			var tetrisJ_2: MovieClip = new MovieClip();
			tetrisJ_2.graphics.beginFill(0xFF8040, 1);
			tetrisJ_2.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisJ_2);
			tetrisJ_2.x = naranja2.x;
			tetrisJ_2.y = naranja2.y;
			colisiones2.push(tetrisJ_2)

			var tetrisJ_3: MovieClip = new MovieClip();
			tetrisJ_3.graphics.beginFill(0xFF8040, 1);
			tetrisJ_3.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisJ_3);
			tetrisJ_3.x = naranja3.x;
			tetrisJ_3.y = naranja3.y;
			colisiones2.push(tetrisJ_3)

			var tetrisJ_4: MovieClip = new MovieClip();
			tetrisJ_4.graphics.beginFill(0xFF8040, 1);
			tetrisJ_4.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisJ_4);
			tetrisJ_4.x = naranja4.x;
			tetrisJ_4.y = naranja4.y;
			colisiones2.push(tetrisJ_4)

		}

		public function createO() {
			var tetrisO_1: MovieClip = new MovieClip();
			tetrisO_1.graphics.beginFill(0xffff00, 1);
			tetrisO_1.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisO_1);
			tetrisO_1.x = amarillo1.x;
			tetrisO_1.y = amarillo1.y;
			colisiones2.push(tetrisO_1)

			var tetrisO_2: MovieClip = new MovieClip();
			tetrisO_2.graphics.beginFill(0xffff00, 1);
			tetrisO_2.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisO_2);
			tetrisO_2.x = amarillo2.x;
			tetrisO_2.y = amarillo2.y;
			colisiones2.push(tetrisO_2)

			var tetrisO_3: MovieClip = new MovieClip();
			tetrisO_3.graphics.beginFill(0xffff00, 1);
			tetrisO_3.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisO_3);
			tetrisO_3.x = amarillo3.x;
			tetrisO_3.y = amarillo3.y;
			colisiones2.push(tetrisO_3)

			var tetrisO_4: MovieClip = new MovieClip();
			tetrisO_4.graphics.beginFill(0xffff00, 1);
			tetrisO_4.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisO_4);
			tetrisO_4.x = amarillo4.x;
			tetrisO_4.y = amarillo4.y;
			colisiones2.push(tetrisO_4)
		}

		public function createS() {
			var tetrisS_1: MovieClip = new MovieClip();
			tetrisS_1.graphics.beginFill(0x00FF00, 1);
			tetrisS_1.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisS_1);
			tetrisS_1.x = verde1.x;
			tetrisS_1.y = verde1.y;
			colisiones2.push(tetrisS_1)

			var tetrisS_2: MovieClip = new MovieClip();
			tetrisS_2.graphics.beginFill(0x00FF00, 1);
			tetrisS_2.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisS_2);
			tetrisS_2.x = verde2.x;
			tetrisS_2.y = verde2.y;
			colisiones2.push(tetrisS_2)

			var tetrisS_3: MovieClip = new MovieClip();
			tetrisS_3.graphics.beginFill(0x00FF00, 1);
			tetrisS_3.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisS_3);
			tetrisS_3.x = verde3.x;
			tetrisS_3.y = verde3.y;
			colisiones2.push(tetrisS_3)

			var tetrisS_4: MovieClip = new MovieClip();
			tetrisS_4.graphics.beginFill(0x00FF00, 1);
			tetrisS_4.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisS_4);
			tetrisS_4.x = verde4.x;
			tetrisS_4.y = verde4.y;
			colisiones2.push(tetrisS_4)
		}

		public function createZ() {
			var tetrisZ_1: MovieClip = new MovieClip();
			tetrisZ_1.graphics.beginFill(0xFF0000, 1);
			tetrisZ_1.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisZ_1);
			tetrisZ_1.x = rojo1.x;
			tetrisZ_1.y = rojo1.y;
			colisiones2.push(tetrisZ_1)

			var tetrisZ_2: MovieClip = new MovieClip();
			tetrisZ_2.graphics.beginFill(0xFF0000, 1);
			tetrisZ_2.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisZ_2);
			tetrisZ_2.x = rojo2.x;
			tetrisZ_2.y = rojo2.y;
			colisiones2.push(tetrisZ_2)

			var tetrisZ_3: MovieClip = new MovieClip();
			tetrisZ_3.graphics.beginFill(0xFF0000, 1);
			tetrisZ_3.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisZ_3);
			tetrisZ_3.x = rojo3.x;
			tetrisZ_3.y = rojo3.y;
			colisiones2.push(tetrisZ_3)

			var tetrisZ_4: MovieClip = new MovieClip();
			tetrisZ_4.graphics.beginFill(0xFF0000, 1);
			tetrisZ_4.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisZ_4);
			tetrisZ_4.x = rojo4.x;
			tetrisZ_4.y = rojo4.y;
			colisiones2.push(tetrisZ_4)
		}

		public function createT() {
			var tetrisT_1: MovieClip = new MovieClip();
			tetrisT_1.graphics.beginFill(0x800080, 1);
			tetrisT_1.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisT_1);
			tetrisT_1.x = morado1.x;
			tetrisT_1.y = morado1.y;
			colisiones2.push(tetrisT_1)

			var tetrisT_2: MovieClip = new MovieClip();
			tetrisT_2.graphics.beginFill(0x800080, 1);
			tetrisT_2.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisT_2);
			tetrisT_2.x = morado2.x;
			tetrisT_2.y = morado2.y;
			colisiones2.push(tetrisT_2)

			var tetrisT_3: MovieClip = new MovieClip();
			tetrisT_3.graphics.beginFill(0x800080, 1);
			tetrisT_3.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisT_3);
			tetrisT_3.x = morado3.x;
			tetrisT_3.y = morado3.y;
			colisiones2.push(tetrisT_3)

			var tetrisT_4: MovieClip = new MovieClip();
			tetrisT_4.graphics.beginFill(0x800080, 1);
			tetrisT_4.graphics.drawRect(0, 0, 24, 24);
			this.addChild(tetrisT_4);
			tetrisT_4.x = morado4.x;
			tetrisT_4.y = morado4.y;
			colisiones2.push(tetrisT_4)
		}
	}

}