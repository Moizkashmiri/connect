import 'package:flutter/material.dart';
import '../utils/AppColors.dart';

class CallsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> calls = [
    {
      'name': 'John Doe',
      'time': 'Today, 10:30 AM',
      'type': 'missed',
      'image': 'assets/user1.jpg',
    },
    {
      'name': 'Jane Smith',
      'time': 'Today, 9:45 AM',
      'type': 'outgoing',
      'image': 'assets/user2.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.01,
      ),
      itemCount: calls.length,
      itemBuilder: (context, index) {
        final call = calls[index];
        return Container(
          margin: EdgeInsets.only(bottom: screenHeight * 0.02),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.01,
            ),
            leading: CircleAvatar(
              radius: screenWidth * 0.06,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Icon(
                Icons.person,
                color: AppColors.primary,
                size: screenWidth * 0.08,
              ),
            ),
            title: Text(
              call['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.04,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(
                  call['type'] == 'missed'
                      ? Icons.call_missed
                      : Icons.call_made,
                  size: screenWidth * 0.04,
                  color: call['type'] == 'missed'
                      ? Colors.red
                      : Colors.green,
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  call['time'],
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.call,
                color: AppColors.primary,
                size: screenWidth * 0.06,
              ),
              onPressed: () {
                // Handle call action
              },
            ),
          ),
        );
      },
    );
  }
}