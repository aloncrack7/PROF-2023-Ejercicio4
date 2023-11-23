# PROF-2023-Ejercicio4

En el ámbito de DevOps, existen procesos distintos al _build_ que se pueden implementar usando servidores de integración continua como Jenkins. Uno de ellos es el mantenimiento y despliegue de Bases de Datos. 

Adjunto a este enunciado, puedes encontrar el fichero Employees.db. Se trata de una base de datos SQLite. Esta base de datos contiene el esquema y los datos indicados en [https://www.sqltutorial.org/sql-sample-database/](https://www.sqltutorial.org/sql-sample-database/)

Adicionalmente, he subido al repo [https://github.com/GRISE-UPM/PROF-2023-Ejercicio4](https://github.com/GRISE-UPM/PROF-2023-Ejercicio4) el _script_ de creación de la base de datos (sqlite.sql).

Supongamos que queremos modificar la base de datos. Para ello, hacemos un fork (para no crear ramas innecesarias) del repo [https://github.com/GRISE-UPM/PROF-2023-Ejercicio4](https://github.com/GRISE-UPM/PROF-2023-Ejercicio4), realizamos los cambios necesarios en el fichero sqlite.sql y hacemos un _pull request_. Este _pull request_ activa mediante un _webhook_ un proyecto de Jenkins que realiza las siguientes acciones:

*   Hacer una copia de los datos actuales en la base de datos
*   Eliminar el esquema actual. Quizás se podría realizar un DROP DATABASE.
*   Cargar el nuevo esquema.
*   Restaurar los datos respaldados anteriormente.

**Los pasos anteriores cuadran perfectamente con el concepto de _pipeline_. Este ejercicio consiste en implementar en Jenkins dicho _pipeline_.** **Puedes usar el siguiente token para gestionar webhooks, pull requests y commits:**

github\_pat\_11AATFDCA0p6n4XZndkJgV\_WwmdgTSfJUUu0Y9JoxhdN6zl3lZelwoEpkcMfHH8f72JFWTSJZBwuq0A3cG

**_(si hubiera algún problema con el token, avisame)_**

Es conveniente aclarar que el mantenimiento de una base de datos no es tan sencillo como lo indicado anteriormente. Por ejemplo, al borrar una columna, la carga posterior de los datos mediante un INSERT va a fallar. Lo mismo puede ocurrir con restricciones de integridad, cambio de formatos de los datos, etc. Hay productos específicos para la gestión de bases de datos que veremos posteriormente en el curso. **Por ahora, digamos que, ante un error cualquiera, lo que podríamos hacer es restaurar la base de datos original, sin cambios.**

Debes almacenar la base de datos Employees.db en el directorio del proyecto de Jenkins (así nos ahorramos las colisiones que podrían ocurrir con MySQL). Esta base de datos se puede manipular mediante línea de comandos usando el comando sqlite3 (accesible desde [https://sqlite.org/cli.html](https://sqlite.org/cli.html)). Te proporciono un par de ejemplos de cómo se usa sqlite3:

  

**Ejecutar un script**

sqlite3 Employees < script.sql

  

**Ejecutar interactivamente**

sqlite3 Employees.db \\

        ".mode column" \\

        ".headers on" \\

        "select \* \\

           from employees, jobs \\

           where jobs.job\_id = 1 and employees.job\_id = jobs.job\_id;"

  

1.  Para salvaguardar los datos de la base de datos, probablemente deberás usar el comando .dump. Para restaurar los datos, probablemente deberás ejecutar únicamente los comandos INSERT del fichero de _dump_.  
    

Por último, el proyecto de Jenkins debe activar un _statuscheck_ en GitHub indicando si el mantenimiento de la base de datos ha sido exitoso. Sería conveniente mezclar el _pull request_ automáticamente, pero no lo vamos a hacer para no tocar el fichero sqlite.sql.

**Para realizar la entrega:  
**

*   Indícame la máquina donde está instalado el Jenkins
*   Dame acceso como usuario a Jenkins usando las siguientes credenciales:
    *   username: odieste
    *   password: 3.1415

*   Indícame el nombre del proyecto.
*   Proporcioname el fichero con la clave _ssh_ por si necesitase acceder al directorio de Jenkins.
