class Message{
  final String body;
  final String id;
  Message(this.body,this.id);

factory Message.fromJson(jsonData){
  
  return Message(jsonData['body'] , jsonData['id']);
}
}