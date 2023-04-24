import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/CartProduct.dart';
import 'package:stylish/FakeRepo.dart';
import 'package:stylish/ProductListExpansionWeiget.dart';
import 'package:stylish/ShoppingCartPage.dart';
import 'package:stylish/cubit/product_cubit/product_state.dart';
import 'package:stylish/domain/category_domain.dart';
import 'package:stylish/models/products_model.dart';
import 'package:stylish/product.dart';
import 'package:stylish/widgets/default_loading_indicator.dart';

import 'ImageCardWeiget.dart';
import 'ProductDetailsPage copy.dart';
import 'ProductListWeiget.dart';
import 'cubit/product_cubit/product_cubit.dart';
import 'package:flutter/painting.dart' as libColor;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _goRouter = GoRouter(routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const ProductsPage(),
    ),
    GoRoute(
      path: "/productDetails",
      builder: (context, state) => ProductDetailsPage(
        product: state.extra as Datum,
        // product: Product(
        //     id: '2023001001',
        //     productName: '超帥氣襯衫',
        //     imageSrc: 'images/men_clothes.jpg',
        //     price: '299',
        //     currency: "NT\$",
        //     variants: FakeRepo().getFakeVariants()),
      ),
    ),
    GoRoute(
      path: "/shoppingCart",
      builder: (context, state) => ShoppingCartPage(),
    ),
  ]);

  // // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => MyAppState(),
  //     child: MaterialApp.router(
  //       routerConfig: _goRouter,
  //       title: 'Flutter Demo',
  //       theme: ThemeData(
  //         // This is the theme of your application.
  //         //
  //         // Try running your application with "flutter run". You'll see the
  //         // application has a blue toolbar. Then, without quitting the app, try
  //         // changing the primarySwatch below to Colors.green and then invoke
  //         // "hot reload" (press "r" in the console where you ran "flutter run",
  //         // or simply save your changes to "hot reload" in a Flutter IDE).
  //         // Notice that the counter didn't reset back to zero; the application
  //         // is not restarted.
  //         primarySwatch: Colors.grey,
  //       ),
  //       // home: ProductDetailsPage(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProcuctCubit(),
      child: MaterialApp.router(
        routerConfig: _goRouter,
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
        // home: ProductDetailsPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  int selectedItem = -1;
  List<CartProduct> cartProducts = [];
  void itemSelected(int selectedIndex) {
    selectedItem = selectedIndex;
    notifyListeners();
  }

  void addProduct2Cart(CartProduct product) {
    cartProducts.add(product);
    notifyListeners();
  }

  void removeProductfromCart(CartProduct product) {
    cartProducts.remove(product);
    notifyListeners();
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});
  @override
  State<ProductsPage> createState() => _ProductsPage();
}

class _ProductsPage extends State<ProductsPage> {
  FakeRepo repo = FakeRepo();
  late ProcuctCubit procuctCubit;
  static const platform = MethodChannel('samples.flutter.dev/battery');

  @override
  void initState() {
    // procuctCubit = ProcuctCubit();
    // procuctCubit.getAllProducts(0);
    context.read<ProcuctCubit>().getBatteryLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<ProcuctCubit>().getAllProducts(0);
    var level = context.watch<ProcuctCubit>().batteryLevel;
    return 
    BlocBuilder<ProcuctCubit, ProductState>(
      builder: (context, state) {
        return Center(
          child: Text(level),
        );
      },
    );
    // LayoutBuilder(builder: (context, constraints) {
    //   var webLayout = Scaffold(
    //     appBar: AppBar(
    //         backgroundColor: libColor.Color(0xF1F4F8),
    //         title: Image.asset(
    //           'images/stylish_logo02.png',
    //           height: 24,
    //           fit: BoxFit.fitHeight,
    //         ),
    //         actions: <Widget>[
    //           IconButton(
    //             icon: Icon(
    //               Icons.add_shopping_cart,
    //               color: Colors.white,
    //             ),
    //             onPressed: () {
    //               GoRouter.of(context).go('/shoppingCart');
    //             },
    //           ),
    //         ]),
    //     body:
    //         BlocBuilder<ProcuctCubit, ProductState>(builder: (context, state) {
    //       return Center(
    //           child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           SizedBox(
    //             height: 170,
    //             child: ListView(
    //               scrollDirection: Axis.horizontal,
    //               children: [
    //                 for (var i = 0; i < 5; i++) const ImageCardWeiget()
    //               ],
    //             ),
    //           ),
    //           Expanded(child: getWebProductListWidget(state)
    //               // Row(
    //               //   children: [
    //               //     ProductListWidget(
    //               //       listTitle: '男裝',
    //               //       // products: repo.getMenProducts(),
    //               //       onProductTap: (product) {},
    //               //     ),
    //               //     ProductListWidget(
    //               //       listTitle: '女裝',
    //               //       // products: repo.getWomenProducts(),
    //               //       onProductTap: (product) {},
    //               //     ),
    //               //     ProductListWidget(
    //               //       listTitle: '配件',
    //               //       // products: repo.getAccessoryProducts(),
    //               //       onProductTap: (product) {},
    //               //     ),
    //               //   ],
    //               // ),
    //               ),
    //         ],
    //       ));
    //     }),
    //   );
    //   var mobileLayout = MobileCatalogScreen(
    //     repo: repo,
    //     onProductTap: (value) {},
    //   );
    //   return (constraints.maxWidth > 700) ? webLayout : mobileLayout;
    // });
  }
}

