import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListResponseModel<T> {
  const ListResponseModel({
    required this.pageNum,
    required this.pageSize,
    required this.total,
    required this.data,
  });

  factory ListResponseModel.fromJson(
          Map<String, dynamic> json, T Function(dynamic) create) =>
      _$ListResponseModelFromJson(json, create);

  final int pageNum;
  final int pageSize;
  final int total;
  final List<T> data;
}
