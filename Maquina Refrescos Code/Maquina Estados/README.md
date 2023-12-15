# Indicaciones Maquina Estados

La salida en los segmentos con valores especiales a tener en cuenta en el decodificador son las siguientes:

* 36 : Se montrará por el display una -
* 25 : Se mostrará por el display una P

Los tiempos de los contadores son:

* Tiempo hasta inactividad : 30 segundos
* Tiempo encendido LED error dinero : 2 segundos

# Indicaciones testbench/simulador

Cabe destacar que en la imagen de la simulacion se ve que se efectuan transiciones que no deberian suceder tan rapido. Esto se debe a que se ha reducido la frecuencia o tiempo requerido para las mismas de forma que se pueda comprobar el correcto funcionamiento de las mismas. En el codigo final viene con el valor correcto.
