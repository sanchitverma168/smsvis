import 'package:Smsvis/providers/importContact.dart';
import 'package:Smsvis/widgets/importContactV2/bottomTools.dart';
import 'package:Smsvis/widgets/importContact/cantreadcontacts.dart';
import 'package:Smsvis/widgets/importContact/deviceContacts.dart';
import 'package:Smsvis/widgets/importContact/nocontactfound.dart';
import 'package:Smsvis/widgets/importContact/searchContacts.dart';
import 'package:Smsvis/widgets/importContact/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReturnContactQuickSendWidget extends StatelessWidget {
  ReturnContactQuickSendWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ImportContact>(
      builder: (context, user, child) {
        switch (user.screenContent) {
          case ScreenContent.isDeviceContacts:
            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SearchBar(),
                    Expanded(
                      child: DeviceContacts(),
                    ),
                  ],
                ),
                Positioned(
                  bottom: -5,
                  left: -5,
                  right: -5,
                  child: BottomTools(),
                ),
              ],
            );
          case ScreenContent.isSearchContacts:
            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SearchBar(),
                    Expanded(
                      child: SearchContacts(),
                    )
                  ],
                ),
                Positioned(
                  bottom: -5,
                  left: -5,
                  right: -5,
                  child: BottomTools(),
                ),
              ],
            );
          case ScreenContent.isNoContactFound:
            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SearchBar(),
                    Expanded(
                      child: NoContactFound(),
                    ),
                  ],
                ),
                Positioned(
                  bottom: -5,
                  left: -5,
                  right: -5,
                  child: BottomTools(),
                ),
              ],
            );
          case ScreenContent.isError:
            return CantReadContacts();
          case ScreenContent.isloading:
            return Loading();
          default:
            return Loading();
        }
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var importContacts = Provider.of<ImportContact>(context, listen: false);
    importContacts.init();
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
