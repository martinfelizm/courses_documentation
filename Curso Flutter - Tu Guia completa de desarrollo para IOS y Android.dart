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