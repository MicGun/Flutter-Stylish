import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stylish/ProductVariantIemWithOptionsWidget.dart';

class ProductVariantsWidget extends StatefulWidget {
  const ProductVariantsWidget({super.key});

  @override
  State<ProductVariantsWidget> createState() => _ProductVariantsWidgetState();
}

class _ProductVariantsWidgetState extends State<ProductVariantsWidget> {
  String? sizeValue = 'M';
  int? count = 1;
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      int? qty = int.tryParse(_controller.text);

      if(qty == null) {
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
    return SizedBox(
      height: 500,
      width: 360,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '超帥氣襯衫',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '20230831',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              height: 16,
            ),
            Text('NT\$ 323'),
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
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Card(
                          color: Colors.red,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Card(
                          color: Colors.yellow,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Card(
                          color: Colors.black,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Card(
                          color: Colors.blue,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            ProductVariantIemWithOptionsWidget(
              title: '尺寸',
              child: Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: Text('XS'),
                    selected: sizeValue == 'XS',
                    onSelected: (selected) {
                      setState(() {
                        sizeValue = selected ? 'XS' : null;
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text('S'),
                    selected: sizeValue == 'S',
                    onSelected: (selected) {
                      setState(() {
                        sizeValue = selected ? 'S' : null;
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text('M'),
                    selected: sizeValue == 'M',
                    onSelected: (selected) {
                      setState(() {
                        sizeValue = selected ? 'M' : null;
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text('L'),
                    selected: sizeValue == 'L',
                    onSelected: (selected) {
                      setState(() {
                        sizeValue = selected ? 'L' : null;
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text('XL'),
                    selected: sizeValue == 'XL',
                    onSelected: (selected) {
                      setState(() {
                        sizeValue = selected ? 'XL' : null;
                      });
                    },
                  ),
                ],
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
                    icon: Icon(Icons.add),
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
                    icon: Icon(Icons.add),
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
                      backgroundColor: const Color(0xff3f3a3a),
                      minimumSize: const Size(320, 60),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '請選擇尺寸',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
