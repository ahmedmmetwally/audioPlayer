import 'package:flutter/material.dart';
import 'package:imp_audioplayer_sanaa/file_play.dart';
import 'package:imp_audioplayer_sanaa/network_play.dart';
import 'package:imp_audioplayer_sanaa/play_music.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MusicApp(),
    );
  }
}
class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  List<Widget> myWidget=[PlayMusic(), NetWorkPlay(), FilePlay()];
  int pageIndex= 0;
  selectPage(int val)
  {
    setState(() {
      pageIndex=val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myWidget[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: selectPage,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Assets'),
          BottomNavigationBarItem(icon:Icon( Icons.vpn_lock),label: 'Network'),
          BottomNavigationBarItem(icon: Icon(Icons.folder),label: 'File')
        ],
      ),
    );
  }
}

