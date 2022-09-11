import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orange/data/response/status.dart';
import 'package:orange/model/list_profile_section.dart';
import 'package:orange/model/userModel.dart';
import 'package:orange/services/LifeCycleService.dart';
import 'package:orange/utils/CustomTextStyle.dart';
import 'package:orange/utils/routes/routeNames.dart';
import 'package:orange/viewmodels/profileViewModel.dart';
import 'package:orange/viewmodels/userViewModel.dart';
import 'package:provider/provider.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<ListProfileSection> listSection = <ListProfileSection>[];
  String _myname = "Dummy Text";
  String _img_link = "assets/img/ic_launcher.png";

  ProfileViewModel pdetails = ProfileViewModel();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserViewModel>(context,listen: false).getUserName().then((value) {
      _myname = value.toString();
    });
    pdetails.getProfileInfo(context);
    createListItem();
  }

  void createListItem() {
    listSection.add(createSection(
        "Logout", "assets/img/ic_logout.png", Colors.red.withOpacity(0.7),
        SizedBox()));
  }

  createSection(String title, String icon, Color color, Widget widget) {
    return ListProfileSection(title, icon, color, widget);
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
                height: 240,
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
              Container(
                child: Text(
                  "Profile",
                  style: CustomTextStyle.textFormFieldBold
                      .copyWith(color: Colors.white, fontSize: 24),
                ),
                margin: EdgeInsets.only(top: 72, left: 24),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                    flex: 20,
                  ),
                  Expanded(
                    child: ChangeNotifierProvider<ProfileViewModel>(
                      create: (context) => pdetails,
                      child: Consumer<ProfileViewModel>(
                        builder: (context, value, child) {
                          switch (value.profileModelResp.status) {
                            case Status.LOADING:
                              return Center(child: CircularProgressIndicator());
                            case Status.COMPLETED:
                              return Container(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      child: Card(
                                        margin:
                                        EdgeInsets.only(top: 50, left: 16, right: 16),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(16))),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 8, top: 8, right: 8, bottom: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: <Widget>[

                                                  IconButton(
                                                    icon: Icon(Icons.edit),
                                                    color: Colors.black,
                                                    iconSize: 24,
                                                    onPressed: () {
                                                      Navigator.of(context).pushNamed(RouteNames.edit_profile);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              _myname.toString(),
                                              style: CustomTextStyle.textFormFieldBlack
                                                  .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 30.0,right: 30,top: 10),
                                              child: Text(
                                                value.profileModelResp.data!.desc.toString(),
                                                style: CustomTextStyle.textFormFieldMedium
                                                    .copyWith(

                                                    color: Colors.grey.shade700,
                                                    fontSize: 13,


                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Container(
                                              height: 2,
                                              width: double.infinity,
                                              color: Colors.grey.shade200,
                                            ),
                                            buildListView()
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade400, width: 2),
                                            shape: BoxShape.circle,

                                            image:
                                            value.profileModelResp.data!.images.toString()==""?
                                            DecorationImage(
                                                image: AssetImage(_img_link),
                                                fit: BoxFit.cover):
                                            DecorationImage(
                                                image: NetworkImage(value.profileModelResp.data!.images.toString()),
                                                fit: BoxFit.cover)),
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                          }
                          return Container();
                        },
                      ),
                    ),
                    flex: 75,
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

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return createListViewItem(listSection[index]);
      },
      itemCount: listSection.length,
    );
  }
  createListViewItem(ListProfileSection listSection) {
    return Builder(builder: (context) {
      return InkWell(
        splashColor: Colors.teal.shade200,
        onTap: () {
          if (listSection.widget != null) {

            Provider.of<UserViewModel>(context,listen:false).removeToken();
            Navigator.pop(context);
            Navigator.pushNamed(context,RouteNames.login);
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 12),
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage(listSection.icon),
                width: 20,
                height: 20,
                color: Colors.grey.shade500,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                listSection.title,
                style: CustomTextStyle.textFormFieldBold
                    .copyWith(color: Colors.grey.shade500),
              ),
              Spacer(
                flex: 1,
              ),
              Icon(
                Icons.navigate_next,
                color: Colors.grey.shade500,
              )
            ],
          ),
        ),
      );
    });
  }


}