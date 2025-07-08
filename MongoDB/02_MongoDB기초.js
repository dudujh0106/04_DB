//use my_database

db.users.find()

//use tutorial2

// 1행 삽입
db.users.insertOne({username: "smith"})

// 여러 행 삽입
db.users.insertMany([
    {username: "tom"},
    {username: "jones"}
])

// 확인(조회, find)
db.users.find({})   // 모두 다 조회

// document(행) 개수 확인
db.users.countDocuments()
db.users.estimatedDocumentCount()   // 추정치 계산

// username이 일치하는 document 검색
db.users.find({username: "jones"})

// 묵시적 AND
// - 자동 생성된 _id 필드 값은 꼭 ObjectId() 감싸줘라!!!
db.users.find({
    _id : ObjectId("6833ede43cfaee18f8bccfd1"),
    username : "jones"
})

// 명시적 AND
db.users.find({
    $and : [
        {_id : ObjectId("6833ede43cfaee18f8bccfd1")},
        {username : "jones"}
    ]
})

// OR 연산자 사용
db.users.find({
    $or : [
        {username: "smith"},
        {username : "jones"}
    ]
})

// === 필드 추가 ===
// 구 버전 (MongoDB 3.2 이전)
db.users.update({username: "smith"}, {$set: {country: "Canada"}})

// 신 버전 (MongoDB 3.2+) - 권장
db.users.updateOne(
    {username: "smith"}, // 쿼리 셀렉터
    {$set: {country2: "Canada2"}} // {$set/$unset : {바꿀 필드 : 값}}
)

// === 결과 확인 ===
db.users.find({username: "smith"})


// === 필드 삭제 ===
// 구 버전 (MongoDB 3.2 이전)
// country 필드 삭제
db.users.update({username: "smith"}, {$unset: {country: 1}})

// 신 버전 (MongoDB 3.2+) - 권장
db.users.updateOne({username: "smith"}, {$unset: {country2: 1}})

// === 결과 확인 ===
db.users.find({username: "smith"})

// 대체
db.users.replaceOne({username: "smith"}, {country2: "Canada"})

db.users.find()

// === 복잡한 데이터 업데이트 ===
// 구 버전 (MongoDB 3.2 이전)
db.users.update({username: "tom"}, {
    $set: {
        favorites: {
            cities: ["Chicago", "Cheyenne"],
            movies: ["Casablanca", "For a Few Dollars More", "The Sting"]
        }
    }
})

// 신 버전 (MongoDB 3.2+) - 권장
db.users.updateOne({username: "tom"}, {
    $set: {
        favorites: {
            cities: ["Chicago", "Cheyenne"],
            movies: ["Casablanca", "For a Few Dollars More", "The Sting"]
        }
    }
})

db.users.updateOne({username: "jones"}, {
    $set: {
        favorites: {
            movies: ["Casablanca", "Rocky"]
        }
    }
})

db.users.find({"favorites.movies": "Casablanca"}).pretty()


// === 다중 업데이트 비교 ===

// 신 버전 (MongoDB 3.2+) - 권장
db.users.updateMany(
    {"favorites.movies": "Casablanca"},
    {$addToSet: {"favorites.movies": "The Maltese Falcon"}},
    {upsert: false} // multi 옵션 불필요
)
// 1. favorites 객체 안의 movies 배열에 "Casablanca"가 포함된 도큐먼트 찾기
// 2. favorites.movies 배열에 "The Maltese Falcon" 추가 (이미 있으면 추가 안함)
// 3. upsert: false: 조건에 맞는 도큐먼트가 없어도 새로 생성하지 않음
// 4. multi: true: 조건에 맞는 모든 도큐먼트를 수정


// === 단일 업데이트 (신버전) ===
db.users.updateOne(
    {"favorites.movies": "Casablanca"},
    {$push: {"favorites.movies": "Citizen Kane"}}
)

// 1. favorites 객체 안의 movies 배열에 "Casablanca"가 포함된 도큐먼트 찾기
// -updateOne() 메서드이기 때문에 조건에 맞는 첫 번째 도큐먼트만 수정
// 2. favorites.movies 배열에 "Citizen Kane" 추가 (중복 허용)

db.users.find({"favorites.movies": "Casablanca"})

// 삭제
// 신 버전 (MongoDB 3.2+) - 권장
db.users.deleteOne({"favorites.cities": "Cheyenne"})    // 첫 번째 문서만 삭제
db.users.deleteMany({"favorites.cities": "Cheyenne"})   // 조건에 맞는 모든 문서 삭제

// === 모든 문서 삭제 ===
db.users.deleteMany({})  // 모든 문서 삭제 (컬렉션 유지)
db.users.countDocuments()

// === 컬렉션 삭제 ===
db.users.drop()  // 버전 무관 - 컬렉션 자체 삭제

//use tutorial2

for(let i = 0; i < 20000; i++) {
    db.numbers.insert({num: i});
}

// 도큐먼트 개수 확인
db.numbers.countDocuments()

// 큰 값 검색 ($gt: greater than)
db.numbers.find({num: {"$gt": 19995}})

// 범위 검색 ($gt, $lt)
db.numbers.find({num: {"$gt": 20, "$lt": 25}})

// 쿼리 실행 계획 확인
db.numbers.find({num: {"$gt": 19995}}).explain("executionStats")

db.numbers.createIndex({num: 1})

// === 인덱스 확인 ===
db.numbers.getIndexes()  // 버전 무관

db.hello()