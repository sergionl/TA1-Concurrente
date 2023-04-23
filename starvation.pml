// Ejemplo de un problema de starvation
byte resource = 1; // recurso compartido

proctype firstProcess() {
  do
  :: true -> // espera un tiempo aleatorio
     atomic {
       resource == 1; // solicita el recurso compartido
       printf("Proceso 1 utiliza el recurso compartido.\n");
       // proceso 1 nunca libera el recurso compartido
     }
  od;
}

proctype secondProcess() {
  do
  :: true -> // espera un tiempo aleatorio
     atomic {
       resource == 1; // solicita el recurso compartido
       printf("Proceso 2 utiliza el recurso compartido.\n");
       resource = 0; // libera el recurso compartido
     }
  od;
}

init {
  run firstProcess();
  run secondProcess();
}