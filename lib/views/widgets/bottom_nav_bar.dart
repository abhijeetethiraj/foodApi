import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({super.key,required this.currentIndex,required this.onTap});

@override
Widget build(BuildContext context){
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: const Color(0xFFFFF8F3),
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey.shade500,
    showSelectedLabels: true,
    selectedFontSize: 12,
    currentIndex: currentIndex,
    onTap: onTap,
    items: [
      const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label:"Home"),
      const BottomNavigationBarItem(icon: Icon(Icons.search),label:"Search"),
      BottomNavigationBarItem(
        icon:Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: currentIndex == 2 ? const Color(0xFFFF6B3A): Colors.transparent, shape:  BoxShape.circle),
           child: Icon(Icons.shopping_cart_outlined, color: currentIndex == 2 ? Colors.white : Colors.grey.shade500),
        ),
        label:"cart"
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: "Orders"),
    ],
  );
}
  
}

