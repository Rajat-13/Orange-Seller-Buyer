import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orange/data/response/status.dart';
import 'package:orange/model/productModel.dart';
import 'package:orange/repository/authRepository.dart';
import 'package:orange/utils/CustomTextStyle.dart';
import 'package:orange/utils/CustomUtils.dart';
import 'package:orange/viewmodels/sellercrudViewModel.dart';
import 'package:provider/provider.dart';



class SellerProductListDeletePage extends StatefulWidget {
  @override
  _SellerProductListDeletePageState createState() => _SellerProductListDeletePageState();
}

class _SellerProductListDeletePageState extends State<SellerProductListDeletePage> {
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

  // footer(BuildContext context) {
  //   return Container(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: <Widget>[
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             Container(
  //               margin: EdgeInsets.only(left: 30),
  //               child: Text(
  //                 "Total",
  //                 style: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.grey, fontSize: 12),
  //               ),
  //             ),
  //             Container(
  //               margin: EdgeInsets.only(right: 30),
  //               child: Text(
  //                 "\₹299.00",
  //                 style: CustomTextStyle.textFormFieldBlack.copyWith(color: Colors.greenAccent.shade700, fontSize: 14),
  //               ),
  //             ),
  //           ],
  //         ),
  //         Utils.getSizedBox(height: 8),
  //         ElevatedButton(
  //           onPressed: () {
  //             Navigator.push(context, new MaterialPageRoute(builder: (context) => CheckOutPage()));
  //           },
  //           // color: Colors.green,
  //           // padding: EdgeInsets.only(top: 12, left: 60, right: 60, bottom: 12),
  //           // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
  //           child: Text(
  //             "Checkout",
  //             style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.white),
  //           ),
  //         ),
  //         Utils.getSizedBox(height: 8),
  //       ],
  //     ),
  //     margin: EdgeInsets.only(top: 16),
  //   );
  // }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Delete Product from List",
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
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 60,
                height: 60,
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
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 10, top: 8),
            child: InkWell(
              onTap: (){
                Provider.of<SellercrudViewModel>(context,listen: false).deleteProduct(context,productid);

                Future.delayed(Duration(seconds: 1),(){sellercrudViewModel.getSellerOwnProduct(context);});

              },
              child: Icon(
                Icons.delete_forever_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Colors.red),
          ),
        )
      ],
    );
  }

}
