byte resource = 0; // recurso compartido
byte turn = 0; // variable de estado para coordinar la asignación del recurso compartido

proctype firstProcess() {
  do
  :: true -> // espera un tiempo aleatorio
     atomic {
       turn == 0; // espera su turno para solicitar el recurso compartido
       printf("Proceso 1 solicita el recurso compartido.\n");
       resource == 0; // espera a que el recurso compartido esté disponible
       printf("Proceso 1 utiliza el recurso compartido.\n");
       // libera el recurso compartido después de un tiempo aleatorio
       printf("Proceso 1 libera el recurso compartido.\n");
       resource = 1;
       // cambia la variable de estado para permitir que el proceso 2 solicite el recurso compartido
       turn = 1;
     }
  od;
}

proctype secondProcess() {
  do
  :: true -> // espera un tiempo aleatorio
     atomic {
       turn == 1; // espera su turno para solicitar el recurso compartido
       printf("Proceso 2 solicita el recurso compartido.\n");
       resource == 0; // espera a que el recurso compartido esté disponible
       printf("Proceso 2 utiliza el recurso compartido.\n");
       // libera el recurso compartido después de un tiempo aleatorio
       printf("Proceso 2 libera el recurso compartido.\n");
       resource = 1;
       // cambia la variable de estado para permitir que el proceso 1 solicite el recurso compartido
       turn = 0;
     }
  od;
}

proctype controlProcess() {
  do
  :: true -> // espera un tiempo aleatorio
     atomic {
       // inicializa la variable de estado para permitir que el proceso 1 solicite el recurso compartido
       turn = 0;
     }
  od;
}

init {
  run controlProcess();
  run firstProcess();
  run secondProcess();
}
