부산 해산물 마켓 (釜山海産物マーケット)
-----------------------------------------------------------------------------------------------------------

팀 프로젝트 개발일지(Team Project 開発日知)　


![image](https://github.com/user-attachments/assets/0cc6191b-ee60-43b5-9660-dca814e5bfba)

관리자 권한 （管理者権限）
・Test id : admin
・Test pw : 1111

일반 유저  （一般ユーザー）
・Test id : hi
・Test pw : hi

-----------------------------------------------------------------------------------------------------------
프로젝트 소개（Project紹介）

- 당근 마켓 및 플리마켓이라는 사이트를 참고하여 부산의 지역특성으로 바다와 해산물이 유명하며, 오직 부산에서 열리는 행사를 개최하기 위한 사이트입니다.
- PC WEB 또는 스마트폰 APP을 통하여 예약을 할 수 있습니다.
- 공지사항에서는 관리자 권한으로 다른 유저들에게 공지를 알릴 수 있도록 글쓰기 , 수정 및 삭제 권한이 있습니다.
- 유저가 로그인후 마이페이지를 통하여 회원 정보를 수정할 수 있으며 이름, 이메일을 수정할 수 있습니다. 
- 메인 페이지 및 관람 안내 부분에서 다이나믹한 느낌을 주기 위해 Fade in을 사용하였습니다.
  
  (선정이유 : 저희 팀은 배운 것을 베이스로 현업에서 많이 사용할 법한 기능들을 넣고자 하였으며, 홈페이지로써의 기본적
  기능 구현을 목표로 구성하게 되었습니다. 또한 새로운 API 기능과 BootStrap 사용으로 기능을 추가하게 되었습니다.)
------

- 韓国株式会社キャロット及びフリーマーケットのサイトを参考し釜山の地域特徴上海と海産物が有名で、釜山で開かれるイベントを開催するためのサイトです。
- PC WEB 又は Smart-phone APPを通じて予約出来ます。
- お知らせページでは管理者の権限で他のユーザにお知らせ出来るよう書き込み・修正・削除の権限があります。
- ユーザーがLogin後マイページを通じて、名前・メールアドレスが修正可能にしました。
- メインページ及び観覧案内の部分をダイナミックに見えるようFade in機能を使用しました。
  
  （選定理由：私達のチームは学んだ事をベースに現業で多く使いそうな機能を入れようとしました。主にホームページで基 
   本的な機能の具現を目標に構成するようにしました。又、新しいAPI機能とBootStrapを使用し機能を追加させました。） 
-----------------------------------------------------------------------------------------------------------

   Project member : 탁성민 , 이경민 , 이지우 / 3명　
  　タク・ソンミン、イ・ギョンミン、イ・ジウ / ３人

----
1. 개발환경（開発環境）

 - DevTools : IntelliJ IDEA Ultimate
 -  HTML , JSP , CSS , JAVASCRIPT
 -  DB(DBeaver 24.1.3)사용（使用） , ERD설계（設計） , 제공된（提供された） API활용（活用
 - 버전 관리 (Version管理) : Github
 - 협업 툴 (協業 Tool) : Discord
 - Design and Nav : Bootstrap
   
-----------------------------
2. 프로젝트 구조
```
├─src
│  └─main
│      ├─java
│      │  └─com
│      │      └─example
│      │          ├─common
│      │          ├─common1
│      │          ├─project
│      │          ├─user
│      │          │  └─reservation
│      │          └─util
│      └─webapp
│          ├─01
│          ├─CreateProject
│          │  └─css
│          ├─css
│          ├─font
│          ├─html
│          │  └─.idea
│          ├─jpg
│          ├─js
│          └─WEB-INF
└─target
    ├─classes
    │  └─com
    │      └─example
    │          ├─common
    │          ├─common1
    │          ├─project
    │          ├─user
    │          │  └─reservation
    │          └─util
    ├─generated-sources
    │  └─annotations
    ├─jsp-1.0-SNAPSHOT
    │  ├─CreateProject
    │  │  └─css
    │  ├─css
    │  ├─font
    │  ├─jpg
    │  ├─META-INF
    │  └─WEB-INF
    │      ├─classes
    │      │  └─com
    │      │      └─example
    │      │          ├─common
    │      │          ├─common1
    │      │          └─util
    │      └─lib
    ├─Project-1.0-SNAPSHOT
    │  ├─9999
    │  ├─completeapp
    │  ├─CreateProject
    │  │  └─css
    │  ├─css
    │  ├─font
    │  ├─jpg
    │  ├─js
    │  ├─META-INF
    │  └─WEB-INF
    │      ├─classes
    │      │  └─com
    │      │      └─example
    │      │          ├─common
    │      │          ├─common1
    │      │          ├─project
    │      │          ├─user
    │      │          │  └─reservation
    │      │          └─util
    │      └─lib
    └─teamPjt2-1.0-SNAPSHOT
        ├─01
        ├─9999
        ├─completeapp
        ├─CreateProject
        ├─css
        ├─font
        ├─html
        │  └─.idea
        ├─jpg
        ├─js
        ├─META-INF
        └─WEB-INF
            ├─classes
            │  └─com
            │      └─example
            │          ├─common
            │          ├─common1
            │          ├─project
            │          ├─user
            │          │  └─reservation
            │          └─util
            └─lib

```
-----------
ERD 구성(構成)
![image](https://github.com/user-attachments/assets/fed0b1a9-072d-4e9c-a06a-05fe60675863)





----------
   
3. 역할분담（役割分担）
   
　- 탁성민 タク・ソンミン
 
  - CSS

  Main Page 담당
  Header , footer등 메인페이지를 비롯하여 전체 페이지의 CSS 담당
  Fade in 기능을 사용하여 홈페이지 형성

  Main Page 担当
　Header , footer等全般的なメインページを始め各ページのCSSを担当
  Fade in　機能を使用しホームページを形成


  - 이경민 イ・ギョンミン
  
  - Login
  
  Login 담당 
  
  DB와 Login 부분을 담당하였으며 Servlet을 사용하여 관리자 및 일반 유저가 로그인 하였을때
  각각의 권한을 분리 되도록 형성

  Login 担当
  
  Login DB及びLogin部分の担当でServletを使用し管理者又は一般ユーザーがLoginした際、各権限を
  分離するよう形成

 - 이지우 イ・ジウ
 
 - 공지사항 (お知らせ）

  공지사항 담당
  DB와 공지사항 부분을 담당하였으며 Servlet을 사용하지 않고 관리자 및 일반 유저가 로그인 하였을 
  때 각각의 권한으로 유저가 접속하면 목록 페이지 및 본인이 작성한 글을 수정 삭제할 수 있도록하고 
  관리자에 공지사항 글쓰기 권한 및 유저가 쓴 글을 수정할 수 있게 구성 

 お知らせ担当 
 
 DBとお知らせの部分の担当でServletを使用せず管理者又は一般ユーザーがLoginした際、各権限でユーザー 
 がLoginしたら目録ページ及び本人が作成した文を修正や削除が出来るようにし管理者もユーザーが作成した
 文を修正・削除出来るように構成


----------
4. 개발 기간 및 작업관리（開発期間及び作業管理）

- 2024-8-1 ~ 2024-8-23 

- GitHub Projects와 Discord를 사용하여 진행 상황을 공유했습니다.

  GitHub Projectsと Discordを使用し状況を共有しました。

------------
5. 신경 쓴 부분

  気にした部分

- 접근제어 설정
- 메인페이지

- 接近制御設定
- メインページ

 --------
 6. 페이지별 기능
   ページ別機能

메인페이지 Fade in
![chrome-capture-2024-8-29 (1)](https://github.com/user-attachments/assets/93e9c3aa-0963-4d6f-af85-842ea9596341)

