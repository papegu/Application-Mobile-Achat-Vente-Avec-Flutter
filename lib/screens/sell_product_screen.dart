import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SellProductScreen extends StatefulWidget {
  @override
  _SellProductScreenState createState() => _SellProductScreenState();
}

class _SellProductScreenState extends State<SellProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _submitProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() => _errorMessage = "Veuillez vous connecter pour vendre un produit.");
        return;
      }

      await FirebaseFirestore.instance.collection('products').add({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'price': double.parse(_priceController.text.trim()),
        'imageUrl': _imageUrlController.text.trim(),
        'sellerId': user.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produit mis en vente avec succès !')),
      );
      Navigator.pop(context);
    } catch (error) {
      setState(() {
        _errorMessage = "Erreur lors de l'ajout du produit : ${error.toString()}";
      });
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vendre un produit")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Nom du produit", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _titleController,
                  validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
                ),
                const SizedBox(height: 10),
                const Text("Description", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
                ),
                const SizedBox(height: 10),
                const Text("Prix (FCFA)", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
                ),
                const SizedBox(height: 10),
                const Text("URL de l'image", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _imageUrlController,
                  validator: (value) => value!.isEmpty ? "Champ obligatoire" : null,
                ),
                const SizedBox(height: 20),
                if (_errorMessage != null)
                  Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 10),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: _submitProduct,
                  child: const Text("Mettre en vente"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
