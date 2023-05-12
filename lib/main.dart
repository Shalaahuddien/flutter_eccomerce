import 'package:flutter/material.dart';
import 'package:flutter_eccomerce/views/cart_page.dart';
import 'package:flutter_eccomerce/views/detail_page.dart';
import 'package:flutter_eccomerce/views/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  ));
}
