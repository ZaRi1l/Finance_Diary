# 📱 Finance-Diary: Trading Diary & Analysis App

<div align="center">
  <img src="docs/홍보용 사진/메인사진.png" width="800"/> 
</div>
<br/>

- **프로젝트 기간** : 2023.07 ~ 2023.08 (기획, 개발 및 배포)
- **개요** : Flutter를 사용하여 **기획부터 개발, 광고 수익화, 그리고 Google Play Store 배포까지 전 과정을 1인 개발**로 완성한 매매일지 애플리케이션입니다. 자신의 매매를 기록하고 시각적으로 분석하여 투자 습관을 개선하는 데 도움을 주는 것을 목표로 합니다.

<br>

Google Play 다운로드: https://play.google.com/store/apps/details?id=com.trade.trading_diary&hl=ko-KR

<br>

---

## 🚀 주요 기능 (Key Features)

- **📈 상세한 매매 기록**:
  - 주식, 코인 등 종목에 구애받지 않고 매매 내역(매수/매도, 평단가, 수량)을 기록.
  - 날짜별, 종목별로 기록을 관리하고 손쉽게 조회 가능.

- **📊 시각적 분석 및 통계**:
  - 누적 손익, 총 투자금, 실현 손익 등 투자 현황을 한눈에 파악.
  - **`fl_chart`** 라이브러리를 활용하여 수익률 변화를 동적인 그래프로 시각화.

- **🔍 강력한 필터링 및 검색**:
  - 기간별, 종목명 등 다양한 조건으로 거래 내역을 필터링.
  - 원하는 종목의 거래 기록만 빠르게 찾아볼 수 있는 검색 기능.

- **💾 데이터 백업 및 공유 (Excel)**:
  - **`excel`**, **`path_provider`** 라이브러리를 통해 모든 매매 기록을 Excel(.xlsx) 파일로 내보내기.
  - **`permission_handler`** 를 사용하여 저장소 접근 권한을 안전하게 관리.

- **💰 광고 수익화**:
  - **`google_mobile_ads`** 를 적용하여 배너 광고를 통한 앱 수익화 모델 구현.

<br>

---

## 🛠️ 기술 스택 및 핵심 구현 내용

| Category | Technologies & Libraries | Description |
|---|---|---|
| **Core** | <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white"/> <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white"/> | 앱의 기본 언어 및 크로스플랫폼 프레임워크 |
| **Data Persistence** | **File I/O, `path_provider`, `csv`** | 로컬 DB 없이, 파일 입출력을 직접 구현하여 매매 데이터를 기기 내에 영구적으로 저장 및 관리 |
| **Chart** | **`fl_chart`** | 수익률 데이터를 시각적으로 표현하기 위한 동적 라인 차트 구현 |
| **File & Permission** | **`excel`, `path_provider`, `permission_handler`** | 메모리의 데이터를 Excel 파일로 변환하고, 안전하게 저장소에 저장 및 권한 관리 |
| **UI/UX** | **`flutter_screenutil`, `fluttertoast`** | 다양한 화면 크기에 대응하는 반응형 UI 및 사용자 피드백 토스트 메시지 구현 |
| **Monetization** | **`google_mobile_ads`** | Google AdMob을 연동하여 앱 내 배너 광고를 통한 수익화 구현 |
| **Etc.** | `intl` (날짜/숫자 포맷팅), `flutter_svg` (SVG 이미지 사용) | |


<br>

---

## ✨ 1인 개발을 통해 얻은 역량

이 프로젝트는 **Flutter 프레임워크를 독학**하며 진행한 첫 번째 앱 개발 프로젝트입니다. 혼자 아이디어를 구체화하고, 필요한 기술을 학습하며 실제 사용 가능한 앱을 만들기까지의 전 과정을 경험하며 다음과 같은 역량을 길렀습니다.

- **Full-Cycle 앱 개발 경험**: 기획, UI/UX 설계, 개발, 테스트, 그리고 **Google Play Store 배포 및 광고 수익화**까지 앱 생명주기 전체를 독립적으로 관리하고 완성했습니다.
- **독립적인 문제 해결 능력**: 기능 구현 중 발생하는 수많은 에러와 기술적 난관들을 공식 문서, 커뮤니티 등을 통해 스스로 해결하는 능력을 길렀습니다.
- **아키텍처 설계 및 적용**: 데이터의 흐름과 상태 관리를 효율적으로 하기 위한 구조를 고민하고, 다양한 라이브러리를 목적에 맞게 조합하여 적용했습니다.

자세한 개발 후기는 [Tistory 블로그](https://stellacode.tistory.com/entry/App-%EB%A7%A4%EB%A7%A4%EC%9D%BC%EC%A7%80-%EC%BD%94%EC%9D%B8-%EC%A3%BC%EC%8B%9D-%EB%B6%84%EC%84%9D)에 기록해두었습니다.
