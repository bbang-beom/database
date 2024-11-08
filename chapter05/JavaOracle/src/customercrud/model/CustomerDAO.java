package customercrud.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
	// DB 연결 정보
	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String userId = "c##madang";
	private String pwd = "madang";
	
	// DB 연결 객체
	private Connection conn = null;
	private PreparedStatement pstm = null;
	private ResultSet rs = null;
	
	// 연결
	public void connect() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, userId, pwd);
			System.out.println("연결 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 해제
	public void disconnect() {
		if(conn != null) {
			try {
				conn.close();
				System.out.println("연결 해제");
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(pstm != null) {
			try {
				pstm.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(rs != null) {
			try {
				rs.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	// Read
	public List<CustomerDTO> getCustomers() {
		List<CustomerDTO> customers = new ArrayList<CustomerDTO>();
		String sql = "select * from customer";
		try {
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();
			while(rs.next()) {
				CustomerDTO customer = new CustomerDTO();
				customer.setCustId(rs.getInt(1));
				customer.setName(rs.getString(2));
				customer.setAddress(rs.getString(3));
				customer.setPhone(rs.getString(4));
				customers.add(customer);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return customers;
	}
	
	// key로 Read
	public CustomerDTO getCustomer(int custId) {
		CustomerDTO c = new CustomerDTO();
		String sql = "select * from customer where custid = ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, custId);
			rs = pstm.executeQuery();
			while(rs.next()) {
				c.setCustId(rs.getInt(1));
				c.setName(rs.getString(2));
				c.setAddress(rs.getString(3));
				c.setPhone(rs.getString(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c;
	}
	
	// insert(create)
	public void putCustomer(CustomerDTO c) {
		String sql = "insert into customer values(?,?,?,?)";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, c.getCustId());
			pstm.setString(2, c.getName());
			pstm.setString(3, c.getAddress());
			pstm.setString(4, c.getPhone());
			pstm.executeUpdate();
			System.out.println("생성 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// delete
	public void deleteCustomer(int custId) {
		String sql = "delete from customer where custid = ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, custId);
			rs = pstm.executeQuery();
			pstm.executeUpdate();
			System.out.println("삭제 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// update
	public void updateCustomerName(int custId, String name) {
		String sql = "update customer set name = ? where custid = ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, name);
			pstm.setInt(2, custId);
			rs = pstm.executeQuery();
			pstm.executeUpdate();
			System.out.println("수정 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
}
