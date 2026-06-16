
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
