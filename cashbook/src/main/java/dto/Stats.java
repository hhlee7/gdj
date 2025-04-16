package dto;

public class Stats {
	private String kind;
	private int count;
	private int amount;
	private String cashDate;
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getCashDate() {
		return cashDate;
	}
	public void setCashDate(String cashDate) {
		this.cashDate = cashDate;
	}
	@Override
	public String toString() {
		return "Stats [kind=" + kind + ", count=" + count + ", amount=" + amount + ", cashDate=" + cashDate + "]";
	}
}
