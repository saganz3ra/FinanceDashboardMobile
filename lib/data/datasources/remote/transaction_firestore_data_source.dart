import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/transaction_model.dart';

abstract class TransactionFirestoreDataSource {
  Future<List<TransactionModel>> getTransactions(String userId);
  Future<void> addTransaction(String userId, TransactionModel transaction);
  Future<void> editTransaction(String userId, String transactionId, TransactionModel transaction);
  Future<void> deleteTransaction(String userId, String transactionId);
}

class TransactionFirestoreDataSourceImpl implements TransactionFirestoreDataSource {
  final FirebaseFirestore firestore;
  TransactionFirestoreDataSourceImpl({required this.firestore});

  @override
  Future<List<TransactionModel>> getTransactions(String userId) async {
    final snapshot = await firestore.collection('users').doc(userId).collection('transactions').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return TransactionModel.fromMap({...data, 'id': doc.id});
    }).toList();
  }

  @override
  Future<void> addTransaction(String userId, TransactionModel transaction) async {
    await firestore.collection('users').doc(userId).collection('transactions').add(transaction.toMap());
  }

  @override
  Future<void> editTransaction(String userId, String transactionId, TransactionModel transaction) async {
    await firestore.collection('users').doc(userId).collection('transactions').doc(transactionId).set(transaction.toMap());
  }

  @override
  Future<void> deleteTransaction(String userId, String transactionId) async {
    await firestore.collection('users').doc(userId).collection('transactions').doc(transactionId).delete();
  }
}
