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
    _addSphere(arCoreController);
    _addCylinder(_arCoreController);
    _addCube(_arCoreController);
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
      ),
    );
  }
}
