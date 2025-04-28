import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';


class AddproductphotoWidget extends StatefulWidget {
  final String titleName;
  final double outerWidth;
  final double outerHeight;
  final double innerWidth;
  final double innerHeight;
  final Function(File?, Uint8List?)? onImageSelected; // Updated callback

  const AddproductphotoWidget({
    super.key,
    required this.titleName,
    this.outerWidth = 0.40,
    this.outerHeight = 0.40,
    this.innerWidth = 0.3,
    this.innerHeight = 0.20,
    required this.onImageSelected,
  });

  @override
  State<AddproductphotoWidget> createState() => _AddProductPhotoWidgetState();
}

class _AddProductPhotoWidgetState extends State<AddproductphotoWidget> {
  final ImagePicker _imagePicker = ImagePicker();
  Uint8List? _imageBytes;
  File? _selectedImageFile;
  String? imageName;

  Future<void> pickImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null && result.files.first.bytes != null) {
        setState(() {
          _imageBytes = result.files.first.bytes;
          _selectedImageFile = null;
          imageName = result.files.first.name;
        });
        widget.onImageSelected?.call(null, _imageBytes);
      }
    } else {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImageFile = File(image.path);
          _imageBytes = null;
          imageName = image.name;
        });
        widget.onImageSelected?.call(_selectedImageFile, null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titleName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF313948),
            ),
          ),
          const SizedBox(height: 7),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * widget.outerWidth,
            height: MediaQuery.of(context).size.height * widget.outerHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: pickImage,
                  child: Center(
                    child: DottedBorder(
                      color: _imageBytes == null && _selectedImageFile == null
                          ? const Color(0xFF9A97EB)
                          : const Color(0xFFFFFFFF),
                      strokeWidth: 2,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      dashPattern: const [6, 4],
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            widget.innerWidth,
                        height: MediaQuery.of(context).size.height *
                            widget.innerHeight,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _imageBytes != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.memory(
                                  _imageBytes!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              )
                            : _selectedImageFile != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      _selectedImageFile!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      HugeIcon(
                                        icon:
                                            HugeIcons.strokeRoundedImageUpload,
                                        size: 40,
                                        color: Color(0xFF9A97EB),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Tap to upload image",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF313948),
                                        ),
                                      ),
                                    ],
                                  ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    _imageBytes == null && _selectedImageFile == null
                        ? "Set the product thumbnail image.\nOnly *.png, *.jpg, *.jpeg are accepted."
                        : "Image: $imageName",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddPodcastAudioWidget extends StatefulWidget {
  final String titleName;
  final double outerWidth;
  final double outerHeight;
  final double innerWidth;
  final double innerHeight;
  final Function(File?, Uint8List?)?
      onAudioSelected; // Updated callback to pass both File and Uint8List

  const AddPodcastAudioWidget({
    super.key,
    required this.titleName,
    this.outerWidth = 0.40,
    this.outerHeight = 0.40,
    this.innerWidth = 0.3,
    this.innerHeight = 0.20,
    required this.onAudioSelected,
  });

  @override
  State<AddPodcastAudioWidget> createState() => _AddPodcastAudioWidgetState();
}

class _AddPodcastAudioWidgetState extends State<AddPodcastAudioWidget> {
  Uint8List? _audioBytes;
  File? _selectedAudioFile;
  String? audioName;

  Future<void> pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null) {
      if (kIsWeb && result.files.first.bytes != null) {
        setState(() {
          _audioBytes = result.files.first.bytes;
          _selectedAudioFile = null;
          audioName = result.files.first.name;
        });
        widget.onAudioSelected?.call(null, _audioBytes);
      } else if (result.files.single.path != null) {
        setState(() {
          _selectedAudioFile = File(result.files.single.path!);
          _audioBytes = null;
          audioName = result.files.single.name;
        });
        widget.onAudioSelected?.call(_selectedAudioFile, null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titleName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF313948),
            ),
          ),
          const SizedBox(height: 7),
          Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * widget.outerWidth,
            height: MediaQuery.of(context).size.height * widget.outerHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: pickAudio,
                  child: Center(
                    child: DottedBorder(
                      color: _audioBytes == null && _selectedAudioFile == null
                          ? const Color(0xFF9A97EB)
                          : const Color(0xFFFFFFFF),
                      strokeWidth: 2,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      dashPattern: const [6, 4],
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            widget.innerWidth,
                        height: MediaQuery.of(context).size.height *
                            widget.innerHeight,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _audioBytes != null || _selectedAudioFile != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  HugeIcon(
                                    icon: HugeIcons.strokeRoundedRadio,
                                    size: 40,
                                    color: const Color(0xFF9A97EB),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    audioName ?? "Audio Selected",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF313948),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  HugeIcon(
                                    icon: HugeIcons.strokeRoundedRadio,
                                    size: 40,
                                    color: Color(0xFF9A97EB),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Tap to upload audio",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF313948),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    _audioBytes == null && _selectedAudioFile == null
                        ? "Set the podcast audio file.\nOnly audio files are accepted."
                        : "Audio: $audioName",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
