class Comment {
  final int id;
  final String by;
  final String text;
  final int time;
  final List<int>? kids;
  final bool deleted;

  Comment({
    required this.id,
    required this.by,
    required this.text,
    required this.time,
    this.kids,
    this.deleted = false,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      by: json['by'] ?? 'Anonymous',
      text: json['text'] ?? '',
      time: json['time'] ?? 0,
      kids: json['kids'] != null ? List<int>.from(json['kids']) : null,
      deleted: json['deleted'] ?? false,
    );
  }
}
