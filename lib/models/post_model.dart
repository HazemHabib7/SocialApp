class SocialNewPostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  SocialNewPostModel(
      {required name,
        required uId,
        required image,
        required dateTime,
        required text,
        required postImage});

  SocialNewPostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
