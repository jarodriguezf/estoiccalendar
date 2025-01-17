import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Punto de entrada de la aplicación
void main() {
  runApp(const MainApp());
}

// Clase principal que representa la aplicación
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Scaffold proporciona una estructura básica de pantalla, con AppBar, Body y otras áreas.
      home: Scaffold(
        // Cuerpo de la pantalla
        body: const Center(
          child: DateDisplay(), // Widget para mostrar la fecha actual en pantalla
        ),

        // Barra de navegación inferior
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white, // Color de fondo negro para la barra
          selectedItemColor: Colors.black, // Color de los íconos seleccionados
          unselectedItemColor: Colors.grey, // Color texto no seleccionado
          // unselectedItemColor: Colors.grey, // Color de los íconos no seleccionados
          items: [
            // Ítem de navegación para "Home/Calendar"
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/calendar-icon-navbar.png', // Ruta del archivo PNG
                height: 24, // Altura del ícono
                width: 24, // Ancho del ícono
              ),
              label: 'Home',
            ),
            // Ítem de navegación para "Quotes"
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/quotes-icon-navbar.png', // Ruta del archivo PNG
                height: 24, // Altura del ícono
                width: 24, // Ancho del ícono
              ),
              label: 'Quotes',
            ),
            // Ítem de navegación para "Personal Journey"
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/temple-icon-navbar.png', // Ruta del archivo PNG
                height: 24, // Altura del ícono
                width: 24, // Ancho del ícono
              ),
              label: 'My journey',
            ),
            // Ítem de navegación para "Profile"
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/profile-icon-navbar.png', // Ruta del archivo PNG
                height: 24, // Altura del ícono
                width: 24, // Ancho del ícono
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para mostrar la fecha actual
class DateDisplay extends StatelessWidget {
  const DateDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener la fecha actual y formatearla
    final now = DateTime.now();
    final day = DateFormat('d').format(now); // Día en formato numérico
    final month = DateFormat('MMMM').format(now).toUpperCase(); // Mes en string, en mayúsculas

    return Stack(
      children: [
        // Texto situado en la parte superior y centrado
        Positioned(
          top: 50, // Distancia desde la parte superior
          left: 0,
          right: 0,
          child: Text(
            '$day $month', // Formato de la fecha "14 FEBRUARY"
            textAlign: TextAlign.center, // Centramos horizontalmente
            style: const TextStyle(
              fontSize: 24, // Tamaño de fuente
              fontWeight: FontWeight.bold, // Negrita
            ),
          ),
        ),

        // Filtros de vista (botones) debajo de la fecha actual
        Positioned(
          top: 120, // Colocamos los botones debajo de la fecha
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20), // Márgenes laterales para los extremos
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 0.05), // Padding alrededor de los botones
              decoration: BoxDecoration(
                color:Colors.white, // Fondo gris claro para el contenedor
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton('Weekly'),
                  const SizedBox(width: 10), // Separación entre botones
                  Container(
                    height: 40, // Altura de la barra (igual que los botones)
                    width: 1, // Grosor de la barra
                    color: const Color.fromARGB(255, 209, 209, 209), // Color de la barra
                  ),
                  _buildButton('Monthly'),
                  const SizedBox(width: 10),
                  Container(
                    height: 40, // Altura de la barra (igual que los botones)
                    width: 1, // Grosor de la barra
                    color: const Color.fromARGB(255, 209, 209, 209),
                  ),
                  _buildButton('Annual'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Método para crear los botones de filtro
  Widget _buildButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10), // Margen a los lados
        child: TextButton(
          onPressed: () {}, // Sin funcionalidad por ahora
          style: TextButton.styleFrom(
            backgroundColor: Colors.white, // Color de fondo claro
            foregroundColor: Colors.black, // Color de texto
            padding: const EdgeInsets.symmetric(vertical: 14), // Mayor altura
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Bordes ligeramente redondeados
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}