# nbcamp-Project-TravelLogAPP
[내일배움캠프 iOS트랙] 10~11주차 개인과제/iOS 앱개발 심화 프로젝트 - 정해진 UI 및 CoreData 구현하기
<br><br><br><br>


## 📆 프로젝트 기간
* 2023-09-12(화) ~ 2023-09-22(금), 9일간
<br><br>

## 📚 구현 기능
- **필수 구현 기능**
    - [x] CoreData를 사용해서 데이터 일관성 유지하기
    - [x] Life Cycle을 고려하여 데이터를 불러오는 시점을 생각하여 설계하기
    - [x] UI 동일하게 구현하기
    - [x] Profile 페이지 만들기
   <br>
  
- **선택 구현 기능**
    - [x] TableView의 Section과 Header를 사용해서 Task데이터 나타내기
    - [x] App Icon, Launch Screen 설정하기
    - [x] 프로필 수정 페이지 만들기 (ProfileViewController)
    - [x] Task와 Category의 관계(Relation) 적용하기
<br>

##  🛠️ 사용한 기술 스택 (Tech Stack)

<img src="https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=Xcode&logoColor=white"/></a>
<img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=Swift&logoColor=white"/></a>
<br><br>
<div align="left">

## 🏹 사용한 라이브러리

1. [SnapKit](https://github.com/SnapKit/SnapKit)
2. CoreData
<br><br>

## ⚡️ 라이브러리 사용 이유
1. ***SnapKit*** <br>
`Auto Layout`을 쉽게 설정하기 위해 사용
2. ***CoreData*** <br>
`Data`을 일관성있게 다루기 위해 사용
<br><br>

## TravelLogAPP 파일 구조
<div style="display: flex; flex-direction: row;">
    <img width="327" src="https://github.com/anfgbwl/TravelLogAPP/assets/53863005/f2f4295d-4b94-47b8-bb0c-351dc6f07dea">
</div>
<br><br>

## TravelLogAPP 구조
![‎MVVM ‎001](https://github.com/anfgbwl/TravelLogAPP/assets/53863005/cab2af85-5de3-4c9a-a2d2-7fc0d251b34c)


### 1. Model
- 데이터와 비즈니스 로직을 포함합니다.
- 데이터를 다루고 조작하는 역할을 합니다.
- 데이터 관련 작업을 수행합니다.

### 2. View
- 사용자 인터페이스(UI)를 표시합니다.
- 사용자에게 정보를 보여주고 입력을 받는 역할을 합니다.
- UIViewController, UIView 등과 연관됩니다.

### 3. ViewModel
- View와 Model 사이의 중간 역할을 합니다.
- View에게 데이터를 제공하고 사용자 입력을 처리합니다.
- 데이터 바인딩을 통해 View와 양방향으로 연결됩니다.
<br>

## MVVM 패턴 장점
- `뷰와 로직의 분리`: 뷰 코드와 비즈니스 로직 코드가 서로 혼재하지 않아 유지 보수가 더 쉽습니다.
- `테스트 용이성`: ViewModel은 순수한 비즈니스 로직을 포함하고 있으며, 이 로직을 독립적으로 테스트하기 편리합니다.
- `재사용성`: 동일한 비즈니스 로직을 여러 뷰에서 사용하거나 다른 프로젝트에서 재사용할 수 있습니다.
- `데이터 바인딩`: 데이터 바인딩을 사용하면 뷰와 ViewModel 간의 데이터 흐름을 자동화할 수 있으며 UI 업데이트가 간편해집니다.
<br>

## MVC 패턴과 비교
- 

<br>

## 데이터 일관성 비교

### UserDefaults
- 

### CoreData
-
