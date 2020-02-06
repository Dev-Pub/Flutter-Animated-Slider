import 'package:example/devpub_slider_animated.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  final String title;

  HomeView({
    this.title
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String textCallback = "NO";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // EXAMPLE 1
            Text('EXAMPLE 1 - Sample', textAlign: TextAlign.center,),
            AnimatedSlider(
              buttonSize: 50,
              barHeight: 40,
              barText: Center(child: Text('Swipe to signing', style: TextStyle(color: Colors.black45),),),
              progressText: Center(child: Text('Signing...', style: TextStyle(color: Colors.white)),),
              buttonIcon: Icon(
                Icons.create,
                color: Colors.white,
                size: 25,
              ),
            ),
            SizedBox(height: 40,),

            // EXAMPLE 2
            Text('EXAMPLE 2 - Borders', textAlign: TextAlign.center,),
            AnimatedSlider(
              buttonSize: 50,
              barHeight: 40,
              barText: Center(child: Text('Swipe'),),
              progressText: Center(child: Text('Loading...'),),
              progressColor: Colors.redAccent,
              barBorderRadius: 10,
              buttonBorderRadius: 10,
              buttonIcon: Icon(
                Icons.credit_card,
                color: Colors.white,
                size: 25,
              ),
            ),
            SizedBox(height: 40,),

            // EXAMPLE 3
            Text('EXAMPLE 3 - height', textAlign: TextAlign.center,),
            AnimatedSlider(
              buttonSize: 30,
              barColor: Colors.amber,
              barHeight: 30,
              barText: Center(child: Text('Swipe...'),),
              progressText: Center(child: Text('Opening...'),),
              progressColor: Colors.greenAccent,
              buttonIcon: Icon(
                Icons.photo_camera,
                color: Colors.white,
                size: 15,
              ),
            ),
            SizedBox(height: 40,),

            
            // EXAMPLE 3
            Text('EXAMPLE 4 - Callback', textAlign: TextAlign.center,),
            AnimatedSlider(
              buttonSize: 40,
              buttonColor: Colors.greenAccent,
              barColor: Colors.redAccent,
              barHeight: 30,
              barText: Center(child: Text('NO', style: TextStyle(color: Colors.white),),),
              progressText: Center(child: Text('YES'),),
              progressColor: Colors.greenAccent,
              buttonIcon: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 15,
              ),
              onSuccess: () {
                setState((){
                  textCallback = "YES";
                });
              },
              onFailed: (){
                setState(() {
                  textCallback = "NO";
                });
              },
            ),
            Text('Callback: $textCallback', style: TextStyle(color: Colors.amber, fontSize: 20),),
            SizedBox(height: 40,),

            
            // EXAMPLE 3
            Text('EXAMPLE 5 - Range', textAlign: TextAlign.center,),
            Container(
              width: 200,
              child: AnimatedSlider(
                range: 0.5,
                buttonSize: 40,
                buttonColor: Colors.deepOrange,
                barColor: Colors.deepOrangeAccent.withOpacity(0.6),
                barHeight: 20,
                progressColor: Colors.indigo,
                buttonIcon: Icon(
                  Icons.room,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}