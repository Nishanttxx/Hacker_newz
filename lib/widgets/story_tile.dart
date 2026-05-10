import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/story_model.dart';
import '../screens/detail_screen.dart';

class StoryTile extends StatelessWidget {
  final Story story;
  final int index;

  const StoryTile({
    super.key,
    required this.story,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF161614),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(story: story),
            ),
          );
        },
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${index + 1}. ▲ ${Uri.parse(story.url ?? "").host}',
              style: GoogleFonts.dmMono(
                color: const Color(0xFFFF6600),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              story.title,
              style: GoogleFonts.dmSerifDisplay(
                color: const Color(0xFFF0EDE6),
                fontSize: 20,
                height: 1.1,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Row(
            children: [
              _buildMetaItem(Icons.arrow_upward, '${story.score}'),
              const SizedBox(width: 16),
              _buildMetaItem(Icons.comment_outlined, '${story.descendants}'),
              const SizedBox(width: 16),
              _buildMetaItem(Icons.person_outline, story.by),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetaItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF7A786E)),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.instrumentSans(
            color: const Color(0xFF7A786E),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
