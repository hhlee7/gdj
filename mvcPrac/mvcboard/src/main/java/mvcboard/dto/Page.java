package mvcboard.dto;

public class Page {
	private int rowPerPage;
	private int currentPage;
	
	public Page() {}
	// 생성자 오버로딩
	public Page(int currentPage, int rowPerPage) {
		this.currentPage = currentPage;
		this.rowPerPage = rowPerPage;
	}
	
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getBeginRow() {
		return (this.currentPage - 1) * this.rowPerPage;
	}
}
