import 'dart:io';
import 'package:church_admin/Service/UserServices.dart';
import 'package:church_admin/Service/ChurchToolsServices.dart';
import 'package:church_admin/Widgets/AddProductPhotoWidget.dart';
import 'package:church_admin/Widgets/CustomButtons.dart';
import 'package:church_admin/Widgets/DropDown.dart';
import 'package:church_admin/Widgets/TextFieldForms.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AudioPodcastForms extends StatefulWidget {
  const AudioPodcastForms({super.key});

  @override
  State<AudioPodcastForms> createState() => _AudioPodcastFormsState();
}

class _AudioPodcastFormsState extends State<AudioPodcastForms> {
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, bool> _errorStates = {};
  final Churchtoolsservices _audioPodcastService = Churchtoolsservices();

  final List<String> fields = [
    'Episode *',
    'Volume *',
    'Vocal *',
    'Title *',
    'User *',
    'Description',
  ];

  String? selectedUserId;
  File? selectedImageFile;
  Uint8List? selectedImageBytes;
  File? selectedAudioFile;
  Uint8List? selectedAudioBytes;
  List<String> userIds = [];
  Map<String, String> userIdToNameMap = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    for (String field in fields) {
      if (field != 'User *') {
        _textControllers[field] = TextEditingController();
      }
      _errorStates[field] = false;
    }
    _fetchUserDetails();
  }

  @override
  void dispose() {
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _fetchUserDetails() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await UserServices.fetchUserDetails();

      if (response.isEmpty) {
        setState(() {
          userIds = [];
          userIdToNameMap = {};
          isLoading = false;
        });
        return;
      }

      final userDetails = response[0]['data'] as List<dynamic>;

      setState(() {
        userIds = userDetails
            .where((user) =>
                user['No'] != null &&
                user['Name'] != null &&
                user['Name']['name'] != null)
            .map((user) => user['No'].toString())
            .toList();

        userIdToNameMap = {
          for (var user in userDetails)
            if (user['No'] != null &&
                user['Name'] != null &&
                user['Name']['name'] != null)
              user['No'].toString(): user['Name']['name'].toString()
        };

        selectedUserId = userIds.isNotEmpty ? userIds[0] : null;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _validateForm() {
    setState(() {
      for (String field in fields) {
        if (field.endsWith('*')) {
          if (field == 'User *') {
            _errorStates[field] = selectedUserId == null;
          } else {
            _errorStates[field] = _textControllers[field]!.text.isEmpty;
          }
        }
      }
      // Require audio file
      _errorStates['audio_file'] = kIsWeb ? selectedAudioBytes == null : selectedAudioFile == null;
      // Image file is optional, but you can make it required by uncommenting:
      // _errorStates['image_file'] = kIsWeb ? selectedImageBytes == null : selectedImageFile == null;
    });

    bool isValid = !_errorStates.values.contains(true);
    if (isValid) {
      _submitForm();
    } else {
      if (_errorStates['User *'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a user')),
        );
      } else if (_errorStates['audio_file'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload an audio file')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')),
        );
      }
      print("Form errors: $_errorStates");
    }
  }

  Future<void> _submitForm() async {
    bool success = await _audioPodcastService.createAudioPodcast(
      episode: _textControllers['Episode *']!.text,
      volume: _textControllers['Volume *']!.text,
      title: _textControllers['Title *']!.text,
      description: _textControllers['Description']!.text,
      vocal: _textControllers['Vocal *']!.text,
      user: selectedUserId!,
      createdBy: "admin_user",
      imageFile: selectedImageFile,
      imageBytes: selectedImageBytes,
      audioFile: selectedAudioFile,
      audioBytes: selectedAudioBytes,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Audio podcast added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add audio podcast')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.74,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xfff4f7fc),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Add Audio Podcast'),
                  const Divider(thickness: 1, color: Color(0xFFE4E6E8)),
                  const SizedBox(height: 15),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator())
                  else ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: AddPodcastAudioWidget(
                              titleName: 'Add Audio',
                              onAudioSelected: (File? file, Uint8List? bytes) {
                                setState(() {
                                  selectedAudioFile = file;
                                  selectedAudioBytes = bytes;
                                  _errorStates['audio_file'] = false; // Clear error when file is selected
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            flex: 1,
                            child: AddproductphotoWidget(
                              titleName: 'Add Photo',
                              onImageSelected: (File? file, Uint8List? bytes) {
                                setState(() {
                                  selectedImageFile = file;
                                  selectedImageBytes = bytes;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Flexible(flex: 1, child: _buildTextField(fields[0])),
                        const SizedBox(width: 15),
                        Flexible(flex: 1, child: _buildTextField(fields[1])),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Flexible(flex: 1, child: _buildTextField(fields[2])),
                        const SizedBox(width: 15),
                        Flexible(flex: 1, child: _buildTextField(fields[3])),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(fields[4]),
                    const SizedBox(height: 15),
                    _buildTextField(fields[5], isMultiline: true),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CustomButton(
                        text: "Add Now",
                        color: Colors.blue,
                        textColor: Colors.white,
                        onPressed: _validateForm,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField(String fieldName, {bool isMultiline = false}) {
    if (fieldName == 'User *') {
      return DropdownSelector(
        title: fieldName,
        value: selectedUserId ?? '',
        onChanged: (newValue) {
          setState(() {
            selectedUserId = newValue!;
            _errorStates[fieldName] = false;
          });
        },
        ItemList: userIds,
      );
    } else {
      return Textfieldforms(
        title: fieldName,
        hint: "Enter ${fieldName.replaceAll('*', '').trim().toLowerCase()}",
        isBlocked: false,
        isMultiline: isMultiline,
        isController: _textControllers[fieldName]!,
        isErrorText: _errorStates[fieldName]!,
      );
    }
  }
}