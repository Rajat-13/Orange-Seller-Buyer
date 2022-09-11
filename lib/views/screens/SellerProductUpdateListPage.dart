import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orange/data/response/status.dart';
import 'package:orange/model/productModel.dart';
import 'package:orange/repository/authRepository.dart';
import 'package:orange/utils/CustomBorder.dart';
import 'package:orange/utils/CustomTextStyle.dart';
import 'package:orange/utils/CustomUtils.dart';
import 'package:orange/viewmodels/sellercrudViewModel.dart';
import 'package:orange/views/widgets/content_dialog.dart';
import 'package:provider/provider.dart';



class SellerProductListUpdatePage extends StatefulWidget {
  @override
  _SellerProductListUpdatePageState createState() => _SellerProductListUpdatePageState();
}

class _SellerProductListUpdatePageState extends State<SellerProductListUpdatePage> {
  SellercrudViewModel sellercrudViewModel = SellercrudViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sellercrudViewModel.getSellerOwnProduct(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) {
          return ListView(
            children: <Widget>[createHeader(), createCartList()],
          );
        },
      ),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Update your product here",
        style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 16, color: Colors.black),
      ),
      margin: EdgeInsets.only(left: 12, top: 12),
    );
  }


  createCartList() {
    return

      ChangeNotifierProvider<SellercrudViewModel>(
        create: (context) => sellercrudViewModel,
        child: Consumer<SellercrudViewModel>(
        builder: (context, value, child) {
         switch (value.productlists.status){
           case Status.LOADING:
             return const Center(
               child: CircularProgressIndicator(),
             );
           case Status.ERROR:
             return Center(
               child: Text(value.productlists.message.toString()),
             );
           case Status.COMPLETED:
             return
           ListView.builder(
           shrinkWrap: true,
           primary: false,
           itemBuilder: (context, position) {
             return createCartListItem(value.productlists.data!.data![position].productName.toString(),
                 value.productlists.data!.data![position].productUnitQty.toString(),
                 value.productlists.data!.data![position].productPrice.toString(),
                 value.productlists.data!.data![position].productMrp.toString(),
                 value.productlists.data!.data![position].productDiscount.toString(),
                 value.productlists.data!.data![position].productId.toString()
             );
           },
           itemCount: value.productlists.data!.data!.length,
         );


           default:
         }
         return Container();
        }
        ),
      );

  }

  createCartListItem(String productname,String productunit,String productprice, String productmrp, String productdiscount,String productid) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: (){

            TextEditingController product_name = TextEditingController();
            TextEditingController product_price = TextEditingController();
            TextEditingController product_mrp = TextEditingController();
            TextEditingController product_discount = TextEditingController();
             product_name.text = productname;
             product_price.text = productprice;
             product_mrp.text = productmrp;
             product_discount.text = productdiscount;

            showDialog(context: context, builder: (context) =>
                ContainerDialog(title: 'Update Product',
                  subtitle: "Product ID #$productid",
                  container: Container(
                    height: 250,
                    width: 250,
                    child: Column(
                      children: [
                        TextFormField(

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                                border: CustomBorder.enabledBorder,
                                labelText: "Orange Variant",
                                focusedBorder: CustomBorder.focusBorder,
                                errorBorder: CustomBorder.errorBorder,
                                enabledBorder: CustomBorder.enabledBorder,
                                labelStyle: CustomTextStyle.textFormFieldRegular
                                    .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                            controller: product_name,
                            keyboardType: TextInputType.text),
                        Utils.getSizedBox(height: 10),
                        TextFormField(

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                                border: CustomBorder.enabledBorder,
                                labelText: "Orange Price",
                                focusedBorder: CustomBorder.focusBorder,
                                errorBorder: CustomBorder.errorBorder,
                                enabledBorder: CustomBorder.enabledBorder,
                                labelStyle: CustomTextStyle.textFormFieldRegular
                                    .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                            controller: product_price,
                            keyboardType: TextInputType.number),
                        Utils.getSizedBox(height: 10),
                        TextFormField(

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                                border: CustomBorder.enabledBorder,
                                labelText: "MRP",
                                focusedBorder: CustomBorder.focusBorder,
                                errorBorder: CustomBorder.errorBorder,
                                enabledBorder: CustomBorder.enabledBorder,
                                labelStyle: CustomTextStyle.textFormFieldRegular
                                    .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                            controller: product_mrp,
                            keyboardType: TextInputType.number),
                        Utils.getSizedBox(height: 10),
                        TextFormField(

                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                                border: CustomBorder.enabledBorder,
                                labelText: "Discount %",
                                focusedBorder: CustomBorder.focusBorder,
                                errorBorder: CustomBorder.errorBorder,
                                enabledBorder: CustomBorder.enabledBorder,
                                labelStyle: CustomTextStyle.textFormFieldRegular
                                    .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                            controller: product_discount,
                            keyboardType: TextInputType.number),
                        Utils.getSizedBox(height: 10),
                      ],
                    ),),
                  onCancel: (){
                  Navigator.of(context).pop();
                  },
                  onOk: (){

                  Map data = {
                    'product_name' : product_name.text,
                    'product_price' :product_price.text,
                    'product_mrp' :product_mrp.text,
                    'product_discount' : product_discount.text,
                  };

                  Provider.of<SellercrudViewModel>(context,listen:false).updateProduct(context, data,productid).then((value) {
                    Future.delayed(Duration(seconds: 1),(){sellercrudViewModel.getSellerOwnProduct(context);});
                    Navigator.of(context).pop();
                  });

                  },

                )

            );


          },
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      color: Colors.orangeAccent.shade100,
                      image: DecorationImage(image: AssetImage("assets/img/ic_launcher.png"),fit: BoxFit.contain)),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(

                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width*0.5,
                          child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "$productprice Rupees/Kg",
                              style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "($productdiscount %OFF)",
                              style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.red, fontSize: 12,fontWeight: FontWeight.bold),
                            ),
                            ]
                          )
                        ),
                        Utils.getSizedBox(height: 6),
                        Container(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "$productname",
                                    style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.green, fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\₹ $productmrp/Kg",
                                    style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.black54, fontSize: 13,fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough),
                                  ),
                                ]
                            )
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "",
                                style: CustomTextStyle.textFormFieldBlack.copyWith(color: Colors.green),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     crossAxisAlignment: CrossAxisAlignment.end,
                              //     children: <Widget>[
                              //       Icon(
                              //         Icons.remove,
                              //         size: 24,
                              //         color: Colors.grey.shade700,
                              //       ),
                              //       Container(
                              //         color: Colors.grey.shade200,
                              //         padding: const EdgeInsets.only(bottom: 2, right: 12, left: 12),
                              //         child: Text(
                              //           "1",
                              //           style: CustomTextStyle.textFormFieldSemiBold,
                              //         ),
                              //       ),
                              //       Icon(
                              //         Icons.add,
                              //         size: 24,
                              //         color: Colors.grey.shade700,
                              //       )
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 100,
                )
              ],
            ),
          ),
        ),

      ],
    );
  }

}
