part of 'player.model.dart';

abstract class PlayerDTO extends _PlayerDAO {}

class _PlayerDAO {
  String uid;
  String nick;
  String email;
  int gold;

  _PlayerDAO({
    @required this.uid,
    @required this.nick,
    @required this.email,
    @required this.gold,
  });

  factory _PlayerDAO.fromMap(map) {
    return _PlayerDAO(
      uid: map['UID'],
      nick: map['nick'],
      email: map['email'],
      gold: int.parse(map['gold']),
    );
  }

  void insert(Transaction txn) async {
    await txn.rawInsert(
      '''
      INSERT INTO Player
      VALUES(
        $uid, 
        '$nick', 
        '$email',
        '$gold',
      )
      ''',
    );
  }

  void update() {}

  void delete() {}
}
