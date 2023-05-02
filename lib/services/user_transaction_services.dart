part of 'services.dart';

class UserTransactionServices {
  static final CollectionReference _transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

  static Future<void> saveTransaction(UserTransaction userTransaction) async {
    await _transactionCollection.add({
      'userID': userTransaction.userID,
      'title': userTransaction.title,
      'subtitle': userTransaction.subtitle,
      'amount': userTransaction.amount,
      'time': userTransaction.time.microsecondsSinceEpoch,
      'picture': userTransaction.picture ?? ''
    });
  }

  static Future<List<UserTransaction>> getTransaction(String userID) async {
    QuerySnapshot snapshot = await _transactionCollection.get();
    var documents =
        snapshot.docs.where((document) => document['userID'] == userID);

    return documents
        .map((e) => UserTransaction(
              userID: e['userID'],
              title: e['title'],
              subtitle: e['subtitle'],
              time: DateTime.fromMicrosecondsSinceEpoch(e['time']),
              amount: e['amount'],
              picture: (e['picture'] != '') ? e['picture'] : null,
            ))
        .toList();
  }
}
