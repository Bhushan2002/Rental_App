import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rental_application/data/MessageData/message_repository.dart';

final messageRepositoryProvider = Provider((ref) => MessageRepository());

final messageControllerProvider =
    StateNotifierProvider<MessageController, AsyncValue<void>>((ref) {
      return MessageController(ref.watch(messageRepositoryProvider));
    });

class MessageController extends StateNotifier<AsyncValue<void>> {
  final MessageRepository _messageRepository;

  MessageController(this._messageRepository)
    : super(const AsyncValue.data(null));
  Future<void> sendMessage({
    required String ownerId,
    required String tenantId,
    required String tenantName,
    required String tenantEmail,
    required String message,
    required String propertyId,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _messageRepository.sendMessage(
        ownerId: ownerId,
        tenantId: tenantId,
        tenantName: tenantName,
        tenantEmail: tenantEmail,
        message: message,
        propertyId: propertyId,
      );
      state = const AsyncValue.data(null);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your message has been sent to the owner.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Faild to send message: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }
}
