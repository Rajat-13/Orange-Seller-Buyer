import 'package:flutter/material.dart';
import 'package:orange/utils/CustomColors.dart';
import 'package:orange/utils/CustomTextStyle.dart';
import 'package:orange/viewmodels/sellercrudViewModel.dart';
import 'package:provider/provider.dart';


class CreateProductPage extends StatefulWidget {
  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {

  TextEditingController product_name = TextEditingController();
  TextEditingController product_disc = TextEditingController();
  TextEditingController product_mrp = TextEditingController();
  TextEditingController product_price = TextEditingController();
  TextEditingController product_unit_quantity = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "ADD Product",
          style: CustomTextStyle.textFormFieldBlack.copyWith(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24,
            ),

            Container(
              child: TextFormField(
                controller: product_name,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: border,
                  hintText: "Orange Type Name",
                  focusedBorder: border.copyWith(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            ),
            Container(
              child: TextFormField(
                controller: product_price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: border,
                  hintText: "Product Price",
                  focusedBorder: border.copyWith(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            ),
            Container(
              child: TextFormField(
                controller: product_disc,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: border,
                  hintText: "Product Discount in %",
                  focusedBorder: border.copyWith(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            ),
            Container(
              child: TextFormField(
                controller: product_mrp,
                keyboardType: TextInputType.number ,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: border,
                  hintText: "Product MRP",
                  focusedBorder: border.copyWith(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            ),
            // Container(
            //   child: TextFormField(
            //     controller: product_unit_quantity,
            //     keyboardType: TextInputType.text,
            //     decoration: InputDecoration(
            //       contentPadding: EdgeInsets.all(12),
            //       border: border,
            //       hintText: "Product Unit Quantity",
            //       focusedBorder: border.copyWith(
            //           borderSide: BorderSide(color: Colors.blue)),
            //     ),
            //   ),
            //   margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            // ),

            SizedBox(
              height: 24,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 48, right: 48),
              child: ElevatedButton(
                // color: Colors.blue,
                // textColor: Colors.white,
                onPressed: () {

                  Map data = {
                 'product_name' : product_name.text,
                  'product_price' :product_price.text,
                  'product_mrp' :product_mrp.text,
                  'product_discount' : product_disc.text,
                  'product_unit_qty' : product_unit_quantity.text,
                  };

                  Provider.of<SellercrudViewModel>(context,listen: false).postProduct(context, data);

                },
                child: Text(
                  "Save",
                  style: CustomTextStyle.textFormFieldBlack
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.grey));
}
