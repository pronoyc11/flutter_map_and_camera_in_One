import 'package:flutter/material.dart';
import 'package:map_integration_app1/image_selector_screen.dart';
import 'package:map_integration_app1/map_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

    int? _selectedIndex;


  @override
  Widget build(BuildContext context) {
    _selectedIndex ??= _selectedIndex = 0;
    Widget? content;
    switch(_selectedIndex){
      case 0:
      content = const ImageSelectorScreen();
      break;
      case 1:
      content = const MapScreen();
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Map and Camera Integration")),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 100,
        
        onTap: (value) => {
          setState(() {
            _selectedIndex = value;
          })
        },
        currentIndex:_selectedIndex==null?0: _selectedIndex!,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: "Camera",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.location_on_rounded),
            label: "Location",
          ),
        ],
      ),
    );
  }
}
