package dto;

public class Receipt {
	public int cashNo;
	public String filename;
	public String createdate;
	
	public int getCashNo() {
		return cashNo;
	}
	public void setCashNo(int cashNo) {
		this.cashNo = cashNo;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	
	@Override
	public String toString() {
		return "Receipt [cashNo=" + cashNo + ", filename=" + filename + ", createdate=" + createdate + "]";
	}
}
