import 'dart:io';

import 'package:dio/dio.dart';

class _BaseException implements Exception {
  _BaseException({this.msg = "Error occurred"});
  String msg;
  @override
  String toString() => msg;
}

class NoException extends _BaseException {
  NoException({this.message = "Initiating Class"}) : super(msg :message);
  String message;
}
class ElseConditionException extends _BaseException {
  ElseConditionException(this.message) : super(msg :message);
  String message;
}

class CancellationException extends _BaseException {
  CancellationException({this.message = "Request cancellation"}) : super(msg :message);
  String message;
}

class TimeoutException extends _BaseException {
  TimeoutException({this.message = "Timeout"}) : super(msg :message);
  String message;
}
class NoInternetException extends _BaseException {
  NoInternetException({this.message = "No connection available, please check network connection"}) : super(msg :message);
  String message;
}

class ResponseException extends _BaseException {
  ResponseException({this.message = "Response exception"}) : super(msg :message);
  String message;
}


class SocketException extends _BaseException {
  SocketException({this.message = "Connection has been interrupted"}) : super(msg :message);
  String message;
}

class FormatException extends _BaseException {
  FormatException({this.message = "Invalid format (Unable to processs the data)"}) : super(msg :message);
  String message;
}
class UnableToProcessException extends _BaseException {
  UnableToProcessException({this.message = "Unable to process : Not type of;"}) : super(msg :message);
  String message;
}

class UnexpectedException extends _BaseException {
  UnexpectedException({this.message = "Unknown exception"}) : super(msg :message);
  String message;
}


getDioException(error) {
  if (error is Exception) {
    try {
      Exception e;
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.CANCEL:
            e = CancellationException();
            break;
          case DioErrorType.CONNECT_TIMEOUT:
            e =TimeoutException();
            break;
          case DioErrorType.DEFAULT :
              e = SocketException();
            break;
          case DioErrorType.RECEIVE_TIMEOUT:
            e = TimeoutException();
            break;
          case DioErrorType.RESPONSE:
            e = ResponseException();
            break;
          case DioErrorType.SEND_TIMEOUT:
            e = TimeoutException();
            break;
        }
      } else if (error is SocketException)
        e = SocketException();
      else e = UnexpectedException();
      return e;
    } on FormatException catch (e) {
      // Helper.printError(e.toString());
      return FormatException();
    } catch (error) {
      return UnexpectedException(message: error.toString());
    }
  } else {
    if (error.toString().contains("is not a subtype of")) {
      return UnableToProcessException(message: error.toString());
    } else {
      return UnexpectedException();
    }
  }
}

