byte resource = 0;

active [2] proctype process() {
    do
        :: true -> 
            printf("Intentando adquirir recurso desde proceso %d\n", _pid);
            if
                :: resource == 0 -> 
                    printf("Recurso adquirido por proceso %d\n", _pid);
                    resource = _pid;
                :: else -> skip;
            fi;
        :: true -> 
            printf("Intentando liberar recurso desde proceso %d\n", _pid);
            if
                :: resource == _pid -> 
                    printf("Recurso liberado por proceso %d\n", _pid);
                    resource = 0;
                :: else -> skip;
            fi;
    od
}

init {
    run process();
    run process();
}