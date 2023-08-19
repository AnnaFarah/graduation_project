import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../constant/appColor.dart';
import '../constant/appliApis.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class NotificationPatientView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإشعارات'),
        centerTitle: true,
        backgroundColor: Color(newDarkBlue),
      ),
      body: Center(
        child: FutureBuilder(
          future: http.get(
            Uri.parse('$url/api/getNotifications'),
            headers: {
              'Accept': 'application/json',
              'Authorization':
                  'Bearer ${patientSharedPreferences.getString('token')}'
            },
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              inspect(snapshot);
              return ListView.builder(
                itemCount:
                    (jsonDecode(snapshot.data!.body)['data'] as List).length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(6),
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset('icons/user.png'),
                      ),
                      title: Text(
                        jsonDecode(snapshot.data!.body)['data'][index]['title'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        jsonDecode(snapshot.data!.body)['data'][index]['text'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
