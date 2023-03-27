import 'package:flutter/material.dart';
import 'package:stylish/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
      ),
      home: const ProductsPage(),
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPage();
}

class _ProductsPage extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var webLayout = Scaffold(
        appBar: AppBar(
            title: Image.asset(
          'images/stylish_logo02.png',
          height: 24,
          fit: BoxFit.fitHeight,
        )),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [for (var i = 0; i < 5; i++) const ImageCard()],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  ProductListWeiget(products: [
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                  ],),
                  ProductListWeiget(products: [
                    Product(productName: '超漂亮約會裝扮', imageSrc: 'images/women_clothes.jpg', price: '399'),
                    Product(productName: '超漂亮約會裝扮', imageSrc: 'images/women_clothes.jpg', price: '399'),
                    Product(productName: '超漂亮約會裝扮', imageSrc: 'images/women_clothes.jpg', price: '399'),
                    Product(productName: '超漂亮約會裝扮', imageSrc: 'images/women_clothes.jpg', price: '399'),
                    Product(productName: '超漂亮約會裝扮', imageSrc: 'images/women_clothes.jpg', price: '399'),
                    Product(productName: '超漂亮約會裝扮', imageSrc: 'images/women_clothes.jpg', price: '399'),
                  ],),
                  ProductListWeiget(products: [
                    Product(productName: '必備率性皮帶', imageSrc: 'images/accessories.jpg', price: '199'),
                    Product(productName: '必備率性皮帶', imageSrc: 'images/accessories.jpg', price: '199'),
                    Product(productName: '必備率性皮帶', imageSrc: 'images/accessories.jpg', price: '199'),
                    Product(productName: '必備率性皮帶', imageSrc: 'images/accessories.jpg', price: '199'),
                    Product(productName: '必備率性皮帶', imageSrc: 'images/accessories.jpg', price: '199'),
                    Product(productName: '必備率性皮帶', imageSrc: 'images/accessories.jpg', price: '199'),
                  ],),
                ],
              ),
            ),
          ],
        )),
      );
      var mobileLayout = Scaffold(
        appBar: AppBar(
            title: Image.asset(
          'images/stylish_logo02.png',
          height: 24,
          fit: BoxFit.fitHeight,
        )),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [for (var i = 0; i < 5; i++) const ImageCard()],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  ProductListWeiget(products: [
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                    Product(productName: '超帥氣襯衫', imageSrc: 'images/men_clothes.jpg', price: '299'),
                  ],),
                ]
              ),
            ),
          ],
        )),
      );
      return (constraints.maxWidth > 700) ? webLayout : mobileLayout;
    });
  }
}

class ProductListWeiget extends StatelessWidget {
  ProductListWeiget({
    super.key,
    required this.products,
  });

  List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const Text(
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), '男裝'),
        Expanded(
          child: ListView(
            children: [
              for (Product product in products)
                ProductWidget(
                  product: product,
                )
            ],
          ),
        )
      ],
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            const ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
              child: Image(
                image: AssetImage('images/muji_banner.jpg'),
                fit: BoxFit.fill,
                height: 150,
                width: 300,
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding placeholder() {
    return const Padding(
      padding: EdgeInsets.all(10),
      // ignore: prefer_const_constructors
      child: Card(
        color: Colors.amberAccent,
        borderOnForeground: true,
        child: SizedBox(
          height: 150,
          width: 300,
        ),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  ProductWidget({super.key, required this.product});

  Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            ),
            child: Image(
              image: AssetImage(product.imageSrc),
              fit: BoxFit.fill,
              height: 100,
              width: 80,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.productName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('${product.currency} ${product.price}'),
            ],
          ),
        ],
      ),
    );
  }
}
