package sec02;

import app.Database;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.result.InsertOneResult;
import org.bson.Document;

public class InsertOneTest {
    public static void main(String[] args) {
        // Database 유틸리티 클래스를 이용해서 todo 컬렉션(테이블)이 연결 객체 얻어오기
        MongoCollection<Document> collection = Database.getCollection("todo");

        // 문서(행)을 정의하는 객체 생성(BSON)
        Document document = new Document();
        document.append("title", "MongoDB");
        document.append("desc", "MongoDB 공부하기");
        document.append("done", false);

        InsertOneResult result = collection.insertOne(document);
        System.out.println("==> InsertOneResult : " + result.getInsertedId());
        Database.close();
    }
}
