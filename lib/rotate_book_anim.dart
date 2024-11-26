import 'package:flutter/material.dart';
import 'dart:math' as math;

class AmazingRotatingBookApp extends StatelessWidget {
  const AmazingRotatingBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: const RotatingBookScreen(),
    );
  }
}

class RotatingBookScreen extends StatelessWidget {
  const RotatingBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          BackgroundEffect(),
          RotatingBookView(),
        ],
      ),
    );
  }
}

///Rotating Book View
class RotatingBookView extends StatefulWidget {
  const RotatingBookView({super.key});

  @override
  State<RotatingBookView> createState() => _RotatingBookViewState();
}

class _RotatingBookViewState extends State<RotatingBookView> {
  final PageController _pageController = PageController(viewportFraction: 1.0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: 10,
      itemBuilder: (context, index) {
        return bookPage(index);
      },
    );
  }

  Widget bookPage(int index) {
    final List<String> images = [
      'assets/book5.png',
      'assets/book6.png',
      'assets/book7.png',
      'assets/book8.png',
      'assets/book9.png',
      'assets/book10.png',
      'assets/book1.png',
      'assets/book2.png',
      'assets/book3.png',
      'assets/book4.png',
    ];

    final List<String> titles = [
      "The Hobbit",
      "Gift of Earth",
      "Frost Arch",
      "Winter Wars",
      "Dark Knight",
      "Dishonored Knight",
      "The Last Four Things",
      "The Hobbit",
      "The Shot to Die For",
      "Hanging House",
    ];

    final List<String> authors = [
      "J.R.R. Tolkien",
      "Isaac Asimov",
      "Kate Jan",
      "Sarah Addison",
      "Frank Miller",
      "G.R. Matthews",
      "Paul Hoffman",
      "J.R.R. Tolkien",
      "Raymond Chandler",
      "Agatha Christie",
    ];

    final List<String> genres = [
      "Fantasy, Adventure",
      "Science Fiction, Drama",
      "Fantasy, Romance",
      "Historical, Fantasy",
      "Graphic Novel, Action",
      "Fantasy, Thriller",
      "Philosophical, Fiction",
      "Fantasy, Adventure",
      "Crime, Thriller",
      "Mystery, Suspense",
    ];

    final List<String> descriptions = [
      "A grand epic of friendship, heroism, and the quest to destroy the One Ring.",
      "A futuristic tale of humanity's struggle to colonize distant planets.",
      "A young girl discovers her magical powers and faces a dangerous enemy.",
      "A tale of conflict and survival in a frozen, war-torn landscape.",
      "A gritty tale of a vigilante fighting crime in a corrupt city.",
      "A dishonored knight embarks on a journey to reclaim his honor and past glory.",
      "A story of redemption and philosophical conflict amidst an epic war.",
      "A grand epic of friendship, heroism, and the quest to destroy the One Ring.",
      "A private investigator takes on a deadly case full of twists and betrayal.",
      "A secluded house holds dark secrets that unravel one fateful night.",
    ];

    /// Use FutureBuilder to wait until the first frame is rendered
    return FutureBuilder(
      future: Future.delayed(Duration.zero),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(); // Show an empty container while waiting
        }

        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double pageOffset = 0;

            /// Only access page when hasClients and page is available
            if (_pageController.hasClients && _pageController.page != null) {
              pageOffset = index - _pageController.page!;
            }

            double rotation = math.pi / 2 * -pageOffset;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY(rotation),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 600,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 35),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(10, 10),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, size: 80);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        titles[index],
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[800],
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: const Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        authors[index],
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.deepOrange[800],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        genres[index],
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal[800],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        descriptions[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[900],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class BackgroundEffect extends StatefulWidget {
  const BackgroundEffect({super.key});

  @override
  State<BackgroundEffect> createState() => _BackgroundEffectState();
}

class _BackgroundEffectState extends State<BackgroundEffect> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,

      /// Slightly increase the opacity for visibility
      child: Image.asset(
        'assets/background_pattern.png',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
