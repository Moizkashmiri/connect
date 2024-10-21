import 'package:flutter/material.dart';
import '../utils/AppColors.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'John Doe',
      'message': 'Hey, how are you?',
      'time': '10:30 AM',
      'unread': 2,
      'image': 'assets/user1.jpg',
      'isOnline': true,
      'lastSeen': 'online'
    },
    {
      'name': 'Sarah Wilson',
      'message': 'The meeting is scheduled for tomorrow',
      'time': '9:45 AM',
      'unread': 3,
      'image': 'assets/user2.jpg',
      'isOnline': true,
      'lastSeen': 'online'
    },
    {
      'name': 'Tech Team Group',
      'message': 'Alex: Latest updates are deployed',
      'time': '8:30 AM',
      'unread': 5,
      'image': 'assets/group1.jpg',
      'isOnline': false,
      'lastSeen': '2 participants online'
    },
    {
      'name': 'Emily Brown',
      'message': 'Thanks for your help!',
      'time': 'Yesterday',
      'unread': 0,
      'image': 'assets/user3.jpg',
      'isOnline': false,
      'lastSeen': 'last seen 2h ago'
    },
  ];

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primary,
      title: !_isSearching
          ? Text(
        'Chats',
        style: TextStyle(
          fontSize: screenWidth * 0.06,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      )
          : null,
      flexibleSpace: _isSearching
          ? SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.01,
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: screenWidth * 0.06,
                ),
                onPressed: () {
                  setState(() {
                    _isSearching = false;
                    _searchController.clear();
                  });
                },
              ),
              Expanded(
                child: Container(
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search chats...',
                      hintStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: screenWidth * 0.04,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.01,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          : null,
      actions: !_isSearching
          ? [
        IconButton(
          icon: Icon(
            Icons.search,
            size: screenWidth * 0.06,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
        PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            size: screenWidth * 0.06,
            color: Colors.white,
          ),
          onSelected: (value) {
            // Handle menu actions
          },
          itemBuilder: (context) => [
            _buildPopupMenuItem(
              'New Group',
              Icons.group_add,
              screenWidth,
            ),
            _buildPopupMenuItem(
              'Archived',
              Icons.archive,
              screenWidth,
            ),
            _buildPopupMenuItem(
              'Starred Messages',
              Icons.star,
              screenWidth,
            ),
            _buildPopupMenuItem(
              'Settings',
              Icons.settings,
              screenWidth,
            ),
          ],
        ),
      ]
          : [],
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
      String text,
      IconData icon,
      double screenWidth,
      ) {
    return PopupMenuItem(
      value: text,
      child: Row(
        children: [
          Icon(
            icon,
            size: screenWidth * 0.05,
            color: AppColors.textPrimary,
          ),
          SizedBox(width: screenWidth * 0.03),
          Text(
            text,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.01,
              ),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return _buildChatItem(
                  chat,
                  screenWidth,
                  screenHeight,
                  isPortrait,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: Icon(
          Icons.chat,
          color: Colors.white,
          size: screenWidth * 0.06,
        ),
        onPressed: () {
          // Handle new chat
        },
      ),
    );
  }

  Widget _buildMyStatus(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(right: screenWidth * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: screenWidth * 0.07,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: AppColors.primary,
                  size: screenWidth * 0.08,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.backgroundLight,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: screenWidth * 0.04,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'My Status',
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(
      Map<String, dynamic> chat,
      double screenWidth,
      double screenHeight,
      ) {
    return Container(
      margin: EdgeInsets.only(right: screenWidth * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                ],
              ),
            ),
            child: CircleAvatar(
              radius: screenWidth * 0.067,
              backgroundColor: AppColors.backgroundLight,
              child: CircleAvatar(
                radius: screenWidth * 0.065,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: AppColors.primary,
                  size: screenWidth * 0.08,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            chat['name'].split(' ')[0],
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(
      Map<String, dynamic> chat,
      double screenWidth,
      double screenHeight,
      bool isPortrait,
      ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.01,
      ),
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
        leading: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: chat['isOnline']
                      ? Colors.green
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: screenWidth * 0.06,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: AppColors.primary,
                  size: screenWidth * 0.08,
                ),
              ),
            ),
            if (chat['isOnline'])
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: screenWidth * 0.03,
                  height: screenWidth * 0.03,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.backgroundLight,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                chat['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.043,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              chat['time'],
              style: TextStyle(
                fontSize: screenWidth * 0.032,
                color: chat['unread'] > 0
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.005),
            Row(
              children: [
                Expanded(
                  child: Text(
                    chat['message'],
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: chat['unread'] > 0
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                      fontWeight: chat['unread'] > 0
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (chat['unread'] > 0)
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.015),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      chat['unread'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              chat['lastSeen'],
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        onTap: () {
          // Handle chat item tap
        },
      ),
    );
  }
}