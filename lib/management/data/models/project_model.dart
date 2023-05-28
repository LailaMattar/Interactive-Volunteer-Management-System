import 'package:takatof/management/data/models/initiative_model.dart';
import 'package:takatof/management/domain/entities/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required super.id,
    required super.numberVolunteer,
    required super.name,
    required super.description,
    required super.nameAdmin,
    required super.image,
    required super.initiatives,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'],
        numberVolunteer: json['number_volunteer'],
        name: json['name'],
        description: json['description'],
        nameAdmin: json['name_admin'] ?? '',
        image: json['image'] ?? '',
        initiatives: List<InitiativeModel>.from((json['allinitiatives'] as List)
            .map((object) => InitiativeModel.fromJson(object))),
      );
}
