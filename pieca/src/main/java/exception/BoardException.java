package exception;

public class BoardException extends RuntimeException {
	private String url;
	public BoardException(String url) {
		this.url = url;
	}
	public String getUrl() {
		return url;
	}
}
