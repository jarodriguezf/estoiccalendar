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
      home: Scaffold(
        body: const Center(
          child: DateDisplay(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/calendar-icon-navbar.png',
                height: 24,
                width: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/quotes-icon-navbar.png',
                height: 24,
                width: 24,
              ),
              label: 'Quotes',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/temple-icon-navbar.png',
                height: 24,
                width: 24,
              ),
              label: 'My journey',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/profile-icon-navbar.png',
                height: 24,
                width: 24,
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
  String? selectedDay;
  String? selectedMonth;
  Map<int, String> reminders = {}; // Para guardar las notas de cada hora.

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final day = DateFormat('d').format(now);
    final month = DateFormat('MMMM').format(now).toUpperCase();

    return Stack(
      children: [
        // Fecha actual en el centro
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Text(
            '$day $month',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Filtros de la vista (Weekly, Monthly, Annual)
        Positioned(
          top: 120,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('Weekly'),
              const SizedBox(width: 10),
              _buildButton('Monthly'),
              const SizedBox(width: 10),
              _buildButton('Annual'),
            ],
          ),
        ),

        // Vista semanal
        if (selectedFilter == 'Weekly')
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final nextDay = now.add(Duration(days: index));
                  final dayName = DateFormat('EEE').format(nextDay);
                  final dayNumber = DateFormat('d').format(nextDay);

                  final isToday = nextDay.day == now.day &&
                                  nextDay.month == now.month &&
                                  nextDay.year == now.year;

                  final isSelected = nextDay.day == int.tryParse(selectedDay ?? '');

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) {
                            if (isSelected) return Colors.blue;
                            return isToday ? Colors.black : Colors.grey[300]!;
                          },
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => isSelected || isToday ? Colors.white : Colors.black,
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedDay = dayNumber;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dayName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(dayNumber),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

        // Vista mensual
        if (selectedFilter == 'Monthly')
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: DateTime(now.year, now.month + 1, 0).day,
                itemBuilder: (context, index) {
                  final currentDay = DateTime(now.year, now.month, index + 1);
                  final dayName = DateFormat('EEE').format(currentDay);
                  final dayNumber = DateFormat('d').format(currentDay);

                  final isToday = currentDay.day == now.day &&
                                  currentDay.month == now.month &&
                                  currentDay.year == now.year;

                  final isSelected = currentDay.day == int.tryParse(selectedDay ?? '');

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) {
                            if (isSelected) return Colors.blue;
                            return isToday ? Colors.black : Colors.grey[300]!;
                          },
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => isSelected || isToday ? Colors.white : Colors.black,
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedDay = dayNumber;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dayName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(dayNumber),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

        // Vista anual
        if (selectedFilter == 'Annual')
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
                itemBuilder: (context, index) {
                  final monthName = DateFormat('MMMM').format(DateTime(now.year, index + 1));
                  final monthNumber = index + 1;

                  final isThisMonth = monthNumber == now.month;
                  final isSelected = monthNumber == int.tryParse(selectedMonth ?? '');

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) {
                            if (isSelected) return Colors.blue;
                            return isThisMonth ? Colors.black : Colors.grey[300]!;
                          },
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => isSelected || isThisMonth ? Colors.white : Colors.black,
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedMonth = monthNumber.toString();
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            monthName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text('$monthNumber'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        
        // Mostrar horas y notas solo para Weekly y Monthly
        if (selectedFilter == 'Weekly' || selectedFilter == 'Monthly')
          if (selectedDay != null)
            Positioned(
              top: 300,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Recordatorios para el día $selectedDay',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Poner en negrita
                      fontSize: 20, // Tamaño de la fuente
                      color: const Color.fromARGB(255, 0, 0, 0), // Color blanco para contraste
                    ),
                  ),
                  
                  SizedBox(
                    height: 490,
                    child: ListView.builder(
                      itemCount: 24, // Para mostrar todas las 24 horas
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${index + 1}:00',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, // Poner en negrita
                                  fontSize: 15, // Ajusta el tamaño de la fuente si es necesario
                                  color: const Color.fromARGB(255, 0, 0, 0), // Color blanco para un mejor contraste
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      reminders[index] = value; // Guardar recordatorio
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Nota...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
            borderRadius: BorderRadius.circular(20),
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
