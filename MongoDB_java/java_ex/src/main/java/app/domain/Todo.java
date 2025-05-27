package app.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Todo {
    private ObjectId id;     // MongoDB _id 필드
    private String title;    // 할일 제목
    private String desc;     // 할일 설명
    private boolean done;    // 완료 여부
}
