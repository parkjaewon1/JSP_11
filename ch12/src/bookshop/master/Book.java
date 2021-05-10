package bookshop.master;
import java.sql.Timestamp;
public class Book {
	private int book_id;
	private String book_kind;
	private String book_title;
	private int book_price;
	private int book_count;
	private String author;
	private String publishing_com;
	private String publishing_date;
	private String book_image;
	private String book_content;
	private int discount_rate;
	private Timestamp reg_date;
	
	public int getBook_id() {	return book_id;	}
	public void setBook_id(int bookId) {	book_id = bookId;	}
	public String getBook_kind() {	return book_kind;	}
	public void setBook_kind(String bookKind) {
		book_kind = bookKind;
	}
	public String getBook_title() {	return book_title;	}
	public void setBook_title(String bookTitle) {
		book_title = bookTitle;
	}
	public int getBook_price() {	return book_price;	}
	public void setBook_price(int bookPrice) {
		book_price = bookPrice;
	}
	public int getBook_count() {	return book_count;	}
	public void setBook_count(int bookCount) {
		book_count = bookCount;
	}
	public String getAuthor() {		return author;	}
	public void setAuthor(String author) {	this.author = author;	}
	public String getPublishing_com() {		return publishing_com;	}
	public void setPublishing_com(String publishingCom) {
		publishing_com = publishingCom;
	}
	public String getPublishing_date() {	return publishing_date;	}
	public void setPublishing_date(String publishingDate) {
		publishing_date = publishingDate;
	}
	public String getBook_image() {	return book_image;	}
	public void setBook_image(String bookImage) {
		book_image = bookImage;
	}
	public String getBook_content() {	return book_content;	}
	public void setBook_content(String bookContent) {
		book_content = bookContent;
	}
	public int getDiscount_rate() {	return discount_rate;	}
	public void setDiscount_rate(int discountRate) {
		discount_rate = discountRate;
	}
	public Timestamp getReg_date() {	return reg_date;	}
	public void setReg_date(Timestamp regDate) {
		reg_date = regDate;
	}	
}