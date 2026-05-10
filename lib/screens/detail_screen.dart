import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/story_model.dart';
import '../widgets/comment_tile.dart';

class DetailScreen extends StatelessWidget {
  final Story story;

  const DetailScreen({super.key, required this.story});

  Future<void> _launchUrl() async {
    if (story.url == null) return;
    final uri = Uri.parse(story.url!);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch ${story.url}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF7A786E), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (story.url != null)
            IconButton(
              icon: const Icon(Icons.open_in_new, color: Color(0xFFFF6600)),
              onPressed: _launchUrl,
            ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    story.title,
                    style: GoogleFonts.dmSerifDisplay(
                      color: const Color(0xFFF0EDE6),
                      fontSize: 28,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'by ${story.by}',
                        style: GoogleFonts.dmMono(
                          color: const Color(0xFFFF6600),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '·',
                        style: TextStyle(color: Colors.white.withOpacity(0.2)),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${story.score} points',
                        style: GoogleFonts.instrumentSans(
                          color: const Color(0xFF7A786E),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.white12),
                  const SizedBox(height: 12),
                  Text(
                    'Comments (${story.descendants})',
                    style: GoogleFonts.dmMono(
                      color: const Color(0xFFF0EDE6),
                      fontSize: 14,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          if (story.kids == null || story.kids!.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  'No comments yet.',
                  style: GoogleFonts.instrumentSans(color: Colors.grey),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CommentTile(id: story.kids![index]);
                },
                childCount: story.kids!.length,
              ),
            ),
        ],
      ),
    );
  }
}
