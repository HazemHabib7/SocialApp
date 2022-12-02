import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy/layout/social_app/cubit/states.dart';
import 'package:udemy/models/message_model.dart';
import 'package:udemy/models/post_model.dart';
import 'package:udemy/models/social_user_model.dart';
import 'package:udemy/modules/social_app/chats/chats_screen.dart';
import 'package:udemy/modules/social_app/feeds/feeds_screen.dart';
import 'package:udemy/modules/social_app/users/users_screen.dart';
import 'package:udemy/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../modules/social_app/post/post_screen.dart';
import '../../../modules/social_app/settings/settings_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    PostScreen(),
    UsersScreen(),
    SocialSettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Create Post',
    'Users',
    'Settings',
  ];

  int currentIndex = 0;

  void socialChangeNav(index) {
    currentIndex = index;
    if (index == 1 && users.length == 0) {
      getAllUsers();
    }
    emit(SocialChangeNavState());
  }

  SocialUserModel? userModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetUserErrorState());
    });
  }

  File? profileImage;

  Future<void> pickProfileImage() async {
    final pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> pickCoverImage() async {
    final pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void updateProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, image: value);
        print(value);
        // emit(SocialUploadProfileImageSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void updateCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        // emit(SocialUploadCoverImageSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    // emit(SocialUpdateUserLoadingState());
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: image ?? userModel?.image,
      cover: cover ?? userModel?.cover,
      email: userModel?.email,
      uId: userModel?.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      emit(SocialUpdateUserErrorState());
    });
  }

  File? postImage;
  Future<void> pickPostImage() async {
    final pickedFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  Future uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage1: value,
        );
      }).catchError((onError) {
        print(onError.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage1 = '',
  }) {
    emit(SocialCreatePostLoadingState());
    SocialNewPostModel model = SocialNewPostModel(
      image: userModel?.image,
      uId: uId,
      name: userModel?.name,
      text: text,
      dateTime: dateTime,
      postImage: postImage1,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap()) //لحالو بولد دوك عشوائي
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialPostImageRemovedState());
  }

  List<SocialNewPostModel> posts = [];
  List<String> postsIds = [];
  List<int> likes = [];
  List<int> comments = [];
  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          element.reference.collection('comments').get().then((value) {
            comments.add(value.docs.length);
            postsIds.add(element.id);
            posts.add(SocialNewPostModel.fromJson(element.data()));
          });
        });
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetPostsErrorState());
    });
  }

  void likePost(postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialLikePostErrorState());
    });
  }

  void commentPost(String postId, String comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({'comment': comment}).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialCommentPostErrorState());
    });
  }

  List<SocialUserModel> users = [];
  void getAllUsers() {
    users = [];
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != uId)
          users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialGetAllUsersErrorState());
    });
  }

  void sendMessages({
    required String receiverId,
    required String text,
    required String dateTime,
  }) {
    MessageModel model = MessageModel(
        senderId: uId, receiverId: receiverId, text: text, dateTime: dateTime);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap()) //لحالو بولد دوك عشوائي
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(model.toMap()) //لحالو بولد دوك عشوائي
        .then((value) {
      emit(SocialGetMessageSuccessState());
    }).catchError((onError) {
      emit(SocialGetUserErrorState());
    });
  }

  List<MessageModel> message = [];
  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          message = [];
          event.docs.forEach((element) {
            message.add(MessageModel.fromJson(element.data()));
          });
    });
  }
}
