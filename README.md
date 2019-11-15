# Flutter Application :: Lista de Tareas

Proyecto de caracter educativo-tutorial de Flutter con una aplicación 100% funcional, esta estructurada para navegar en los diferentes branch que se encuentran en el repositorio, los cuales representan un paso en la creación de la aplicación desde cero y haciendo uso del State Management propio de flutter StatefulWidget, luego con la ayuda del paquete Provider se almacena la información en SQFlite y en los pasos finales se hacen los ajustes para almacenar la información con Firebase.

**Es de recordar que este repositorio es de ejemplo y busca a ayudar a quienes comienzan** se ha tratado de utilizar los recursos y hacer uso de buenas practicas al momento de crearla, siempre pueden existir errores y estare feliz de corregir cualquiera de ellos que encuentren.

### Como Iniciar

Primero clona este repositorio a tu cuenta para que puedas modificarlo a tu conveniencia.

Una vez que este clonado encontraras 6 ramas (branch) con nombre step/0 hasta step/5, cada branch incrementa la funcionalidad poco a poco de la aplicación, para moverte dentro del repositorio y sus ramas puedes hacerlo asi:

```
git checkout step/<paso>
```
donde **paso** es el número de paso a revisar.

### ¿ Que contiene cada rama ?

#### step/0

Esta rama contiene unicamente la estructura de carpetas y una aplicación que al correrla solo mostrará un container.

#### step/1

Contiene la creación de una Clase Modelo llamada Task, a nivel de UI se ha construido un Listado (Listview Widget) a partir de un grupo de Tareas (tasks) en memoria, y se ha agregado la funcionalidad de crear nuevos

#### step/2

Se agregan las siguientes funcionalidades:
1. Modificar una tarea al marcarla de completado
2. Eliminar una tarea
3. Ajustes minimos al codigo

Siempre haciendo uso de StatefulWidget


#### step/3

Se agregan las siguientes funcionalidades:
1. Se incorporta el paquete Provider 
2. Se crea una clase Provider para la comunicación entre nuestro UI y la data [todo-provider.dart](https://github.com/erikwco/flutter_todo_list_app/blob/master/lib/src/providers/todo-provider.dart)
3. Se crea una clase servicio para almacenar las tareas siempre en memoria pero se exponene metodos que se utilizan en nuestra clase Provider [todo-service.dart](https://github.com/erikwco/flutter_todo_list_app/blob/master/lib/src/services/todo-service.dart)
4. Se hace la primera refactorización y limpieza de código

#### step/4

En este paso se agrega los siguiente:
1. Se crea una clase Servicio para almacenar las tareas en SQFlite similar a la utilizada el paso 3 para almacenar los tareas en memoria [todo-service-sqflite.dart](https://github.com/erikwco/flutter_todo_list_app/blob/master/lib/src/services/todo-service.dart)
2. Se modifica la clase proveedor temporalmente para poder intercambiar entre datos en memoria o datos en SQFlite bajo una sola interfaz, sin cambiar nada del UI [list-todo-page.dart](https://github.com/erikwco/flutter_todo_list_app/blob/master/lib/src/widgets/todo/list-todo-page.dart)
3. Se realizar la seguna refactorización y ajustes a los métodos de ambos servicios para poder homologarlos y tener un solo provider

#### step/5

En este último paso se realizan los cambios mas notables:
1. Se crea una clase abstracta [abstract-todo-service.dart](https://github.com/erikwco/flutter_todo_list_app/blob/master/lib/src/services/abstract-todo-service.dart) para poder modificar la clase Provider [todo-provider.dart](https://github.com/erikwco/flutter_todo_list_app/blob/master/lib/src/providers/todo-provider.dart) por una Generica para extender nuestras clases servicio para que permita desde la instanciación indicar via constructor cual sera el servicio a utilizar en el [main.dart](https://github.com/erikwco/flutter_todo_list_app/blob/master/lib/main.dart)
2. Se agregan los paquetes cloud_firestore y firebase_core para poder realizar la conexión con Firebase
3. Se configura la aplicación en la consola de firebase
4. Se descarga el archivo google-service.json para realizar la conexión con nuestra base (Este paso deben de realizarlo antes de pasar al paso 5 o les dara un error)
5. Se crea una clase servicio para Firestore [todo-service-firebase.dart](https://github.com/erikwco/flutter_todo_list_app/blob/master/lib/src/services/todo-service-firebase.dart) la cual extiende nuestra clase abstracta
6. Se implementa un RefreshIndicator en el listado [list-todo-page.dart](https://github.com/erikwco/flutter_todo_list_app/blob/master/lib/src/widgets/todo/list-todo-page.dart) para refrescar los datos de nuestro repositorio Firebase.


## **************************************************

Espero que con este proyecto tengan una base para arrancar otros proyectos, estare publicando otras aplicaciones pequeñas y otras funcionalidades que son comunes y que muchas veces dan problemas com la autenticación con Firebase

Si tiene alguna duda o encuentran algun error pueden contactarme o crear un issue en el repositorio para revisarlos.

Happy coding.!
