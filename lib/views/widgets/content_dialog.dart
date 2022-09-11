import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final Container container;
  final VoidCallback onOk;
  final VoidCallback onCancel;

  const ContainerDialog({
    required this.title,
    required this.subtitle,
    required this.onOk,
    required this.onCancel,
    required this.container,
  });

  dialogContent(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          SizedBox(height: 16.0),
          // Image.asset('assets/images/splashscreen.png', height: 100),
          Text(
            title,
            style:Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black,fontFamily: "Gilroy"),
          ),
          SizedBox(height: 16.0),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black,fontFamily: "Gilroy",fontSize: 13),
          ),
          SizedBox(height: 24.0),
          container,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(

                onPressed: onOk,
                child:  Text('OK',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white)),
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              ElevatedButton(
                onPressed: onCancel,
                child: Text('Cancel',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white)),
              ),
            ],

          ),
          SizedBox(height: 16.0),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}