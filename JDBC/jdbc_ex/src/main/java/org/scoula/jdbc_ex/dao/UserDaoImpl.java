package org.scoula.jdbc_ex.dao;

import org.scoula.jdbc_ex.common.JDBCUtil;
import org.scoula.jdbc_ex.domain.UserVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserDaoImpl implements UserDao {
    Connection conn = JDBCUtil.getConnection();

    private String USER_LIST = "SELECT * FROM users";
    private String USER_GET = "SELECT * FROM users WHERE id = ?";
    private String USER_INSERT = "INSERT INTO users VALUES (?, ?, ?, ?)";
    private final String USER_UPDATE = "update users set name = ?, role = ? where id = ?";
    private final String USER_DELETE = "delete from users where id = ?";

    /**
     * ResultSet에서 UserVO 객체로 매핑하는 메서드
     * @param rs 데이터베이스 쿼리 결과셋
     * @return 결과셋의 현재 행을 기반으로 생성된 UserVO 객체
     * @throws SQLException DB 작업 중 오류 발생 시
     */
    private UserVO map(ResultSet rs) throws SQLException {
//        UserVO user = new UserVO();
//        user.setId(rs.getString("ID"));           // 사용자 ID
//        user.setPassword(rs.getString("PASSWORD")); // 비밀번호
//        user.setName(rs.getString("NAME"));       // 이름
//        user.setRole(rs.getString("ROLE"));       // 역할
        UserVO user = UserVO.builder()
                .id(rs.getString("id"))
                .password(rs.getString("password"))
                .name(rs.getString("name"))
                .role(rs.getString("role"))
                .build();
        return user;
    }

    @Override
    public int create(UserVO user) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(USER_INSERT)) {
            ps.setString(1, user.getId());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getName());
            ps.setString(4, user.getRole());

            return ps.executeUpdate();
        }
    }

    @Override
    public List<UserVO> getList() throws SQLException {
        List<UserVO> userList = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(USER_LIST)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserVO user = map(rs);
                userList.add(user);
            }
        }
        return userList;
    }

    @Override
    public Optional<UserVO> get(String id) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(USER_GET)) {
            ps.setString(1, id);
            try(ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(map(rs));
                }
            }
        }
        // 조회 결과가 없으면 비어있는 Optional
        return Optional.empty();
    }

    @Override
    public int update(UserVO user) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(USER_UPDATE)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getRole());
            ps.setString(3, user.getId());

            return ps.executeUpdate();
        }
    }

    @Override
    public int delete(String id) throws SQLException {
        try(PreparedStatement pstmt = conn.prepareStatement(USER_DELETE)) {
            pstmt.setString(1, id);                          // ID 파라미터 바인딩
            return pstmt.executeUpdate();                    // 쿼리 실행 및 영향받은 행 수 반환
        }
    }
}
