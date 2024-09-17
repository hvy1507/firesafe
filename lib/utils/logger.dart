import 'package:logger/logger.dart';

final _logger = Logger(
    printer: PrettyPrinter(
  methodCount: 0,
  printEmojis: false,
  noBoxingByDefault: true,
));

void debugLog(dynamic message) {
  _logger.d(message);
}

void infoLog(dynamic message) {
  _logger.i(message);
}

void errorLog(dynamic message) {
  _logger.e(message);
}
