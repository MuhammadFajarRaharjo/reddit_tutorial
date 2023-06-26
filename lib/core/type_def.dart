import 'package:fpdart/fpdart.dart';
import 'package:reddit_tutorial/core/failure.dart';

// for handle return if hasError
typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
