# Comandos de GIT

# git  --version :  Para ver la version de Git instalada en la pc que estoy usando
# git --help : Comandos de ayuda de Git, se puede alternar poniendo despues de git el nombre del proceso que se quiere hacer y despues --help. Ejemplo: git commit --help
# git config --global : Comandos para crear la configuracion global de mi Repositorio Git se le agrega al mismo para agregar el nombre del usuario git config --global user.name "Nombre y apellido" y para agregar el correo git config --global user.email "mycorreo@mail.com"
# git init : Para inicializar un nuevo repositorio.
# git status: este da información de los commit de la rama en que se encuentra.
# git add: para incluir los registros a los que git no le esta dando seguimiento por que no estan incluidos en el repositorio actual ("git add ." - agregar todos los archivos,).
# git reset "nombreArchivo": para remover un archivo agregado en el git add.
# git commit -m: captura o fotografia de los registros que se van a actualizar, el -m es para incluir el comentario (-m "comentario").
# git log: para ver los commit que se han hecho.
# git config core.autocrlf true: Nota - CRLF, si aparece este error, es la interpretacion de un caracter. Solo hay que ejecutar este codigo.
# git checkout -- .: para reconstruir el proyecto a como estaba en el último commit.
# git checkout -- "nombre del archivo con su extensión": para reconstruir un archivo del proyecto a como estaba en el último commit.
# git branch: nos dice en que branch se esta trabajando.
# git branch -m "rama" "new name rama": para cambiar el nombre de una rama, para por ejemplo cambiar el nombre de la rama master por el nombre de main.
# git config --global init.defaultBranch main: para implementar el cambio del nombre main del branch de manera global.
# git config --global -e: para verficar si se aplico lo del cambio del nombre de la rama y se quiere editar algo (se presiona la letra a para poder bajar entre lineas), si se quiere guardar el cambio se presiona ESC se escribe :wq! ENTER
# :q!: para salir de la ejecucion de un comando.
# :wq!: para escribir dentro de la ejecucion de un comando y despues salir.
# git commit -am "Comentario": para agregar archivos a los que se le estaba dando seguimiento anteriormente.
# git add "nombre de archivo" "nombre de archivo": para agregar solo los archivos que quiera a git por nombre.
Los comodines o wildcard (*."extension del archivo"): se utilizan despues del comando add para especificar que agrege a todos los archivos de esa extensión. Ejemplo: git add *.html ó git add "directorio"/*.html (en el caso de que no este en el directorio raiz.
-Si los directorios estan vacios git no los reconoce.
-Si se quiere que git reconozca siempre una carpeta aunque este vacia se tiene que crear un archivo .gitkeep para que git lo tome en cuenta.
# git add "carpeta"/: para agregar todos los documentos y carpetas en este directorio.
# git config --global alias."nombre alias" "comando git": se crea un alias para no tener que escribir el comando completo de git. Ejemplo: git config --global alias.s status --short
Important!!!!:
Comando para la configuracion de un short command
Log
# git config --global alias.lg "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
Status
# git config --global alias.s status --short
Alternativa útil de status
# git config --global alias.s status -sb

# git log --oneline: para ver la forma corta shorta hash de los commit y los detalles de los logs de forma mas reducida.
# git log --oneline -- decorate --all --graph: para ver de forma mas grafica los logs de los commits.
# git diff: para ver los archivos que han cambiado y donde cambiaron.
# git diff --staged: para ver los archivos que estan en el staged que han cambiado y donde cambiaron.
# git commit --amend -m "Nuevo comentario": para actualizar el comentario del último commit.
# git commit --amend: para ver en detalle el último commit (Presione A: para editar, ESC: para ir a la última linea, :wq!: para guardar lo editado y salir)
# git reset HEAD^: para volver a como estaba el proyecto antes del último commit.
git reset --soft HEAD^: para volver al commit antes del último (se perderan los cambios hechos en el último commit).
Si aparece el warning: LF will be replaced by CRLF in... Puede configurar este salto con : git config core.autocrlf true.
git commit  -am "Comentario": sirve para al mismo tiempo agregar y dar commit a los últimos cambios.
git reset --soft "codigo commit" : para volver a los cambios cuando se hizo ese commit y mantener los cambios hechos despues para que se corrijan y volver a subirlos cuando estoy listo (NO DESTRUCTIVO).
git reset --mixed "codigo commit": para volver a los cambios cuando se hizo ese commit y mantener los cambios hechos despues para que se corrijan y volver a subirlos cuando estoy listo (NO DESTRUCTIVO).
git reset --hard "codigo commit": para volver a los cambios cuando se hizo ese commit y no mantiene los cambios hechos posteriormente (DESTRUCTIVO).
git reflog: para ver todos lo commit hechos, aun los que se hallan borrado.
git mv "rutaOrigen\nombreArchivo" "rutaDestino\nombreArchivo": para mover los documentos de directorios, tambien se puede cambiar el nombre si en la ruta de destino se indica con que nombre se va a mover.
git rm "nombreArchivo": para borrar un archivo de git.
git reset --hard: para restaurar el proyecto a la última versión.
git branch "nombre de la rama": para crear una nueva rama del repositorio principal
git brach: para ver las ramas que tengo configuradas en git de este proyecto, la que esta de color mas llamativo es por que es la rama en la que estoy actualmente en el proyecto.
git checkout "nombre de la rama": para cambiar de rama.
git merge "nombre de la rama": para traer los cambios que hay en otra rama para actualizar la nuestra (por ejemplo cuando queremos actualizar nuestra rama master con los cambios que hemos hecho el la rama de desarrollo).
Nota: 1- Si aparece Fast Forward despues de un merge, es por que se realizo la union sin problemas, ya que no existian commits en la rama a la cual unimos los cambios.
2- Si aparece ?? en un archivo cuando le damos git estatus, es porque aun no se le esta dando seguimiento a ese archivo en git.
git branch -d "nombre de la rama": para eliminar una rama (si los cambios hechos a este branch que vamos a eliminar no se ha incluido git lo preguntara previamente si aun que queremos eliminarlo. Si de todas formas se quiere eliminar usar el git branch -d "nombre de la rama" -f para hacer un borrado forzado (force).
git checkout -b "nombre de la rama": para crear la rama y automaticamente movernos a ella.
git tag "Nombre de la etiqueta": se utiliza para crear las etiquetas de versionamiento, con el fin de enmarcar cada punto de actulización mas ordenado. Se puede cambiar de rama solo con la etiqueta.
git tag: Para ver todas las etiquetas que se han creado.
git tag -d "Nombre de la etiqueta": para eliminar la etiqueta.
git tag -a "Version (ejemplo: v1.0.0)" -m "Comentario de la versión": para que la etiqueta nos identifique una versión especifica de nuestro repositorio.
git tag -a "Version (ejemplo: v1.0.0)" "hash del commit" -m "Comentario de la versión": se usa para poder ponerle una etiqueta a un commit anteriormente realizado.
git show "etiqueta": para ver el historial de creación de la etiqueta.
git stash: guarda todo el directorio en el cual se esta trabajando (como si fuera guardando lo que teniamos en una caja fuerte), para continuarlo posteriormente (cuando usamos este comando el proyecto entrara en un Work in progress (WIP) ).
git stash list: para ver los stash que hemos creado.
git stash pop: restablece el repositorio a como estaba en el ultimo stash.
git stash clear: para eliminar los stash guardados (recordar que lo podemos recuperar todo lo borrado por el git reflog).
git stash apply "hash del stash ejemplo: stash@{0}": para recuperar un stash en especifico, por su numero de hash.
git stash drop "hash del stash ejemplo: stash@{0}": para borrar un stash en especifico.
git stash show "hash del stash ejemplo: stash@{0}": para mostrar la información de los cambios en un stash en especifico.
git stash save "comentario para identificar el stash": para poder agregarle un descripción especifica a un stash.
git stash list --stat: para ver mas informacion al ver la lista de los stash guardados.
git rebase master: para unir todos los commits que halla en master con los de la rama en la que estamos (para eso debemos de posicionarnos en la rama en la cual queremos este cambio con git checkout "nombre de la rama").
git rebase, nos puede servir para actualizar el punto de separación de una rama.
git merge "nombre de la rama": para unir todo lo que tengo en mi repositorio actual con la rama master  (para eso debemos de posicionarnos en la rama en la cual queremos este cambio con git checkout "master").
git rebase -i HEAD~(numero de cantidad de commit que nos interesa): al ejecutar este comando elegira los commit indicado en el parametro despues de la virgulilla (~) y con estos ejecutar comando que se describen en el mismo para editarlos, fucionarlos, eliminarlos, ect. Según la opción que se decida.
git rebase -i ó rebase interactivo este puede unir dos o mas commit en un único commit, re-ordenar commits, corregir mensajes de commits, separar commits.
git rebase --continue : se debe ejecutar despues de estar seguros que se hicieron todas la correcciones necesarias en el/los commits que eligieron.
git remote add origin https://github.com/company/name_repository.git: para agregar un origen remoto en nuestro repositorio local.
git remote -v : para ver todos las fuentes o repositorios remotos que tenemos agregados en nuestro repositorio local.
git push -u origin master : para subir los cambios al repositorio remoto.
INFO: ¿Qué es Gitosis? Instalación y configuración
Guardar su contraseña de GitHub en la máquina WINDOWS

Guardar usuario y contraseña de GitHub



Guardar su usuario y contraseña en la máquina LINUX

Guardar usuario y contraseña de GitHub en la maquína

Para usuario de OSx 10.0 o superior, el KeyChain se los maneja automáticamente