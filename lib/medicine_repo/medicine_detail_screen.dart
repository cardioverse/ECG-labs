import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import FontAwesome package

class MedicineDetailScreen extends StatelessWidget {
  final Map<String, dynamic> medicine;

  MedicineDetailScreen({required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Details'),
      ),
      body: Stack(
        children: [
          // SingleChildScrollView to allow scrolling of content below the header
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 120), // Add top padding to avoid content being hidden
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full-width Description Card
                  _buildFullWidthCard(
                    icon: Icons.description,
                    title: 'Description',
                    content: medicine['description'] ?? 'No description available',
                  ),
                  SizedBox(height: 16),

                  // Grid Layout for Type, Dosage, Half-Life, and Onset of Action (2x2)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 cards per row
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: 4, // 4 items now: Type, Dosage, Half-Life, Onset of Action
                    itemBuilder: (context, index) {
                      return _buildCard(index); // Type (0), Dosage (1), Half-Life (2), Onset of Action (3)
                    },
                  ),
                  SizedBox(height: 16),

                  // Full-width Indication Card
                  _buildFullWidthCard(
                    icon: Icons.health_and_safety,
                    title: 'Indication',
                    content: medicine['indication'] ?? 'No indication available',
                  ),
                  SizedBox(height: 16),

                  // Full-width Contraindication Card
                  _buildFullWidthCard(
                    icon: Icons.warning,
                    title: 'Contraindication',
                    content: medicine['contraindication'] ?? 'No contraindication available',
                  ),
                ],
              ),
            ),
          ),

          // Positioned widget to keep the pill icon and medicine name at the top with a background
          Positioned(
            top: 0, // Position at the top
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black, // Background color for the header
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Pill Icon inside a smooth-edged square container
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200, // Background color of the pill icon
                      borderRadius: BorderRadius.circular(16), // Smooth edges
                    ),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.pills,  // Pill icon from FontAwesome
                        size: 30, // Icon size
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Space between the icon and the text

                  // Display the Medicine Name to the right of the pill icon
                  Expanded(
                    child: Text(
                      medicine['name'] ?? 'No name',  // Directly displaying the medicine name
                      style: TextStyle(
                        fontSize: 38,  // Larger text for the medicine name
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color to make it stand out
                      ),
                      overflow: TextOverflow.fade, // Handle overflow if the name is too long
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to create a card with icon, title, and content
  Widget _buildCard(int index) {
    // Icons for each card
    List<IconData> icons = [
      Icons.category, // Type
      Icons.access_alarm, // Dosage
      Icons.access_time, // Half-Life
      Icons.access_alarm, // Onset of Action (same icon for now)
    ];

    // Titles for each card
    List<String> titles = [
      'Type',
      'Dosage',
      'Half-Life',
      'Onset of Action',
    ];

    // Content for each card
    List<String> content = [
      medicine['type'] ?? 'No type available',
      medicine['dosage'] ?? 'No dosage available',
      medicine['half_life'] ?? 'No half-life available',
      medicine['onset_of_action'] ?? 'No onset of action available',
    ];

    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon at the top of the card
            Icon(
              icons[index],
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(height: 8),

            // Title centered at the top of the card
            Text(
              titles[index],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),

            // Content below the title
            Text(
              content[index],
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Function to create full-width cards for Description, Indication, and Contraindication
  Widget _buildFullWidthCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 40, color: Colors.blue),
                SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
