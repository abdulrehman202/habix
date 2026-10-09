
import 'package:habix/core/Error/Failures.dart';
import 'package:uuid/uuid.dart';

extension abc on String{

  get capitalize {
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

extension newExt on int{

  String get dayInAlphabets
  {
    switch(this){
      case DateTime.monday:
      return 'Monday';
      case DateTime.tuesday:
      return 'Tuesday';
      case DateTime.wednesday:
      return 'Wednesday';
      case DateTime.thursday:
      return 'Thursday';
      case DateTime.friday:
      return 'Friday';
      case DateTime.saturday:
      return 'Saturday';

      case DateTime.sunday:
      return 'Sunday';

      default:
      return '';
    }
  }

  String get monthInAlphabets
  {
    switch(this){
      case DateTime.january:
      return 'January';
      case DateTime.february:
      return 'February';
      case DateTime.march:
      return 'March';

      case DateTime.april:
      return 'April';

      case DateTime.may:
      return 'May';
      
      case DateTime.june:
      return 'June';
      
      case DateTime.july:
      return 'July';
      case DateTime.august:
      return 'August';
      case DateTime.september:
      return 'September';
      case DateTime.october:
      return 'October';
      case DateTime.november:
      return 'November';

      case DateTime.december:
      return 'December';

      default:
      return '';
    }
  }
}

String getNewHabitId()
{
  
var uuid = Uuid();
return uuid.v4();
}


extension FailureLocalization on Failure {
  /// Converts a domain Failure into a user-friendly UI string
  String toUserMessage() {
    // Assuming you have localization setup. If not, use fallback strings.
    // final l10n = AppLocalizations.of(context)!;

    return switch (this) {
      NetworkFailure() => 'No internet connection. Please check your network and try again.',
      CacheFailure() => 'Local storage error. Could not retrieve your data.',
      ServerFailure(statusCode: final code) => _mapServerCodeToMessage(code),
      _ => 'An unexpected error occurred. Please try again later.',
    };
  }

  String _mapServerCodeToMessage(int? statusCode) {
    if (statusCode == null) return 'Unable to connect to the server.';
    
    return switch (statusCode) {
      401 => 'Incorrect email or password.',
      403 => 'You do not have permission to access this resource.',
      404 => 'The requested resource was not found on the server.',
      500 || 503 => 'Our servers are experiencing issues. Please try again shortly.',
      _ => 'Server returned an error code: $statusCode.',
    };
  }
}