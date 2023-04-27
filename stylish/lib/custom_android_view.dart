import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnViewCreated = Function(CustomViewController);

///Custome AndroidView
class CustomAndroidView extends StatefulWidget {
  final OnViewCreated onViewCreated;

  const CustomAndroidView(this.onViewCreated, {Key? key}) : super(key: key);

  @override
  State<CustomAndroidView> createState() => _CustomAndroidViewState();
}

class _CustomAndroidViewState extends State<CustomAndroidView> {
  late MethodChannel _channel;

  @override
  Widget build(BuildContext context) {
    return _getPlatformFaceView();
  }

  Widget _getPlatformFaceView() {
    return AndroidView(
      viewType: 'com.rex.custom.android/customView',
      onPlatformViewCreated: _onPlatformViewCreated,
      creationParams: const <String, dynamic>{'initParams': 'hello world'},
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

  void _onPlatformViewCreated(int id) {
    _channel = MethodChannel('com.rex.custom.android/customView$id');
    final controller = CustomViewController._(
      _channel,
    );
    widget.onViewCreated(controller);
  }
}

class CustomViewController {
  final MethodChannel _channel;
  final StreamController<String> _controller = StreamController<String>();

  CustomViewController._(
    this._channel,
  ) {
    _channel.setMethodCallHandler(
      (call) async {
        switch (call.method) {
          case 'getPrimeSuccessful':
          //get data from native side
            final result = call.arguments as String;
            _controller.sink.add(result);
            break;
        }
      },
    );
  }

  Stream<String> get customDataStream => _controller.stream;

  // send data to native side
  Future<void> sendMessageToAndroidView(String message) async {
    await _channel.invokeMethod(
      'methodNameHere',
      message,
    );
  }
}