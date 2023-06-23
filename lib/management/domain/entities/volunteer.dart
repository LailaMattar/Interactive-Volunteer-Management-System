import 'package:equatable/equatable.dart';

class Volunteer extends Equatable {
  final int id;
  final String name;
  final int attend;
  final int? isEvaluation;
  final String image;
  bool checked;

  Volunteer({
    required this.id,
    required this.name,
    required this.attend,
    required this.checked,
    required this.isEvaluation,
    required this.image,
  });

  @override
  List<Object?> get props => [
        name,
        attend,
        checked,
        id,
        isEvaluation,
        image,
      ];
}
