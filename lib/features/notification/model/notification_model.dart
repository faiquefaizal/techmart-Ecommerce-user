class NotificationModel {
  final String title;
  final String message;
  final String time;

  NotificationModel({required this.title, required this.message, String? time})
    : time = time ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toMap() {
    return {"title": title, "message": message, "time": time};
  }

  factory NotificationModel.fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      title: data["title"] ?? "No Title",
      message: data["message"] ?? "No Message",
      time: data["time"],
    );
  }
}
