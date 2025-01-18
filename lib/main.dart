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
class DateDisplay extends StatefulWidget {
  const DateDisplay({super.key});

  @override
  _DateDisplayState createState() => _DateDisplayState();
}

class _DateDisplayState extends State<DateDisplay> {
  String selectedFilter = 'Weekly';

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final day = DateFormat('d').format(now);
    final month = DateFormat('MMMM').format(now).toUpperCase();

    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Text(
            '$day $month',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 120,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('Weekly'),
              const SizedBox(width: 5),
        
              _buildButton('Monthly'),
              const SizedBox(width: 5),
             
              _buildButton('Annual'),
            ],
          ),
        ),

        if (selectedFilter == 'Weekly')
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7, // Para los 7 días de la semana
                itemBuilder: (context, index) {
                  final nextDay = now.add(Duration(days: index)); // Día específico
                  final dayName = DateFormat('EEE').format(nextDay);
                  final dayNumber = DateFormat('d').format(nextDay);

                  // Verificar si el día actual es el que se debe resaltar
                  final isToday = nextDay.day == now.day &&
                                  nextDay.month == now.month &&
                                  nextDay.year == now.year;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isToday ? Colors.black : Colors.transparent, // Fondo negro si es hoy
                            borderRadius: BorderRadius.circular(8), // Bordes redondeados
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                dayName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isToday ? Colors.white : Colors.black, // Texto blanco si es hoy
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dayNumber,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isToday ? Colors.white : Colors.black, // Texto blanco si es hoy
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        if (selectedFilter == 'Monthly')
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: DateTime(now.year, now.month + 1, 0).day, // Todos los días del mes
                itemBuilder: (context, index) {
                  final currentDay = DateTime(now.year, now.month, index + 1);
                  final dayName = DateFormat('EEE').format(currentDay);
                  final dayNumber = DateFormat('d').format(currentDay);

                  // Verificar si el día actual es el que se debe resaltar
                  final isToday = currentDay.day == now.day &&
                                  currentDay.month == now.month &&
                                  currentDay.year == now.year;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isToday ? Colors.black : Colors.transparent, // Fondo negro si es hoy
                            borderRadius: BorderRadius.circular(8), // Bordes redondeados
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                dayName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isToday ? Colors.white : Colors.black, // Texto blanco si es hoy
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dayNumber,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isToday ? Colors.white : Colors.black, // Texto blanco si es hoy
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        if (selectedFilter == 'Annual')
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12, // 12 meses en el año
                itemBuilder: (context, index) {
                  final monthAbbreviation = DateFormat('MMM').format(DateTime(now.year, index + 1));
                  final monthNumber = index + 1;

                  // Verificar si el mes actual es el que se debe resaltar
                  final isThisMonth = monthNumber == now.month;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isThisMonth ? Colors.black : Colors.transparent, // Fondo negro si es este mes
                            borderRadius: BorderRadius.circular(8), // Bordes redondeados
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                monthAbbreviation,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isThisMonth ? Colors.white : Colors.black, // Texto blanco si es este mes
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$monthNumber',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isThisMonth ? Colors.white : Colors.black, // Texto blanco si es este mes
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildButton(String label) {
    final isSelected = label == selectedFilter;
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedFilter = label;
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? Colors.black : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
