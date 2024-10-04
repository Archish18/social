import 'package:flutter/material.dart';
import 'package:media/profile.dart';

void main() {
  runApp(const SocialMediaApp());
}

class SocialMediaApp extends StatelessWidget {
  const SocialMediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, 
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), 
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black, 
          selectedItemColor: Colors.white, 
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),    
    const CreateTab(),  
    const SearchTab(),  
    const MessageTab(), 
    const ProfileTab(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], 
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex, 
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Create'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: 'Messages'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); 
  }
  Widget _buildStoriesSection() {
    final List<String> stories = List.generate(10, (index) => 'Story ${index + 1}');

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryViewScreen(
                      stories: stories,
                      initialIndex: index,
                    ),
                  ),
                );
              },
              child: Container(
                width: 60,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[800], 
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    stories[index],
                    style: const TextStyle(color: Colors.white), 
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostList() {
    return ListView.builder(
      itemCount: 5, 
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey[900], 
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                leading: CircleAvatar(backgroundColor: Colors.grey),
                title: Text('Account_name', style: TextStyle(color: Colors.white)),
                subtitle: Text('Post content goes here...', style: TextStyle(color: Colors.white70)),
              ),
              Container(
                height: 200,
                color: Colors.grey[700], 
                child: const Center(child: Text('Image Placeholder', style: TextStyle(color: Colors.white))),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_up_alt_outlined, color: Colors.white),
                        SizedBox(width: 4),
                        Text('500 likes', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.comment_outlined, color: Colors.white),
                        SizedBox(width: 4),
                        Text('154 comments', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Home', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          _buildStoriesSection(),
          const Divider(color: Colors.white),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Individual'),
              Tab(text: 'Community'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPostList(), 
                _buildPostList(), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StoryViewScreen extends StatefulWidget {
  final List<String> stories; 
  final int initialIndex; 

  const StoryViewScreen({
    super.key,
    required this.stories,
    required this.initialIndex,
  });

  @override
  _StoryViewScreenState createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.stories.length,
          itemBuilder: (context, index) {
            return Center(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.grey[850], 
                child: SizedBox(
                  width: double.infinity,
                  height: 400, 
                  child: Center(
                    child: Text(
                      widget.stories[index], 
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search', style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text('Search Content', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class CreateTab extends StatelessWidget {
  const CreateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create', style: TextStyle(color: Colors.white)),
      ),
      body: const Center(child: Text('Create Content', style: TextStyle(color: Colors.white))),
    );
  }
}

class MessageTab extends StatelessWidget {
  const MessageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages', style: TextStyle(color: Colors.white)),
      ),
      body: const Center(child: Text('Messages Content', style: TextStyle(color: Colors.white))),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePage(); 
  }
}