import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

import 'model/PasterProfile.dart';

Color primaryBlue = Color(0xFF635BFF);
Color secondaryBlue = Color.fromARGB(255, 123, 116, 250);

/*final List<Map<String, dynamic>> menuData = [
  {
    'title': 'Church Database',
    'items': [
      'User List',
      'Members List',
      'Families',
      'Little Flocks',
      'Student',
      'Committee',
      'Pastors',
      'Church Staff',
      'Department',
    ],
  },
];*/
/*final List<Map<String, dynamic>> tableData = [
  {
    'user': 'Vijay',
    'profilePicture': 'assets/avatar1.png',
    'project': 'Actor',
    'users':  'assets/avatar2.png',
    'status': 'Active',
    'date': '2023-09-13',
    'time': '04:15 PM',
    'amount': '100.00',
    'month' : 'Aug 2024',
    'paymentMode': 'upi',
  },
  {
    'user': 'Boopathi',
    'profilePicture': 'assets/avatar2.png',
    'project': 'Sales',
    'users': 'assets/avatar4.png',
    'status': 'Cancel',
    'date': '2023-09-14',
    'time': '12:30 PM',
    'amount': '500.00',
    'month' : 'Jun 2022',
    'paymentMode': 'cash',
  },
  {
    'user': 'Syed',
    'profilePicture': 'assets/avatar3.png',
    'project': 'Developer',
    'users': 'assets/avatar3.png',
    'status': 'Active',
    'date': '2023-09-15',
    'time': '10:00 AM',
    'amount': '250.00',
    'month' : 'Nov 2023',
    'paymentMode': 'card',
  },
  {
    'user': 'Hariharan',
    'profilePicture': 'assets/avatar4.png',
    'project': 'Developer',
    'users': 'assets/avatar4.png',
    'status': 'Pending',
    'date': '2023-09-12',
    'time': '08:45 AM',
    'amount': '300.00',
    'month' : 'Nov 2021',
    'paymentMode': 'card',
  },
];*/
/*final List<Map<String, dynamic>> mainTableData = [
  {
    'user': 'Hariharan',
    'profilePicture': 'assets/Person Image.png',
    'date': '2023-09-12',
    'time': '08:45 AM',
    'amount': '300.00',
    'month' : 'Nov 2021',
    'paymentMode': 'card',
  },
  {
    'user': 'Vijay',
    'profilePicture': 'assets/Person Image.png',
    'date': '2023-09-15',
    'time': '10:00 AM',
    'amount': '250.00',
    'month' : 'Nov 2023',
    'paymentMode': 'card',
  },
  {
    'user': 'Boopathi',
    'profilePicture': 'assets/Person Image.png',
    'date': '2023-09-14',
    'time': '12:30 PM',
    'amount': '500.00',
    'month' : 'Jun 2022',
    'paymentMode': 'cash',
  },
  {
    'user': 'Syed',
    'profilePicture': 'assets/Person Image.png',
    'date': '2023-09-13',
    'time': '04:15 PM',
    'amount': '100.00',
    'month' : 'Aug 2024',
    'paymentMode': 'upi',
  },
];*/

final Map<String, Color> statusColors = {
  'Active': Color(0xFF7876FA),
  'Pending': Color(0xFF86C690),
  'Cancel': Color(0xFFFF89A7),
  'upi': Colors.grey,
  'card': Colors.indigoAccent,
  'cash': Colors.greenAccent,
  'bank': Colors.deepOrangeAccent,
  'cheque': Colors.cyanAccent,
};

final List<String> columnHeaders = [
  'User',
  'Date',
  'Amount',
  'Status',
  'Option'
];

final List<Map<String, dynamic>> rowData = [
  {
    'user': 'Vijay',
    'date': '2023-09-15',
    'amount': 250.00,
    'status': 'Active',
    'profilePicture': 'assets/Person Image.png'
  },
  {
    'user': 'Boopathi',
    'date': '2023-09-14',
    'amount': 500.00,
    'status': 'Pending',
    'profilePicture': 'assets/Person Image.png'
  },
  {
    'user': 'Syed',
    'date': '2023-09-13',
    'amount': 100.00,
    'status': 'Cancelled',
    'profilePicture': 'assets/Person Image.png'
  },
  {
    'user': 'Syed',
    'date': '2023-09-13',
    'amount': 100.00,
    'status': 'Cancelled',
    'profilePicture': 'assets/Person Image.png'
  },
  {
    'user': 'Syed',
    'date': '2023-09-13',
    'amount': 100.00,
    'status': 'Cancelled',
    'profilePicture': 'assets/Person Image.png'
  },
];

