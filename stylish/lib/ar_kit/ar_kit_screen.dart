import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArKitScreen extends StatefulWidget {
  const ArKitScreen({super.key});

  @override
  State<ArKitScreen> createState() => _ArKitScreenState();
}

class _ArKitScreenState extends State<ArKitScreen> {
  late ArCoreController arCoreController;

  _onArCoreViewCreated(ArCoreController _arCoreController) {
    arCoreController = _arCoreController;
    arCoreController.onPlaneTap = (hits) {
      _handlePlaneTap(hits, arCoreController);
    };
    // _addSphere(arCoreController);
    // _addCylinder(_arCoreController);
    // _addCube(_arCoreController);
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

    final moonMaterial = ArCoreMaterial(color: Colors.grey);

    final moonShape = ArCoreSphere(
      materials: [moonMaterial],
      radius: 0.03,
    );

    final moon = ArCoreNode(
      shape: moonShape,
      position: vector.Vector3(0.2, 0, 0),
      rotation: vector.Vector4(0, 0, 0, 0),
    );

    final earthMaterial = ArCoreMaterial(
        color: Color.fromARGB(184, 66, 134, 244),);

    final earthShape = ArCoreSphere(
      materials: [earthMaterial],
      radius: 0.1,
    );

    final earth = ArCoreNode(
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

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }
}
