import 'package:flutter/material.dart';
import 'package:netflix/API/customer-api.dart';
import 'package:netflix/API/general-api.dart';
import 'package:netflix/models/pref-model.dart';
import 'package:provider/provider.dart';

class ProviderModel {
  bool firstTime;
  CustomerAPI customerAPI;
  PrefModel prefModel;
  GeneralAPI generalAPI;
  ProviderModel({this.firstTime = true});
  initialise(BuildContext context) {
    customerAPI = Provider.of<CustomerAPI>(context);
    prefModel = Provider.of<PrefModel>(context);
    generalAPI = Provider.of<GeneralAPI>(context);
  }
}
