import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:true_shuffle/logging/logging.dart';

class SpotifyService {
  final log = logger(SpotifyService);
  var connected = false;

  Future connect() async {
    log.i('Connecting to spotify...');
    connected = await SpotifySdk.connectToSpotifyRemote(
      clientId: env['CLIENT_ID'].toString(),
      redirectUrl: env['REDIRECT_URI'].toString(),
    );
    if (connected) {
      log.i('Successfully connected to spotify');
    } else {
      throw Exception('Unknown failure');
    }
  }

  void togglePlayback() async {
    checkConnection();
    final state = await SpotifySdk.getPlayerState();
    if (state.isPaused) {
      await SpotifySdk.resume();
    } else {
      await SpotifySdk.pause();
    }
  }

  void checkConnection() {
    if (!connected) {
      throw Exception('Not connected to spotify');
    }
  }
}
