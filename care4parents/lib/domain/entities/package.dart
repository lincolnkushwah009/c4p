import 'package:json_annotation/json_annotation.dart';

part 'package.g.dart';

@JsonSerializable()
class Package {
  int id;
  String name;
  bool status;
  String description;
  int index;
  String type;
  String duration;
  String code;
  int price;
  bool isSelected,isViewPackage;

  Package(
      {this.id,
      this.name,
      this.status,this.type,
      this.description,
      this.index,
      this.duration,
      this.code,
      this.price,
      this.isSelected = false,this.isViewPackage=false});

  @override
  String toString() => 'Package { id: $id, name: $name , type: $type}';
  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
  Map<String, dynamic> toJson() => _$PackageToJson(this);
}
