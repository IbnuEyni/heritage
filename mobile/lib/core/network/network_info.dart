import 'dart:io';
import '../constants/app_constants.dart';

class NetworkInfo {
  /// Opens a raw TCP socket to the server host:port.
  /// Much faster than HTTP — no HTTP overhead, just checks if port is open.
  static Future<bool> get isConnected async {
    try {
      final uri  = Uri.parse(AppConstants.baseUrl);
      final host = uri.host;
      final port = uri.port;
      final sock = await Socket.connect(host, port,
          timeout: const Duration(seconds: 3));
      sock.destroy();
      return true;
    } catch (_) {
      return false;
    }
  }
}
