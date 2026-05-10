import 'package:flutter/material.dart';
import '../models/story_model.dart';
import '../services/hacker_news_service.dart';

class StoryProvider with ChangeNotifier {
  final HackerNewsService _service = HackerNewsService();
  List<Story> _stories = [];
  bool _isLoading = false;
  String? _error;

  List<Story> get stories => _stories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchStories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final ids = await _service.fetchTopStories();
      // Fetch details for the first 30 stories
      final topIds = ids.take(30).toList();
      
      final fetchedStories = await Future.wait(
        topIds.map((id) => _service.fetchStory(id))
      );

      _stories = fetchedStories;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
