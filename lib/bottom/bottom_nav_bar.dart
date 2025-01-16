import 'package:flutter/material.dart';

import 'package:test_todo/ui/todo_view.dart';
import 'package:test_todo/ui/weather.dart';

class BottomNavBars extends StatefulWidget {
  const BottomNavBars({super.key});

  @override
  State<BottomNavBars> createState() => _BottomNavBarsState();
}
 int curPage = 0;
class _BottomNavBarsState extends State<BottomNavBars> {
  final pages = [
    TodoView(),
    WeatherScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      BottomNavigationBar(
        currentIndex: curPage,
          onTap: (val) {
           setState(() {
             curPage = val;
           });
          },
          items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.today_outlined),
          label:'Task',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sunny_snowing),
          label:'Weather',
        )
      ]),
      body: pages[curPage],
    );
  }
}
