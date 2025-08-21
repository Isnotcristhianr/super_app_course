class IaChatModel {
  String id;
  String lastMessage;
  DateTime timestamp;
  bool isUser;

  IaChatModel({
    required this.id,
    required this.lastMessage,
    required this.timestamp,
    required this.isUser,
  });

  //factory
  factory IaChatModel.fromJson(Map<String, dynamic> json) {
    return IaChatModel(
      id: json['id'] as String,
      lastMessage: json['lastMessage'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isUser: json['isUser'] as bool? ?? false,
    );
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastMessage': lastMessage,
      'timestamp': timestamp.toIso8601String(),
      'isUser': isUser,
    };
  }
}
