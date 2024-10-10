  //
  // import 'dart:io';
  // import 'package:flutter/material.dart';
  // import 'package:image_picker/image_picker.dart';
  //
  // import '../../../../common/widgets/CircularImage.dart';
  // import '../../../../utils/constants/AppImagePaths.dart';
  //
  // class ImageWidget1 extends StatefulWidget {
  //   const ImageWidget1({super.key, required this.imageUrl});
  //
  //   final String imageUrl;
  //
  //   @override
  //   _ImageWidget1State createState() => _ImageWidget1State();
  // }
  //
  // class _ImageWidget1State extends State<ImageWidget1> {
  //   File? _selectedImage; // To store the selected image
  //   final ImagePicker _picker = ImagePicker(); // Initialize the ImagePicker
  //
  //   // Function to pick image from gallery or capture using camera
  //   Future<void> _pickImage(ImageSource source) async {
  //     final pickedFile = await _picker.pickImage(source: source);
  //     if (pickedFile != null) {
  //       setState(() {
  //         _selectedImage = File(pickedFile.path); // Store the selected image
  //       });
  //     }
  //   }
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         // Circular Image with inner shadow effect
  //         Container(
  //           decoration: const BoxDecoration(
  //             shape: BoxShape.circle,
  //           ),
  //           child: Stack(
  //             alignment: Alignment.center,
  //             children: [
  //
  //
  //             Container(
  //             width: 70,
  //             height: 70,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //
  //             ),
  //             child: ClipOval(
  //               child: FadeInImage(
  //                 placeholder: AssetImage(AppImagePaths.placeholder1), // Placeholder image
  //                 image: NetworkImage('imageUrl'),
  //                 fit: BoxFit.cover,
  //                 fadeInDuration: Duration(milliseconds: 200),
  //                 fadeOutDuration: Duration(milliseconds: 200),
  //                 imageErrorBuilder: (context, error, stackTrace) {
  //                   return Center(child: Text('Failed to load image'));
  //                 },
  //               ),
  //             ),
  //           ),
  //
  //
  //           // Inner shadow simulation using a gradient
  //               Container(
  //                 width: 100,
  //                 height: 100,
  //                 decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   gradient: RadialGradient(
  //                     colors: [
  //                       Colors.black.withOpacity(0.5), // Dark center for inner shadow effect
  //                       Colors.transparent, // Fades to transparent
  //                     ],
  //                     stops: [0.7, 1.0],
  //                     center: Alignment.center,
  //                     radius: 0.9, // Adjust the radius for the effect
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         // Camera icon centered over the image
  //         Positioned.fill(
  //           child: Align(
  //             alignment: Alignment.center,
  //             child: IconButton(
  //               onPressed: () {
  //                 _showImageSourceActionSheet(context); // Show options to select source
  //               },
  //               icon: const Icon(
  //                 Icons.camera_alt_outlined,
  //                 color: Colors.white,
  //                 size: 30,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  //
  //   // Function to show an ActionSheet with options
  //   void _showImageSourceActionSheet(BuildContext context) {
  //     showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return SafeArea(
  //           child: Wrap(
  //             children: [
  //               ListTile(
  //                 leading: const Icon(Icons.photo_library),
  //                 title: const Text('Choose from Gallery'),
  //                 onTap: () {
  //                   Navigator.of(context).pop();
  //                   _pickImage(ImageSource.gallery); // Pick image from gallery
  //                 },
  //               ),
  //               ListTile(
  //                 leading: const Icon(Icons.camera_alt),
  //                 title: const Text('Capture Image'),
  //                 onTap: () {
  //                   Navigator.of(context).pop();
  //                   _pickImage(ImageSource.camera); // Capture image using camera
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }


  import 'dart:io';
  import 'package:flutter/material.dart';
  import 'package:image_picker/image_picker.dart';
  import 'package:firebase_storage/firebase_storage.dart';
  import 'package:path/path.dart' as path;
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:firebase_database/firebase_database.dart';

  import '../../../../common/widgets/CircularImage.dart';
  import '../../../../utils/constants/AppImagePaths.dart';

  class ImageWidget1 extends StatefulWidget {
    const ImageWidget1({super.key, required this.imageUrl});

    final String imageUrl;

    @override
    _ImageWidget1State createState() => _ImageWidget1State();
  }

  class _ImageWidget1State extends State<ImageWidget1> {
    File? _selectedImage;
    final ImagePicker _picker = ImagePicker();
    bool _isUploading = false; // To track upload status

    // Function to pick image from gallery or capture using camera
    Future<void> _pickImage(ImageSource source) async {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        await _uploadImage(); // Call the upload function after image is selected
      }
    }

    // Function to upload the image to Firebase Storage
    Future<void> _uploadImage() async {
      if (_selectedImage == null) return;

      setState(() {
        _isUploading = true; // Set uploading status
      });

      try {
        // Create a unique file name for the image
        final fileName = path.basename(_selectedImage!.path);
        final storageRef = FirebaseStorage.instance.ref().child('user_images/$fileName');

        // Upload the file to Firebase Storage
        final uploadTask = storageRef.putFile(_selectedImage!);
        await uploadTask.whenComplete(() {});

        // Get the download URL of the uploaded image
        final downloadUrl = await storageRef.getDownloadURL();

        // Update the user data with the new image URL in Realtime Database
        await _updateUserImageUrl(downloadUrl);

        setState(() {
          _isUploading = false; // Reset uploading status
        });

      } catch (error) {
        setState(() {
          _isUploading = false;
        });
        print('Error uploading image: $error');
      }
    }

    // Function to update the user image URL in Firebase Realtime Database
    Future<void> _updateUserImageUrl(String imageUrl) async {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the user's node in Firebase Realtime Database
        final userRef = FirebaseDatabase.instance.ref().child('users').child(user.uid);

        await userRef.update({
          'imageUrl': imageUrl, // Update the user's image URL
        });

        // Optionally, show a success message or Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile image updated successfully!')),
        );
      }
    }

    @override
    Widget build(BuildContext context) {
      return Stack(
        alignment: Alignment.center,
        children: [
          // Circular Image with inner shadow effect
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: _selectedImage == null
                        ? FadeInImage(
                      placeholder: AssetImage(AppImagePaths.placeholder1), // Placeholder image
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 200),
                      fadeOutDuration: Duration(milliseconds: 200),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Center(child: Text('Failed to load image'));
                      },
                    )
                        : Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Inner shadow simulation using a gradient
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      stops: [0.7, 1.0],
                      center: Alignment.center,
                      radius: 0.9,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isUploading)
            CircularProgressIndicator(), // Show a progress indicator when uploading
          // Camera icon centered over the image
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  _showImageSourceActionSheet(context); // Show options to select source
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Function to show an ActionSheet with options
    void _showImageSourceActionSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Capture Image'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }
