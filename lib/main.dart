import 'package:flutter/material.dart';
import 'package:foodapi/viewmodels/home_viewmodel.dart';
import 'package:foodapi/viewmodels/search_viewmodel.dart';
import 'package:foodapi/views/navigation/app_shell.dart';
import 'package:foodapi/provider/cart_provider.dart';
import 'package:foodapi/provider/order_database.dart';
import 'package:provider/provider.dart';

void main(){
runApp(
  MultiProvider(
    providers:[
      ChangeNotifierProvider(
        create: (_) => HomeViewmodel(),
        ),
      ChangeNotifierProvider(
        create: (_) => SearchViewmodel(),
        ),
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
        ),
      ChangeNotifierProvider(
        create: (_) => OrderProvider(),
        ),
    ] ,
    child: const MyApp(),
    )
);
}

class MyApp extends StatelessWidget{
  const MyApp ({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AppShell(),
    );
  }
}