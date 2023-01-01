import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class NetWorkPlay extends StatefulWidget {
  const NetWorkPlay({Key? key}) : super(key: key);

  @override
  _NetWorkPlayState createState() => _NetWorkPlayState();
}

class _NetWorkPlayState extends State<NetWorkPlay> {
  bool isPlaying=false;
  AudioPlayer? audioPlayer;
  AudioCache? audioCache;
  Duration currentPosition=Duration();
  Duration musicDuration=Duration();

  String  url = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';

  @override
  void initState() {
    //audioCache=AudioCache();
    audioPlayer=AudioPlayer();
    setUp();
    // TODO: implement initState
    super.initState();
  }
  void setUp() {
    audioPlayer!.onAudioPositionChanged.listen((d) {
      setState(() {
        currentPosition=d;
      });
    });
    audioPlayer!.onDurationChanged.listen((length) {
      setState(() {
        musicDuration=length;
      });
    });
  }
  @override
  void dispose() {
    audioPlayer!.pause();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(
        width: double.infinity,
        height:double.infinity,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.1, 0.5, 0.7, 0.9],
        colors: [
        Colors.blue,
        Colors.indigo,
        Colors.black87,
        Colors.red,
        ],
    ),
    ),
    child:Padding(
      padding: const EdgeInsets.all(20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
        Text("NetWork",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          Text("${currentPosition.inSeconds.toDouble()}",style:const TextStyle(fontSize: 18,color: Colors.white),),
          Expanded(child:Slider(activeColor:Colors.white,onChanged: (val){
            setState(() {
              currentPosition=Duration(seconds: val.toInt());
            });
            seekTo(val.toInt());
          },
            value: currentPosition.inSeconds.toDouble(),
            max: musicDuration.inSeconds.toDouble(),) ),
          Text("${musicDuration.inSeconds.toDouble()}",style:const TextStyle(fontSize: 18,color: Colors.white),),
        ],),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           // IconButton(onPressed: (){}, icon:const Icon(Icons.first_page,color: Colors.white,)),
            IconButton(onPressed: (){
              if(isPlaying){
                setState(() {
                  isPlaying=false;
                });
                stopPlaying();
              }else {
                setState(() {
                  isPlaying=true;
                });
                startPlaying();
              }
            }, icon: Icon(isPlaying?Icons.pause:Icons.play_arrow,color: Colors.white)),
           // IconButton(onPressed: (){}, icon:const Icon(Icons.last_page,color: Colors.white)),
          ],),
      ],),
    ),)
    );
  }

  void stopPlaying() {
    audioPlayer!.pause();
  }

  startPlaying()async{
    await audioPlayer!.play(url);
  }

  seekTo(int sec){
    audioPlayer!.seek(Duration(seconds: sec));
  }


/*  Future startPlaying ()async {
    // audioPlayer=AudioPlayer();
    // audioCache =AudioCache(prefix: "assets/");
    audioCache!.play("amr.mp3");
    final url=await audioCache!.load("amr.mp3");
    audioPlayer!.setUrl(url.path,isLocal: true);
    // audioPlayer!.setSourceAsset("a.mp3");
    // audioPlayer!.setSourceUrl(url.path);
    print("finish");

    //audioPlayer!.
  }*/
}
