
import 'package:elvate/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Screen/product_screen.dart';

void main() {
  runApp(
  const MyApp(),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ProductCubit()..fetchProducts(),
        child:  const ProductScreen(),
      ),
    );
  }
}

