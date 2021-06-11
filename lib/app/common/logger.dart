// @dart=2.9
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrefixPrinter(PrettyPrinter(
      methodCount: 1,
      // number of method calls to be displayed
      errorMethodCount: 8,
      // number of method calls if stacktrace is provided
      lineLength: 120,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp,

      )),
  output: null, // Use the default LogOutput (-> send everything to console)
  filter: null, // Use the default LogFilter (-> only log in debug mode)
);