/*final List<Map<String, dynamic>> testData = [
{
  "header":{ "s.no", "name", "dob" ,"members" ,"conatct" ,"email" ,""},
  "dataType":{"Text","profileImageAndText","Text","profileImages","Text","Text","actionButton"},
  "data":{
    {'user': 'Vijay', "profileImage":{"name":"Udayakumar","imageUrl":"https://test.com/udaya.png"},'date': '2023-09-15', 'amount': 250.00, 'status': 'Active','profilePicture': 'assets/Person Image.png'},
    {'user': 'Boopathi', 'date': '2023-09-14', 'amount': 500.00, 'status': 'Pending','profilePicture': 'assets/Person Image.png'},
    {'user': 'Syed', 'date': '2023-09-13', 'amount': 100.00, 'status': 'Cancelled','profilePicture': 'assets/Person Image.png'},
    {'user': 'Syed', 'date': '2023-09-13', 'amount': 100.00, 'status': 'Cancelled','profilePicture': 'assets/Person Image.png'},
    {'user': 'Syed', 'date': '2023-09-13', 'amount': 100.00, 'status': 'Cancelled','profilePicture': 'assets/Person Image.png'},
  }

}
];*/
final List<Map<String, dynamic>> testData = [
  {
    "header": [
      "User",
      "Date",
      "Amount",
      "UserList",
      'other',
      'Status',
      "Action"
    ],
    "dataType": [
      "UserNameWithProfile",
      "Date",
      "Amount",
      "UserList",
      'other',
      'Status',
      "ActionButton",
    ],
    "data": [
      {
        "User": {"name": "Vijay", "imageUrl": "assets/Person Image.png"},
        "Date": "2023-09-15",
        "Amount": 1290,
        "UserList": [
          'assets/ProfileImage1.jpeg',
          'assets/ProfileImage2.jpeg',
          'assets/Person Image.png'
        ],
        'other': 2,
        'Status': 'Pending',
        "Action": 'Action'
      },
      {
        "User": {"name": "Ravi", "imageUrl": "assets/Person Image.png"},
        "Date": "2023-09-16",
        "Amount": 1000,
        "UserList": [
          'assets/Person Image.png',
          'assets/ProfileImage1.jpeg',
          'assets/ProfileImage2.jpeg'
        ],
        "other": 0,
        'Status': 'Active',
        "Action": 'Payment',
      },
      {
        "User": {"name": "Ajay", "imageUrl": "assets/Person Image.png"},
        "Date": "2023-09-15",
        "Amount": 1200,
        "UserList": [
          'assets/Person Image.png',
          'assets/ProfileImage1.jpeg',
        ],
        'other': 2,
        'Status': 'Pending',
        "Action": 'Action',
      },
      {
        "User": {"name": "Kumar", "imageUrl": "assets/Person Image.png"},
        "Date": "2023-09-15",
        "Amount": 1790,
        "UserList": ['assets/Person Image.png'],
        'other': 2,
        'Status': 'Cancel',
        "Action": 'Payment',
      },
      {
        "User": {"name": "Velu", "imageUrl": "assets/Person Image.png"},
        "Date": "2023-09-15",
        "Amount": 18960,
        "UserList": [
          'assets/ProfileImage1.jpeg',
          'assets/ProfileImage2.jpeg',
        ],
        'other': 2,
        'Status': 'Active',
        "Action": 'Action',
      },
      {
        "User": {"name": "Kumar", "imageUrl": "assets/Person Image.png"},
        "Date": "2023-09-15",
        "Amount": 1790,
        "UserList": [
          'assets/ProfileImage1.jpeg',
          'assets/ProfileImage2.jpeg',
          'assets/Person Image.png'
        ],
        'other': 2,
        'Status': 'Cancel',
        "Action": 'Payment',
      },
    ],
  }
];

//Membership Data
final List<Map<String, dynamic>> MembershipData = [
  {
    "header": ["User", "Date", "Amount", 'Month', 'Payment Mode', "Action"],
    "dataType": [
      "UserNameWithProfile",
      "Date",
      "Text",
      'Text',
      'Status',
      "Action",
    ],
    "data": [
      {
        "User": {"name": "Vijay", "imageUrl": "assets/Person Image.png"},
        "Date": "2023-09-15 11:39:28",
        "Amount": 1290,
        "Month": 'Nov 2025',
        'Payment Mode': 'upi',
        "Action": 'Action'
      },
      {
        "User": {"name": "Ravi", "imageUrl": "assets/Person Image.png"},
        "Date": "2023-09-16 19:31:02",
        "Amount": 1000,
        "Month": 'Nov 2025',
        'Payment Mode': 'card',
        "Action": 'Action',
      },
      {
        "User": {"name": "Ajay", "imageUrl": "assets/Person Image.png"},
        "Date": "2023-09-15 01:12:22",
        "Amount": 1200,
        "Month": 'Nov 2025',
        'Payment Mode': 'cash',
        "Action": 'Action',
      },
      {
        "User": {"name": "Kumar", "imageUrl": "assets/Person Image.png"},
        "Date": "2023-09-15 21:13:45",
        "Amount": 1790,
        "Month": 'Nov 2025',
        'Payment Mode': 'card',
        "Action": 'Action',
      },
      {
        "User": {"name": "Velu", "imageUrl": "assets/Person Image.png"},
        "Date": "2023-09-15 17:46:19",
        "Amount": 18960,
        "Month": 'Nov 2025',
        'Payment Mode': 'upi',
        "Action": 'Action',
      },
      // {
      //   "User": {"name": "Kumar", "imageUrl": "assets/Person Image.png"},
      //   "Date": "2023-09-15 11:34:35",
      //   "Amount": 1790,
      //   "Month":'Nov 2025',
      //   'Payment Mode':'cash',
      //   "Action": 'Action',
      // },
    ],
  }
];

//Fund_Management
final List<Map<String, dynamic>> FundRecordsData = [
  {
    "header": [
      "No",
      "Amount",
      'Verifier',
      'Source',
      "Record Type",
      "Document",
      "Action"
    ],
    "dataType": [
      "Text",
      "Text",
      'Text',
      'Text',
      "Record Type",
      "Text",
      "Action"
    ],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Amount": [1000, 1200, 1790, 18960, 1790][index],
              "Verifier": ['Anbu', 'Raju', 'Anbu', 'Raju', 'Jhon'][index],
              "Source": [
                'Anbu Trust',
                'Raju Trust',
                'Anbu Trust',
                'Trust Jhon',
                'Raju Trust'
              ][index],
              "Record Type": [
                'Receivable',
                'Receivable',
                'Receivable',
                'Receivable',
                'Expense'
              ][index],
              "Document": [
                'Document',
                '',
                '',
                '',
                '',
              ][index],
              "Action": 'Action',
            }),
  }
];

//Donations
final List<Map<String, dynamic>> DonationsData = [
  {
    "header": ["No", "Date", "Amount", 'Source', "Cheque/Bank", "Action"],
    "dataType": ["Text", "Date", 'Text', 'Text', "Status", "Action"],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Date": [
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
              ][index],
              "Amount": [1000, 1200, 1790, 18960, 1790, 2500][index],
              "Source": [
                'Anbu',
                'Raju',
                'Rahul',
                'Jhon',
                'Deepak',
                'Trust'
              ][index],
              "Cheque/Bank": [
                'bank',
                'upi',
                'cheque',
                'upi',
                'bank',
                'upi'
              ][index],
              "Action": 'Action',
            }),
  }
];

//AssetsManagement
final List<Map<String, dynamic>> AssetData = [
  {
    "header": [
      "No",
      "Date",
      "Amc Date",
      'Assets',
      "Approximate Value",
      "Note",
      "Action"
    ],
    "dataType": ["Text", "Date", 'Date', 'Text', 'Text', "Status", "Action"],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Date": [
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
              ][index],
              "Amc Date": [
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
              ][index],
              "Assets": [
                'Fan',
                'Aa',
                'Ad',
                'Good Wood',
                'Desktop',
                'Trust'
              ][index],
              "Approximate Value": [1000, 1200, 1790, 18960, 1790, 2500][index],
              "Note": ['bank', 'upi', 'cheque', 'bank', 'upi', 'cheque'][index],
              "Action": 'Action',
            }),
  }
];

