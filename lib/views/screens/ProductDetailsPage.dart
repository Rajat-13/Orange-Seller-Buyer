import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:orange/data/response/status.dart';
import 'package:orange/utils/CustomTextStyle.dart';
import 'package:orange/utils/CustomUtils.dart';
import 'package:orange/viewmodels/buyercrudViewModel.dart';
import 'package:orange/viewmodels/sellercrudViewModel.dart';
import 'package:provider/provider.dart';


class ProductDetailsPage extends StatefulWidget {
  Map heroTag;

  ProductDetailsPage(this.heroTag);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState(heroTag);
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with TickerProviderStateMixin<ProductDetailsPage> {

  var heroTag;
  BuyercrudViewModel buyercrudViewModel = BuyercrudViewModel();
  _ProductDetailsPageState(this.heroTag);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buyercrudViewModel.getSellerOwnProduct(context,heroTag["seller_id"]);

  }



  @override
  Widget build(BuildContext context) {
    var halfOfScreen = MediaQuery.of(context).size.height / 2.8;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Builder(builder: (context) {
        return Container(
          height: double.infinity,
          child: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Hero(
                  tag: heroTag,
                  child: Image(
                    image: NetworkImage(heroTag["seller_img"]),
                    height: halfOfScreen,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      height: 28,
                      width: 32,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        iconSize: 14,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),

                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: productDetailsSection(),
              )
            ],
          ),
        );
      }),
    );
  }

  productDetailsSection() {
    return Container(
      padding: EdgeInsets.all(8),
      height: 520,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(
                  heroTag["seller_name"],
                  style: CustomTextStyle.textFormFieldSemiBold.copyWith(color: Colors.black),
                ),
              ),
              IconButton(icon: Icon(Icons.search), onPressed: () {
                Flushbar(
                  message: "Will be provided in next update!",
                  icon: Icon(
                    Icons.info_outline,
                    size: 28.0,
                    color: Colors.blue,
                  ),
                  duration: Duration(seconds: 3),
                  leftBarIndicatorColor: Colors.blue,
                )
                  ..show(context);
              })
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            alignment: Alignment.topLeft,
            child: Text(
              heroTag["seller_desc"],
              textAlign: TextAlign.start,
              style: CustomTextStyle.textFormFieldBold.copyWith(color: Colors.black.withOpacity(0.8), fontSize: 12),
            ),
          ),

          Utils.getSizedBox(height: 16),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 8),
            child: Text(
              "Rate Chart",
              style: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.black.withOpacity(0.8), fontSize: 15),
            ),
          ),


          createDetailList(),
          
          
        ],
      ),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    );
  }

  createDetailList() {
    return

      ChangeNotifierProvider<BuyercrudViewModel>(
        create: (context) => buyercrudViewModel,
        child: Consumer<BuyercrudViewModel>(
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
                    Scrollbar(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, position) {
                          return createCartListItem(value.productlists.data!.data![position].productName.toString(),
                              value.productlists.data!.data![position].productUnitQty.toString(),
                              value.productlists.data!.data![position].productPrice.toString(),
                              value.productlists.data!.data![position].productMrp.toString(),
                              value.productlists.data!.data![position].productDiscount.toString()
                          );
                        },
                        itemCount: value.productlists.data!.data!.length,
                      ),
                    );


                default:
              }
              return Container();
            }
        ),
      );

  }
  createCartListItem(String productname,String productunit,String productprice, String productmrp, String productdiscount) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 8, right: 8, top: 5),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16)),border: Border.all(color: Colors.orange)),
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
                          width: MediaQuery.of(context).size.width*0.6,
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

                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),

      ],
    );
  }




}
