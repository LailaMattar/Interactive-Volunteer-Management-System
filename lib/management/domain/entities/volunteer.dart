import 'package:equatable/equatable.dart';

class Volunteer extends Equatable{
  final String email;
  final String password;


  const Volunteer({
    required this.email,
    required this.password
  });

  @override
  List<Object?> get props => [
    email,
    password,
  ];

}