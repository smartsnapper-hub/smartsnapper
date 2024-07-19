
class AppException implements Exception {

  final _message ;
 // final _prefix ;
  AppException([this._message ]);


  @override
  String toString(){
    return '$_message' ;
  }

}


class FetchDataException extends AppException {
 // FetchDataException([String? message]) : super(message, 'Error During Communication');
  FetchDataException([String? message]) : super(message);
}


class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message);
  // BadRequestException([String? message]) : super(message, 'Invalid request');
}


class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super(message);
 // UnauthorisedException([String? message]) : super(message, 'Unauthorised request');
}


class InvalidInputException extends AppException {
  //InvalidInputException([String? message]) : super(message, 'Invalid Input');
  InvalidInputException([String? message]) : super(message);
}
