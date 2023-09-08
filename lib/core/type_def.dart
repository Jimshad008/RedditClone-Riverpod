import 'package:fpdart/fpdart.dart';
import 'package:riverpodproject/core/failure.dart';

typedef FutureEither<T>=Future<Either<Failure,T>>;
typedef Futurevoid=FutureEither<void>;