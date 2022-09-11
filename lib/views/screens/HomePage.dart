import 'package:flutter/material.dart';
import 'package:orange/data/response/status.dart';
import 'package:orange/utils/CustomTextStyle.dart';
import 'package:orange/utils/CustomUtils.dart';
import 'package:orange/utils/routes/routeNames.dart';
import 'package:orange/viewmodels/buyercrudViewModel.dart';
import 'package:orange/views/screens/SignupScreen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BuyercrudViewModel buyercrudViewModel = BuyercrudViewModel();

  @override
  void initState() {
    super.initState();
    buyercrudViewModel.getBuyerSellers(context);
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
                      "Welcome Buyer",
                      style: CustomTextStyle.textFormFieldBlack.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: "Gilroy"),
                    ),
                    margin: EdgeInsets.only(top: 72, left: 24),
                  ),
                  Container(
                    child: Text(
                      "Check the Rate Charts Given below\n"
                      "by our top sellers",
                      style: CustomTextStyle.textFormFieldBold.copyWith(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: "Gilroy",
                          fontStyle: FontStyle.italic),
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
                              height: MediaQuery.of(context).size.height * 0.25,
                            ),
                            ChangeNotifierProvider<BuyercrudViewModel>(
                              create: (context) => buyercrudViewModel,
                              child: Consumer<BuyercrudViewModel>(
                                  builder: (context, value, child) {
                                switch (value.sellerlists.status) {
                                  case Status.LOADING:
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  case Status.ERROR:
                                    return Center(
                                      child: Text(
                                          value.sellerlists.message.toString()),
                                    );

                                  case Status.COMPLETED:
                                    return Expanded(
                                        child: GridView.count(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 8.0,
                                            children: List.generate(
                                                value.sellerlists.data!.data!
                                                    .length, (index) {
                                              return _sellerList(
                                                  value.sellerlists.data!
                                                      .data![index].image
                                                      .toString(),
                                                  value.sellerlists.data!
                                                      .data![index].name
                                                      .toString(),
                                                  value.sellerlists.data!
                                                      .data![index].id
                                                      .toString(),
                                                  value.sellerlists.data!
                                                      .data![index].desc
                                                      .toString());
                                            })));
                                }

                                return Container();
                              }),
                            ),
                          ],
                        )),
                    flex: 95,
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
    ;
  }

  Widget _sellerList(String image, String seller_name, String id, String desc) {
    image = image==""?"https://firebasestorage.googleapis.com/v0/b/orange-c52a0.appspot.com/o/images%2Fno_image.png?alt=media&token=b99593b2-6ba2-4f12-8c60-fe2f72a3aba9":image;
    desc = desc ==""?"Details will be provided soon by seller master":desc;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.sellers_products_from_buyer,
            arguments: {
              "seller_img": image,
              "seller_name": seller_name,
              "seller_id": id,
              "seller_desc": desc
            });
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
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      image,
                      height: 100,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      seller_name,
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
