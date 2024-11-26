import 'package:book_animation/books/books.dart';
import 'package:book_animation/float_book_anim.dart';
import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';

void main() => runApp(
    const MyApp()
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BookShelfPage(title: 'Flutter Demo Home Page'),
    );
  }
}