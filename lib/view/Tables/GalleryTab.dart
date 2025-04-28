import 'package:flutter/material.dart';

import '../../CustomColors.dart';
import '../../Widgets/GridImage.dart';
import '../../Widgets/TitleRow.dart';
import '../Header/DashBoardHeader.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Carousel using CarouselSlider with autoPlay this code for gallery
/*class ChurchGalleryPage extends StatefulWidget {
  @override
  _ChurchGalleryPageState createState() => _ChurchGalleryPageState();
}

class _ChurchGalleryPageState extends State<ChurchGalleryPage> {
  List<String> carouselImages = [
    "assets/avatar2.png", // Local asset image for carousel
    "assets/avatar4.png", // Local asset image for carousel
    "assets/avatar3.png", // Local asset image for carousel
  ];

  List<String> gridImages = [
    "assets/avatar1.png",
    "assets/avatar2.png",
    "assets/avatar4.png",
  ];

  int activePage = 0;

  @override
  void initState() {
    super.initState();
  }


  void addImageToGrid() {
    setState(() {
      gridImages.add('assets/avatar2.png');
    });
  }

  void deleteImageFromGrid(int index) {
    setState(() {
      gridImages.removeAt(index);
    });
  }

  void editImageInGrid(int index) {
    setState(() {
      gridImages[index] = 'assets/avatar${index + 3}.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 400.0,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    height: 400.0,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                  ),
                  items: carouselImages.map((image) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: gridImages.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(gridImages[index], fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () => editImageInGrid(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteImageFromGrid(index),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addImageToGrid,
        child: Icon(Icons.add),
      ),
    );
  }
}*/

// this code fetch picture from file manager or mobile via gallery

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late final PageController pageController;
  List<Map<String, dynamic>> sliderImages = [];
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
  }

  Future<void> pickImage({int? editIndex}) async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        Uint8List webImage = result.files.first.bytes!;
        setState(() {
          if (editIndex != null) {
            sliderImages[editIndex] = {"image": webImage, "isWeb": true};
          } else {
            sliderImages.add({"image": webImage, "isWeb": true});
          }
        });
      }
    } else {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File mobileImage = File(image.path);
        setState(() {
          if (editIndex != null) {
            sliderImages[editIndex] = {"image": mobileImage, "isWeb": false};
          } else {
            sliderImages.add({"image": mobileImage, "isWeb": false});
          }
        });
      }
    }
  }

  void deleteImage(int index) {
    setState(() {
      sliderImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FB),
      body: ListView(
        children: [
          DashboardHeader(),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TitleRow(title: 'Gallery'),
          ),
          Container(
            height: 10,
            child: PageView.builder(
              controller: pageController,
              itemCount: sliderImages.length,
              onPageChanged: (index) {
                setState(() {});
              },
              itemBuilder: (_, index) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: sliderImages[index]["isWeb"]
                            ? Image.memory(sliderImages[index]["image"],
                                fit: BoxFit.cover, width: double.infinity)
                            : Image.file(sliderImages[index]["image"],
                                fit: BoxFit.cover, width: double.infinity),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.white),
                            onPressed: () => pickImage(editIndex: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteImage(index),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Gridimage()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


// working code

/*class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late final PageController pageController;
  late final CarouselController _carouselController;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(
        initialPage: 0,
        viewportFraction: 0.85
    );
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(),
            Padding(
              padding: const EdgeInsets.only(top: 20,right: 120,left: 120,bottom: 20),
              child: TitleRow(title: 'Gallery'),
            ),
            SizedBox(
              height: 500,
              child: PageView.builder(
                itemCount: sliderImage.length,
                controller: pageController,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      if (pageController.page != null) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          sliderImage[index]['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Gridimage(),
          ],
        ),
      ),
    );
  }

}*/



