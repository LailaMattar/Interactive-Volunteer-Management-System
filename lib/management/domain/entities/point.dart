import 'package:equatable/equatable.dart';

class AppPoint extends Equatable{
  final int id;
  final String amount;
  final String evaluationName;
  final String evaluationDescription;
  final String eventName;
  final String eventDate;

  const AppPoint(
      {required this.id,
      required this.amount,
      required this.evaluationName,
      required this.evaluationDescription,
      required this.eventName,
      required this.eventDate});

  @override
  List<Object?> get props => [
    id,
    amount,
    evaluationName,
    evaluationDescription,
    eventName,
    eventDate,
  ];

}