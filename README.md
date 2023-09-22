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
- ViewModel 사용으로 ViewController의 역할이 매우 축소되고 각 컴포넌트의 역할이 명확해집니다.
- 다만, View와 관련된 비즈니스 로직을 ViewModel에 넣다보니 유사 로직이 각 ViewModel에 중복으로 작성될 수 있습니다.
- 이 문제는 중복 로직은 Model에 적용될 수 있게 설계하면 가독성 높은 코드로 작성이 가능합니다.
- 로직의 변경과 오류를 해결하는데 있어서 MVVM이 훨씬 수월합니다.
<br>

## 데이터 일관성 비교
![TravelLogAPP drawio](https://github.com/anfgbwl/TravelLogAPP/assets/53863005/ef2ebde9-d9fe-44d5-8eab-445a6857aade)

### UserDefaults
- UserDefaults는 파일 시스템에서 키-값 쌍 형식으로 데이터를 저장하기 때문에 단순하고 빠르지만, 복잡한 모델 구조에 적용하기에 어려움이 있습니다.
- 트랜잭션을 지원하지 않아, 여러 개의 UserDefaults값을 동시에 업데이트/롤백하는데 어려움이 있습니다.
- 주로 기본 데이터 유형 (ex. String, Int, Bool)을 저장하며, 데이터의 복잡성 및 유효성 검사가 제한적입니다.
- 병행 액세스와 데이터 동기화를 처리하는 기능을 제한적으로 지원합니다. 따라서 여러 스레드 또는 프로세스에서 데이터를 동시에 업데이트하면 데이터 일관성 문제가 발생할 수 있습니다.

### CoreData
- 데이터베이스 형식으로 데이터를 저장하므로 모델과 테이블 간의 관계를 다루기 쉽습니다.
- 트랜잭션을 지원하여 여러 개의 데이터를 업데이트하고 롤백할 수 있습니다. 이를 통해 데이터 일관성을 더 잘 유지할 수 있습니다.
- 복잡한 데이터 모델을 정의하고 데이터 유효성을 더욱 강화할 수 있습니다. 데이터 일관성을 유지하기 위해 관계와 제약 조건을 사용할 수 있습니다.
- 병행성 관리를 위한 다양한 옵션과 동시 액세스에 대한 더 나은 지원을 제공합니다.

  
<br><br>

## 🧐 앱 실행 및 사용 방법
![‎앱실행화면 ‎001](https://github.com/anfgbwl/TravelLogAPP/assets/53863005/b389e075-4b09-4e85-9f74-9128f2f5921f)



<br><br>

## 💥 트러블 슈팅
- 카테고리 변경 시 기존 카테고리가 삭제되지 않음
  ```
  deleteCategory 메서드에서 카테고리 삭제 시 연관된 task의 여부를 확인하고, 연관된 task가 없을 때만 삭제하도록 수정
  ```
- 카테고리 추가 및 삭제 후 데이터 일관성 문제
  ```
  카테고리를 추가 또는 삭제한 후 데이터베이스 내용을 업데이트하기 위해 fetchCategory 메서드를 호출하여 데이터베이스 내용을 즉시 갱신하도록 수정
  ```
- 카테고리가 변경된 경우 해당 카테고리의 task가 테이블뷰에 즉시 반영되지 않는 문제
  ```
  카테고리 변경 후에 tableView.reloadData() 메서드를 호출하여 테이블뷰를 리로드하여 변경된 task를 반영하도록 수정
  ```
- fetchBucketList 함수 내 tableView reload 핸들러 미작동 문제
  ```
  Caterogy 및 BucketList fetch 이전에 핸들러를 설정하도록 함수 호출 위치 변경
  ```
- **(미해결)** Task 추가 시 테이블 뷰 리로드되지 않는 문제
- **(미해결)** 모든 Task 삭제 시 카테고리가 N/A로 유지되어 보이는 문제
