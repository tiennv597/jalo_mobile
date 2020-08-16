class Article {
  String title;
  String author;
  String description;
  String urlToImage;
  DateTime publshedAt;
  String content;
  String articleUrl;

  Article(
      {this.title,
      this.description,
      this.author,
      this.content,
      this.publshedAt,
      this.urlToImage,
      this.articleUrl});
}

final articleList = [
  Article(
      title: '5 ngày “xử gọn” bảng chữ cái tiếng Nhật Hiragana',
      author: 'Title 1',
      description:
          'Bảng chữ cái Hiragana (chữ mềm) là bảng chữ cái cơ bản trong tiếng Nhật. Việc thuộc lòng bảng Hiragana là việc đầu tiên mà người bắt đầu học tiếng Nhật phải làm để chuẩn bị tốt cho việc học lên cao....',
      urlToImage:
          'https://resources.matcha-jp.com/resize/720x2000/2020/04/10-101153.jpeg',
      publshedAt: DateTime.parse("1969-07-20 20:18:04Z"),
      content: '2019',
      articleUrl: 'https://akira.edu.vn/cach-hoc-bang-chu-hiragana/'),
  Article(
      title: 'Cách ghi nhớ bảng chữ cái Katakana siêu tốc',
      author: 'Title 1',
      description:
          'Bên cạnh bảng chữ mềm Hiragana thì bảng chữ cứng Katakana cũng là bảng chữ cái quan trọng mà những người mới bắt đầu học tiếng Nhật cần phải nắm được...',
      urlToImage:
          'https://files.tofugu.com/articles/japanese/2017-07-13-katakana-chart/happy-lilac-1.jpg',
      publshedAt: DateTime.parse("1969-07-20 20:18:04Z"),
      content: '2019',
      articleUrl: 'https://akira.edu.vn/cach-hoc-bang-chu-cai-katakana/'),
];
