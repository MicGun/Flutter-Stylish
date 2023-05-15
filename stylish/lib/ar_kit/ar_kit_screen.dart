import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArKitScreen extends StatefulWidget {
  const ArKitScreen({super.key});

  @override
  State<ArKitScreen> createState() => _ArKitScreenState();
}

class _ArKitScreenState extends State<ArKitScreen> {
  late ArCoreController arCoreController;

  bool isEarth = false;

  _onArCoreViewCreated(ArCoreController _arCoreController) {
    arCoreController = _arCoreController;
    arCoreController.onNodeTap = (name) => _onTapHandler(name);
    arCoreController.onPlaneTap = (hits) {
      if (isEarth) {
        _handlePlaneTap(hits, _arCoreController);
      } else {
        _addToucano(hits, arCoreController);
      }
    };
    // _addSphere(arCoreController);
    // _addCylinder(_arCoreController);
    // _addCube(_arCoreController);
  }

  _onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('移除$name'),
        content: Text('你真的捨得移除$name嗎？'),
        actions: <Widget>[
          MaterialButton(
            child: const Text(
              '取消',
              style: TextStyle(color: Color(0xff575a69)),
            ),
            onPressed: () {},
          ),
          MaterialButton(
            child: const Text(
              '移除',
              style: TextStyle(color: Colors.redAccent),
            ),
            onPressed: () {
              arCoreController.removeNode(nodeName: name);
              Navigator.pop(context);
            },
          ),
        ],
        // Row(
        //   children: <Widget>[
        //     Text('Remove $name?'),
        //     IconButton(
        //         icon: Icon(
        //           Icons.delete,
        //         ),
        //         onPressed: () {
        //           arCoreController.removeNode(nodeName: name);
        //           Navigator.pop(context);
        //         })
        //   ],
        // ),
      ),
    );
  }

  _handlePlaneTap(
      List<ArCoreHitTestResult> hits, ArCoreController _arCoreController) {
    var hit = hits.first;
    if (hit != null) {
      _addSphereByClickPlane(hit, _arCoreController);
    }
  }

  _addSphereByClickPlane(
      ArCoreHitTestResult hit, ArCoreController _arCoreController) async {

    ByteData moonTextureBytes = await rootBundle.load('images/moon.jpeg');    
    final moonMaterial = ArCoreMaterial(color: Colors.grey, textureBytes: moonTextureBytes.buffer.asUint8List());

    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: 0.03,
    );

    final moon = ArCoreNode(
      shape: moonShape,
      position: vector.Vector3(0.2, 0, 0),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    ByteData textureBytes = await rootBundle.load('images/earth.jpg');

    final earthMaterial = ArCoreMaterial(
      color: Color.fromARGB(184, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List()
    );

    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius: 0.1,
    );

    final earth = ArCoreNode(
      name: '地球月亮',
        shape: earthShape,
        children: [moon],
        position: hit.pose.translation + vector.Vector3(0.0, 0.5, 0.0),
        rotation: hit.pose.rotation);

    // var material = ArCoreMaterial(color: Colors.deepOrange);
    // var sphere = ArCoreSphere(materials: [material], radius: 0.2);
    // var node = ArCoreNode(
    //   shape: sphere,
    //   position: hit.pose.translation + vector.Vector3(0.0, 1.0, 0.0),
    //   rotation: hit.pose.rotation
    // );
    _arCoreController.addArCoreNodeWithAnchor(earth);
  }

  _addSphere(ArCoreController _arCoreController) {
    var material = ArCoreMaterial(color: Colors.deepOrange);
    var sphere = ArCoreSphere(materials: [material], radius: 0.2);
    var node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1),
    );
    _arCoreController.addArCoreNode(node);
  }

  _addCylinder(ArCoreController _arCoreController) {
    var material = ArCoreMaterial(color: Colors.green, reflectance: 1);
    var cylinder =
        ArCoreCylinder(materials: [material], radius: 0.4, height: 0.3);
    var node = ArCoreNode(
      shape: cylinder,
      position: vector.Vector3(0, -0.5, -3.0),
    );
    _arCoreController.addArCoreNode(node);
  }

  _addCube(ArCoreController _arCoreController) {
    var material = ArCoreMaterial(color: Colors.pink, metallic: 1);
    var cube = ArCoreCube(materials: [material], size: vector.Vector3(1, 1, 1));
    var node = ArCoreNode(
      shape: cube,
      position: vector.Vector3(-0.5, -0.5, -4.0),
    );
    _arCoreController.addArCoreNode(node);
  }

  _addToucano(
      List<ArCoreHitTestResult> hits, ArCoreController _arCoreController) {
    var plane = hits.first;
    final toucanNode = ArCoreReferenceNode(
        name: "可愛鴨鴨",
        object3DFileName: '',
        objectUrl:
            "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf",
        position: plane.pose.translation,
        rotation: plane.pose.rotation);

    _arCoreController.addArCoreNodeWithAnchor(toucanNode);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  _swich2Balls() {
    setState(() {
      isEarth = true;
    });
  }

  _swich2Duck() {
    setState(() {
      isEarth = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isEarth ? Colors.black87 : Colors.black12,
                        minimumSize: const Size(300, 60),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      onPressed: _swich2Balls,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '地球月亮',
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isEarth ? Colors.black12 : Colors.black87,
                        minimumSize: const Size(300, 60),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      onPressed: _swich2Duck,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '黃色鴨鴨',
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
                // MaterialButton(
                //   child: Text('太陽系'),
                //   onPressed: _swich2Balls,
                // ),
                // MaterialButton(child: Text('黃色鴨鴨'), onPressed: _swich2Duck)
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
