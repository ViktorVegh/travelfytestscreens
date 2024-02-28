import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:provider/provider.dart';
import '../model/media.dart';
import '../model/mock_post_singleton.dart';
import '../model/post.dart';
import '../model/location.dart';
import '../provider/user_provider.dart';

class CreatePostWidget extends StatefulWidget {
  @override
  _CreatePostWidgetState createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool isCurrentlyOnTrip = false;
  List<File> _selectedImages = [];
  File? _mostRecentImage;
  List<AssetEntity> _libraryImages = [];
  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    _fetchMostRecentImage();
    _loadLibraryImages();
  }

  Future<void> _fetchMostRecentImage() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      final List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(type: RequestType.image);
      final List<AssetEntity> recentAssets =
          await albums.first.getAssetListPaged(page: 0, size: 1);
      if (recentAssets.isNotEmpty) {
        final AssetEntity recentImage = recentAssets.first;
        final File? file = await recentImage.file;
        setState(() {
          _mostRecentImage = file;
        });
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  Future<void> _handleImageSelection() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      // Check if there's a most recent image and insert it first
      if (_mostRecentImage != null) {
        setState(() {
          _selectedImages.insert(
              0, _mostRecentImage!); // Add the most recent image first
        });
      }
      for (var image in images) {
        setState(() {
          _selectedImages.add(File(image.path)); // Add the rest of the images
        });
      }
    }
  }

  Future<void> _handleCameraImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImages.insert(0, File(image.path)); // Add without cropping
        _mostRecentImage =
            File(image.path); // Set as most recent without cropping
      });
    }
  }

  Future<void> _handlePostCreation() async {
    final currentUser =
        Provider.of<UserProvider>(context, listen: false).currentUser;
    if (currentUser?.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: No user is logged in.")));
      return;
    }

    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please select an image.")));
      return;
    }

    // Creating Media objects using the file paths from _selectedImages
    List<Media> mediaList = _selectedImages
        .map((file) => Media(
              id: UniqueKey().hashCode, // Or any other ID generation strategy
              type: MediaType.IMAGE, // Assuming all selected media are images
              path: file.path, // Using 'path' attribute for local file path
              // Note: 'url' could be used if you have a remote URL for the media
            ))
        .toList();

    Post newPost = Post(
      id: UniqueKey().hashCode,
      mediaList: mediaList,
      timestamp: DateTime.now(),
      location:
          Location(id: 0, address_id: 0, point_id: 0, region_id: 0, tags: []),
      userId: 1, // Assuming a static user ID for testing
      likeCount: 0,
      isLikedByCurrentUser: false,
    );

    MockPostSingleton().mockPost.addPost(newPost);

    // Feedback to the user
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Post Created")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF007BFF), // Docker-inspired blue background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Create Post', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => _handlePostCreation(),
            child: Text('Post', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCurrentlyOnTripSwitch(),
              _buildImagePreviewSection(),
              _buildDescriptionField(),
              _buildRecentImagesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentlyOnTripSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Currently on trip',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        Switch(
          value: isCurrentlyOnTrip,
          onChanged: (value) {
            setState(() {
              isCurrentlyOnTrip = value;
            });
          },
          activeColor: Colors.white,
          activeTrackColor: Colors.white24,
        ),
      ],
    );
  }

  Widget _buildImagePreviewSection() {
    return _selectedImages.isNotEmpty
        ? Column(
            children: [
              CarouselSlider(
                items: _selectedImages
                    .map((file) => Image.file(file, fit: BoxFit.cover))
                    .toList(),
                options: CarouselOptions(
                  aspectRatio: 0.8,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current =
                          index; // Update the index to reflect the current image
                    });
                  },
                ),
                carouselController:
                    _carouselController, // Utilize the carousel controller
              ),
              SizedBox(
                  height:
                      20), // Provide some spacing between the carousel and dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_selectedImages.length, (index) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(index),
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Theme.of(context)
                                  .primaryColor // Active dot color
                              : Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4) // Inactive dot color
                          ),
                    ),
                  );
                }),
              ),
            ],
          )
        : Center(
            child: Text('No Image Selected',
                style: TextStyle(color: Colors.white)),
          );
  }

  Widget _buildDescriptionField() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      child: TextField(
        controller: _descriptionController,
        style: TextStyle(color: Colors.white),
        maxLines: 3,
        decoration: InputDecoration(
          hintText: "Add a description...",
          hintStyle: TextStyle(color: Colors.white54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white24,
        ),
      ),
    );
  }

  Widget _buildLibraryImagesGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: _libraryImages.length,
        itemBuilder: (BuildContext context, int index) {
          return FutureBuilder<File?>(
            future: _libraryImages[index].file,
            builder: (BuildContext context, AsyncSnapshot<File?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedImages.add(snapshot.data!);
                  }),
                  child: Image.file(snapshot.data!, fit: BoxFit.cover),
                );
              }
              return Container(color: Colors.grey[200]);
            },
          );
        },
      ),
    );
  }

  Future<void> _loadLibraryImages() async {
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();
    final List<AssetEntity> images = await albums[0]
        .getAssetListPaged(page: 0, size: 100); // Adjust size as needed

    setState(() {
      _libraryImages = images;
    });
  }

  Widget _buildRecentImagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent', style: TextStyle(color: Colors.white, fontSize: 16)),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add, color: Colors.white),
                  onPressed: _handleImageSelection,
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: _handleCameraImage,
                ),
              ],
            ),
          ],
        ),
        Container(
          height: 100, // Adjust based on your UI
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _selectedImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return Image.file(_selectedImages[index], fit: BoxFit.cover);
            },
          ),
        ),
      ],
    );
  }

  Future<File?> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Edit Photo',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Edit Photo',
        ),
        // Add WebUiSettings if you're also targeting web
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    } else {
      return null;
    }
  }
}
