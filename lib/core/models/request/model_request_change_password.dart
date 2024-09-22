import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class ModelRequestChangePassword {

  const ModelRequestChangePassword({
    required this.id,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmedNewPassword,
  });
  final String id;
  final String oldPassword;
  final String newPassword;
  final String confirmedNewPassword;
}
