import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:stylish/video_call/video_call_server.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  String? _selfId;
  VideoCallingServer? _callingServer;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  Session? _session;
  bool _inCalling = false;
  bool _waitAccept = false;

  TextEditingController _peerIdController = TextEditingController();
  String? _peerId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initRenderers();
    _initServer(context);
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void _initServer(BuildContext context) async {
    _callingServer ??= VideoCallingServer(context)..connect();

    _selfId = await _callingServer?.getSelfId();
    if (_selfId != null) {
      setState(() {});
    }

    _callingServer?.onCallStateChange =
        (Session session, CallState state) async {
      switch (state) {
        case CallState.CallStateNew:
          setState(() {
            _session = session;
          });
          break;
        case CallState.CallStateRinging:
          bool? accept = await _showAcceptDialog(session.pid);
          if (accept!) {
            _accept();
            setState(() {
              _inCalling = true;
            });
          } else {
            _reject();
          }
          break;
        case CallState.CallStateBye:
          if (_waitAccept) {
            print('peer reject');
            _waitAccept = false;
            Navigator.of(context).pop(false);
          }
          setState(() {
            _localRenderer.srcObject = null;
            _remoteRenderer.srcObject = null;
            _inCalling = false;
            _session = null;
          });
          break;
        case CallState.CallStateInvite:
          _waitAccept = true;
          _showInvateDialog(session.pid);
          break;
        case CallState.CallStateConnected:
          if (_waitAccept) {
            _waitAccept = false;
            Navigator.of(context).pop(false);
          }
          setState(() {
            _inCalling = true;
          });

          break;
      }
    };

    _callingServer?.onLocalStream = ((stream) {
      _localRenderer.srcObject = stream;
      setState(() {});
    });

    _callingServer?.onAddRemoteStream = ((_, stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });

    _callingServer?.onRemoveRemoteStream = ((_, stream) {
      _remoteRenderer.srcObject = null;
    });

    // _callingServer?.onLocalStream = ((stream) {
    //   _localRenderer.srcObject = stream;
    //   setState(() {});
    // });

    // _callingServer?.onAddRemoteStream = ((_, stream) {
    //   _remoteRenderer.srcObject = stream;
    //   _inCalling = true;
    //   setState(() {});
    // });

    // _callingServer?.onRemoveRemoteStream = ((_, stream) {
    //   // _remoteRenderer.srcObject = null;
    //   setState(() {
    //     _inCalling = false;
    //     _waitAccept = false;
    //     _localRenderer.srcObject = null;
    //     _remoteRenderer.srcObject = null;
    //     _inCalling = false;
    //     _session = null;
    //   });
    // });
  }

  _invitePeer(BuildContext context, String peerId, bool useScreen) async {
    if (_callingServer != null && peerId != _selfId) {
      _callingServer?.invite(peerId, 'video', useScreen);
    }
  }

  _accept() {
    if (_session != null) {
      _callingServer?.accept(_session!.sid, 'video');
    }
  }

  _reject() {
    if (_session != null) {
      _callingServer?.reject(_session!.sid);
    }
  }

  _hangUp() {
    if (_session != null) {
      _callingServer?.bye(_session!.sid);
    }
  }

  _muteMic() {
    _callingServer?.muteMic();
  }

  // void _createVideoCall() async {
  //   if (_peerId != null && _peerId!.isNotEmpty) {
  //     _session = await _callingServer?.createCall(_peerId!);
  //     if (_session != null) {
  //       setState(() {
  //         _waitAccept = true;
  //       });
  //     }
  //   }
  // }

  // void _JoinVideoCall() async {
  //   if (_peerId != null && _peerId!.isNotEmpty) {
  //     _session = await _callingServer?.joinCall(_peerId!);
  //     if (_session != null) {
  //       setState(() {
  //         _waitAccept = true;
  //       });
  //     }
  //   }
  // }

  // _hangUp() {
  //   if (_session != null) {
  //     _callingServer?.leaveCall(_session!.sid);
  //   }
  // }

  Future<bool?> _showAcceptDialog(String peerId) {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Calling..."),
          content: Text('你收到來自 $peerId 的來電'),
          actions: <Widget>[
            MaterialButton(
              child: Text(
                '拒接',
                style: TextStyle(color: Color(0xff575a69)),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            MaterialButton(
              child: Text(
                '接起',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showInvateDialog(String peerId) {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Calling"),
          content: Text("正在等待 $peerId 接通電話"),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () {
                Navigator.of(context).pop(false);
                _hangUp();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _inCalling
          ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                child: const Icon(
                  Icons.call_end,
                  color: Colors.red,
                ),
                onPressed: () {
                  _hangUp();
                },
              ),
              FloatingActionButton(
                child: const Icon(
                  Icons.mic_off_rounded,
                  color: Colors.blueAccent,
                ),
                onPressed: () {
                  _muteMic();
                },
              ),]
          )
          : null,
      body: _inCalling
          ? OrientationBuilder(builder: (context, orientation) {
              return Stack(children: <Widget>[
                Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 0.0,
                    bottom: 0.0,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: RTCVideoView(_remoteRenderer),
                      decoration: BoxDecoration(color: Colors.black54),
                    )),
                Positioned(
                  left: 20.0,
                  top: 20.0,
                  child: Container(
                    width: orientation == Orientation.portrait ? 90.0 : 120.0,
                    height: orientation == Orientation.portrait ? 120.0 : 90.0,
                    child: RTCVideoView(_localRenderer, mirror: true),
                    decoration: BoxDecoration(color: Colors.black54),
                  ),
                ),
              ]);
            })
          : IntrinsicWidth(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Text(
                          'Your Id : $_selfId',
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              // textInputAction: TextInputAction.search,
                              // onSubmitted: (value) {
                              //   getSearchLocation(value);
                              // },
                              controller: _peerIdController,
                              onChanged: (text) {
                                setState(() {
                                  _peerId = text;
                                });
                              },
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.supervised_user_circle),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                hintText: 'Input Peer Id here',
                              ),
                            )),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              minimumSize: const Size(300, 60),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: () {
                              //to call peer
                              if (_peerId != null && _peerId!.isNotEmpty) {
                                _invitePeer(context, _peerId!, false);
                              }
                              // _createVideoCall();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '打給他',
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: EdgeInsets.all(16),
                      //     child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.purpleAccent,
                      //         minimumSize: const Size(300, 60),
                      //         shape: const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.all(
                      //             Radius.circular(5),
                      //           ),
                      //         ),
                      //       ),
                      //       onPressed: () {
                      //         //to call peer
                      //         _JoinVideoCall();
                      //       },
                      //       child: const Padding(
                      //         padding: EdgeInsets.all(8.0),
                      //         child: Text(
                      //           '加入他',
                      //           style: TextStyle(
                      //             color: Color(0xffffffff),
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }
}
