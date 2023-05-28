import 'package:equatable/equatable.dart';
import 'package:takatof/management/domain/entities/event.dart';

class Initiative extends Equatable {
  final int id;
  final String name;
  final String image;
  final int numberVolunteer;
  final String description;
  final List<Event> events;

  const Initiative(
      {required this.id,
      required this.name,
      required this.image,
      required this.numberVolunteer,
      required this.description,
      required this.events});

  const Initiative.empty(
      {this.id = 0,
      this.name = '',
      this.image = '',
      this.numberVolunteer = 0,
      this.description = '',
      this.events = const []});

  @override
  List<Object?> get props =>
      [id, name, image, numberVolunteer, description, events];
}
