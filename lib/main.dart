import 'package:flutter/material.dart';
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
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F8F5), // Off-white/cream background
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          secondary: Color(0xFFE2DDF8), // Pastel purple from radar
          surface: Colors.white,
          background: Color(0xFFF8F8F5),
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
          bodyColor: const Color(0xFF1A1A1A),
          displayColor: const Color(0xFF1A1A1A),
        ),
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
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: Colors.black.withOpacity(0.05),
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.radar_outlined), selectedIcon: Icon(Icons.radar), label: 'Radar'),
            NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Map'),
            NavigationDestination(icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle), label: 'Report'),
            NavigationDestination(icon: Icon(Icons.leaderboard_outlined), selectedIcon: Icon(Icons.leaderboard), label: 'Rank'),
          ],
        ),
      ),
    );
  }
}

// ----------------- HOME SCREEN (Radar) -----------------
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
          'CAMPUS PULSE RADAR',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 1.2,
            color: Colors.black54,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        children: [
          Text(
            'Stop guessing.\nStart knowing.',
            style: GoogleFonts.inter(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Real-time campus crowd radar, seat telemetry, and mess velocity delivered straight to your pocket.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.6),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 40),
          
          // Row of quick status cards
          Row(
            children: [
              Expanded(child: _buildMiniCard('Main Library • Floor 2', '18% Full', const Color(0xFF4CAF50))),
              const SizedBox(width: 12),
              Expanded(child: _buildMiniCard('Dining Hall • Hub 3', 'Rush Hour', const Color(0xFFF44336))),
            ],
          ),
          const SizedBox(height: 32),
          
          Text('All Locations', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          _buildLocationTile('Central Mess', 'Packed', const Color(0xFFF44336)),
          _buildLocationTile('Library 1st Floor', 'Moderate', const Color(0xFFFF9800)),
          _buildLocationTile('Library 2nd Floor', 'Empty', const Color(0xFF4CAF50)),
          _buildLocationTile('Canteen', 'Packed', const Color(0xFFF44336)),
          _buildLocationTile('Gymnasium', 'Moderate', const Color(0xFFFF9800)),
        ],
      ),
    );
  }

  Widget _buildMiniCard(String title, String status, Color dotColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0EE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(status, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationTile(String name, String status, Color dotColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(status, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

// ----------------- MAP SCREEN -----------------
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('AURA HEATMAP', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 1.2, color: Colors.black54)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE2DDF8).withOpacity(0.5),
              ),
              child: const Icon(Icons.map, size: 60, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            const Text('Interactive Map Integration', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Google Maps SDK will render here.', style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
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
        title: Text('TACTILE TELEMETRY', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 1.2, color: Colors.black54)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Where are you right now?', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Select Location...'),
                  value: selectedLocation,
                  items: const [
                    DropdownMenuItem(value: 'mess', child: Text('Central Mess')),
                    DropdownMenuItem(value: 'lib1', child: Text('Library Floor 1')),
                    DropdownMenuItem(value: 'lib2', child: Text('Library Floor 2')),
                    DropdownMenuItem(value: 'canteen', child: Text('Canteen')),
                  ],
                  onChanged: (val) => setState(() => selectedLocation = val),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text('How crowded is it?', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatusBtn('Empty', const Color(0xFF4CAF50))),
                const SizedBox(width: 12),
                Expanded(child: _buildStatusBtn('Moderate', const Color(0xFFFF9800))),
                const SizedBox(width: 12),
                Expanded(child: _buildStatusBtn('Packed', const Color(0xFFF44336))),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 0,
              ),
              onPressed: (selectedLocation != null && selectedStatus != null)
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Intel received. +15 Points!')));
                      setState(() { selectedLocation = null; selectedStatus = null; });
                    }
                  : null,
              child: const Text('Submit Report', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBtn(String text, Color color) {
    bool isSelected = selectedStatus == text;
    return GestureDetector(
      onTap: () => setState(() => selectedStatus = text),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? color : Colors.grey.shade300, width: isSelected ? 2 : 1),
        ),
        child: Column(
          children: [
            Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(height: 8),
            Text(text, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
          ],
        ),
      ),
    );
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
        title: Text('RANKINGS', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: 1.2, color: Colors.black54)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Text('#${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black45)),
                const SizedBox(width: 16),
                const CircleAvatar(backgroundColor: Color(0xFFE2DDF8), child: Icon(Icons.person, color: Colors.black54)),
                const SizedBox(width: 16),
                Text('Student ${index + 1}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                const Spacer(),
                Text('${2000 - (index * 150)} pts', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );
  }
}
