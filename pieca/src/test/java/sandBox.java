import org.apache.ibatis.javassist.NotFoundException;

class sandBox {
	
//	public static void main(String args[]) throw sdfsdfdsfsdf {
	public static void main(String args[]) {
		// 이거는 내가 처리할수있음.
		int a = exceptionTest();
		int b = 0;
		System.out.println(a + 300);
		
		System.out.println("원래라면 이것만 출력되고 아래 는 출력안댐");
		
		try {
			b = exceptionTest2();
		} catch(NotFoundException nfe) {
			nfe.printStackTrace();

			System.exit(0); // 0~ 몇까지있을텐데... 정상종료~ 1 비정상종료~~ n ~~~
		} catch (Exception e) {
			// new throws 기본 형식이 e.printStackTrace();
			e.printStackTrace();
		}		
		
		b = 300;
		
		System.out.println(300 + "에러가 났지만 처리는 해주겠다.");
	}
	
	private static int exceptionTest() {
		try {
			boolean flg = true;
			if(flg) {
				throw new NotFoundException("ㅋㅋㅋㅋㅋ 에러당ㅋㅋ ㄹ파일에러 ㅋㅋㅋㅋ");
			}
			
			return 1;
		} catch(Exception e) {
			return 0;
		}
	}
	
	private static int exceptionTest2() throws NotFoundException{
		boolean flg = true;
		if(flg) {
			throw new NotFoundException("ㅋㅋㅋㅋㅋ 에러당ㅋㅋ ㄹ파일에러 ㅋㅋㅋㅋ");
		}

		return 1;
	}
}