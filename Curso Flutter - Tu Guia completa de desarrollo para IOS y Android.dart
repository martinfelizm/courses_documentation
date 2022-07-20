#Curso Flutter: Tu Guia completa de desarrollo para IOS y Android
## Variables de tipo Alfanumerico y Numericos
void main(){
  
  //Strings
  //var nombre = 'Tony';
  //final nombre = 'Tony';
  //final String nombre = 'Tony'; // solo cambia en la primera asigación
  //const nombre = 'Tony'; // solo cambia cuando sube la aplicación
  String nombre = 'Tony';
  String apellido= 'Stark';
  
  print('$nombre $apellido');
  
  //Numeros
  int empleados = 10; //Solo numeros enteros
  double precios = 10.235;
    print(empleados);
  print(precios);
}

## Booleanos y Condiciones
void main(){
 
 //bool? isActive = null; // para que acepte null
 bool isActive = true;
 //  if( !isActive )//Diferente
  //if( isActive == null ) para validar si la variable viene null
  if( isActive ){
    print( 'Esta Activo' );    
  }else{
     print( 'Esta Inactivo' );    
  }
}

## Tipo de dato - Lista
void main(){

  List <int> numeros = [1,2,3,4,5,6,7]; //Lista de tipo Dynamic acepta todo tipo de datos junto
  //List numeros = [1,2,3,4,5,6,7]; //Lista de tipo Dynamic acepta todo tipo de datos junto
  
  numeros.add(11) ;
  
  print(numeros[5]);
  print(numeros);
  
  final masNumeros = List.generate(100,(int index)=> index); // Lista que se autogenera segun la condicion que se expecifique
  
  print(masNumeros);
}

## Tipo de dato - Map
void main(){
/*
  Map persona ={
    'nombre': 'Martin',
    'edad': 37,
    'soltero': false,
    true:false,
      1:100
  };
  print(persona);
  print(persona['nombre']);
   print(persona[true]);
   */
   Map <String, dynamic> persona ={
    'nombre': 'Martin',
    'edad': 37,
    'soltero': false
  };
  persona.addAll({'segundo nombre':'Jose'});
  print(persona);
  
}

## Funciones en Dart
void main(){
final name = 'Martin';
  saludar(name);
  saludar2(nombre: name);
}

void saludar( String nombre, [String mensaje = 'No tiene']){
  print("Buenos dias $nombre Mensajes: $mensaje");
}

void saludar2(
  {required String nombre,
 String? mensaje, String aviso = 'Sin Aviso' } 
){
  print('$nombre $mensaje $aviso');
}

## Clases en Dart
void main(){
final wolwerine = new Hero(nombre:'Logan',poder:'Regeneracion');
  /*
  wolwerine.nombre = 'Logan';
  wolwerine.poder = 'Regeneración';
  */
  
  print(wolwerine);
}

class Hero{
  String nombre;
  String poder;
  
  //Hero(this.nombre, this.poder);
  Hero({required this.nombre, required this.poder});
  
  @override
  String toString(){
    return 'Heroe: Nombre: ${this.nombre}, Poder: ${this.poder}';
  }
  
}

## Constructores por Nombre
void main(){

 final rawjson = {
    'nombre': 'Hulk',
    'poder' : 'Super Fuerza'
  };

  final ironman  = Hero.fromJson(rawjson);
  
  print(ironman);
}

class Hero{
  String nombre;
  String poder;

  Hero.fromJson(Map<String, String> json):
    this.nombre = json['nombre']!,
    this.poder = json['poder']!;
    //this.poder = json['poder'] ?? 'No tiene poder';
 
  
  @override
  String toString(){
    return 'Heroe: Nombre: ${this.nombre}, Poder: ${this.poder}';
  }
  
}

## Getter & Setter Dart
import 'dart:math' as Math;
void main(){
 final clCuadrado = new Cuadrado(10);
  clCuadrado.area = 35;
  print('La propiedad Get Area es igual a: ${clCuadrado.area}');
  print('La propiedad Set Lado es igual a: ${clCuadrado.lado}');
}

class Cuadrado{
 double lado;
 double get area{
     return this.lado * this.lado;
 }
  set area(double valor){
     this.lado = Math.sqrt(valor);
 }
Cuadrado(double plado): this.lado = plado;  
  
}

## Clases Abstractas en Dart
void main(){
 final perro = new Perro();
 final gato = new Gato();
  
  sonidoAnimal(perro);
  sonidoAnimal(gato);
}

void sonidoAnimal(Animal animal){
  animal.emitirSonido();
}
abstract class Animal{
  int? patas;

  void emitirSonido();  
}

class Perro implements Animal{
  int? patas;

  @override
  void emitirSonido()=> print('Guauuuu');  
}

class Gato implements Animal{
  int? patas;
  int? cola; 
  
  @override
  void emitirSonido()=> print('Miauuu');  
}

## Extends Class en Dart
void main(){
  final wolwerine = new Heroe('Logan');
  final luthor = new Villano('Lex Luthor');
  
  print(wolwerine);
  print(luthor);
}

abstract class Personaje{
  String? poder;
  String nombre;
  
  Personaje(this.nombre);
  
  @override
  String toString(){
    return '$nombre - $poder';
  }
}

class Heroe extends Personaje{
  int valentia = 100;
  
  Heroe(String nombre): super( nombre );
}

class Villano extends Personaje{
  int maldad = 50;
  
  Villano(String nombre): super( nombre );
}

## Mixins en Dart
abstract class Animal{}

abstract class Mamal extends Animal{}

abstract class Bird extends Animal{}

abstract class Fish extends Animal{}

abstract class Fly{
  void flying() => print('I am flying');
}
abstract class Walk{
  void walking() => print('I am walking');
}
abstract class Swim{
    void swimming() => print('I am swimming');
}

class Bat extends Mamal with Fly, Walk{}
  
class Dolphin extends Mamal with Swim{}

class Dove extends Mamal with Fly, Walk{}
  
class Cat extends Mamal with Walk{}

class Duck extends Mamal with Fly, Walk, Swim{}

void main(){
  final flipper = new Dolphin();
  flipper.swimming();
  
  final batman = new Bat();
  batman.walking();
  batman.flying();
  
   final catwoman = new Cat();
  catwoman.walking();
  
   final doveM = new Dove();
  doveM.walking();
  doveM.flying();
  
  final donalDuck = new Duck();
  donalDuck.walking();
  donalDuck.flying();
  donalDuck.swimming();  
}

## Futures en Dart
void main(){
  print('Inicio del programa');
  httpGet('http://www.Google.com').then( (data) => print(data.toUpperCase()));
  print('Fin del programa');
}
/*
Future httpGet(String url){
 return Future.delayed( Duration( seconds:3 ), (){
   return 'Hola Mundo - 3 segundos';
 });
}*/
Future<String> httpGet(String url){
 return Future.delayed( Duration( seconds:3 ), (){
   return 'Hola Mundo - 3 segundos';
 });
}

## Async - Await en Dart
void main() async{
  print('Inicio del programa');
  final data = await httpGet('http://www.Google.com');
  print( data );
  print('Fin del programa');
}

Future<String> httpGet(String url){
 return Future.delayed( Duration( seconds:3 ), (){
   return 'Hola Mundo - 3 segundos';
 });
}


------------------------------------------
## Flutter Commands
flutter channel dev
flutter upgrade
flutter config --enable-web
mkdir <new_project_directory_name>
cd <into new_project_directory>
flutter create .
flutter run -d chrome

