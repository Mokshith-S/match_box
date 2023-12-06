import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:match_box/logic/matrix.dart';
import 'package:match_box/provider/icon_status.dart';
import 'package:match_box/screen/game_screen.dart';
import 'package:match_box/widget/home_page_animation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 39, 148, 141),
          ),
          textTheme: GoogleFonts.baloo2TextTheme().copyWith(
            titleLarge: GoogleFonts.kenia(),
          ),
        ),
        home: const MatchBoxEntryPage(),
      ),
    ),
  );
}

class MatchBoxEntryPage extends ConsumerWidget {
  const MatchBoxEntryPage({super.key});

  void onGameStart(BuildContext context, String mode) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (ctx) => MatchScreen(
                gameMode: mode,
              )),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Match Up',
          style: GoogleFonts.kenia(
              color: Theme.of(context).colorScheme.errorContainer),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color.fromARGB(255, 109, 109, 109),
              Color.fromARGB(255, 54, 54, 54),
            ],
            stops: [0.0, 0.4, 0.6],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'Selected Difficulty',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 35),
              ),
              onPressed: () {
                ref
                    .read(iconStatusProvider.notifier)
                    .setIconMap(generateIconBox(10));
                onGameStart(context, 'Easy');
              },
              child: const Text('Easy'),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 35),
              ),
              onPressed: () {
                ref
                    .read(iconStatusProvider.notifier)
                    .setIconMap(generateIconBox(15));
                onGameStart(context, 'Medium');
              },
              child: const Text('Medium'),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 35),
              ),
              onPressed: () {
                ref
                    .read(iconStatusProvider.notifier)
                    .setIconMap(generateIconBox(20));
                onGameStart(context, 'Hard');
              },
              child: const Text('Hard'),
            ),
            const HomeAnimation(),
          ],
        ),
      ),
    );
  }
}
