import 'package:flutter/material.dart';

class ProductVariantsWidget extends StatelessWidget {
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
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Text('顏色', style: Theme.of(context).textTheme.bodyMedium,),
                  const VerticalDivider(
                    width: 16,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Text('尺寸', style: Theme.of(context).textTheme.bodyMedium,),
                  const VerticalDivider(
                    width: 16,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Text('數量', style: Theme.of(context).textTheme.bodyMedium,),
                  const VerticalDivider(
                    width: 16,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                ],
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
        minimumSize: const Size(320,60),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
               Radius.circular(5),
            ),
        ),
    ),
                  onPressed: () {  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('請選擇尺寸', style: TextStyle(color: Color(0xffffffff), fontSize: 18, fontWeight: FontWeight.bold),),
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
}
