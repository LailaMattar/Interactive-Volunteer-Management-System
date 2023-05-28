import 'package:equatable/equatable.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';

class Project extends Equatable{
  final int id;
  final int numberVolunteer;
  final String name;
  final String description;
  final String nameAdmin;
  final String image;
  final List<Initiative> initiatives;

  const Project({
    required this.id,
    required this.numberVolunteer,
    required this.name,
    required this.description,
    required this.nameAdmin,
    required this.image,
    required this.initiatives,
  });

  @override
  List<Object?> get props => [
    id,
    numberVolunteer,
    name,
    description,
    nameAdmin,
    image,
    initiatives,
  ];


}