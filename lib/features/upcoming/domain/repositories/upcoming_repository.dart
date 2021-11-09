import 'package:dartz/dartz.dart';
import 'package:demo_tdd_clean/core/error/failures.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/entities/upcoming.dart';

abstract class UpcomingRepository {
  Future<Either<Failure, List<Upcoming>>> getConcreteUpcoming();
  Future<Either<Failure, List<Upcoming>>> getConcreteUpcomingId(int number);
}