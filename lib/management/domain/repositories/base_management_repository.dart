import 'package:dartz/dartz.dart';
import 'package:takatof/core/error/failure.dart';
import 'package:takatof/management/domain/entities/Initiative.dart';
import 'package:takatof/management/domain/entities/event.dart';
import 'package:takatof/management/domain/entities/project.dart';
import 'package:takatof/management/domain/entities/volunteer.dart';

abstract class BaseManagementRepository{
  Future<Either<Failure,String>> login(Volunteer parameters);

  Future<Either<Failure,List<Project>>> getProjects();

  Future<Either<Failure,List<Event>>> getEvents();

  Future<Either<Failure,List<Event>>> getMyEvents();

  Future<Either<Failure,Initiative>> getInitiativeDetails(int parameters);

  Future<Either<Failure,String>> registerInEvent(int parameters);
}