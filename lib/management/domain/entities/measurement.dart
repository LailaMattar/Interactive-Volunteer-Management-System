import 'package:equatable/equatable.dart';

class Measurement extends Equatable{
  final int id;
  final String name;
  final String description;
  final String type;
  int value;


   Measurement({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.value
  });

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['value'] = value;
    return data;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    type,
    value,
  ];

}