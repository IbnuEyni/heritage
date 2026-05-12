abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('No internet connection. Showing cached data.');
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error. Please try again.']);
}

class CacheFailure extends Failure {
  const CacheFailure() : super('No cached data available. Connect to the internet.');
}

class NotFoundFailure extends Failure {
  const NotFoundFailure() : super('The requested content was not found.');
}

class TimeoutFailure extends Failure {
  const TimeoutFailure() : super('Request timed out. Check your connection.');
}