//EmailCommunication
final List<Map<String, dynamic>> EmailData = [
  {
    "header": ["No", "To", "Subject", 'Content', "Action"],
    "dataType": ["Text", "Text", 'Text', 'Text', "Action"],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "To": [
                '',
                'sandeep.ar69@gmail.com',
                'gnshealth@gmail.com',
                '',
                '',
                '@gmail.com',
              ][index],
              "Subject": [
                'subject',
                'hello',
                'hi',
                '',
                '',
                '',
              ][index],
              "Content": [
                'hello',
                'Aa',
                'Ad',
                'Good',
                'Desktop',
                'hello'
              ][index],
              "Action": 'Action',
            }),
  }
];

//EngagementNotifications
final List<Map<String, dynamic>> NotificationData = [
  {
    "header": ["No", "Date", "Time", "Subject", 'Content', "View"],
    "dataType": ["Text", "Date", 'Date', 'Text', "Text", "Text"],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Date": [
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
              ][index],
              "Time": [
                '08:12am',
                '22:54pm',
                '14:25pm',
                '19:36pm',
                '05:25am',
                '00:30pm',
              ][index],
              "Subject": [
                'subject',
                'hello',
                'hi',
                '',
                '',
                '',
              ][index],
              "Content": [
                'hello',
                'Aa',
                'Ad',
                'Good',
                'Desktop',
                'hello'
              ][index],
              "View": [3, 4, 2, 1, 4, 2][index],
            }),
  }
];

//SmsCommunicationTable
final List<Map<String, dynamic>> SmsCommunicationData = [
  {
    "header": ["No", "Time", "Subject", 'Message', "UserCount", "Action"],
    "dataType": ["Text", "Text", 'Text', 'Text', "Text", "Action"],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Time": [
                '08:12am',
                '2:54pm',
                '4:25pm',
                '1:36pm',
                '05:25am',
                '01:30pm',
              ][index],
              "Subject": [
                'subject',
                'hello',
                'church',
                'hello',
                'lord',
                'hello lord',
              ][index],
              "Message": [
                'hello',
                'Aa',
                'Ad',
                'Good',
                'Desktop',
                'hello'
              ][index],
              "UserCount": [3, 4, 2, 1, 4, 2][index],
              "Action": 'Action',
            }),
  }
];

//add the filter in this table //EngagementBloodGroup
final List<Map<String, dynamic>> BloodData = [
  {
    "header": ["No", "Name", "Phone", "Blood Group", 'Address'],
    "dataType": ["Text", "Text", 'Text', 'Text', "Text", "Text"],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Name": [
                'Sam',
                'jeba',
                'Sai',
                '',
                '',
                '',
              ][index],
              "Phone": [
                '9876543120',
                '9865327410',
                '7845129863',
                '',
                '',
                '852941367',
              ][index],
              "Blood Group": [
                'O-',
                '',
                'O+',
                'O-',
                '',
                'O+',
              ][index],
              "Address": ['salai', 'Anna', 'Nagar', '', '', ''][index],
            }),
  }
];

//Blog
final List<Map<String, dynamic>> BlogData = [
  {
    "header": [
      "No",
      "Title",
      "Description",
      "Date",
      'Like',
      "Author/Writer/Speaker",
      "Action"
    ],
    "dataType": ["Text", "Text", 'Text', 'Date', "Icon", "Text", "Action"],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Title": [
                'Top Apps Every ',
                ' Every Christian',
                '',
                'Top Apps Every',
                '',
                ' Every Christian',
              ][index],
              "Description": [
                'Tell your audience ',
                '',
                'Tell your audience',
                '',
                'Tell your',
                '',
              ][index],
              "Date": [
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
              ][index],
              "Like": [3, 4, 4, 3, 1, 5][index],
              "Author/Writer/Speaker": [
                'Sam',
                'jeba',
                'Sai',
                '',
                '',
                '',
              ][index],
              "Action": 'Action',
            }),
  }
];

//Testimony and Paryers,
final List<Map<String, dynamic>> TestimonyData = [
  {
    "header": ["No", "Title", "Date", "Description", "Action"],
    "dataType": ["Text", "Text", 'Date', "Text", "Action"],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Title": [
                'subject',
                'hello',
                'hi',
                '',
                '',
                '',
              ][index],
              "Date": [
                '2023-09-15 11:34:35',
                '2023-09-15 17:46:19',
                '2023-09-15 21:13:45',
                '2023-09-15 01:12:22',
                '2023-09-16 19:31:02',
                '2023-09-15 11:39:28',
              ][index],
              "Description": [
                'Tell your audience about',
                '',
                'Tell your audience about the best',
                '',
                'Tell your audience about the',
                '',
              ][index],
              "Action": 'verify',
            }),
  }
];

//Event Management
final List<Map<String, dynamic>> EventManagementData = [
  {
    "header": [
      "No",
      "Event",
      "Date",
      "View",
      "Registered Users",
      "Location",
      "Description",
      "Action"
    ],
    "dataType": [
      "Text",
      "UserList",
      'Date',
      "Text",
      "Icon",
      "Text",
      "Text",
      "Action"
    ],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Event": [
                ['assets/Person Image.png'],
                ['assets/Person Image.png'],
                ['assets/Person Image.png'],
                ['assets/Person Image.png'],
                ['assets/Person Image.png'],
                ['assets/Person Image.png'],
              ][index],
              "Date": [
                '2023-09-15 11:34:35',
                '2023-09-15 17:46:19',
                '2023-09-15 21:13:45',
                '2023-09-15 01:12:22',
                '2023-09-16 19:31:02',
                '2023-09-15 11:39:28',
              ][index],
              "View": [3, 0, 4, 0, 0, 0][index],
              "Registered Users": [3, 4, 4, 3, 1, 5][index],
              "Location": ['Kilpauk', '', 'cc', 'Chennai', '', 'bb'][index],
              "Description": [
                'Tell your ',
                '',
                'Tell',
                '',
                'Tell ',
                '',
              ][index],
              "Action": 'Action',
            }),
  }
];

