import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stylish/ProductVariant.dart';
import 'package:stylish/ProductVariantIemWithOptionsWidget.dart';
import 'package:stylish/product.dart';

class ProductVariantsWidget extends StatefulWidget {
  ProductVariantsWidget({
    super.key,
    required this.product,
  });
  // List<ProductVariant> variants;
  Product product;
  @override
  State<ProductVariantsWidget> createState() => _ProductVariantsWidgetState();
}

class _ProductVariantsWidgetState extends State<ProductVariantsWidget> {
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
    Product product = widget.product;
    String price = product.price;
    String currency = product.currency;

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
              widget.product.productName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              widget.product.id,
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
                    icon: const Icon(Icons.add),
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: enableAdd2Cart? const Color(0xff3f3a3a) : const Color(0xffe6e6e6),
                      minimumSize: const Size(320, 60),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '加入購物車',
                        style: TextStyle(
                            color: enableAdd2Cart? Color(0xffffffff) : Color(0xff575a69),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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

  List<Widget> getColorOptionWidgets(Product product) {
    List<String> colorCodes = [];
    List<Widget> colors = [];
    for (ProductVariant productVariant in product.variants) {
      String colorCode = productVariant.colorCode;
      if (!colorCodes.contains(colorCode)) {
        colorCodes.add(colorCode);
        colors.add(ChoiceChip(
          label: Card(
            color: hexToColor(productVariant.colorCode),
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

  List<Widget> getSizeOptionWidgets(Product product) {
    List<String> allSize = [];
    List<Widget> sizeWidgetList = [];
    for (ProductVariant productVariant in product.variants) {
      String size = productVariant.size;
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

  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// class VariantSizePicker extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 8,
//       children: [
//         ChoiceChip(
//           label: Text('XS'),
//           selected: sizeValue == 'XS',
//           onSelected: (selected) {
//             setState(() {
//               sizeValue = selected ? 'XS' : null;
//             });
//           },
//         ),
//         ChoiceChip(
//           label: Text('S'),
//           selected: sizeValue == 'S',
//           onSelected: (selected) {
//             setState(() {
//               sizeValue = selected ? 'S' : null;
//             });
//           },
//         ),
//         ChoiceChip(
//           label: Text('M'),
//           selected: sizeValue == 'M',
//           onSelected: (selected) {
//             setState(() {
//               sizeValue = selected ? 'M' : null;
//             });
//           },
//         ),
//         ChoiceChip(
//           label: Text('L'),
//           selected: sizeValue == 'L',
//           onSelected: (selected) {
//             setState(() {
//               sizeValue = selected ? 'L' : null;
//             });
//           },
//         ),
//         ChoiceChip(
//           label: Text('XL'),
//           selected: sizeValue == 'XL',
//           onSelected: (selected) {
//             setState(() {
//               sizeValue = selected ? 'XL' : null;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
