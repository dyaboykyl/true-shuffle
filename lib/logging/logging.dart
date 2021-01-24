import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {
  final String className;
  final errorColor = PrettyPrinter.levelColors[Level.error];
  SimpleLogPrinter(this.className);

  @override
  List<String> log(LogEvent logEvent) {
    var color = PrettyPrinter.levelColors[logEvent.level];
    var emoji = PrettyPrinter.levelEmojis[logEvent.level];
    final timestamp = DateTime.now().toLocal();
    final messages = [color('$timestamp $emoji$className - ${logEvent.message}')];
    if (logEvent.error != null) {
      messages.add(errorColor('${logEvent.error}'));
    }
    if (logEvent.stackTrace != null) {
      logEvent.stackTrace.toString().split('\n').take(8).forEach((line) {
        messages.add(errorColor(line));
      });
    }
    return messages;
  }
}

Logger logger(Type type) => Logger(printer: SimpleLogPrinter(type.toString()));
