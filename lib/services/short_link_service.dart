import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shortly/models/short_link/short_link.dart';
import 'package:shortly/services/database_sqflite.dart';
import 'package:shortly/shared/constants.dart';
import 'package:http/http.dart' as http;

class ShortLinkService with ChangeNotifier{

  bool isLoadingLink = true;
  List<ShortLink> shortLinks = [];
  final databaseSqfLite = DatabaseSqfLite.instance;

  bool isLoadingGetShortLink = false;
  String errorGetGetShortLink = '';

  /// For Fetch All Short Links
  fetchShortLinks() async {
    isLoadingLink = true;

    List<Map<String, dynamic>> data = await databaseSqfLite.queryAllRows();
    data.forEach((element) {
      shortLinks.add(ShortLink.fromJson(element));
    });

    isLoadingLink = false;
    notifyListeners();
  }

  /// For Add Short Link
  addShortLink({required ShortLink shortLink}) async {
    try {
      int idFromSQF = await databaseSqfLite.insert(shortLink);
      shortLink.id = idFromSQF;
      shortLinks.add(shortLink);
      notifyListeners();
    } catch (e) {}
  }

  /// For Delete Short Link
  deleteShortLink({required ShortLink link}) async {
    try {
      int deleteStatus  = await databaseSqfLite.delete(link.id!);
      if(deleteStatus == 1) {
        shortLinks
          .removeWhere((element) => element.id == link.id);
      }

      notifyListeners();
    } catch (e) {}
  }

  /// For Get Short Link From Shrtcode Api
  Future<void> getShortLink({required String link,}) async {
    isLoadingGetShortLink = true;
    errorGetGetShortLink = '';
    notifyListeners();

    Uri url = Uri.parse('$BASEURL$shorten?url=$link');
    await http.get(url,).then((response) async{
      Map<String, dynamic> results =
      jsonDecode(response.body) as Map<String, dynamic>;
      if(results['ok']){
        ShortLink shortLink = ShortLink.fromJson(results['result'] as Map<String, dynamic>);
        await addShortLink(shortLink: shortLink);

        isLoadingGetShortLink = false;
        errorGetGetShortLink = '';
        notifyListeners();
      }else{
        isLoadingGetShortLink = false;
        errorGetGetShortLink = results['error_code'] == 2 ? 'This is not a valid URL.' : 'No url set.';
        notifyListeners();
        throw '';
      }

    }).catchError((onError) {
      isLoadingGetShortLink = false;
      if(errorGetGetShortLink.isEmpty) {
        errorGetGetShortLink = 'Something went wrong.';
      }
      notifyListeners();
      throw '';
    });
  }

  /// For Reset Error
  void reSetError(){
    errorGetGetShortLink ='';
    notifyListeners();
  }
}