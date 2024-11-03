abstract class Failure {
  final String message;

  Failure({
    required this.message,
  });

  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message});
}

class UnknownFailure extends Failure {
  UnknownFailure({required super.message});
}
