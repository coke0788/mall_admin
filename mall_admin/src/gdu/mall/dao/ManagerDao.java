package gdu.mall.dao;
import gdu.mall.vo.*;
import java.sql.*;
import java.util.*;
import gdu.mall.util.*;

public class ManagerDao {
	public static ArrayList<Manager> selectManagerListByZero() throws Exception{
		//승인 대기중인 매니저 목록
		//1. sql문 작성
		String sql = "SELECT manager_id, manager_date FROM manager WHERE manager_level=0";
		//2. return 타입 초기화
		ArrayList<Manager> list = new ArrayList<>();
		//3. db
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next() ) { //목록 쿼리 값 정의
			Manager m = new Manager();
			m.setManagerId(rs.getString("manager_id"));
			m.setManagerDate(rs.getString("manager_date"));
			list.add(m); //list에 쿼리값 정의한 것들을 추가하기. 
		}
		//디버깅
		System.out.println("목록 stmt:"+stmt);	
		return list;
	}
	//전체 행의 수
	public static int totalCount() throws Exception{
		String sql = "SELECT COUNT(*) cnt FROM manager";
		int totalRow=0;
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		System.out.println("토탈페이지 stmt : "+stmt);
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		return totalRow;
	}
	
	//수정 메서드
	public static int updateManagerLevel(String managerId, int managerLevel) throws Exception{
		//1. sql문 작성
		String sql = "UPDATE manager set manager_level=? WHERE manager_id=?";
		//2. return 타입 초기화
		int rowCnt = 0;
		//3. db
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerLevel);
		stmt.setString(2, managerId);
		rowCnt=stmt.executeUpdate();
		
		System.out.println("수정 stmt="+stmt);
		
		//4. 리턴
		return rowCnt;
	}
	//삭제 메서드
	public static int deleteManager(int managerNo) throws Exception{
		//1. sql문 작성
		String sql = "DELETE from manager WHERE manager_no=?";
		//2. return 타입 초기화
		int rowCnt = 0;
		//3. db
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerNo);
		rowCnt=stmt.executeUpdate();
		
		System.out.println("삭제 stmt="+stmt);
		//4. 리턴
		return rowCnt;
		
	}
	
	
	//목록 메서드
	public static ArrayList<Manager> selectManagerList(int rowPerPage, int beginRow) throws Exception {
		//1. sql문 작성
		String sql = "SELECT manager_no managerNo, manager_id managerId, manager_name managerName,manager_date managerDate, manager_level managerLevel FROM manager ORDER BY manager_level DESC LIMIT ?, ?";
		
		//2. return 타입 초기화
		ArrayList<Manager> list = new ArrayList<>();
		
		//3. db
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next() ) { //목록 쿼리 값 정의
			Manager m = new Manager();
			m.setManagerNo(rs.getInt("managerNo"));
			m.setManagerId(rs.getString("managerId"));
			m.setManagerName(rs.getString("managerName"));
			m.setManagerDate(rs.getString("managerDate"));
			m.setManagerLevel(rs.getInt("managerLevel"));
			list.add(m); //list에 쿼리값 정의한 것들을 추가하기. 
		}
		
		//디버깅
		System.out.println("목록 stmt:"+stmt);
		
		//4. 리턴
		return list;
	}
	//입력 메서드
	public static int insertManager(String managerId, String managerPw, String managerName) throws Exception{
		//1. sql문 작성
		String sql = "INSERT INTO manager(manager_id,manager_pw,manager_name,manager_date, manager_level) VALUES(?,?,?,now(),0)";
		
		//2. return 타입 초기화
		int rowCnt = 0; //입력 성공 시 1, 입력 실패 시 0
		
		//3. db
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		stmt.setString(3, managerName);
		
		//디버깅 -> 값을 넘겨 받으면 무조건 작성하기.
		System.out.println(stmt+": stmt");
		rowCnt = stmt.executeUpdate();
		return rowCnt;
	}
	//id 중복 확인
	public static String selectManagerId(String managerId) throws Exception {
		//1. sql문 작성
		String sql = "SELECT manager_id FROM manager WHERE manager_id=?";
		
		//2. return타입 초기화 (현재는 String. void 일 경우 할 필요 x)
		String returnManagerId = null;
		
		//3. db 준비 > 전처리 > 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			returnManagerId = rs.getString("manager_id");
		}
		
		// 4. 리턴
		return returnManagerId;
	}
	
	//로그인 메서드
	public static Manager login(String managerId, String managerPw) throws Exception { //만약에 메소드 실행 중 예외가 발생하면 끝낸다?
		//매니저 아이디와 패스워드가 일치하고 레벨값이 0보다 클 경우 진입 가능
		String sql = "SELECT manager_id, manager_name, manager_level FROM manager WHERE manager_id=? AND manager_pw=? AND manager_level>0";
		Manager manager = null;
		
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		//디버깅
		System.out.println("stmt="+stmt);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			manager = new Manager();
			manager.setManagerId(rs.getString("manager_id"));
			manager.setManagerName(rs.getString("manager_name"));
			manager.setManagerLevel(rs.getInt("manager_level"));
		}
		return manager;
	}
}