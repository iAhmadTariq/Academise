class Video{
  final String id;
  final String video_title;
  final String video_description;

  Video({
    required this.id,
    required this.video_title,
    required this.video_description,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      video_title: json['video_title'],
      video_description: json['video_description'],
    );
    
  }
}