import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _savedOutfits = [
    {
      'image': 'https://images.pexels.com/photos/5886041/pexels-photo-5886041.jpeg',
      'name': 'Summer Casual',
      'date': 'Saved yesterday'
    },
    {
      'image': 'https://images.pexels.com/photos/2983464/pexels-photo-2983464.jpeg',
      'name': 'Office Outfit', 
      'date': 'Saved last week'
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Personal'),
            Tab(text: 'Measurements'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPersonalTab(),
          _buildMeasurementsTab(),
          _buildHistoryTab(),
        ],
      ),
    );
  }

  Widget _buildPersonalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Alex Johnson',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Member since June 2023',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _buildInfoCard('Email', 'alex.johnson@example.com'),
          const SizedBox(height: 16),
          _buildInfoCard('Phone', '+1 (555) 123-4567'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Edit Profile'),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Body Measurements',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'These help us recommend better fitting clothes',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildMeasurementInput('Height (cm)', '175'),
              const SizedBox(width: 16),
              _buildMeasurementInput('Weight (kg)', '68'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildMeasurementInput('Bust (cm)', '92'),
              const SizedBox(width: 16),
              _buildMeasurementInput('Waist (cm)', '76'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildMeasurementInput('Hips (cm)', '94'),
              const SizedBox(width: 16),
              _buildMeasurementInput('Inseam (cm)', '81'),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Update Measurements'),
          ),
          const SizedBox(height: 24),
          const Text(
            'Size Guide',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DataTable(
            columns: const [
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Your Size')),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('Tops')),
                DataCell(Text('M')),
              ]),
              DataRow(cells: [
                DataCell(Text('Bottoms')),
                DataCell(Text('32 (Waist)')),
              ]),
              DataRow(cells: [
                DataCell(Text('Dresses')),
                DataCell(Text('8 (US)')),
              ]),
              DataRow(cells: [
                DataCell(Text('Shoes')),
                DataCell(Text('9.5 (US)')),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Recent Try-Ons',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ..._buildTryOnHistory(),
          const SizedBox(height: 24),
          const Text(
            'Saved Outfits',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemCount: _savedOutfits.length,
            itemBuilder: (context, index) {
              final outfit = _savedOutfits[index];
              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        outfit['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            outfit['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            outfit['date'],
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTryOnHistory() {
    return [
      ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage('https://images.pexels.com/photos/428340/pexels-photo-428340.jpeg'),
        ),
        title: const Text('White T-shirt with Jeans'),
        subtitle: const Text('Yesterday at 3:42 PM'),
        trailing: IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () {},
        ),
      ),
      const Divider(),
      ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage('https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg'),
        ),
        title: const Text('Gray Sweater'),
        subtitle: const Text('2 days ago'),
        trailing: IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () {},
        ),
      ),
      const Divider(),
    ];
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementInput(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          TextFormField(
            initialValue: value,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}