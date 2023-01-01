/*
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
class PlayMusic extends StatefulWidget {
  const PlayMusic({Key? key}) : super(key: key);

  @override
  _PlayMusicState createState() => _PlayMusicState();
}


class _PlayMusicState extends State<PlayMusic> {
  late AudioPlayer player;
  late AudioCache cache;
  bool isPlaying =false;
  Duration currentPostion = Duration();
  Duration musicLength = Duration();
  int index =0;
  List<String> mylist= ['a.mp3','b.mp3','c.mp3', 'd.mp3', 'e.mp3'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player = AudioPlayer();
    cache = AudioCache(fixedPlayer: player);
    index =0;
    // cache.loadAll(['1.mp3','2.mp3','3.mp3', '4.mp3', '5.mp3']);
    setUp();
  }
  setUp(){
    player.onAudioPositionChanged.listen((d) {
      // Give us the current position of the Audio file
      setState(() {
        currentPostion = d;
      });

      player.onDurationChanged.listen((d) {
        //Returns the duration of the audio file
        setState(() {
          musicLength= d;
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: Text('Play Music', style: TextStyle(fontSize: 35, color: Colors.white),),
            alignment: Alignment.center,
            color: Colors.indigo,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('${currentPostion.inSeconds}'),
              Container(
                  width: 300,
                  child: Slider(
                      value: currentPostion.inSeconds.toDouble(),
                      max: musicLength.inSeconds.toDouble(),
                      onChanged: (val){
                        seekTo(val.toInt());
                      })
              ),
              Text('${musicLength.inSeconds}'),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.first_page), iconSize: 35,
                onPressed: (){
                  if(index>0) {
                    setState(() {
                      index--;
                      isPlaying= true;
                      print('$index');
                    });
                    cache.play(mylist[index]);
                  }
                  else{
                    setState(() {
                      isPlaying= true;

                    });
                    print('$index');
                    cache.play(mylist[index]);
                  }
                }, ),
              IconButton(onPressed: (){
                if(isPlaying)
                {
                  setState(() {
                    isPlaying = false;
                  });
                  stopMusic();
                }
                else {
                  setState(() {
                    isPlaying = true;
                  });
                  playMusic(mylist[index]);
                }
              },
                icon: isPlaying?Icon(Icons.pause):
                Icon(Icons.play_arrow), iconSize: 35,),

              IconButton(
                icon: Icon(Icons.last_page), iconSize: 35,
                onPressed: (){
                  if(index < mylist.length-1 )
                  {  print('$index');
                  setState(() {
                    index=index+1;
                    isPlaying=true;
                  });
                  print('$index');
                  cache.play(mylist[index]);
                  }
                  else {
                    setState(() {
                      index=0;
                      isPlaying=true;
                    });
                    print("$index");
                    cache.play(mylist[index]);
                  }
                },
              )
            ],
          ),
          Text('${mylist[index]}')
        ],
      ),
    );
  }

  playMusic(String song)
  { // to play the Audio
    cache.play(song);
  }
  stopMusic()
  {// to pause the Audio
    player.pause();
  }
  seekTo(int sec)
  {// To seek the audio to a new position
    player.seek(Duration(seconds: sec));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }
}
*/

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayMusic extends StatefulWidget {
  const PlayMusic({Key? key}) : super(key: key);

  @override
  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  bool isPlaying=false;
  AudioPlayer? audioPlayer;
  AudioCache? audioCache;
  Duration currentPosition=Duration();
  Duration musicDuration=Duration();
  List<String> musicList=["amr.mp3",'a.mp3','b.mp3','c.mp3', 'd.mp3', 'e.mp3'];
  int index=0;

  @override
  void initState() {
    //audioCache=AudioCache();
    audioPlayer=AudioPlayer();
    audioCache=AudioCache(fixedPlayer: audioPlayer);
    audioCache!.load("amr.mp3");
    setUp();
    // TODO: implement initState
    super.initState();
  }
  void setUp() {
   /* audioPlayer!.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying=state==PlayerState.PLAYING;
      });
    });*/
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
      body: Column(children: [
        Container(height: 400,width: double.infinity,color: Colors.deepPurple,
          child: Center(child: Text("hello audio",style:const TextStyle(fontSize: 18),)),),

         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10),
           child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
              Text("${currentPosition.inSeconds.toDouble()}",style:const TextStyle(fontSize: 18),),
              Expanded(child:Slider(onChanged: (val){
                setState(() {
                  currentPosition=Duration(seconds: val.toInt());
                });
                seekTo(val.toInt());
              },
                value: currentPosition.inSeconds.toDouble(),
                max: musicDuration.inSeconds.toDouble(),) ),
              Text("${musicDuration.inSeconds.toDouble()}",style:const TextStyle(fontSize: 18),),
            ],),
         ),
           Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){
                if(index>0
                    //&& isPlaying==true
                ){
                  setState(() {
                    index--;
                    isPlaying=true;
                  });
                 // if(isPlaying){startPlaying("${musicList[index]}");}
                  startPlaying("${musicList[index]}");

                }
                // else if( index>0&&isPlaying==false){
                //   setState(() {
                //     index--;
                //     // isPlaying=false;
                //   });
                //   // if(isPlaying){startPlaying("${musicList[index]}");}
                //   stopPlaying();
                //
                // }
                else {
                  setState(() {
                    index=musicList.length-1;
                    isPlaying=true;
                  });
                  startPlaying("${musicList[index]}");
                }

              }, icon:const Icon(Icons.first_page)),
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
                  startPlaying("${musicList[index]}");
                }
              }, icon: Icon(isPlaying?Icons.pause:Icons.play_arrow)),
              IconButton(onPressed: (){
                if(index<musicList.length-1){
                  setState(() {
                    index++;
                    isPlaying=true;

                  });
                  startPlaying("${musicList[index]}");
                }

                else{
                  setState(() {
                    index=0;
                    isPlaying=true;
                  });
                  startPlaying("${musicList[index]}");
                }

              }, icon:const Icon(Icons.last_page)),
            ],),
        Text("${musicList[index]}",style: TextStyle(fontSize: 18),)

      ],),
    );
  }

  void stopPlaying() {
    audioPlayer!.pause();
  }

  startPlaying(String sound){
    audioCache!.play(sound);
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
