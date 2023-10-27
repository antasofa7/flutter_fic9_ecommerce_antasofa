import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    @Default('') String id,
    @Default('') String username,
    @Default('') String email,
    @Default('') String provider,
    @Default('') String confirmed,
    @Default('') String blocked,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}
