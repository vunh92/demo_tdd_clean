import 'package:dartz/dartz.dart';
import 'package:demo_tdd_clean/core/error/exceptions.dart';
import 'package:demo_tdd_clean/core/error/failures.dart';
import 'package:demo_tdd_clean/core/network/network_info.dart';
import 'package:demo_tdd_clean/features/upcoming/data/datasource/upcoming_local_data_source.dart';
import 'package:demo_tdd_clean/features/upcoming/data/datasource/upcoming_remote_data_source.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/entities/upcoming.dart';
import 'package:demo_tdd_clean/features/upcoming/domain/repositories/upcoming_repository.dart';

typedef Future<List<Upcoming>> _ConcreteOrRandomChooser();

class UpcomingRepositoryImpl implements UpcomingRepository{
  final UpcomingRemoteDataSource remoteDataSource;
  final UpcomingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UpcomingRepositoryImpl({this.remoteDataSource, this.localDataSource, this.networkInfo});

  @override
  Future<Either<Failure, List<Upcoming>>> getConcreteUpcomingId(int number) async {
    return await _getUpcoming(() {
      return remoteDataSource.getUpcomingId(number);
    });
  }

  @override
  Future<Either<Failure, List<Upcoming>>> getConcreteUpcoming() async {
    return await _getUpcomingList(() {
      return remoteDataSource.getUpcoming();
    });
  }

  Future<Either<Failure, List<Upcoming>>> _getUpcoming(
      _ConcreteOrRandomChooser getConcreteOrRandom,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUpcomming = await getConcreteOrRandom();
        localDataSource.cacheUpcoming(remoteUpcomming);
        return Right(remoteUpcomming);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localUpcoming = await localDataSource.getLastUpcoming();
        return Right(localUpcoming);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, List<Upcoming>>> _getUpcomingList(
      _ConcreteOrRandomChooser getConcreteOrRandom,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUpcomming = await getConcreteOrRandom();
        localDataSource.cacheUpcomingList(remoteUpcomming);
        return Right(remoteUpcomming);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localUpcoming = await localDataSource.getLastUpcomingList();
        return Right(localUpcoming);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

}