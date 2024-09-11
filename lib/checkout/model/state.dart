
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class State{

  int id;

  String name;

  State({required this.id, required this.name});

  factory State.fromJson(Map<String, dynamic> json) =>
      _$StateFromJson(json);

  Map<String, dynamic> toJson() => _$StateToJson(this);

  @override
  String toString() {
    return 'State{id: $id, name: $name}';
  }
}