import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable{
  final int id;
  final int eventId;
  final int volunteerId;
  final String state;
  final String initiativeName;
  final String profession;
  final String date;
  final String name;


  const RegisterRequest(
      {required this.id,
        required this.eventId,
        required this.volunteerId,
        required this.state,
        required this.initiativeName,
        required this.profession,
        required this.date,
        required this.name,
     });

  @override
  List<Object?> get props => [
    id,
    eventId,
    volunteerId,
    state,
    initiativeName,
    profession,
    date,
    name,
  ];

}