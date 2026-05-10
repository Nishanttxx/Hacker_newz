import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:shimmer/shimmer.dart';
import '../models/comment_model.dart';
import '../services/hacker_news_service.dart';

class CommentTile extends StatefulWidget {
  final int id;
  final int depth;

  const CommentTile({
    super.key,
    required this.id,
    this.depth = 0,
  });

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  final HackerNewsService _service = HackerNewsService();
  Comment? _comment;
  bool _isLoading = true;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _fetchComment();
  }

  Future<void> _fetchComment() async {
    try {
      final comment = await _service.fetchComment(widget.id);
      if (mounted) {
        setState(() {
          _comment = comment;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _parseHtml(String html) {
    final document = html_parser.parse(html);
    return document.body?.text ?? "";
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Shimmer.fromColors(
        baseColor: const Color(0xFF1E1E1B),
        highlightColor: const Color(0xFF2C2C28),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0 * widget.depth + 16,
            right: 16,
            top: 8,
            bottom: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_comment == null || _comment!.deleted) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 16.0 * widget.depth + 16,
            right: 16,
            top: 8,
            bottom: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _comment!.by,
                    style: GoogleFonts.dmMono(
                      color: const Color(0xFFFF6600),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'just now', // Simplified time
                    style: GoogleFonts.instrumentSans(
                      color: const Color(0xFF7A786E),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                _parseHtml(_comment!.text),
                style: GoogleFonts.instrumentSans(
                  color: const Color(0xFFF0EDE6),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              if (_comment!.kids != null && _comment!.kids!.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Text(
                    _isExpanded ? 'Hide replies' : 'Show ${_comment!.kids!.length} replies',
                    style: GoogleFonts.instrumentSans(
                      color: const Color(0xFF7A786E),
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (_isExpanded && _comment!.kids != null)
          ..._comment!.kids!.map((id) => CommentTile(id: id, depth: widget.depth + 1)),
        Divider(color: Colors.white.withOpacity(0.05), height: 1),
      ],
    );
  }
}
