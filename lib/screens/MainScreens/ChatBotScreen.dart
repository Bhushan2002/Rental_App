// lib/screens/ChatbotScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final _chatController = TextEditingController();
  final gemini = Gemini.instance;
  String? _response;
  bool _isLoading = false;

  // --- STEP 1: DEFINE YOUR Q&A CONTEXT ---
  // Add all your specific questions and answers here.
  final String qaContext = """
  You are a helpful assistant for a property rental application.
  Your goal is to answer user questions based ONLY on the following information.
  If the user asks something not covered here, kindly say "I can only answer questions about our properties and services."

  **Frequently Asked Questions:**

  **Question: How do I book a property?**
  Answer: You can book a property by navigating to the property details page and clicking the 'Book Now' button. You will be asked to select your desired dates and make an initial payment.

  **Question: What is the pet policy?**
  Answer: Pets are allowed in select properties only. Please check the property details page for a 'Pets Allowed' icon before booking. An additional pet deposit may be required.

  **Question: How can I contact the property owner?**
  Answer: Once your booking is confirmed, you will find the owner's contact details under the 'My Bookings' section of the app.

  **Question: What is the cancellation policy?**
  Answer: You can cancel for free up to 7 days before your check-in date. A 50% fee applies for cancellations within 7 days, and no refund is provided for cancellations within 24 hours of check-in.

  **Question: How do I report a maintenance issue?**
  Answer: For any maintenance issues, please go to 'My Bookings', select the property, and use the 'Report an Issue' feature. Our team will get in touch with you shortly.
  """;

  @override
  Widget build(BuildContext context) {
    // ... The build method remains the same as before ...
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistant'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: _response != null
                    ? Text(_response!, style: const TextStyle(fontSize: 16))
                    : const Center(
                        child: Text(
                          'Ask me anything about our properties!',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
              ),
            ),
          ),
          if (_isLoading) const CircularProgressIndicator(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_chatController.text.isNotEmpty) {
      final userMessage = _chatController.text;
      _chatController.clear();
      setState(() {
        _isLoading = true;
        _response = null;
      });

      // --- STEP 2: COMBINE THE CONTEXT WITH THE USER'S MESSAGE ---
      final prompt = "$qaContext\n\nUser Question: \"$userMessage\"\n\nAnswer:";

      gemini
          .text(prompt)
          .then((result) {
            setState(() {
              _response = result?.output;
              _isLoading = false;
            });
          })
          .catchError((e) {
            setState(() {
              _response = 'Error: ${e.toString()}';
              _isLoading = false;
            });
          });
    }
  }
}
