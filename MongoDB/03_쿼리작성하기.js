// === 상품 정보 조회 ===
db.products.find()

// 조회된 laptop-1을 product 변수에 저장
product = db.products.findOne({'slug': 'laptop-1'})
console.log(product)

// === 연관 데이터 조회 ===
// 해당 상품의 카테고리 정보
db.categories.findOne({'_id': product['main_cat_id']})


// 해당 상품의 리뷰 목록
db.reviews.find({'product_id': product['_id']})

// === 기본 페이지네이션 ===
product = db.products.findOne({'slug': 'laptop-1'})
console.log(product)


// 첫 번째 페이지 (0-11번째 리뷰)
db.reviews.find({'product_id': product['_id']})
db.reviews.countDocuments({'product_id': product['_id']})


db.reviews.find({'product_id': product['_id']})
    .skip(0) // 넘기는 것 없음
    .limit(12) // 다음 12개 조회 (0~11)
    .sort({'helpful_votes': -1}) // helpful_votes 필드값 내림차순 조회


// === 완전한 페이지네이션 시스템 ===
page_number = 1  // 현재 페이지 번호
page_size = 12   // 페이지당 항목 수

product = db.products.findOne({'slug': 'laptop-1'})
category = db.categories.findOne({'_id': product['main_cat_id']})

// 전체 리뷰 개수 (구 버전)
reviews_count = db.reviews.count({'product_id': product['_id']})

// 전체 리뷰 개수 (신 버전 - MongoDB 4.0+)
reviews_count = db.reviews.countDocuments({'product_id': product['_id']})


// 페이지네이션된 리뷰 조회
reviews = db.reviews.find({'product_id': product['_id']})
    .skip((page_number - 1) * page_size)
    .limit(page_size)
    .sort({'helpful_votes': -1})


// === 카테고리별 상품 리스트 ===

db.categories.find() // categories 컬렉션의 모든 document 조회

category = db.categories.findOne({'slug': 'electronics'})
console.log(category)

// 해당 카테고리 상품 목록 + 페이지네이션(5개당 1페이지)
db.products.find({'category_id': category['_id']})
page_number = 1
page_size = 5
products = db.products.find({'category_id': category['_id']})
    .skip((page_number - 1) * page_size)
    .limit(page_size)
    .sort({'helpful_votes': -1})
console.log(products)

// === 전체 사용자 조회 ===
db.users.find({})

// === 단일 조건 ===
db.users.find({'last_name': "White"})

// === 복수 조건 (묵시적 AND) ===
db.users.find({'first_name': "Tom", 'birth_year': 1993})

// === 명시적 AND (복잡한 조건 시) ===
db.users.find({
    $and: [
        {'first_name': "Kelly"},
        {'birth_year': 1979}
    ]
})

db.items.insertMany([
    { "_id" : ObjectId("4caf82011b0978483ea29ada"), "value" : 97 },
    { "_id" : ObjectId("4caf82031b0978483ea29adb"), "value" : 98 },
    { "_id" : ObjectId("4caf82051b0978483ea29adc"), "value" : 99 },
    { "_id" : ObjectId("4caf820d1b0978483ea29ade"), "value" : "a" },
    { "_id" : ObjectId("4caf820f1b0978483ea29adf"), "value" : "b" },
    { "_id" : ObjectId("4caf82101b0978483ea29ae0"), "value" : "c" }
])

// === 타입별 범위 검색 ===
// 정수 범위 검색 (숫자 데이터만 반환)
db.items.find({'value': {'$gte': 97}})

// 문자열 범위 검색 (문자열 데이터만 반환)
db.items.find({'value': {'$gte': "a"}})