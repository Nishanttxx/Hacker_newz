import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:js' as js;
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/story_provider.dart';
import '../widgets/story_tile.dart';
import '../widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<StoryProvider>().fetchStories(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0C),
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6600),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Y',
                style: GoogleFonts.dmMono(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'HN Reader',
              style: GoogleFonts.dmSerifDisplay(
                color: const Color(0xFFF0EDE6),
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          if (kIsWeb)
            IconButton(
              icon: const Icon(Icons.exit_to_app, color: Color(0xFF7A786E)),
              tooltip: 'Exit to Landing Page',
              onPressed: () {
                js.context.callMethod('showLandingPage');
              },
            ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF7A786E)),
            onPressed: () => context.read<StoryProvider>().fetchStories(),
          ),
        ],
      ),
      body: Consumer<StoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingWidget();
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Oops! Something went wrong.',
                    style: GoogleFonts.instrumentSans(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () => provider.fetchStories(),
                    child: const Text('Retry', style: TextStyle(color: Color(0xFFFF6600))),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchStories(),
            color: const Color(0xFFFF6600),
            backgroundColor: const Color(0xFF1E1E1B),
            child: ListView.builder(
              itemCount: provider.stories.length,
              itemBuilder: (context, index) {
                return StoryTile(
                  story: provider.stories[index],
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
