## 1 Instalar editor de código
Sublime text, Visual Studio Code

## 2 Crear carpeta para los proyectos

## 3 Como usar Javascript en el Html
crear la etique <script type="text/javascript"> Aquí va el codigo JS</script> ó
si se quiere usar un archivo independiente de tipo .js (ejemplo main.js) entonces
<script type="text/javascript" src="main.js"></script>
***(Hacer un ejemplo con un alert("Hola") )

## instrucciones 
var ==> se usa para variables de tipo global (que pueden llamarse en cualquier lugar del archivo .js)
let ==> son del tipo local o de blocke-scope (scope: alcance definido de una variable)

## mensajes
alert ==> mensaje flotante-dialogo-alerta se muestra un mensaje por pantalla (alert("hola"))
console.log() ==> mensaje que se muestra en la consola del navegador (F12 --click derecho- inspeccionar-consola)
document.write() ==> mensaje que se muestra incrustado en la pagina

## Tipos de variables
Numerica => var i=20;
Alfanumerica => var s="Mostrando algo (:";
Boolean => var v = true; var f = false;
Arrays - Cadenas de textos => var frutas =['Mango','Pera','Manzana'] 

## uso de DOM
document.getElementByID("ID") ==> obtener o sobreescribir las propiedades o elementos de una etiqueta por su ID. 
Ej1: 
var mydiv = document.getElementByID("idDiv");
mydiv.innerHTML="Hello";
Ej2: 
   var nombre = "Soy la maxima!!!";
    var altura = 100;

    var datos = document.getElementById("myDiv");
    datos.innerHTML=`
    <h1>Yo se que ${nombre}</h1> <!--variable dentro de un string se llama Interpolar ${nombre}-->
    <h3>Y tengo una altura de : ${altura} cm</h3> 
    `;

 ##  Condicionales
 if(altura==100){
        datos.innerHTML+=`<h1>Yo soy alto</h1>`;
    } else if (altura == 90){
        datos.innerHTML+=`<h1>Yo soy una persona casi alta</h1>`;
    }else{
        datos.innerHTML+=`<h1>Yo soy una persona pequeña</h1>`;
    }

## Bucles
 for(var i=2015;i<=2021;i++){
        datos.innerHTML+=`<h3>El numero del bucle va en : ${i}</h1>`;    
    }

## Comentarios
// De una sola linea
/* de varias
lineas*/

## Funciones
# Con parametros
function devolveralgo(nombre){
   return nombre;
}

# Sin parametros
function procesaralgo(){
  var x=20;
  var y=50;
  var result = x+y;
}

# Funciones callback
nombres.foreach( function(nombres){
    document.write(nombres);
}); 

# Funciones callback anonimas funciones de flecha
nombres.foreach( (nombres) => {
    document.write(nombres);
});

## Objetos literales - JSON (en el mismo se pueden incluir propiedades de todo tipo numericas, strings, arrays, funciones)
 var libro = {
        titulo: "Mi libro",
        color: "Azul",
        año: 2021,
        autor:["Jose Feliz",1935],
        mostrarInfo() {
            return "</br> <h1> El libro es : " + this.titulo + " - " + this.color + " - " + this.año+ 
            " - Autor: "+ this.autor[0] +", Fecha nac. "+this.autor[1]+"</h1>";
        }
    }

    document.write(libro.mostrarInfo());

## Promesas (valor que pueda esta disponible ahora,el futuro o nunca, promete que va a retornar algo en algun momento determinado,  se captura la respuesta de una peticion)
  var resultado = new Promise((resolve,reject)=>{
        setTimeout(()=>{ //funcion de tiempo de espera
          let despedida = 'Nos vemos el martes!!!';
         // despedida = false;
          if(despedida){
              resolve(despedida);
          }else{
              reject('No hay despedida');
          }
        },2000) //2 segundos como tiempo de espera
    })

    resultado.then(result => {
        console.log(result);
    }).catch( err =>{
        console.log(err);
    })

## Clases 
   class Coche{
       constructor(modelo,velocidad,antiguedad){
           this.modelo=modelo;
           this.velocidad=velocidad;
           this.antiguedad=antiguedad;
       }

       aumentarVelocidad(){
           this.velocidad+=1;
       }

       reducirVelocidad(){           
           this.velocidad-=1;
       }
    }

    var coche1 = new Coche("Toyota",180,2000);
    coche1.aumentarVelocidad();
    coche1.aumentarVelocidad();
    coche1.reducirVelocidad();
    document.write("</br><h2>"+coche1.velocidad+"</h2>");

## Herencia
   class Autobus extends Coche {
        constructor(modelo, velocidad, antiguedad, color) {
            super(modelo, velocidad, antiguedad);
            this.color = color;
        }

        imprimirColor(){
            return 'El color del autobus es : '+this.color;
        }
    }

    var autobus1 = new Autobus("Mercedez Ben",250,2020,"Blanco");
    document.write("</br><h2>"+autobus1.imprimirColor()+"</h2>")