//Notices
final List<Map<String, dynamic>> NoticesData = [
  {
    "header": ["No", "Title", "Description", "Action"],
    "dataType": ["Text", "Text", "Text", "Action"],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Title": [
                'subject',
                'hello',
                'hi',
                '',
                '',
                '',
              ][index],
              "Description": [
                'Tell your audience about the best apps that can help bring',
                '',
                'Tell your audience about the best apps that can help bring',
                '',
                'Tell your audience about the best apps that can help',
                '',
              ][index],
              "Action": 'verify',
            }),
  }
];

//Function Hall
final List<Map<String, dynamic>> FunctionHallData = [
  {
    "header": ["Title", "Date", "From", 'To', "Action"],
    "dataType": ["Text", 'Date', "Date", 'Date', "Action"],
    "data": List.generate(
        5,
        (index) => {
              "Title": [
                'subject',
                'hello',
                'hi',
                'subject',
                'hello',
              ][index],
              "Date": [
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
              ][index],
              "From": [
                '08:12am',
                '22:54pm',
                '14:25pm',
                '22:54pm',
                '14:25pm',
                '22:54pm',
              ][index],
              "To": [
                '2023-09-15 11:34:35',
                '2023-09-15 17:46:19',
                '2023-09-15 21:13:45',
                '2023-09-15 17:46:19',
                '2023-09-15 21:13:45',
              ][index],
              "Action": 'verify',
            }),
  }
];

//Audio Podcast
final List<Map<String, dynamic>> AudioPodcastData = [
  {
    "header": ["Title", 'Vocal', 'Volume', "Date/Time", "Action"],
    "dataType": ["Text", 'Text', "Text", 'Date', "Action"],
    "data": List.generate(
        5,
        (index) => {
              "Title": [
                'subject',
                'hello',
                'hi',
                'subject',
                'hello',
              ][index],
              "Vocal": [
                'subject',
                'hello',
                'hi',
                'subject',
                'hello',
              ][index],
              "Volume": [
                'subject',
                'hello',
                'hi',
                'subject',
                'hello',
              ][index],
              "Date/Time": [
                '2023-09-15 11:34:35',
                '2023-09-15 17:46:19',
                '2023-09-15 21:13:45',
                '2023-09-15 21:13:45',
                '2023-09-15 21:13:45',
              ][index],
              "Action": 'verify',
            }),
  }
];

//Remembrance Days
final List<Map<String, dynamic>> RemembranceData = [
  {
    "header": ["No", 'Name', 'Description', "Date", "Action"],
    "dataType": ["Text", 'Text', "Text", 'Date', "Action"],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Title": [
                'subject',
                'hello',
                'hi',
                'subject',
                'hello',
              ][index],
              "Name": [
                'subject',
                'hello',
                'hi',
                'subject',
                'hello',
              ][index],
              "Description": [
                'subject',
                'hello',
                'hi',
                'subject',
                'hello',
              ][index],
              "Date": [
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
                '2023-09-15',
              ][index],
              "Action": 'Action',
            }),
  }
];

//userlist
final List<Map<String, dynamic>> userList_Table = [
  {
    "header": ['No', 'Name', 'Phone', 'Pin Code', 'Status', 'Action'],
    "dataType": [
      "Text",
      "UserNameWithProfile",
      "Text",
      "Text",
      "Status",
      "Action"
    ],
    "data": [
      {
        "No": 1,
        "Name": {
          "name": "Jones",
          "profilePictures": "assets/ProfileImage1.jpeg"
        },
        'Phone': '9876504321',
        'Pin Code': '6000300',
        "Status": 'Active',
        "Action": 'Action',
      },
      {
        "No": 2,
        "Name": {
          "name": "Hari",
          "profilePictures": "assets/ProfileImage2.jpeg"
        },
        'Phone': '9876504321',
        'Pin Code': '6000300',
        "Status": 'Pending',
        "Action": 'Action',
      },
      {
        "No": 3,
        "Name": {
          "name": "Jaya",
          "profilePictures": "assets/ProfileImage1.jpeg"
        },
        'Phone': '9876504321',
        'Pin Code': '6000300',
        "Status": 'Cancel',
        "Action": 'Action',
      },
      {
        "No": 4,
        "Name": {"name": "Ram", "profilePictures": "ProfileImage2.jpeg"},
        'Phone': '9876503201',
        'Pin Code': '6000300',
        "Status": 'Active',
        "Action": 'Action',
      },
      {
        "No": 5,
        "Name": {"name": "Siva", "profilePictures": "assets/avatar1.png"},
        'Phone': '9876566666',
        'Pin Code': '6000765',
        "Status": 'Active',
        "Action": 'Action',
      },
    ],
  }
];

final List<Map<String, dynamic>> actionButtons = [
  {
    'label': 'View',
    'icon': HugeIcons.strokeRoundedView,
  },
  {
    'label': 'Edit',
    'icon': HugeIcons.strokeRoundedPencilEdit01,
  },
  {
    'label': 'Delete',
    'icon': HugeIcons.strokeRoundedDelete02,
  }
];

final List<String> listofImage = [
  'assets/ProfileImage2.jpeg',
  'assets/ProfileImage1.jpeg',
  'assets/Person Image.png',
];

final List<Map<String, dynamic>> productList = [
  {
    "productName": "Sample",
    "price": 120.0,
    "originalPrice": 150.0,
    "rating": 4,
    "images": "assets/ProfileImage2.jpeg",
  },
  {
    "productName": "Sneakers",
    "price": 100.0,
    "originalPrice": 130.0,
    "rating": 5,
    "images": "assets/ProfileImage1.jpeg",
  },
  {
    "productName": "Sport",
    "price": 90.0,
    "originalPrice": 110.0,
    "rating": 3,
    "images": "assets/Item2.jpg",
  },
  {
    "productName": "Sample",
    "price": 120.0,
    "originalPrice": 150.0,
    "rating": 4,
    "images": "assets/ProfileImage2.jpeg",
  },
  {
    "productName": "Sneakers",
    "price": 100.0,
    "originalPrice": 130.0,
    "rating": 5,
    "images": "assets/ProfileImage1.jpeg",
  },
  {
    "productName": "Sport",
    "price": 90.0,
    "originalPrice": 110.0,
    "rating": 3,
    "images": "assets/Item1.jpg",
  },
  {
    "productName": "Sample",
    "price": 120.0,
    "originalPrice": 150.0,
    "rating": 4,
    "images": "assets/ProfileImage2.jpeg",
  },
  {
    "productName": "Sneakers",
    "price": 100.0,
    "originalPrice": 130.0,
    "rating": 5,
    "images": "assets/Item1.jpg",
  },
  {
    "productName": "Sport",
    "price": 90.0,
    "originalPrice": 110.0,
    "rating": 3,
    "images": "assets/Item2.jpg",
  },
];

