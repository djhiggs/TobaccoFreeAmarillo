import 'dart:io';

class UsefulInfo
{
  var quizPassed = false;

  String topic;
  String passage;

  //Pulls data from infoBox/infoBox$index.txt and assimilates it into 'this' object.
  infoBox(int index) async
  {
    
    var lines = await new File('infoBox/infobox$index.txt').readAsLines();
    topic = lines[0];
    for(int i = 1; i < lines.length; i++)
      passage += lines[i];
  }

}