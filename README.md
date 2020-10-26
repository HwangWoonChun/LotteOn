# LotteOn

롯데ON 서비스에 있는 상품 목록과 상품 필터 화면을 만들면 됩니다.

[ https://user-images.githubusercontent.com/8130860/97140418-e8ecbd00-179f-11eb-99f1-191abd5b4ae3.gif | height = 100px ]

|기본기능|초기화|
|---|---|---|
|![기본기능](https://user-images.githubusercontent.com/8130860/97140418-e8ecbd00-179f-11eb-99f1-191abd5b4ae3.gif)|<img src = "https://user-images.githubusercontent.com/8130860/97099308-ff751480-16ca-11eb-8268-cfe8be1c177b.png" width = 207 height = 368>|

# 요구사항

####다음의 기능을 가져야 합니다.

- 상품목록의 데이터는 product_list.json 파일에 담겨 있습니다.

  - "t" 는 몰 구분번호 입니다.
    "0": 롯데ON, "1": 롯데백화점, "2": 롯데마트, "3": 롭스 
  - "n" 은 상품의 이름 입니다.
  - "b" 는 브랜드 이름 입니다.
  - "i" 는 상품의 이미지 입니다.
  - "op"는 상품의 원가 입니다.
  - "p" 는 상품의 판매가 입니다.
  - "d" 는 상품의 할인율 입니다.

- 상품 목록 (lotteOn_productList)
  1. 상품은 예시 디자인과 같이 2열로 표시
  2. 전체 상품의 갯수 표시
  3. 상품
     - 상품 목록에서 상품 이미지 표시
     - 상품 목록에서 브랜드 이름 표시 (볼드)
     - 상품 목록에서 상품명 표시 (상품명은 최대 2줄까지 노출합니다)
     - 할인율이 0보다 큰 경우 상품의 원가 노출
     - 원가 노출 시에는 취소선이 그어진 형태로 표시
     - 상품의 판매가 표시
  4. 정렬 버튼
     - 랭킹순 (원본 json데이터의 순서), 낮은가격순, 높은가격순 의 조건을 가집니다.
     - Default 값은 랭킹순 입니다.
     - 조건의 노출 방법(디자인) 은 자유롭게 하셔도 무방합니다.
  5. 필터 버튼
     - 클릭 시 필터화면 노출
     - 설정되어있는 필터가 있는 상태로 필터화면에 진입 할 경우 설정되어있는 필터가 선택되어 있어야합니다.
6. 필터에서 선택한 조건과 정렬 기준을 모두 만족하는 상품을 표시 합니다.
  
- 필터 (lotteOn_filter)
  1. 매장 필터
     - 몰 구분번호에 의하여 매장 필터를 구성 합니다.
     - 매장 필터는 중복 선택 가능합니다.
  2. 가격 필터
     - 가격 필터의 범위는 상품목록의 판매가의 최소값과 최대값으로 합니다.
     - 슬라이드의 간격은 1000원 단위로 합니다.
  3. 필터 선택 시 선택된 조건을 만족하는 상품의 갯수를 표시 합니다.
  4. 초기화 버튼을 선택 한 경우 모든 필터를 초기화 합니다.
  5. 상품보기 버튼을 선택하면 상품 목록 화면으로 돌아가고 선택한 모든 조건을 모두 만족하는 상품만 표시 합니다.

- 예제 이미지의 디자인을 완벽히 구현하지 않아도 됩니다.
- Architecture 와 Library 는 자유롭게 사용하셔도 무방합니다.
- Xcode에서 표시되는 컴파일 경고는 가급적 모두 해결해 주세요.
- Swift 사용을 권장합니다.

# 평가기준

* 기능 완성도
* 코드 구성 / 코드 가독성 (불필요한 주석은 없는 것을 선호합니다)
