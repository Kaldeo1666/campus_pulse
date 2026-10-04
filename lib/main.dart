import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CampusPulseApp());
}

class CampusPulseApp extends StatelessWidget {
  const CampusPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Pulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F1115),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF00FFC6),
          surface: Color(0xFF1A1C23),
          background: Color(0xFF0F1115),
        ),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    MapScreen(),
    CheckInScreen(),
    LeaderboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient Blob
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _screens[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.05),
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: const Color(0xFF15171C),
          indicatorColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.radar_outlined),
              selectedIcon: Icon(Icons.radar),
              label: 'Live',
            ),
            NavigationDestination(
              icon: Icon(Icons.map_outlined),
              selectedIcon: Icon(Icons.map),
              label: 'Heatmap',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_location_alt_outlined),
              selectedIcon: Icon(Icons.add_location_alt),
              label: 'Report',
            ),
            NavigationDestination(
              icon: Icon(Icons.emoji_events_outlined),
              selectedIcon: Icon(Icons.emoji_events),
              label: 'Rank',
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- HOME SCREEN -----------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Campus Pulse',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            fontSize: 26,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {},
          ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 2.seconds),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // Smart Nudge Card
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF8E88FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C63FF).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_circle, size: 40, color: Colors.white)
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(delay: 1.seconds, duration: 2.seconds),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Smart Nudge',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Central Library 2nd Floor is less crowded right now! Go now!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().slideY(begin: -0.2, curve: Curves.easeOutCubic).fadeIn(),
          const SizedBox(height: 32),
          Text(
            'Live Crowd Levels',
            style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold),
          ).animate().fadeIn(delay: 200.ms),
          const SizedBox(height: 16),
          _buildCrowdItem('Central Mess', 'Packed', const Color(0xFFFF4B4B), Icons.restaurant, 0)
              .animate().fadeIn(delay: 300.ms).slideX(begin: 0.1),
          _buildCrowdItem('Library 1st Floor', 'Okay', const Color(0xFFFFB23F), Icons.menu_book, 1)
              .animate().fadeIn(delay: 400.ms).slideX(begin: 0.1),
          _buildCrowdItem('Library 2nd Floor', 'Empty', const Color(0xFF00FFC6), Icons.local_library, 2)
              .animate().fadeIn(delay: 500.ms).slideX(begin: 0.1),
          _buildCrowdItem('Canteen', 'Packed', const Color(0xFFFF4B4B), Icons.coffee, 3)
              .animate().fadeIn(delay: 600.ms).slideX(begin: 0.1),
          _buildCrowdItem('Gymnasium', 'Okay', const Color(0xFFFFB23F), Icons.fitness_center, 4)
              .animate().fadeIn(delay: 700.ms).slideX(begin: 0.1),
        ],
      ),
    );
  }

  Widget _buildCrowdItem(String title, String status, Color color, IconData icon, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C23),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------- MAP SCREEN (Heatmap) -----------------
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Aura Heatmap', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1A1C23),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.2),
                    blurRadius: 50,
                    spreadRadius: 20,
                  )
                ],
              ),
              child: const Icon(Icons.map_rounded, size: 100, color: Color(0xFF6C63FF))
                  .animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .scaleXY(end: 1.1, duration: 2.seconds)
                  .then()
                  .scaleXY(end: 1.0, duration: 2.seconds),
            ).animate().fadeIn(duration: 500.ms),
            const SizedBox(height: 32),
            const Text(
              'Interactive Campus Heatmap',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 12),
            Text(
              'Zoom in to see live crowd densities.',
              style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.5)),
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegend(const Color(0xFF00FFC6), 'Empty').animate().fadeIn(delay: 400.ms),
                const SizedBox(width: 24),
                _buildLegend(const Color(0xFFFFB23F), 'Okay').animate().fadeIn(delay: 500.ms),
                const SizedBox(width: 24),
                _buildLegend(const Color(0xFFFF4B4B), 'Packed').animate().fadeIn(delay: 600.ms),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

