import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/main.dart';
import 'package:socialv/whv/constants/Whv_speech_listener_constants.dart';
import 'package:socialv/whv/constants/whv_constants.dart';
import 'package:speech_to_text/speech_to_text.dart';
// TEST
import 'package:flutter_mobx/flutter_mobx.dart';

class WhvSpeachListeningDialog extends StatefulWidget {
  const WhvSpeachListeningDialog({super.key});

  @override
  State<WhvSpeachListeningDialog> createState() =>
      _WhvSpeachListeningDialogState();
}

class _WhvSpeachListeningDialogState extends State<WhvSpeachListeningDialog> {
  late SpeechToText _speechToText;

  late String _lastWords;

  @override
  void initState() {
    super.initState();
    _speechToText = SpeechToText();
    _lastWords = "";

    _listen();
  }

  void _listen() async {
    if (!webviewStore.isListening) {
      bool available = await _speechToText.initialize(
        debugLogging: true,
        onStatus: (val) async {
          if (Platform.isIOS) {
            // on IOS the speech to text timeout was not working so we have used
            // our manual timeout methoodd.
            _onSpeechInitializedTimeOut();
          }

          if (val == WhvSpeechListenerConstants.done) {
            try {
              _speechToText.stop();

              if (webviewStore.speechText.isEmpty) {
                webviewStore.toggleHasSpeechText(false);
                webviewStore.toggleIsListening(false);
              } else {
                await Future.delayed(Duration(milliseconds: 500));
                navigatorKey.currentState!.pop();
              }
            } catch (e) {
              log("exception while popping $e");
            }
          }
        },
        onError: (val) {
          print('onErrorStatus: $val');
        },
      );
      if (available) {
        webviewStore.toggleHasSpeechText(true);

        webviewStore.toggleIsListening(true);
        await _speechToText.listen(
          // listenFor: Duration(seconds: 30),
          onResult: (val) {
            _lastWords = val.recognizedWords;
            webviewStore.updateSpeechText(val.recognizedWords);

            // we set our own timer on ios as the default speechToText timeOut is not working.
            if (Platform.isIOS) {
              _timeOut(val.recognizedWords);
            }
            setState(() {});
          },
        );
      }
    } else {
      webviewStore.toggleHasSpeechText(false);

      webviewStore.toggleIsListening(false);
      _speechToText.stop();
    }
  }

  _onSpeechInitializedTimeOut() async {
    await Future.delayed(Duration(milliseconds: 2000), () {
      if (_lastWords.isEmpty) {
        _speechToText.stop();
      }
    });
  }

  _timeOut(String newValue) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (newValue.toLowerCase() == webviewStore.speechText.toLowerCase()) {
      _speechToText.stop();
    }
  }

  @override
  dispose() {
    super.dispose();

    _speechToText.stop();
    webviewStore.toggleIsListening(false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AvatarGlow(
            animate: webviewStore.isListening,
            glowColor: context.primaryColor,
            endRadius: 75.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: FloatingActionButton(
              onPressed: null,
              child:
                  Icon(webviewStore.isListening ? Icons.mic : Icons.mic_none),
            ),
          ),
          Text(
            webviewStore.isListening
                ? _lastWords
                : webviewStore.hasGotSpeechText
                    ? WhvConstants.WhvEmptyStr
                    : WhvSpeechListenerConstants.didntGotAnythingMessage,
          ),
          Visibility(
            visible: webviewStore.hasGotSpeechText == false,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: OutlinedButton(
                onPressed: _listen,
                child: Text(whvLanguage.tryAgain),
              ),
            ),
          ),
          if (_lastWords.isNotEmpty || webviewStore.hasGotSpeechText == false)
            SizedBox(height: 20),
        ],
      );
    });
  }
}
