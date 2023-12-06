# Trabajo-SED-MaqRef

Trabajo SED VHDL: Maquina de refrescos. Grupo 14. Tutor: Luis Castedo

**Miembros equipo:**

1. Fernando Moreno Santa Cruz
2. David Pinto Llorente
3. Miguel Ángel Pascual Collar

**Requisitos generales:**

* Utilizar entradas manuales (pulsadores, switches, etc.) y salidas (LEDs, Displays de 7 segmentos, etc.)

* Sincronizar las entradas

* Utilizar la señal de reloj de la placa

* Utilizar señal de RESET

* Utilizar una máquina de estados


**Descripción de tarea:**

Diseñe una máquina expendedora de refrescos. Admite monedas de 10c, 20c, 50c y 1€. Sólo admite el importe exacto, de forma que si introducimos dinero de más da un error y devuelve” todo el dinero. Cuando se llega al importe exacto del refresco (1€) se activará una señal para dar el producto. Como entradas tendrá señales indicadoras de la moneda, señales indicadoras de producto y como salidas la señal de error y la de producto.

**Mejoras propuestas:**

* Se ha decidido añadir una selección de producto, de forma que hay varios y no todos cuestan lo mismo.