// ----------------- CHECK-IN SCREEN -----------------
class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  String? selectedLocation;
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Tactile Telemetry', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select your location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white70),
            ).animate().fadeIn(),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1C23),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: const Color(0xFF1A1C23),
                  value: selectedLocation,
                  isExpanded: true,
                  hint: const Text('E.g. Central Library'),
                  items: const [
                    DropdownMenuItem(value: 'mess', child: Text('Central Mess')),
                    DropdownMenuItem(value: 'lib1', child: Text('Library 1st Floor')),
                    DropdownMenuItem(value: 'lib2', child: Text('Library 2nd Floor')),
                    DropdownMenuItem(value: 'canteen', child: Text('Canteen')),
                  ],
                  onChanged: (val) => setState(() => selectedLocation = val),
                ),
              ),
            ).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 40),
            const Text(
              'How crowded is it right now?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white70),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusButton('Empty', Icons.waves, const Color(0xFF00FFC6)),
                _buildStatusButton('Okay', Icons.groups, const Color(0xFFFFB23F)),
                _buildStatusButton('Packed', Icons.warning_amber, const Color(0xFFFF4B4B)),
              ],
            ),
            const Spacer(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: selectedLocation != null && selectedStatus != null
                      ? [const Color(0xFF6C63FF), const Color(0xFF8E88FF)]
                      : [Colors.grey.shade800, Colors.grey.shade800],
                ),
                boxShadow: selectedLocation != null && selectedStatus != null
                    ? [BoxShadow(color: const Color(0xFF6C63FF).withOpacity(0.4), blurRadius: 20)]
                    : [],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: (selectedLocation != null && selectedStatus != null)
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Awesome! +10 Pulse Points earned 🌟'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              backgroundColor: const Color(0xFF6C63FF),
                            ),
                          );
                          setState(() {
                            selectedLocation = null;
                            selectedStatus = null;
                          });
                        }
                      : null,
                  child: const Center(
                    child: Text(
                      'Broadcast Status',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ).animate().slideY(begin: 1.0, curve: Curves.easeOutCubic),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(String status, IconData icon, Color color) {
    bool isSelected = selectedStatus == status;
    return GestureDetector(
      onTap: () => setState(() => selectedStatus = status),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 100,
        height: 120,
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : const Color(0xFF1A1C23),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? color : Colors.white.withOpacity(0.05),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [BoxShadow(color: color.withOpacity(0.2), blurRadius: 15)] : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: isSelected ? color : Colors.white54),
            const SizedBox(height: 12),
            Text(
              status,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? color : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).scale(curve: Curves.easeOutBack);
  }
}

// ----------------- LEADERBOARD SCREEN -----------------
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Rankings', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // User Stats Card
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFF1A1C23),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn('Your Points', '1,250', const Color(0xFF00FFC6)),
                Container(width: 1, height: 50, color: Colors.white.withOpacity(0.1)),
                _buildStatColumn('Hot Streak', '12 🔥', const Color(0xFFFFB23F)),
              ],
            ),
          ).animate().slideY(begin: -0.2).fadeIn(),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 15,
              itemBuilder: (context, index) {
                bool isTop3 = index < 3;
                Color rankColor = index == 0
                    ? const Color(0xFFFFD700)
                    : index == 1
                        ? const Color(0xFFC0C0C0)
                        : index == 2
                            ? const Color(0xFFCD7F32)
                            : Colors.white70;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isTop3 ? rankColor.withOpacity(0.1) : const Color(0xFF1A1C23),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isTop3 ? rankColor.withOpacity(0.3) : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          '#${index + 1}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: rankColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      CircleAvatar(
                        backgroundColor: Colors.primaries[index % Colors.primaries.length].withOpacity(0.2),
                        child: Text(
                          'S${index + 1}',
                          style: TextStyle(
                            color: Colors.primaries[index % Colors.primaries.length],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Student ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const Spacer(),
                      Text(
                        '${2500 - (index * 120)} pts',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).slideX(begin: 0.1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