//manage role Admin data
Map<String, dynamic> mainTableData = {
  "Options": [
    "Dashboard",
    "Gallery",
    "Reports",
    'MemberShip List',
    'Families',
    'Flocks',
    'Student',
    'Committee',
    'Pastors',
    'ChurchStaff'
  ],
};

//manage role data
final List<Map<String, dynamic>> wrapValue = [
  {
    "name": 'Modules',
    'Value': ['Dashboard', 'Gallery', 'Reports'],
  },
  {
    "name": 'Church Database ',
    'Value': [
      'Users',
      'Membership List',
      'Families',
      'Flocks',
      'Student',
      'Committee',
      'Pastors',
      'ChurchStaff',
      'Department',
    ],
  },
  {
    "name": 'Membership ',
    'Value': [
      'MemberShip Reports ',
      'Membership Register',
    ],
  },
  {
    "name": 'Finance ',
    'Value': ['Fund Management', 'Donations', 'Assets Management', 'Flocks'],
  },
  {
    "name": 'Engagement ',
    'Value': [
      'Wishes',
      'Sms Com',
      'Email Com',
      'Notifications',
      'Blood',
      'Blog',
      'Social Media'
    ],
  },
  {
    "name": 'Church Tools ',
    'Value': [
      'Speech',
      'Testimony',
      'Prayers',
      'Meetings',
      'Event',
      'Remembrance Days',
      'Announcement',
      'Function Hall',
      'Audio Podcast',
      'Certificate Generations'
    ],
  },
  {
    "name": 'Attendance',
    'Value': ['Member Attendance', 'Student Attendance'],
  },
  {
    "name": 'Security',
    'Value': ['Manage Role', 'Login Reports'],
  },
  {
    "name": 'Zone Activities',
    'Value': ['Zone Areas', 'Zone List', 'Zone Reports'],
  },
  {
    "name": 'Ecommerce',
    'Value': [
      'Products',
      'Orders',
    ],
  },
];

//Login Reports
final List<Map<String, dynamic>> Login_Reports = [
  {
    "header": [
      'No',
      'Device Os',
      'Device ID',
      'IP Address',
      'Location',
      'Date'
    ],
    "dataType": ['Text', 'Text', 'Text', 'Text', 'Text', 'Text'],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Device Os": [
                'Windows',
                'Windows',
                'Phone',
                'Phone',
                'Windows'
              ][index],
              "Device ID": [
                'Browser',
                'App',
                'Browser',
                'App',
                'Browser'
              ][index],
              "IP Address": [
                '9876545678',
                '7890654323',
                '8907652341',
                '6578902341',
                '8779308489'
              ][index],
              "Location": [
                'Chennai',
                'Chennai',
                'Chennai',
                'Chennai',
                'Chennai'
              ][index],
              "Date": [
                '2023-09-15',
                '2023-10-31',
                '2025-03-15',
                '2023-09-15',
                '2020-11-01'
              ][index],
            }),
  }
];

final List<Map<String, dynamic>> actionButtons1 = [
  {
    'label': 'AddMember',
    'icon': HugeIcons.strokeRoundedAddTeam,
  },
  {
    'label': 'ViewMember',
    'icon': HugeIcons.strokeRoundedUserGroup,
  },
  {
    'label': 'Delete',
    'icon': HugeIcons.strokeRoundedDelete02,
  }
];

//statusColors
/*final Map<String, Color> statusColors = {
  'Active': Color(0xFF4840E1),
  'Pending': Color(0xFF5DCF8B),
  'Cancel': Color(0xFFE14A78),
};*/

final List<Map<String, dynamic>> gridImage = [
  {
    "image": "assets/church2.jpg",
  },
  {
    "image": "assets/church4.jpg",
  },
  {
    "image": "assets/church5.webp",
  },
  {
    "image": "assets/church6.jpg",
  },
  {
    "image": "assets/church5.webp",
  },
  {
    "image": "assets/avatar4.png",
  }
];

final List<Map<String, dynamic>> sliderImage = [
  {
    "image": "assets/church2.jpg",
  },
  {
    "image": "assets/church4.jpg",
  },
  {
    "image": "assets/church5.webp",
  },
  {
    "image": "assets/avatar3.png",
  },
  {
    "image": "assets/church5.webp",
  },
  {
    "image": "assets/avatar4.png",
  },
  {
    "image": "assets/user.jpg",
  },
  {
    "image": "assets/avatar3.png",
  },
  {
    "image": "assets/church5.webp",
  },
  {
    "image": "assets/church6.jpg",
  },
];

//GrandientLineChat
final List<FlSpot> GrandientLineChatPoints = [
  FlSpot(0, 5),
  FlSpot(1, 10),
  FlSpot(2, 25),
  FlSpot(3, 35),
  FlSpot(4, 20),
  FlSpot(5, 30),
  FlSpot(6, 15),
  FlSpot(7, 25),
  FlSpot(8, 10),
  FlSpot(9, 20),
];

final List<MaterialColor> GrandientLineChatColors = [
  Colors.blue,
  Colors.purple,
];
// UserList

//Member_list
final List<Map<String, dynamic>> memberList_Table = [
  {
    "header": [
      'No',
      'Member ID',
      'Name',
      'Phone',
      'Pin Code',
      'Status',
      'Action'
    ],
    "dataType": [
      "Text",
      "Text",
      "UserNameWithProfile",
      "Text",
      "Text",
      "Status",
      "Action",
    ],
    "data": [
      {
        "No": 1,
        "Member ID": 'IKIA0013',
        "Name": {"name": "Jones", "profilePictures": "assets/avatar1.png"},
        'Phone': '9876504321',
        'Pin Code': '6000300',
        "Status": 'Active',
        "Action": 'Action',
      },
      {
        "No": 2,
        "Member ID": 'IKIA0014',
        "Name": {"name": "Hari", "profilePictures": "assets/avatar3.png"},
        'Phone': '9876504321',
        'Pin Code': '6000300',
        "Status": 'Pending',
        "Action": 'Action',
      },
      {
        "No": 3,
        "Member ID": 'IKIA0015',
        "Name": {"name": "Jaya", "profilePictures": "assets/avatar4.png"},
        'Phone': '9876504321',
        'Pin Code': '6000300',
        "Status": 'Cancel',
        "Action": 'Action',
      },
      {
        "No": 4,
        "Member ID": 'IKIA0016',
        "Name": {"name": "Ram", "profilePictures": "assets/avatar2.png"},
        'Phone': '9876503201',
        'Pin Code': '6000300',
        "Status": 'Active',
        "Action": 'Action',
      },
      {
        "No": 5,
        "Member ID": 'IKIA0017',
        "Name": {"name": "Siva", "profilePictures": "assets/avatar1.png"},
        'Phone': '9876566666',
        'Pin Code': '6000765',
        "Status": 'Active',
        "Action": 'Action',
      },
    ],
  }
];

