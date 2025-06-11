# 🚇 타고또타고
---
실시간 지하철 어플입니다. xcode swift 언어를 사용해서 개발을 진행했습니다.
### 📖 프로젝트 소개
IOS로 어떤 앱을 만들까 고민하던 중 항상 이용하는 지하철을 떠올렸고

자주 이용하는 지하철 앱들을 보며 한번 만들어보고 구조를 이해해 보고 싶어 진행하게 되었습니다.
***
### ⚙️ 개발 환경
macOS Ventura ver.13.7.4
### 🔨 개발 도구
**xcode(ver.14.2)**

**programming language:** Swift

**Database:** Firebase

**역 배열:** JSON

**Open API:** 서울열린데이터광장 실시간지하철도착정보 

https://data.seoul.go.kr/dataList/OA-12764/F/1/datasetView.do
***
### 기능 소개


+ **메인 화면:** 지하철 노선도

  <img src="https://github.com/user-attachments/assets/00d255df-c8c4-4520-9932-f6a425279ee4" width="200">

  앱을 실행 시키면 나오는 화면입니다. 이곳에서 지하철 노선도를 확인 할 수 있습니다. 확대, 축소, 스크롤이 가능합니다.

+ **검색 화면**

  <img src="https://github.com/user-attachments/assets/317dcade-2812-4d6d-a05e-4bc12e6ba7e3" width="200"> <img src="https://github.com/user-attachments/assets/ac4dd377-f32b-4d61-863a-2d8a6c8fac5f" width="200"> <img src="https://github.com/user-attachments/assets/116d4d39-40a0-42f6-974f-a91255e85c80" width="200">

  검색 기능입니다. 스크롤을 통해 직접 역을 찾을 수도 있고, 상단 검색창에 검색해서 찾을 수도 있습니다.

  역 명 오른쪽의 노란 별 아이콘을 누르면 불이 들어오며 해당 역은 프리셋 뷰에 나타나게 됩니다.

  역을 누르면 해당 역의 상행, 하행, 무슨 역 방면인지, 급행인지, 몇 전역에 위치하는지 등의 정보가 나타납니다.

+ **프리셋 화면**

  <img src="https://github.com/user-attachments/assets/0654645c-247b-4f4d-a3a3-905f590eb8b9" width="200">

  검색에서 노란 별 아이콘과 상호작용한 역들이 이곳에 표시됩니다.
  
  이 기능을 통해 사용자가 자주 이용하는 역을 한눈에 확인할 수 있으며,

  마찬가지로 역을 누르면 정보창으로 이동합니다.

  다시 채워진 노란 별 아이콘을 누르면 프리셋 지정이 해제됩니다.

+ **공지사항**

  <img src="https://github.com/user-attachments/assets/67ccba9f-16d3-4b1c-bf13-5fac0f7ddb7a" width="200">

  개발자의 공지사항이 업데이트되는 곳입니다.

  firebase를 통해 업데이트가 되면 따라서 내용이 업로드 됩니다.

***
  
### 📷 동작 영상

https://github.com/user-attachments/assets/4424d7ed-9278-4ca6-a636-ad87e6159035

앱의 실행 영상입니다.  
