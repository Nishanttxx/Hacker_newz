class Story {
  final int id;
  final String title;
  final String by;
  final int score;
  final int descendants;
  final int time;
  final String? url;
  final List<int>? kids;

  Story({
    required this.id,
    required this.title,
    required this.by,
    required this.score,
    required this.descendants,
    required this.time,
    this.url,
    this.kids,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      title: json['title'] ?? '',
      by: json['by'] ?? 'Anonymous',
      score: json['score'] ?? 0,
      descendants: json['descendants'] ?? 0,
      time: json['time'] ?? 0,
      url: json['url'],
      kids: json['kids'] != null ? List<int>.from(json['kids']) : null,
    );
  }
}
