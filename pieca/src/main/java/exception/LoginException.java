package exception;

public class LoginException extends RuntimeException{
	private String url;
	public LoginException(String url) {
		this.url = url;
	}
	public String getUrl() {
		return url;
	}
}