Widget getWebProductListWidget(ProductState state) {
  if (kDebugMode) {
    print(state);
  }
  if (state is GetProductsFailureState) {
    return const Text('Failed to get products');
  } else if (state is GetProductsLoadingState) {
    return const DefaultLoadingIndicator(
      color: Colors.grey,
    );
  } else if (state is ShowLoadingState) {
    return const DefaultLoadingIndicator(
      color: Colors.grey,
    );
  } else if (state is GetProductsSuccessState) {
    var categoryTypes = ProductCategoryType.values;
    return Row(
        children: List.generate(
      categoryTypes.length,
      (index) => ProductListWidget(
        listTitle: categoryTypes[index].getProductCategoryTypeName(),
        categoryType: categoryTypes[index],
        // products: repo.getMenProducts(),
        onProductTap: (product) {},
      ),
    ));
  } else {
    return const Text('Failed to get products');
  }
}

class MobileCatalogScreen extends StatefulWidget {
  MobileCatalogScreen({
    super.key,
    required this.repo,
    required this.onProductTap,
  });

  final FakeRepo repo;
  ValueSetter<Product> onProductTap;
  int expandedIndex = -1;

  @override
  State<MobileCatalogScreen> createState() => _MobileCatalogScreenState();
}

class _MobileCatalogScreenState extends State<MobileCatalogScreen> {
  @override
  Widget build(BuildContext context) {
    var categoryTypes = ProductCategoryType.values;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: libColor.Color(0xF1F4F8),
          title: Image.asset(
            'images/stylish_logo02.png',
            height: 24,
            fit: BoxFit.fitHeight,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                GoRouter.of(context).go('/shoppingCart');
              },
            ),
          ]),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [for (var i = 0; i < 5; i++) const ImageCardWeiget()],
            ),
          ),
          Expanded(
            child: Row(children: [
              ProductListExpansionWidget(
                categoryTypes: categoryTypes,
                onProductTap: widget.onProductTap,
              ),
            ]),
          ),
        ],
      )),
    );

    // Consumer<MyAppState>(
    //   builder: (context, value, child) => Scaffold(
    //     appBar: AppBar(
    //         title: Image.asset(
    //           'images/stylish_logo02.png',
    //           height: 24,
    //           fit: BoxFit.fitHeight,
    //         ),
    //         actions: <Widget>[
    //           IconButton(
    //             icon: Icon(
    //               Icons.add_shopping_cart,
    //               color: Colors.white,
    //             ),
    //             onPressed: () {
    //               GoRouter.of(context).go('/shoppingCart');
    //             },
    //           ),
    //         ]),
    //     body: Center(
    //         child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         SizedBox(
    //           height: 170,
    //           child: ListView(
    //             scrollDirection: Axis.horizontal,
    //             children: [for (var i = 0; i < 5; i++) const ImageCardWeiget()],
    //           ),
    //         ),
    //         Expanded(
    //           child: Row(children: [
    //             ProductListExpansionWidget(
    //               productCategories: repo.getAllCategoryProducts(),
    //               onProductTap: onProductTap,
    //             ),
    //           ]),
    //         ),
    //       ],
    //     )),
    //   ),
    // );
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
