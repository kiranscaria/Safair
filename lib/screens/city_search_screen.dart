import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class CitySearchScreen extends StatefulWidget {
  @override
  _CitySearchScreenState createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFBC4E9C), Color(0xFFF80759)],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Safair',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20 *
                              (MediaQuery.of(context).size.height /
                                  MediaQuery.of(context).size.width),
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 9),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 26.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          cityName = value;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter City Name...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(
                        LineAwesomeIcons.search,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.pop(context, cityName);
                      },
                    ),
                  ),
                ],
              ),
              Spacer()
//              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
