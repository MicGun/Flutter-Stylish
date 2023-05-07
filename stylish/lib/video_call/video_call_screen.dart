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
    _connect(context);
  }

  void _connect(BuildContext context) async {
    _callingServer ??= VideoCallingServer(context);

    _selfId = await _callingServer?.getSelfId();
    if(_selfId != null) {
      setState(() {
        
      });
    }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Video Call'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _inCalling
          ? FloatingActionButton(
              child: const Icon(
                Icons.call_end,
                color: Colors.red,
              ),
              onPressed: () {},
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
                          'Your Id : ${_selfId}',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                          ),),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 350,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: TextField(
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
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0x00000000),
                            minimumSize: const Size(300, 60),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            //to call peer
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
                    ],
                  )
                ],
              ),
          ),
    );
  }
}
