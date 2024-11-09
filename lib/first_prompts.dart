class FirstPrompts {
  static List<String> jpn = ['ねこ', 'フラミンゴ', 'もぐら', 'カラス'];
  static List<String> eng = ['cat', 'flamingo', 'mole', 'crow'];

  static List<JpnEngList> firstPromptsList = [
    for (int i = 0; i < jpn.length; i++) JpnEngList(jpn[i], eng[i]),
  ];
}

class JpnEngList {
  JpnEngList(this.jpn, this.eng);
  String jpn;
  String eng;
}
