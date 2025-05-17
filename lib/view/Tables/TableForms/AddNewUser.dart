import 'dart:convert';
import 'dart:io';
import 'package:church_admin/Widgets/DropDowns.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Church Management',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const Signupdetails(),
    );
  }
}

class Signupdetails extends StatefulWidget {
  final String? email;

  final String? phoneNumber;
  const Signupdetails({super.key, this.email, this.phoneNumber});

  @override
  State<Signupdetails> createState() => _SignupdetailsState();
}

class _SignupdetailsState extends State<Signupdetails> {
  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email ?? '';
    _contactNumberController.text = widget.phoneNumber ?? '';
    fetchFamilyList();
    fetchZoneList();
    fetchUserList();
  }

  late TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _additionalMobileController =
      TextEditingController();
  final TextEditingController _baptismDateController = TextEditingController();
  final TextEditingController _previousChurchController =
      TextEditingController();
  final TextEditingController _spouseController = TextEditingController();
  final TextEditingController _aadharNumberController = TextEditingController();
  final TextEditingController _anniversaryDateController =
      TextEditingController(text: '2000-01-01');
  bool isMarried = false;
  final TextEditingController _hobbiesController = TextEditingController();
  final TextEditingController _zoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _joinedDateController = TextEditingController();
  final TextEditingController _relationWithFamilyController =
      TextEditingController();

  // Address controllers
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  // Blood group controllers
  final TextEditingController _lastDonatedDateController =
      TextEditingController();

  // Professional details controllers
  final TextEditingController _professionNameController =
      TextEditingController();
  final TextEditingController _yearsOfExperienceController =
      TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  // Dropdown values
  String _selectedPrefix = 'Mr.';
  String _selectedRole = 'user';
  int _selectedGroup = 1;
  int _selectedPermissionsRole = 2;
  int _selectedZone = 1;
  int? _selectedSpouse = 0;
  String _selectedServiceLanguage = 'English';
  String _selectedGender = 'male';
  String _selectedMaritalStatus = 'single';
  String _selectedSocialStatus = 'yes';
  String _selectedHouseType = 'owned';
  String _selectedAttendingTime = 'morning';
  bool _selectedOutStation = false;
  String _selectedNationality = 'indian';
  int _selectedRelationToFamily = 1;
  String _selectedAddressType = 'home';
  bool _isPrimaryAddress = true;
  String _selectedBloodGroup = 'A-';
  String _selectedProfessionCategory = 'it';
  String _selectedEmploymentType = 'self_employed';

  // Map
  LatLng? _selectedLocation;
  GoogleMapController? _mapController;

  void _onMapTapped(LatLng location) {
    setState(() {
      _selectedLocation = location;
      _latitudeController.text = location.latitude.toString();
      _longitudeController.text = location.longitude.toString();
    });
  }

  @override
  void dispose() {
    // Dispose all controllers
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _contactNumberController.dispose();
    _additionalMobileController.dispose();
    _baptismDateController.dispose();
    _previousChurchController.dispose();
    _spouseController.dispose();
    _aadharNumberController.dispose();
    _anniversaryDateController.dispose();
    _hobbiesController.dispose();
    _zoneController.dispose();
    _dobController.dispose();
    _joinedDateController.dispose();
    _relationWithFamilyController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    _landmarkController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _lastDonatedDateController.dispose();
    _professionNameController.dispose();
    _yearsOfExperienceController.dispose();
    _qualificationController.dispose();
    _designationController.dispose();
    _companyNameController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      barrierColor: Colors.grey.withOpacity(0.5),
    );
    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  List<Map<String, dynamic>> familyList = [];

  Future<void> fetchFamilyList() async {
    final String url =
        "http://147.93.97.78:5030/fetch_all_family_with_other_details/";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          familyList = List<Map<String, dynamic>>.from(data);

          _selectedRelationToFamily =
              familyList.isNotEmpty ? familyList[0]['family_id'] : 1;
        });
        print("family List: $familyList");
      } else {
        print("Failed to fetch family list: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching family list: $e");
    }
  }

  List<Map<String, dynamic>> zoneList = [];

  Future<void> fetchZoneList() async {
    final String url = "http://147.93.97.78:5030/zones/";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          zoneList = List<Map<String, dynamic>>.from(data);
          _selectedZone = zoneList.isNotEmpty ? zoneList[0]['id'] : 1;
        });
        print("zone List: $zoneList");
      } else {
        print("Failed to fetch zone list: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching zone list: $e");
    }
  }

  List<Map<String, dynamic>> userList = [];

  Future<void> fetchUserList() async {
    final String url = "http://147.93.97.78:5030/users/";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          userList = List<Map<String, dynamic>>.from(data);
           _selectedSpouse = userList.isNotEmpty ? userList[0]['id'] : 1;
        });
        print("user List: $userList");
      } else {
        print("Failed to fetch user list: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching user list: $e");
    }
  }

  bool isReqDone = false;

  Future<void> _submitForm() async {
    try {
      // Prepare the data in the exact structure expected by the API
      final Map<String, dynamic> userData = {
        "user_data": {
          "name": _nameController.text,
          "prefix": _selectedPrefix,
          "email": _emailController.text,
          "password": _dobController.text.toString().replaceAll('-','').replaceAll(' ', '').replaceAll(':', ''),
          "role": 'user',
          "group": _selectedGroup,
          "contact_number": _contactNumberController.text,
          "created_by": "system",
          "dob": _dobController.text,
          "permissions_role": null,
          "joined_date": _joinedDateController.text,
          "additional_mobile_number": _additionalMobileController.text,
          "additional_info_data": {
            "baptism_date": _baptismDateController.text,
            "social_status": _selectedMaritalStatus,
            "previous_church": _previousChurchController.text,
            "service_language": _selectedServiceLanguage,
            "gender": _selectedGender,
            "marital_status": _selectedMaritalStatus,
            "aadhar_number": _aadharNumberController.text,
            "house_type": _selectedHouseType,
            "attending_time": _selectedAttendingTime,
            "hobbies": _hobbiesController.text,
            "zone": _selectedZone.toString(),
            "out_station": _selectedOutStation,
            "nationality": _selectedNationality,
            "relation_to_family": _selectedRelationToFamily,
            "relation_with_family": _relationWithFamilyController.text,
            "created_by": "system",
          },
          "address": {
            "address_type": _selectedAddressType,
            "address_line_1": _addressLine1Controller.text,
            "address_line_2": _addressLine2Controller.text,
            "city": _cityController.text,
            "state": _stateController.text,
            "postal_code": _postalCodeController.text,
            "country": _countryController.text,
            "landmark": _landmarkController.text,
            "latitude": 0,
            "longitude":  0,
            "is_primary": true,
            "created_by": "user"
          },
          "blood_group": {
            "last_donated_date": _lastDonatedDateController.text,
            "blood_group_name": _selectedBloodGroup,
            "created_by": "system"
          },
          "professional_details": {
            "profession_name": _professionNameController.text,
            "category": _selectedProfessionCategory,
            "years_of_experience":
                int.tryParse(_yearsOfExperienceController.text) ?? 0,
            "qualification": _qualificationController.text,
            "type": _selectedEmploymentType,
            "designation": _designationController.text,
            "company_name": _companyNameController.text,
            "department": _departmentController.text,
            "created_by": "system"
          }
        }
      };

      if (_selectedMaritalStatus == 'married') {
        userData["user_data"]["additional_info_data"]["spouse"] =
            _selectedSpouse;
        userData["user_data"]["additional_info_data"]["anniversary_date"] =
            _anniversaryDateController.text;
      }

      if (_selectedImage != null) {
        var uri =
            Uri.parse('http://147.93.97.78:5030/users-with-other-details/');
        var request = http.MultipartRequest('POST', uri);

        request.fields['user_data'] = jsonEncode(userData["user_data"]);

        request.files.add(await http.MultipartFile.fromPath(
          'profile_image',
          _selectedImage!.path,
        ));

        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        _handleResponse(response);
      } else {
        final response = await http.post(
          Uri.parse('http://147.93.97.78:5030/users-with-other-details/'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(userData),
        );

        _handleResponse(response);
      }
    } catch (e) {
      print("Error during form submission: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _handleResponse(http.Response response) {
    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("User registered successfully");
      try {
       
        setState(() {
          isReqDone = true;
        });
      } catch (e) {
        print("Error saving login data: $e");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                'User registered successfully!',
                style: GoogleFonts.manrope(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: const Color(0xff7C3AED),
        ),
      );
      
      //TODO
      // nav to user list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to register: ${response.body}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  File? _selectedImage;
  bool _isUploaded = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    print("called");
    try {
      final img = await _picker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        setState(() {
          _selectedImage = File(img.path);
          _isUploaded = true;
        });
      }
    } catch (e) {
      debugPrint('Error in _pickImageFromGallery: $e');
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final img = await _picker.pickImage(source: ImageSource.camera);
      if (img != null) {
        setState(() {
          _selectedImage = File(img.path);
        });
      }
    } catch (e) {
      debugPrint('Error in _pickImageFromCamera: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildFormRows([

SizedBox(),
                                    Center(
                                      child: GestureDetector(
                                                      onTap: () {
                                                        _pickImageFromGallery();
                                                      },
                                                      child: _isUploaded
                                                          ? CircleAvatar(
                                      radius: 48,
                                      backgroundColor: Color(0xff7C3AED),
                                      backgroundImage: FileImage(_selectedImage!),
                                      //child: Image.file(_selectedImage!,fit: BoxFit.cover,),
                                                            )
                                                          : CircleAvatar(
                                      radius: 48,
                                      backgroundColor: Color(0xff7C3AED),
                                      child: HugeIcon(
                                          icon: HugeIcons.strokeRoundedUserAdd02,
                                          color: Colors.white),
                                                            )),
                                    ),
SizedBox(),

        // Personal Information Section
        Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Personal Infor


            Flexible(
              flex: 1,
              child: _dropdownField(
          label: 'Prefix',
          value: _selectedPrefix,
          items: ['Mr.', 'Mrs.', 'Ms.', 'Dr.', 'Er.'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedPrefix = newValue!;
            });
          },
              ),
            ),
            SizedBox(width: 16),
            Flexible(
              flex: 5,
              child: _inputField(
          label: 'Full Name',
          maxNumbers: 50,
          inputType: TextInputType.name,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedProfile02,
          controller: _nameController,
          hint: 'Enter your full name',
              ),
            ),
          ],
        ),
                _dropdownField(
          label: 'Gender',
          value: _selectedGender,
          items: [
            'male', 'female', 'other'
          ].map((String value) {
            return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
          _selectedGender = newValue!;
            });
          },
        ),

                _dropdownField(
          label: 'Blood Group',
          value: _selectedBloodGroup,
          items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
          .map((String value) {
            return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
          _selectedBloodGroup = newValue!;
            });
          },
        ),

        _dateInputField(
          label: 'Date of Birth',
          icon: HugeIcons.strokeRoundedCalendar03,
          controller: _dobController,
          hint: 'Select your date of birth',
        ),

        _dateInputField(
          label: 'Baptism Date',
          icon: HugeIcons.strokeRoundedCalendar03,
          controller: _baptismDateController,
          hint: 'Select your baptism date',
        ),

        _inputField(
          label: 'Aadhar Number',
          maxNumbers: 12,
          inputType: TextInputType.phone,
          inputAction: TextInputAction.next,
          isNumericOnly: true,
          icon: HugeIcons.strokeRoundedCreditCard,
          controller: _aadharNumberController,
          hint: 'Enter 12-digit Aadhar number',
        ),


        _inputField(
          label: 'Contact Number',
          maxNumbers: 10,
          inputType: TextInputType.phone,
          inputAction: TextInputAction.next,
          isNumericOnly: true,
          icon: HugeIcons.strokeRoundedCall02,
          controller: _contactNumberController,
          hint: 'Enter your phone number',
        ),
        _inputField(
          label: 'Additional Mobile Number',
          maxNumbers: 10,
          inputType: TextInputType.phone,
          inputAction: TextInputAction.next,
                    isNumericOnly: true,

          icon: HugeIcons.strokeRoundedSmartPhone01,
          controller: _additionalMobileController,
          hint: 'Enter alternate phone number (optional)',
        ),
        _inputField(
          label: 'Email',
          maxNumbers: 50,
          inputType: TextInputType.emailAddress,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedMail02,
          controller: _emailController,
          hint: 'Enter your email address',
        ),






        // Professional Information Section
        _inputField(
          label: 'Profession Name',
          maxNumbers: 100,
          inputType: TextInputType.name,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedWorkUpdate,
          controller: _professionNameController,
          hint: 'Enter your profession',
        ),
        _dropdownField(
          label: 'Category',
          value: _selectedProfessionCategory,
          items: ['it', 'education'].map((String value) {
            return DropdownMenuItem<String>(
          value: value,
          child: Text(value.toUpperCase()),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
          _selectedProfessionCategory = newValue!;
            });
          },
        ),
        _inputField(
          label: 'Years of Experience',
          maxNumbers: 2,
          isNumericOnly: true,
          inputType: TextInputType.number,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedWorkHistory,
          controller: _yearsOfExperienceController,
          hint: 'Enter years of experience',
        ),
        _inputField(
          label: 'Qualification',
          maxNumbers: 100,
          inputType: TextInputType.name,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedGraduateMale,
          controller: _qualificationController,
          hint: 'Enter your qualification',
        ),
        _dropdownField(
          label: 'Employment Type',
          value: _selectedEmploymentType,
          items: ['student', 'self_employed', 'entrepreneur']
          .map((String value) {
            return DropdownMenuItem<String>(
          value: value,
          child: Text(
              value.replaceAll('_', ' ').substring(0, 1).toUpperCase() +
              value.replaceAll('_', ' ').substring(1)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
          _selectedEmploymentType = newValue!;
            });
          },
        ),
        _inputField(
          label: 'Designation',
          maxNumbers: 100,
          inputType: TextInputType.name,
          inputAction: TextInputAction.next,
          icon: Icons.badge,
          controller: _designationController,
          hint: 'Enter your designation',
        ),
        _inputField(
          label: 'Company Name',
          maxNumbers: 100,
          inputType: TextInputType.name,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedBuilding05,
          controller: _companyNameController,
          hint: 'Enter company name',
        ),
        _inputField(
          label: 'Department',
          maxNumbers: 100,
          inputType: TextInputType.name,
          inputAction: TextInputAction.done,
          icon: HugeIcons.strokeRoundedDepartement,
          controller: _departmentController,
          hint: 'Enter your department',
        ),
        // Family Information Section




        SearchableFamilyDropdown(
          label: 'Family Name / ID',
          selectedValue: _selectedRelationToFamily,
          items: familyList,
          onChanged: (int newValue) {
            setState(() {
          _selectedRelationToFamily = newValue;
            });
          },
        ),
        _inputField(
          label: 'Relation with Family',
          maxNumbers: 50,
          inputType: TextInputType.name,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedUserGroup,
          controller: _relationWithFamilyController,
          hint: 'Relation with Family',
        ),
        SizedBox(),


        // Address Information Section
        _dropdownField(
          label: 'Address Type',
          value: _selectedAddressType,
          items: ['home', 'work', 'other'].map((String value) {
            return DropdownMenuItem<String>(
          value: value,
          child: Text(
              value.substring(0, 1).toUpperCase() + value.substring(1)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
          _selectedAddressType = newValue!;
            });
          },
        ),
                _inputField(
          label: 'Address Line 1',
          maxNumbers: 200,
          inputType: TextInputType.streetAddress,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedHome05,
          controller: _addressLine2Controller,
          hint: 'Enter your Apartment, suite, unit, etc.',
        ),
        _inputField(
          label: 'Address Line 2',
          maxNumbers: 200,
          inputType: TextInputType.streetAddress,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedHome05,
          controller: _addressLine1Controller,
          hint: 'Enter your street address',
        ),

        _inputField(
          label: 'City',
          maxNumbers: 50,
          inputType: TextInputType.name,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedLocation03,
          controller: _cityController,
          hint: 'Enter your city',
        ),
        _inputField(
          label: 'State',
          maxNumbers: 50,
          inputType: TextInputType.name,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedMapPinpoint02,
          controller: _stateController,
          hint: 'Enter your state/province',
        ),
        _inputField(
          label: 'Postal Code',
          maxNumbers: 6,
          isNumericOnly: true,
          inputType: TextInputType.phone,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedPinCode,
          controller: _postalCodeController,
          hint: 'Enter your postal/zip code',
        ),
        _inputField(
          label: 'Country',
          maxNumbers: 50,
          inputType: TextInputType.name,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedFlag02,
          controller: _countryController,
          hint: 'Enter your country',
        ),
        _inputField(
          label: 'Landmark',
          maxNumbers: 100,
          inputType: TextInputType.name,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedLocation10,
          controller: _landmarkController,
          hint: 'Enter a nearby landmark',
        ),



        //Church Information
        _inputField(
          label: 'Previous Church',
          maxNumbers: 100,
          inputType: TextInputType.name,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedChurch,
          controller: _previousChurchController,
          hint: 'Enter your previous church name',
        ),
        _dropdownField(
          label: 'Service Language',
          value: _selectedServiceLanguage,
          items: [
            'English',
            'Spanish',
            'French',
            'German',
            'Hindi',
            'Tamil'
          ].map((String value) {
            return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
          _selectedServiceLanguage = newValue!;
            });
          },
        ),
        _dropdownField(
          label: 'Attending Time',
          value: _selectedAttendingTime,
          items: ['morning', 'evening'].map((String value) {
            return DropdownMenuItem<String>(
          value: value,
          child: Text(
              value.substring(0, 1).toUpperCase() + value.substring(1)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
          _selectedAttendingTime = newValue!;
            });
          },
        ),


//Marital Status
        _dropdownField(
          label: 'Marital Status',
          value: _selectedMaritalStatus,
          items: [
            'single',
            'married',
            'engaged',
            'separated',
            'divorced',
            'widow'
          ].map((String value) {
            return DropdownMenuItem<String>(
          value: value,
          child: Text(
              value.substring(0, 1).toUpperCase() + value.substring(1)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
          _selectedMaritalStatus = newValue!;
          if (_selectedMaritalStatus != 'married') {
            isMarried = false;
            _spouseController.text = '';
            _anniversaryDateController.text = '2000-01-01';
          }
            });
          },
        ),
       
        // if (_selectedMaritalStatus == 'married') ...[
          _selectedMaritalStatus == 'married'? SearchableDropdown(
            label: 'Spouse Name',
            selectedValue: _selectedSpouse!,
            items: userList,
            onChanged: (int newValue) {
          setState(() {
            _selectedSpouse = newValue;
          });
            },
          ):SizedBox(),
          _selectedMaritalStatus == 'married'? _dateInputField(
            label: 'Anniversary Date',
            icon: HugeIcons.strokeRoundedCheeseCake01,
            controller: _anniversaryDateController,
            hint: 'Select anniversary date',
          ):SizedBox(),
        // ],



        // _inputField(
        //   label: 'Password',
        //   maxNumbers: 12,
        //   inputType: TextInputType.visiblePassword,
        //   inputAction: TextInputAction.next,
        //   icon: HugeIcons.strokeRoundedLockPassword,
        //   controller: _passwordController,
        //   isPassword: true,
        //   hint: 'Create a password',
        // ),

        _dateInputField(
          label: 'Joined Date',
          icon: HugeIcons.strokeRoundedCalendar02,
          controller: _joinedDateController,
          hint: 'Select when you joined',
        ),
        // _dropdownField(
        //   label: 'Role',
        //   value: _selectedRole,
        //   items: [
        //     'user',
        //     'member',
        //     'admin',
        //     'student',
        //     'pastor',
        //     'staff',
        //     'choir'
        //   ].map((String value) {
        //     return DropdownMenuItem<String>(
        //   value: value,
        //   child: Text(value),
        //     );
        //   }).toList(),
        //   onChanged: (String? newValue) {
        //     setState(() {
        //   _selectedRole = newValue!;
        //     });
        //   },
        // ),

        // Additional Information Section

        _dropdownField(
          label: 'Out Of Station',
          value: _selectedSocialStatus,
          items: [
            'yes',
            'no',
          ].map((String value) {
            return DropdownMenuItem<String>(
          value: value,
          child: Text(
              value.substring(0, 1).toUpperCase() + value.substring(1)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
          _selectedSocialStatus = newValue!;
            });
          },
        ),


       


        _dropdownField(
          label: 'House Type',
          value: _selectedHouseType,
          items: ['owned', 'rented'].map((String value) {
            return DropdownMenuItem<String>(
          value: value,
          child: Text(
              value.substring(0, 1).toUpperCase() + value.substring(1)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
          _selectedHouseType = newValue!;
            });
          },
        ),

        _inputField(
          label: 'Hobbies',
          maxNumbers: 100,
          inputType: TextInputType.text,
          inputAction: TextInputAction.next,
          icon: HugeIcons.strokeRoundedWorkoutSport,
          controller: _hobbiesController,
          hint: 'Enter your hobbies',
        ),

        SearchableDropdown(
          label: 'Zone',
          selectedValue: _selectedZone,
          items: zoneList,
          onChanged: (int newValue) {
            setState(() {
          _selectedZone = newValue;
            });
          },
        ),


        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20),
        //     border: Border.all(color: Colors.grey.shade300, width: 1),
        //   ),
        //   margin: EdgeInsets.symmetric(vertical: 10),
        //   height: 300,
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(20),
        //     child: GoogleMap(
        //   initialCameraPosition: CameraPosition(
        //     target:
        //     LatLng(13.0843, 80.2705), // Default location (Chennai)
        //     zoom: 14,
        //   ),
        //   onMapCreated: (controller) {
        //     _mapController = controller;
        //   },
        //   onTap: _onMapTapped,
        //   markers: _selectedLocation != null
        //       ? {
        //       Marker(
        //         markerId: MarkerId("selected-location"),
        //         position: _selectedLocation!,
        //       )
        //     }
        //       : {},
        //   myLocationEnabled: true,
        //   myLocationButtonEnabled: true,
        //   zoomControlsEnabled: true,
        //     ),
        //   ),
        // ),
        // if (_selectedLocation != null)
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text(
        //   "Selected Location: \nLat: ${_selectedLocation!.latitude.toStringAsFixed(6)}, Lng: ${_selectedLocation!.longitude.toStringAsFixed(6)}",
        //   textAlign: TextAlign.center,
        //   style: GoogleFonts.manrope(
        //     fontSize: 14,
        //     color: Colors.black87,
        //   ),
        //     ),
        //   ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 8.0),
        //   child: Row(
        //     children: [
        //   Checkbox(
        //     value: _isPrimaryAddress,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(5),
        //     ),
        //     onChanged: (bool? value) {
        //       setState(() {
        //     _isPrimaryAddress = value!;
        //       });
        //     },
        //     activeColor: Color(0xff7C3AED),
        //   ),
        //   Text(
        //     'Set as Primary Address',
        //     style: GoogleFonts.manrope(
        //       fontSize: 16,
        //       color: Colors.black,
        //     ),
        //   ),
        //     ],
        //   ),
        // ),



        // Church Information Section

        _dateInputField(
          label: 'Last Blood Donated Date',
          icon: HugeIcons.strokeRoundedGiveBlood,
          controller: _lastDonatedDateController,
          hint: 'Select last blood donation date',
        ),
        // SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff7C3AED),
            minimumSize: Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Sign Up',
            style: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
            ),
          ),
        ),
          ]),
        ),
      ),
      
    );

  }



  List<Widget> _buildFormRows(List<Widget> fieldsData) {
    List<Widget> rows = [];
    int i = 0;

    // Helper function to add rows dynamically
    void addRows(int maxFieldsPerRow, int endIndex, String sectionHeader) {
      rows.add(_sectionHeader(sectionHeader));
      rows.add(const SizedBox(height: 10));

      while (i < endIndex) {
        List<Widget> rowChildren = [];
        int count = 0;
        for (; i < endIndex && count < maxFieldsPerRow; i++, count++) {
          rowChildren.add(
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: fieldsData[i],
              ),
            ),
          );
          if (count < maxFieldsPerRow - 1) {
            rowChildren.add(const SizedBox(width: 15)); // Add spacing between fields
          }
        }
        if (rowChildren.isNotEmpty) {
          rows.add(
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rowChildren,
            ),
          );
          rows.add(const SizedBox(height: 15)); // Add spacing after each row
        }
      }
      rows.add(const SizedBox(height: 20));
    }

    // Add sections with respective field counts
        addRows(3, 3, 'User Details');

    addRows(3, 11, 'Personal Information');
    
    addRows(3, 20, 'Professional Information');
    addRows(2, 23, 'Family Information');
    addRows(3, 31, 'Address Information');
    addRows(3, 33, 'Church Information');

    addRows(3, 37, 'Marital Information');
    addRows(3, fieldsData.length, 'Oher Information');

    return rows;
  }
  Widget  _sectionHeader(String title) {
    return Align(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xff7C3AED),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String label,
    required int? maxNumbers,
    required TextInputType inputType,
    required TextInputAction inputAction,
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
    bool isErrorText = false ,
    bool isNumericOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isNumericOnly ? TextInputType.number : inputType,
        textInputAction: inputAction,
        style: GoogleFonts.manrope(
          fontSize: 16,
          color: Colors.black,
        ),
        maxLength: maxNumbers,
        cursorColor: Color(0xff7C3AED),
        inputFormatters: isNumericOnly
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        onChanged: (value) {
          if (inputType == TextInputType.emailAddress) {
            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
            setState(() {
              isErrorText = !emailRegex.hasMatch(value);
            });
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
          ),
          
          errorText: isErrorText ? 'Invalid Email Address' : null,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red, width: 0.8), // Error Red border color
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.red, width: 1.5), // Error Red border on focus
            borderRadius: BorderRadius.circular(10),
          ),
          hoverColor: Colors.transparent,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xff635bff), width: 1.5), // Focused border color
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey.shade400, width: 0.8), // Default border color
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hint,
          hintStyle: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _dateInputField({
    required String label,
    required IconData icon,
    required String hint,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () => _selectDate(context, controller),
        style: GoogleFonts.manrope(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff7C3AED), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelStyle: GoogleFonts.manrope(color: Colors.grey),
          prefixIcon: Icon(icon, color: Colors.grey),
          // suffixIcon:
          //     Icon(HugeIcons.strokeRoundedCalendar03, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _dropdownField({
    required String label,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
    bool smallWidget = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
       
        value: value,
        onChanged: onChanged,
        borderRadius: BorderRadius.circular(10),
        decoration: InputDecoration(
                    labelText: label,

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff635bff),
              width: smallWidget ? 0.5 : 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
            
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey,
              width: smallWidget ? 0.5 : 2.0,
            ),
          ),
        ),
        dropdownColor: Colors.white,
        style: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        items: items,
      ),
    );
  }

  

  Widget _radioButtonGroup({
    required String groupValue,
    required List<String> labels,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: labels.map((label) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Radio<String>(
                  value: label,
                  groupValue: groupValue,
                  onChanged: onChanged,
                  activeColor: Color(0xff7C3AED),
                ),
                Text(
                  label.substring(0, 1).toUpperCase() + label.substring(1),
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}