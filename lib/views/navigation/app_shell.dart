import 'package:flutter/material.dart';
import 'package:foodapi/provider/cart_provider.dart';
import 'package:foodapi/provider/order_database.dart';
import 'package:foodapi/views/cart/cart_page.dart';
import 'package:foodapi/views/home/home.dart';
import 'package:foodapi/views/order/order_history_page.dart';
import 'package:foodapi/views/search/search_page.dart';
import 'package:foodapi/views/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class AppShell extends StatefulWidget {
  final int initialIndex;
  const AppShell({super.key , this.initialIndex = 0});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {

  late int _currentIndex;
  @override
  void initState(){
    super.initState();
    _currentIndex = widget.initialIndex;

    WidgetsBinding.instance.addPostFrameCallback((_){
          context.read<CartProvider>().loadCartItems();
      context.read<OrderProvider>().loadOrders();
    });

  }
  late final List<Widget> _pages =[
    HomeScreen(
      onSearchTap: () => setState(() {
        _currentIndex = 1;
      }),
    ),
    const SearchPage(),
    const CartPage(),
    const OrderHistoryPage()
    
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xFFFFF8F3),
      body:IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}