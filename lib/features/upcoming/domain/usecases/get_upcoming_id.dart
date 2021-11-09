import 'package:dartz/dartz.dart';
import 'package:demo_tdd_clean/core/error/failures.dart';
import 'package:demo_tdd_clean/core/usecases/usecase.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/entities/upcoming.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/repositories/upcoming_repository.dart';
import 'package:equatable/equatable.dart';

class GetUpcomingId implements UseCase<List<Upcoming>, Params>{
  final UpcomingRepository repository;

  GetUpcomingId(this.repository);

  @override
  Future<Either<Failure, List<Upcoming>>> call(Params params) async {
    return await repository.getConcreteUpcomingId(params.number);
  }

}

class Params extends Equatable {
  final int number;

  Params({ this.number});

  @override
  List<Object> get props => [number];
}