import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TryOnPage extends StatefulWidget {
  const TryOnPage({super.key});

  @override
  State<TryOnPage> createState() => _TryOnPageState();
}

class _TryOnPageState extends State<TryOnPage> {
  File? _selectedImage;
  String? _selectedCategory;
  String? _selectedClothing;
  final List<String> _categories = ['Tops', 'Bottoms', 'Dresses', 'Outerwear'];
  final List<String> _clothingItems = [
    'https://images.pexels.com/photos/428340/pexels-photo-428340.jpeg',
    'https://images.pexels.com/photos/994517/pexels-photo-994517.jpeg',
    'https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg',
  ];

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1.5),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _selectedImage = File(croppedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Try-On'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_selectedImage == null)
              _buildUploadSection()
            else
              _buildTryOnSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.person_outline, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Upload a photo or use your camera',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.upload),
                  label: const Text('Upload'),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTryOnSection() {
    return Column(
      children: [
        // Preview Section
        Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Center(
                child: Image.file(_selectedImage!),
              ),
              if (_selectedClothing != null)
                Center(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.7),
                      BlendMode.srcATop,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: _selectedClothing!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Category Selection
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = selected ? category : null;
                      _selectedClothing = null;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),

        // Clothing Items Grid
        if (_selectedCategory != null)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemCount: _clothingItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedClothing = _clothingItems[index];
                  });
                },
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: _clothingItems[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Item ${index + 1}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        const SizedBox(height: 20),

        // Action Buttons
        if (_selectedClothing != null)
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Save to Wardrobe'),
            onPressed: () {
              // Save functionality would go here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Outfit saved to wardrobe!')),
              );
            },
          ),
      ],
    );
  }
}