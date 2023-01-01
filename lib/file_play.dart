/*

import 'dart:html';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePlay extends StatefulWidget {
  const FilePlay({Key? key}) : super(key: key);

  @override
  _FilePlayState createState() => _FilePlayState();
}

class _FilePlayState extends State<FilePlay> {
  String  url = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
  bool isPlaying=false;
  AudioPlayer? audioPlayer;
  AudioCache? audioCache;
  Duration currentPosition=Duration();
  Duration musicDuration=Duration();
  var soundFile;

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
        Container(
          width: double.infinity,
          height:400,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              //stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Colors.blue,
                Colors.indigo,
                Colors.black87,
                Colors.red,
              ],
            ),
          ),
          child: InkWell (onTap: ()async{
            final result=await pickFile();
            if(result!=null){
              await startPlaying();
            }
            else {
              return null;
            }
          },child: Center(child: Text("Pick File",style:const TextStyle(fontSize: 18,color: Colors.white),))),),

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
            IconButton(onPressed: (){}, icon:const Icon(Icons.first_page)),
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
            }, icon: Icon(isPlaying?Icons.pause:Icons.play_arrow)),
            IconButton(onPressed: (){}, icon:const Icon(Icons.last_page)),
          ],),

      ],),
    );
  }
    pickFile() async{
    final FilePickerResult? result=await FilePicker.platform.pickFiles(type:FileType.audio,allowMultiple:false);
    if(result != null) {
      setState(() {
        soundFile=result.files.single.path.toString();
      });
      print("${result.files.single.path.toString()}");
      return File(result.files.single.path.toString());
     }
    return null;
  }
  void stopPlaying() {
    audioPlayer!.pause();
  }

  startPlaying(){
    audioCache!.play(soundFile);
  }
  seekTo(int sec){
    audioPlayer!.seek(Duration(seconds: sec));
  }


*/
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
  }*//*



}
*/
import 'dart:io';
import 'package:http/http.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class FilePlay extends StatefulWidget {
  const FilePlay({Key? key}) : super(key: key);

  @override
  _FilePlayState createState() => _FilePlayState();
}

class _FilePlayState extends State<FilePlay> {
  AudioPlayer audioPlayer = AudioPlayer();
  String file = 'file';
 // AudioCache cache = AudioCache();
  bool isPlaying=false;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 179, 185, 1),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Pick an Audio file',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          InkWell(
              onTap: () async {
                // await _loadFile();
                final result = await openFile();
                if (result != null) {
                  setState(() {
                    isPlaying=true;
                  });
                  startPlaying(result);
                } else {
                  return null;
                }
              },
              child:  Icon(
                Icons.folder_open,
                size: 50,
              )// IconButton(onPressed: (){}, icon:const Icon(Icons.first_page,color: Colors.white,)),
                  // IconButton(onPressed: (){}, icon:const Icon(Icons.last_page,color: Colors.white)),
                ),
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
              startPlaying(file);
            }
          }, icon: Icon(isPlaying?Icons.pause:Icons.play_arrow,color: Colors.white)),
          Text('${file.toString()}'),
        ],
      ),
    );
  }

  openFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.audio, allowMultiple: false);
    if (result != null) {
      setState(() {
        file = result.files.single.path.toString();
      });
      print("${result.files.single.path.toString()}");
      return (result.files.single.path.toString());
    }
    return null;
  }
  startPlaying(String path)async{
   await audioPlayer.play(path,isLocal: true);
  }
   stopPlaying(){
    audioPlayer.pause();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }

// String? localFilePath;
//   String  Url = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
//   Future _loadFile() async {
//     final bytes = await readBytes(Uri.parse(Url));
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/audio.mp3');
//
//     await file.writeAsBytes(bytes);
//     if (file.existsSync()) {
//       setState(() => localFilePath = file.path);
//     }
//     print("${file.path.toString()}");
//   }
}