//famlies
final List<Map<String, dynamic>> famlies_Table = [
  {
    "header": [
      'No',
      'Title',
      'FamilyLeader',
      'Family Count',
      'Phone',
      'Status',
      'Action'
    ],
    "dataType": [
      "Text",
      "Text",
      "Text",
      "UserList",
      "Text",
      "Status",
      "Action"
    ],
    "data": [
      {
        "No": 1,
        "Title": "JOHNSON",
        "FamilyLeader": "JOHNSON",
        "Family Count": [
          "assets/avatar4.png",
          "assets/avatar2.png",
          "assets/avatar4.png"
        ],
        'Phone': '9876504321',
        "Status": 'Active',
        "Action": 'Action',
      },
      {
        "No": 2,
        "Title": "PETTER",
        "FamilyLeader": "BARKAR",
        "Family Count": ["assets/avatar4.png", "assets/avatar2.png"],
        'Phone': '9876504321',
        "Status": 'Active',
        "Action": 'Action',
      },
      {
        "No": 3,
        "Title": "JACK",
        "FamilyLeader": "WILLIOM",
        "Family Count": [
          "assets/avatar4.png",
          "assets/avatar2.png",
          "assets/avatar4.png"
        ],
        'Phone': '9876504321',
        "Status": 'Active',
        "Action": 'Action',
      },
      {
        "No": 4,
        "Title": "JHON",
        "FamilyLeader": "CHINA",
        "Family Count": [
          "assets/avatar4.png",
          "assets/avatar2.png",
          "assets/avatar4.png"
        ],
        'Phone': '9876504321',
        "Status": 'Active',
        "Action": 'Action',
      },
      {
        "No": 5,
        "Title": "ANTONY",
        "FamilyLeader": "MARK",
        "Family Count": [
          "assets/avatar4.png",
          "assets/avatar2.png",
          "assets/avatar4.png"
        ],
        'Phone': '9876504321',
        "Status": 'Active',
        "Action": 'Action',
      },
    ],
  }
];

//Flocks
final List<Map<String, dynamic>> flocks = [
  {
    "header": ['No', 'Name', 'Action'],
    "dataType": ['Text', 'Text', 'Action'],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Name": ['Flock1', 'Flock3', 'Flock2', 'Flock6', 'Flock6'][index],
              "Action": 'Action',
            }),
  }
];

//Students
final List<Map<String, dynamic>> students_Table = [
  {
    "header": ['No', 'Name', 'class', 'Phone', 'Country', 'Action'],
    "dataType": [
      "Text",
      "UserNameWithProfile",
      "Text",
      "Text",
      "Text",
      "Action"
    ],
    "data": [
      {
        "No": 1,
        "Name": {"name": "Jeni", "profilePictures": "assets/avatar4.png"},
        "class": 'L.k.G',
        'Phone': '9876503201',
        'Country': 'America',
        "Action": 'Action',
      },
      {
        "No": 2,
        "Name": {"name": "Thomas", "profilePictures": "assets/avatar2.png"},
        "class": 'VI',
        'Phone': '9876503201',
        'Country': 'Landon',
        "Action": 'Action',
      },
      {
        "No": 3,
        "Name": {"name": "Sam", "profilePictures": "assets/avatar1.png"},
        "class": 'VII',
        'Phone': '9876503201',
        'Country': 'Indian',
        "Action": 'Action',
      },
      {
        "No": 4,
        "Name": {"name": "Jones", "profilePictures": "assets/avatar2.png"},
        "class": 'IX',
        'Phone': '9876503201',
        'Country': 'Indian',
        "Action": 'Action',
      },
      {
        "No": 5,
        "Name": {"name": "Peter", "profilePictures": "assets/avatar3.png"},
        "class": 'X',
        'Phone': '9876503201',
        'Country': 'Indian',
        "Action": 'Action',
      },
    ],
  }
];

//COMMITTEE
final List<Map<String, dynamic>> committee = [
  {
    "header": ['No', 'Name', 'Action'],
    "dataType": ['Text', 'Text', 'Action'],
    "data": List.generate(
        4,
        (index) => {
              "No": index + 1,
              "Name": [
                'NOMINATING COMMITTEES',
                'PROPERTY COMMITTEE',
                'OUT REACH COMMMITTEE',
                'SUB COMMITTEE',
                'PASTORAL RELATIONS COMMITTEE',
                'MISSION COMMITEE'
              ][index],
              "Action": 'Action',
            }),
  }
];

//pastors
final List<Map<String, dynamic>> pastors = [
  {
    "header": ['No', 'Name', 'Position', 'phone', 'Action'],
    "dataType": ['Text', 'UserNameWithProfile', 'Text', 'Text', 'Action'],
    "data": List.generate(
        4,
        (index) => {
              "No": index + 1,
              "Name": [
                {
                  "name": "Jeswin samuel",
                  "profilePictures": "assets/avatar2.png"
                },
                {"name": "Samson R", "profilePictures": "assets/avatar3.png"},
                {"name": "Kiruba K", "profilePictures": "assets/avatar1.png"},
                {
                  "name": "Francis Parker",
                  "profilePictures": "assets/avatar3.png"
                }
              ][index],
              "Position": ['CLERK', 'BUSINNESS', 'DOCTOR', 'IAS'][index],
              "phone": [
                '9876545678',
                '7890654323',
                '8907652341',
                '6578902341'
              ][index],
              "Action": 'Action',
            }),
  }
];

