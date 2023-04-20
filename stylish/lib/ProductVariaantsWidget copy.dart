import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stylish/CartProduct.dart';
import 'package:stylish/ProductVariant.dart';
import 'package:stylish/ProductVariantIemWithOptionsWidget.dart';
import 'package:stylish/main.dart';
import 'package:stylish/models/products_model.dart';
import 'package:stylish/product.dart';
import 'package:flutter/painting.dart' as libColor;

class ProductVariantsWidget2 extends StatefulWidget {
  ProductVariantsWidget2({
    super.key,
    required this.product,
  });
  // List<ProductVariant> variants;
  Datum product;
  @override
  State<ProductVariantsWidget2> createState() => _ProductVariantsWidgetState2();
}

class _ProductVariantsWidgetState2 extends State<ProductVariantsWidget2> {
  String? sizeValue = '';
  String? selectedColorCode = '';
  int? count = 1;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      int? qty = int.tryParse(_controller.text);

      if (qty == null) {
        _controller.text = 1.toString();
        setState(() {
          count = 1;
        });
      } else if (qty < 1) {
        _controller.text = 1.toString();
        setState(() {
          count = 1;
        });
      } else {
        setState(() {
          count = qty;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Datum product = widget.product;
    int? price = product.price;
    String currency = 'NTD';

    bool enableAdd2Cart = count != null &&
        count! >= 1 &&
        selectedColorCode != null &&
        selectedColorCode != '' &&
        sizeValue != null &&
        sizeValue != '';

    return SizedBox(
        height: 500,
        width: 360,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${product.id}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: 16,
              ),
              Text('$currency $price'),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              ProductVariantIemWithOptionsWidget(
                  title: '顏色',
                  child: SingleChildScrollView(
                    child: Row(
                      children: getColorOptionWidgets(product),
                    ),
                  )),
              ProductVariantIemWithOptionsWidget(
                title: '尺寸',
                child: Wrap(
                  spacing: 8,
                  children: getSizeOptionWidgets(product),
                ),
              ),
              ProductVariantIemWithOptionsWidget(
                title: '數量',
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '$count',
                    prefixIcon: IconButton(
                      // iconSize: 20,
                      // padding: EdgeInsets.zero,
                      // constraints: const BoxConstraints(),
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (count == null || count! < 2) {
                            count = 1;
                          } else {
                            count = count! - 1;
                          }
                        });
                        _controller.text = count.toString();
                      },
                    ),
                    suffixIcon: IconButton(
                      // iconSize: 20,
                      // padding: EdgeInsets.zero,
                      // constraints: const BoxConstraints(),
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (count == null) {
                            count = 1;
                          }
                          count = count! + 1;
                        });
                        _controller.text = count.toString();
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: enableAdd2Cart
                              ? const libColor.Color(0xff3f3a3a)
                              : const libColor.Color(0xffe6e6e6),
                          minimumSize: const Size(320, 60),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // if (enableAdd2Cart) {
                          //   CartProduct cartProduct = CartProduct(
                          //       id: widget.product.id,
                          //       imageSrc: widget.product.imageSrc,
                          //       productName: widget.product.productName,
                          //       currency: currency,
                          //       price: price,
                          //       totalPrice: getTotalPrice(count, price),
                          //       colorName: '',
                          //       colorCode: selectedColorCode!,
                          //       size: sizeValue!,
                          //       amount: count!);
                          //   value.addProduct2Cart(cartProduct);
                          //   setState(() {
                          //     count = 1;
                          //     selectedColorCode = '';
                          //     sizeValue = '';
                          //   });
                          //   _controller.text = 1.toString();
                          // }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '加入購物車',
                            style: TextStyle(
                              color: enableAdd2Cart
                                  ? libColor.Color(0xffffffff)
                                  : libColor.Color(0xff575a69),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

  String getTotalPrice(int? amount, String? price) {
    if (price == null || price == '' || amount == null || amount < 1) {
      return 0.toString();
    }

    int? priceInt = int.tryParse(price);
    if (priceInt == null) {
      return '0';
    } else {
      return (amount * priceInt).toString();
    }
  }

  List<Widget> getColorOptionWidgets(Datum product) {
    List<String> colorCodes = [];
    List<Widget> colors = [];
    for (Variant productVariant in product.variants!) {
      String colorCode = productVariant.colorCode!;
      if (!colorCodes.contains(colorCode)) {
        colorCodes.add(colorCode);
        colors.add(ChoiceChip(
          label: Card(
            color: hexToColor(productVariant.colorCode!),
            child: const SizedBox(
              width: 20,
              height: 20,
            ),
          ),
          selected: selectedColorCode == productVariant.colorCode,
          onSelected: (selected) {
            setState(() {
              selectedColorCode = selected ? productVariant.colorCode : null;
            });
          },
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ));
      }
    }
    return colors;
  }

  List<Widget> getSizeOptionWidgets(Datum product) {
    List<String> allSize = [];
    List<Widget> sizeWidgetList = [];
    for (Variant productVariant in product.variants!) {
      String size = productVariant.size!;
      if (!allSize.contains(size)) {
        allSize.add(size);
        sizeWidgetList.add(ChoiceChip(
          label: Text(size),
          selected: sizeValue == size,
          onSelected: (selected) {
            setState(() {
              sizeValue = selected ? size : null;
            });
          },
        ));
      }
    }
    return sizeWidgetList;
  }

  libColor.Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return libColor.Color(int.parse(hexString.replaceFirst('', '0x$alphaChannel')));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
