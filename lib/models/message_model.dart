import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class Message with _$Message {
  const Message._();

  const factory Message({
    required String owner,
    required String text,
    String? imageUrl,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  bool isMine() => owner == 'Me';
}
