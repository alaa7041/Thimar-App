class NotificationModel {
  late int id;
  late final String image, title, body, time;

  NotificationModel({
    this.id = 0,
    required this.time,
    required this.body,
    required this.title,
    required this.image,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    image = json["image"]??'';
    title = json["title"]??'';
    body = json["body"]??'';
    time = json["time"]??'';
  }
}
