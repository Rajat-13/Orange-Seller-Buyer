import 'package:flutter/material.dart';
import 'package:orange/model/list_profile_section.dart';
import 'package:orange/utils/CustomTextStyle.dart';
import 'package:orange/utils/routes/routeNames.dart';
import 'package:orange/viewmodels/userViewModel.dart';
import 'package:provider/provider.dart';

class SellerHomePage extends StatefulWidget {
  @override
  _SellerHomePageState createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: true,
      body: Builder(builder: (context) {
        return Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 340,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Colors.orange, shape: BoxShape.circle),
                      ),
                      top: -40,
                      left: -40,
                    ),
                    Positioned(
                      child: Container(
                        width: 300,
                        height: 260,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent.withOpacity(0.5),
                            shape: BoxShape.circle),
                      ),
                      top: -40,
                      left: -40,
                    ),
                    Positioned(
                      child: Align(
                        child: Container(
                          width: 400,
                          height: 260,
                          decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent.withOpacity(0.5),
                              shape: BoxShape.circle),
                        ),
                      ),
                      top: -40,
                      left: -40,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Welcome Seller",
                      style: CustomTextStyle.textFormFieldBlack.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: "Gilroy"),
                    ),
                    margin: EdgeInsets.only(top: 72, left: 24),
                  ),
                  Container(
                    child: Text(
                      "Choose the options provided below",
                      style: CustomTextStyle.textFormFieldBold.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: "Gilroy"),
                    ),
                    margin: EdgeInsets.only(top: 5, left: 24),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteNames.create_product);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      height: 160,
                                      width: 160,
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/img/ic_createp.png',
                                                color: Colors.orange,
                                                height: 90,
                                                fit: BoxFit.cover,
                                              ),
                                              Text(
                                                "Create Product",
                                                style: TextStyle(
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteNames.seller_productlist);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      height: 160,
                                      width: 160,
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/img/ic_listp.png',
                                                color: Colors.deepOrangeAccent,
                                                height: 90,
                                                fit: BoxFit.cover,
                                              ),
                                              Text(
                                                "Read Product",
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteNames.seller_productlist_update);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      height: 160,
                                      width: 160,
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/img/ic_updatep.png',
                                                color: Colors.deepOrangeAccent,
                                                height: 90,
                                                fit: BoxFit.cover,
                                              ),
                                              Text(
                                                "Update Product",
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RouteNames.seller_productlist_delete);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      height: 160,
                                      width: 160,
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/img/ic_deletep.png',
                                                color: Colors.orange,
                                                height: 90,
                                                fit: BoxFit.cover,
                                              ),
                                              Text(
                                                "Delete Product",
                                                style: TextStyle(
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    flex: 95,
                  ),
                  Expanded(
                    child: Container(),
                    flex: 05,
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