//churchStaff
final List<Map<String, dynamic>> churchStaff = [
  {
    "header": ['No', 'Name', 'Position', 'phone', 'Gender', 'Action'],
    "dataType": [
      'Text',
      'UserNameWithProfile',
      'Text',
      'Text',
      'Text',
      'Action'
    ],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Name": [
                {
                  "name": "Jeswin samuel",
                  "profilePictures": "assets/avatar2.png"
                },
                {"name": "Samson R", "profilePictures": "assets/avatar3.png"},
                {"name": "Kiruba K", "profilePictures": "assets/avatar1.png"},
                {
                  "name": "Francis Parker",
                  "profilePictures": "assets/avatar3.png"
                },
                {"name": "Anoo priya", "profilePictures": "assets/avatar4.png"}
              ][index],
              "Position": [
                'CLERK',
                'BUSINNESS',
                'DOCTOR',
                'IAS',
                'TESTER'
              ][index],
              "phone": [
                '9876545678',
                '7890654323',
                '8907652341',
                '6578902341',
                '8765402341'
              ][index],
              "Gender": ['Male', 'Male', 'Male', 'Male', 'Female'][index],
              "Action": 'Action',
            }),
  }
];

//Departments
final List<Map<String, dynamic>> department = [
  {
    "header": ['No', 'Title', 'Leader Name', 'contact', 'Action'],
    "dataType": ['Text', 'Text', 'Text', 'Text', 'Action'],
    "data": List.generate(
        5,
        (index) => {
              "No": index + 1,
              "Title": [
                'COLLECTIVEHOPE',
                'POWERCHURCH',
                'BRIGARE',
                'DESTINY CHURCH',
                'ONE TRUTH',
                'LIFE AND LOVE'
              ][index],
              "Leader Name": [
                'Justin',
                'Deepak',
                'Nirmal',
                'Gogul',
                'Manoj',
                'James'
              ][index],
              "contact": [
                '9876545678',
                '7890654323',
                '8907652341',
                '6578902341',
                '8765402341',
                '7890765431'
              ][index],
              "Action": 'Action',
            }),
  }
];

//Zone Area
final List<Map<String, dynamic>> zoneAreas = [
  {
    "header": ['No', 'Place', 'Action'],
    "dataType": ['Text', 'icon', 'Action'],
    "data": List.generate(
        4,
        (index) => {
              "No": index + 1,
              "Place": [
                'Asoke Nagar',
                'ThousandLights',
                'Kolathur',
                'Thambaram',
              ][index],
              "Action": 'Action',
            }),
  }
];

//Zone List
final List<Map<String, dynamic>> zoneList = [
  {
    "header": ['No', 'Zone Name', 'Total Area', 'Zone Leader', 'Action'],
    "dataType": ['Text', 'icon', 'Text', 'Text', 'Action'],
    "data": List.generate(
        4,
        (index) => {
              "No": index + 1,
              "Zone Name": [
                'Chennai Zone',
                'Kolathur Zone',
                'Thambaram Zone',
                ''
              ][index],
              "Total Area": [1, 2, 4, 5, 8][index],
              "Zone Leader": ['AMBEDKAR R', 'JACK JHON', 'JEMES', ''][index],
              "Action": 'Action',
            }),
  }
];

//overall Reports
final List<Map<String, dynamic>> zoneReports = [
  {
    "header": [
      'No',
      'Zone Name',
      'Zone Leader',
      'Assigned Date/Time',
      'Status'
    ],
    "dataType": ['Text', 'icon', 'Text', 'date', 'Status'],
    "data": List.generate(
        4,
        (index) => {
              "No": index + 1,
              "Zone Name": [
                'Chennai Zone',
                'Kolathur Zone',
                'Thambaram Zone',
                ''
              ][index],
              "Zone Leader": ['AMBEDKAR R', 'JACK JHON', 'JEMES', ''][index],
              "Assigned Date/Time": [
                '2023-09-15 09:00:00',
                '2023-09-15 06:09:20',
                '2023-09-15 06:10:49',
                ''
              ][index],
              "Status": 'Action',
            }),
  }
];

// Products
final List<Map<String, dynamic>> products = [
  {
    "header": ['No', 'Photo', 'Title', 'Price', 'Categories', 'Tags', 'Action'],
    "dataType": [
      'Text',
      'listOfUser',
      'Text',
      'Text',
      'Text',
      'Text',
      'Action'
    ],
    "data": List.generate(
        4,
        (index) => {
              "No": index + 1,
              "Photo": [
                ["assets/avatar4.png"],
                ["assets/avatar1.png"],
                ["assets/avatar3.png"],
                ["assets/avatar2.png"]
              ][index],
              "Title": ['Pickle', 'Flower', 'Candle', 'Designs'][index],
              "Price": [1200, 200, 1200, 400][index],
              "Categories": ['mango', 'rose', 'big size', 'gods'][index],
              "Tags": ['hari', 'hari', 'hari', 'hari'][index],
              "Action": 'Action',
            }),
  }
];

//Order
final List<Map<String, dynamic>> orders = [
  {
    "header": [
      'No',
      'OrderID',
      'Date',
      'Username',
      'Amount',
      'Phone',
      'Action'
    ],
    "dataType": ['Text', 'Text', 'date', 'Text', 'Text', 'Text', 'Action'],
    "data": List.generate(
        4,
        (index) => {
              "No": index + 1,
              "OrderID": [
                'abcgo123',
                'mnb234',
                'Ltl453',
                'jgh543',
                'Tld432',
                'Rel789'
              ][index],
              "Date": [
                '2023-09-15',
                '2023-09-25',
                '2023-09-15',
                '2023-03-14',
                '2023-04-17',
                '2023-11-15'
              ][index],
              "Username": [
                'Ravip',
                'Anoop',
                'Nanc',
                'Sandeep',
                'Vimal',
                'Sathish'
              ][index],
              "Amount": [1400, 300, 2000, 4800, 10000, 15000][index],
              "Phone": [
                '9876545678',
                '7890654323',
                '8907652341',
                '6578902341',
                '8765402341',
                '7890765431'
              ][index],
              "Action": 'Action',
            }),
  }
];

final List<Map<String, dynamic>> profileName = [
  {'user': 'Vijay', 'profilePicture': 'assets/Person Image.png'},
  {'user': 'Boopathi', 'profilePicture': 'assets/Person Image.png'},
  {'user': 'Arun', 'profilePicture': 'assets/Person Image.png'},
  {'user': 'Velu', 'profilePicture': 'assets/Person Image.png'},
];

