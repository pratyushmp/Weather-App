import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var short_describe;
  var feels;
  var humidity;
  var windspeed;
  var air;

  var assets = 'assets/sunny.gif';
  var color;
  Future getWeather () async {
    http.Response response = await http.get("http://api.openweathermap.org/data/2.5/weather?q=Bengaluru&units=metric&appid=[enter your API id]");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.short_describe = results['weather'][0]['main'];
      this.feels = results['main']['feels_like'];
      this.humidity = results['main']['humidity'];
      this.windspeed = results['wind']['speed'];
      this.air = results['main']['pressure'];

      if(this.short_describe == 'Rain' || short_describe == 'Drizzle' || short_describe == 'Thunderstorm')
        {
          assets = 'assets/rainy.gif';
          color = Color(0xff6b51e8);
        }
      else if(this.short_describe == 'Cloudy' || short_describe == 'Partly Cloudy')
        {
          assets = 'assets/partlycloudy.gif';
          color = Color(0xffe8b951);
        }
      else if(this.short_describe == 'Sunny' || short_describe == 'Hot' || short_describe == 'Clear')
      {
        assets = 'assets/sunny.gif';
        color = Color(0xff218cb6);
      }
      else if(short_describe == 'Mist' || short_describe == 'Haze')
      {
        assets = 'assets/mist.jpg';
        color = Colors.grey;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber[600],
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(assets), fit: BoxFit.cover
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100,0, 0, 270),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.white, size: 30,),
                  SizedBox(width:10),
                  Text("Bengaluru",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: color,
              ),
              height: 300,
              width: 380,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(temp != null ? temp.toString()+"\u00B0\u1d9c" : "Loading",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                          color: Colors.white,
                        ),),
                        Text(short_describe != null ? short_describe.toString() : "Loading", textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text("Weather Details", textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Text(feels != null ? feels.toString()+"\u00B0\u1d9c" : "Loading", textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),),
                      ),
                      VerticalDivider(color: Colors.white,width: 10, thickness: 10,),
                      Padding(
                        padding: const EdgeInsets.only(right: 45.0),
                        child: Text(humidity != null ? humidity.toString()+"%" : "Loading", textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),),
                      ),
                    ],
                  ),
                  // SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("Temperature Felt", textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),),
                      ),
                      VerticalDivider(color: Colors.white,width: 10, thickness: 10,),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Text("Humidity",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Row(
                          children: [
                            Text(air != null ? air.toString() : "Loading", textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                                color: Colors.white,
                              ),),
                            Text("hPa", textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                                color: Colors.white,
                              ),),
                          ],
                        ),
                      ),
                      VerticalDivider(color: Colors.white,width: 10, thickness: 10,),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Row(
                          children: [
                            Text(windspeed != null ? windspeed.toString() : "Loading",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                                color: Colors.white,
                              ),),
                            Text("kmph",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                                color: Colors.white,
                              ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Text("Air Pressure", textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),),
                      ),
                      VerticalDivider(color: Colors.white,width: 10, thickness: 10,),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text("Windspeed",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
