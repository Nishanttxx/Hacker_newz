import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/story_model.dart';
import '../models/comment_model.dart';

class HackerNewsService {
  static const String _baseUrl = 'https://hacker-news.firebaseio.com/v0';

  Future<List<int>> fetchTopStories() async {
    final response = await http.get(Uri.parse('$_baseUrl/topstories.json'));
    if (response.statusCode == 200) {
      return List<int>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch top stories');
    }
  }

  Future<Story> fetchStory(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/item/$id.json'));
    if (response.statusCode == 200) {
      return Story.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch story $id');
    }
  }

  Future<Comment> fetchComment(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/item/$id.json'));
    if (response.statusCode == 200) {
      return Comment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch comment $id');
    }
  }
}
