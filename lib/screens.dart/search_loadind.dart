import 'dart:convert';

import 'package:boekiez/screens.dart/search_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

//For loading the search

class searchloading extends StatefulWidget {
  var text;
  searchloading({@required this.text});

  @override
  State<searchloading> createState() => _searchloadingState();
}

class _searchloadingState extends State<searchloading> {
  var cp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  /*Use async to make our UI not lagging/hanging, but in the same time we
  * also need to wait for some response like API to take the data from it,
  * thats why we use the "AWAIT" keyword
  * */

  void getdata() async {
    //it will wait for the data book from API
    Response r = await get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=intitle:${widget.text}&maxResult=40&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"),
    );

    cp = jsonDecode(r.body);
    print(cp);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //WHEN THE DATA BOOK IS GET, THEN IT WILL PUSH US TO SEARCH FILTER CLASS
      return searchfilter(d: cp);
    }));
    return;
  }

  @override
  Widget build(BuildContext context) {
    return (const Scaffold(
      body: Center(
        // ignore: prefer_const_constructors
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    ));
  }
}
