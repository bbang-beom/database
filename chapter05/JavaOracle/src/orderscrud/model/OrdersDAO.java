package orderscrud.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrdersDAO {
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
	public List<OrdersDTO> getOrders() {
		List<OrdersDTO> orders = new ArrayList<OrdersDTO>();
		String sql = "select * from orders";
		try {
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();
			while(rs.next()) {
				OrdersDTO order = new OrdersDTO();
				order.setOrderId(rs.getInt(1));
				order.setCustId(rs.getInt(2));
				order.setBookId(rs.getInt(3));
				order.setSalePrice(rs.getInt(4));
				order.setOrderDate(rs.getDate(5));
				order.setBookName(rs.getString(6));
				orders.add(order);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return orders;
	}
	
	// key로 Read
	public OrdersDTO getOrder(int orderId) {
		OrdersDTO o = new OrdersDTO();
		String sql = "select * from orders where orderId = ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, orderId);
			rs = pstm.executeQuery();
			while(rs.next()) {
				o.setOrderId(rs.getInt(1));
				o.setCustId(rs.getInt(2));
				o.setBookId(rs.getInt(3));
				o.setSalePrice(rs.getInt(4));
				o.setOrderDate(rs.getDate(5));
				o.setBookName(rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return o;
	}
	
	// insert(create)
	public void putOrder(OrdersDTO o) {
		String sql = "insert into orders values(?,?,?,?,?,?)";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, o.getOrderId());
			pstm.setInt(2, o.getCustId());
			pstm.setInt(3, o.getBookId());
			pstm.setInt(4, o.getSalePrice());
			pstm.setDate(5, o.getOrderDate());
			pstm.setString(6, o.getBookName());
			pstm.executeUpdate();
			System.out.println("생성 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// delete
	public void deleteOrder(int orderId) {
		String sql = "delete from orders where orderId = ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, orderId);
			rs = pstm.executeQuery();
			pstm.executeUpdate();
			System.out.println("삭제 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// update
	public void updateSalePrice(int orderId, int salePrice) {
		String sql = "update orders set saleprice = ? where orderId = ?";
		try {
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, salePrice);
			pstm.setInt(2, orderId);
			rs = pstm.executeQuery();
			pstm.executeUpdate();
			System.out.println("수정 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