/*final List<Widget Function(Map<String, dynamic>)> cellBuilders = [
      (row) => UsernameWidget(username: row['user'], profilePictures: row['profilePicture']),
      (row) => Text(row['date'],TextAlign: TextAlign.left),
      (row) => Text('${row['amount']}',TextAlign: TextAlign.left,),
      (row) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: row['status'] == 'Active'
          ? Colors.green[100]
          : row['status'] == 'Pending'
          ? Colors.yellow[100]
          : Colors.red[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      row['status'],
      style: TextStyle(
        color: row['status'] == 'Active'
            ? Colors.green
            : row['status'] == 'Pending'
            ? Colors.orange
            : Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  (row) => OptionButton(menuItems: menuItems,)
];*/
/*List<String> labels = ["Verify", "Unverified",];
List<IconData> icons = [HugeIcons.strokeRoundedCheckmarkCircle02, HugeIcons.strokeRoundedCancelCircle];*/

final List<Map<String, dynamic>> menuItems = [
  {'label': 'View', 'icon': HugeIcons.strokeRoundedView},
  {'label': 'Edit', 'icon': HugeIcons.strokeRoundedPencilEdit01},
  {'label': 'Delete', 'icon': HugeIcons.strokeRoundedDelete02},
];
final List<Map<String, dynamic>> Testimony = [
  {'label': 'Verify', 'icon': HugeIcons.strokeRoundedCheckmarkCircle02},
  {'label': 'Unverified', 'icon': HugeIcons.strokeRoundedCancelCircle},
];

/*List<Map<String, dynamic>> _iconAndLabel(List<String> labels, List<IconData> icons) {
  if (labels.length != icons.length) {
    throw ArgumentError('Labels and Icons lists must have the same length.');
  }

  return List.generate(labels.length, (index) {
    return {'label': labels[index], 'icon': icons[index]};
  });
}*/

final List<Map<String, dynamic>> paymentItems = [
  {'label': 'Cash', 'icon': HugeIcons.strokeRoundedCash01},
  {'label': 'Upi', 'icon': HugeIcons.strokeRoundedPaypal},
  {'label': 'Card', 'icon': HugeIcons.strokeRoundedCreditCard},
];

// ✅ List of users
final List<UserProfile> users = [
  UserProfile(
    name: 'Jenni',
    job: 'Chemist',
    phone: '9876543210',
    imagePath: 'assets/avatar4.png',
  ),
  UserProfile(
    name: 'John Chena',
    job: 'Software Engineer',
    phone: '9123456789',
    imagePath: 'assets/avatar2.png',
  ),
  UserProfile(
    name: 'Alice Johnson',
    job: 'Doctor',
    phone: '9871234567',
    imagePath: 'assets/avatar1.png',
  ),
  UserProfile(
    name: 'Michael Smith',
    job: 'Architect',
    phone: '9876543211',
    imagePath: 'assets/avatar3.png',
  ),
  UserProfile(
    name: 'Claudia Foster',
    job: 'Manager',
    phone: '9876543210',
    imagePath: 'assets/avatar1.png',
  ),
  UserProfile(
    name: 'John',
    job: 'Software Engineer',
    phone: '9123456789',
    imagePath: 'assets/avatar3.png',
  ),
  UserProfile(
    name: 'catholina',
    job: 'Doctor',
    phone: '9871234567',
    imagePath: 'assets/avatar4.png',
  ),
  UserProfile(
    name: 'Michael Smith',
    job: 'Architect',
    phone: '9876543211',
    imagePath: 'assets/avatar3.png',
  ),
  UserProfile(
    name: 'John Doe',
    job: 'Software Engineer',
    phone: '9123456789',
    imagePath: 'assets/avatar2.png',
  ),
  UserProfile(
    name: 'Alice Johnson',
    job: 'Doctor',
    phone: '9871234567',
    imagePath: 'assets/avatar2.png',
  ),
];

// speech

final List<UserProfile> speech = [
  UserProfile(
    name: 'Jenni',
    phone: '9876543210',
    imagePath: 'assets/avatar4.png',
    dateTime: DateFormat('2021-12-25 12:00').format(DateTime.now()),
  ),
  UserProfile(
    name: 'John Chena',
    phone: '9123456789',
    imagePath: 'assets/avatar2.png',
    dateTime: DateFormat('2021-10-20 1:00').format(DateTime.now()),
  ),
  UserProfile(
    name: 'Alice Johnson',
    phone: '9871234567',
    imagePath: 'assets/avatar1.png',
    dateTime: DateFormat('2021-10-20 1:00').format(DateTime.now()),
  ),
  UserProfile(
    name: 'Michael Smith',
    phone: '9876543211',
    imagePath: 'assets/avatar3.png',
    dateTime: DateFormat('2021-10-20 1:00:').format(DateTime.now()),
  ),
  UserProfile(
    name: 'Claudia Foster',
    phone: '9876543210',
    imagePath: 'assets/avatar1.png',
    dateTime: DateFormat('2021-10-20 1:00').format(DateTime.now()),
  ),
  UserProfile(
    name: 'John',
    phone: '9123456789',
    imagePath: 'assets/avatar3.png',
    dateTime: DateFormat('2021-10-20 1:00').format(DateTime.now()),
  ),
  UserProfile(
    name: 'catholina',
    phone: '9871234567',
    imagePath: 'assets/avatar4.png',
    dateTime: DateFormat('2021-10-20 1:00').format(DateTime.now()),
  ),
  UserProfile(
    name: 'Michael Smith',
    phone: '9876543211',
    imagePath: 'assets/avatar3.png',
    dateTime: DateFormat('2021-10-20 1:00').format(DateTime.now()),
  ),
  UserProfile(
    name: 'John Doe',
    phone: '9123456789',
    imagePath: 'assets/avatar2.png',
    dateTime: DateFormat('2021-10-20 1:00').format(DateTime.now()),
  ),
  UserProfile(
    name: 'Alice Johnson',
    phone: '9871234567',
    imagePath: 'assets/avatar2.png',
    dateTime: DateFormat('2021-10-20 1:00').format(DateTime.now()),
  ),
];

//  Social media icons list
final List<IconData> socialIcons = [
  HugeIcons.strokeRoundedFacebook02,
  HugeIcons.strokeRoundedInstagram,
  HugeIcons.strokeRoundedWhatsapp,
  HugeIcons.strokeRoundedGithub01,
  HugeIcons.strokeRoundedNewTwitter,
];
