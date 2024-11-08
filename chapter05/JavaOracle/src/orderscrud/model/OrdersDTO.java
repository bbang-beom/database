package orderscrud.model;

import java.sql.Date;

public class OrdersDTO {
	private int orderId;
	private int custId;
	private int bookId;
	private int salePrice;
	private Date orderDate;
	private String bookName;
	
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getCustId() {
		return custId;
	}
	public void setCustId(int custId) {
		this.custId = custId;
	}
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public int getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(int salePrice) {
		this.salePrice = salePrice;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	
	@Override
	public String toString() {
		return "OrdersDTO [orderId=" + orderId + ", custId=" + custId + ", bookId=" + bookId + ", salePrice="
				+ salePrice + ", orderDate=" + orderDate + ", bookName=" + bookName + "]";
	}
	
}
