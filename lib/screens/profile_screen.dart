import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/constants.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  late double _screenHeight;
  late double _screenWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          TextButton(onPressed: (){}, child: Text('Edit'))
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints)
      {
        _screenHeight = constraints.maxHeight;
        _screenWidth = constraints.maxWidth;

        return _portrait();// _screenWidth>maxScreenSizeInPortraitMode?_landscape():_portrait();
      }),
    );
  }
  
  Widget _landscape(){
    return Container();
  }
  
  Widget _portrait() 
  {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
        Container(
          width: _screenWidth,
          height: 100,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [Colors.lightBlue,const Color.fromARGB(255, 0, 4, 244)])
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Muhammad Abdul Rehman',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('abdulrehamn1411@gmail.com',textAlign: TextAlign.center, style: TextStyle(color: Colors.white,),),
            ],
          ),
        ),
        Container(
          
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                          height: 100,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [Colors.lightGreen,const Color.fromARGB(255, 194, 228, 0)])
                          ),
                          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Age',textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                Text('28',textAlign: TextAlign.center, style: TextStyle(color: Colors.white,),),
              ],
            ),),
              ),
            Expanded(
              flex: 2,
              child: Container(
                
              height: 100,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [Colors.red,const Color.fromARGB(255, 245, 153, 153)])
              ),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('DOB',textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                Text('18th March 1998',textAlign: TextAlign.center, style: TextStyle(color: Colors.white,),),
              ],
            ),),
            ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                        height: 100,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: [Colors.deepPurple,Colors.purpleAccent])
                        ),
                        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Weight',textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
              Text('90 kg',textAlign: TextAlign.center, style: TextStyle(color: Colors.white,),),
            ],
          ),),
            ),
          Expanded(
            flex: 1,
            child: Container(
              
            height: 100,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: [Colors.teal,Colors.tealAccent])
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Height',textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
              Text('5 ft 5 inch',textAlign: TextAlign.center, style: TextStyle(color: Colors.white,),),
            ],
          ),),
          ),
          ],
        ),
        Container(
          width: _screenWidth,
          height: 100,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [Colors.brown,Colors.brown.withValues(alpha: 0.3)])
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Gender',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              Text('Male',textAlign: TextAlign.center, style: TextStyle(color: Colors.white,),),
            ],
          ),
        ),  
        ],
      ),
    );
  }
}