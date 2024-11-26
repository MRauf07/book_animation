import 'package:flutter/material.dart';
import 'dart:math' as math;

class FloatingBookCarousel extends StatelessWidget {
  const FloatingBookCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black87,
        body: FloatingBookView(),
      ),
    );
  }
}

class FloatingBookView extends StatefulWidget {
  const FloatingBookView({super.key});

  @override
  State<FloatingBookView> createState() => _FloatingBookViewState();
}

class _FloatingBookViewState extends State<FloatingBookView> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  late AnimationController _floatingController;

  @override
  void initState() {
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        double floatValue = math.sin(_floatingController.value * 2 * math.pi) * 10;
        return PageView.builder(
          controller: _pageController,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Transform.translate(
              offset: Offset(0, floatValue),
              child: _bookPage(index),
            );
          },
        );
      },
    );
  }

  Widget _bookPage(int index) {
    final List<String> images = [
      'assets/book1.png',
      'assets/book2.png',
      'assets/book3.png',
      'assets/book4.png',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.4),
              spreadRadius: 8,
              blurRadius: 20,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            images[index],
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, size: 80, color: Colors.red);
            },
          ),
        ),
      ),
    );
  }
}
