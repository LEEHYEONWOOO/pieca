package logic;

import java.io.File;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.CarDao;
import dao.CarlikeDao;
import dao.CommentDao;
import dao.MycarDao;
import dao.PaymentDao;
import dao.RecogDao;
import dao.UserDao;
@Service   //@Component + Service(controller 기능과 dao 기능의 중간 역할 기능) 
public class ShopService {
   @Autowired //객체 주입
   private UserDao userDao;
   @Autowired 
   private BoardDao boardDao;
   @Autowired
   private PaymentDao paymentDao;
   @Autowired
   private CommentDao commDao;
   @Autowired
   private CarDao carDao;
   @Autowired
   private CarlikeDao carlikeDao;
   @Autowired
   private MycarDao mycarDao;
   @Autowired
   private RecogDao recogDao;
   
   
   public void uploadFileCreate(MultipartFile file, String path) {
      //file : 파일의 내용
      //path : 업로드할 폴더
      String orgFile = file.getOriginalFilename(); //파일이름
      File f = new File(path);
      if(!f.exists()) f.mkdirs();
      try {
         //transferTo : file에 저장된 내용을 파일로 저장
         file.transferTo(new File(path+orgFile));
      } catch(Exception e) {
         e.printStackTrace();
      }
   }
   public void userInsert(User user) {
      userDao.insert(user);
   }
   public User selectUserOne(String userid) {
      return userDao.selectOne(userid);
   }
   /*
    * 1.로그인정보,장바구니정보 => sale, saleitem 테이블의 데이터 저장
    * 2.결과는 Sale 객체에 저장
    *   - sale 테이블 저장 : saleid값 구하기. 최대값+1
    *   - saleitem 테이블 저장 : Cart 데이터를 이용하여 저장     
    */
   public void userUpdate(User user) {
      userDao.update(user);      
   }
   public void userDelete(String userid) {
      userDao.delete(userid);
   }
   public void userChgpass(String userid, String chgpass) {
      userDao.chgpass(userid,chgpass);      
   }
   public List<User> userlist() {
      return userDao.list(); //회원목록
   }
   public List<User> getUserList(String[] idchks) {
      return userDao.list(idchks);
   }
   public String getSearch(User user) {
      return userDao.search(user);
   }
   public void boardWrite(Board board, HttpServletRequest request) {
      int maxnum = boardDao.maxNum(); //등록된 게시물의 최대 num값 리턴
      board.setNum(++maxnum);
      board.setGrp(maxnum);
      if(board.getFile1() != null && !board.getFile1().isEmpty()) {
         String path = request.getServletContext().getRealPath("/") + "board/file/";
         this.uploadFileCreate(board.getFile1(), path);
         board.setFileurl(board.getFile1().getOriginalFilename());
      }
      boardDao.insert(board);
   }
   public int boardcount(String boardid, String searchtype, String searchcontent) {
      return boardDao.count(boardid,searchtype,searchcontent);
   }
   public List<Board> boardlist
   (Integer pageNum, int limit, String boardid, String searchtype, String searchcontent) {
      return boardDao.list(pageNum,limit,boardid,searchtype,searchcontent);
   }
   public Board getBoard(Integer num) {
      return boardDao.selectOne(num);  //board 레코드 조회
   }
   public void addReadcnt(Integer num) {
      boardDao.addReadcnt(num);       //조회수 증가
   }
   @Transactional  //트랜젝션 처리함. 업무를 원자화(all or nothing)
   public void boardReply(Board board) {
      boardDao.updateGrpStep(board);  //이미 등록된 grpstep값 1씩 증가
      int max = boardDao.maxNum();    //최대 num 조회
      board.setNum(++max);  //원글의 num => 답변글의 num 값으로 변경
                            //원글의 grp => 답변글의 grp 값을 동일. 설정 필요 없음
                              //원글의 boardid => 답변글의 boardid 값을 동일. 설정 필요 없음
      board.setGrplevel(board.getGrplevel() + 1); //원글의 grplevel => +1 답변글의 grplevel 설정
      board.setGrpstep(board.getGrpstep() + 1);   //원글의 grpstep => +1 답변글의 grpstep 설정
      boardDao.insert(board);
   }
   public void boardUpdate(Board board, HttpServletRequest request) {
      if(board.getFile1() != null && !board.getFile1().isEmpty()) {
         String path = request.getServletContext().getRealPath("/") + "board/file/";
         //파일 업로드 :board.getFile1()의 내용을 파일로 생성
         this.uploadFileCreate(board.getFile1(), path);  
         board.setFileurl(board.getFile1().getOriginalFilename());
      }
      boardDao.update(board);
   }
   public void boardDelete(Integer num) {
      boardDao.delete(num);
      recogDao.delete(num);
   }
   public Map<String, Integer> graph1(String id) {  //게시판 종류별, 글작성자별 등록 건수
      // list : [{writer=홍길동,cnt=10},{writer=김삿갓,cnt=7}...]
      List<Map<String,Object>> list = boardDao.graph1(id);
      //list => map 형태로 변경하여 Controller로 리턴
      Map<String, Integer> map = new HashMap<>();
      for(Map<String,Object> m : list) {
          String writer =(String)m.get("writer"); //홍길동
          long cnt = (Long) m.get("cnt"); // count(*) 형태의 데이터는 long 타입으로 전달
          map.put(writer,(int)cnt); //{"홍길동":10,"김삿갓":7,....}
      }      
      return map;
   }
   public Map<String, Integer> graph2(String id) {
      //list : [{day:2023-06-07, cnt:10},....]
      List<Map<String,Object>> list = boardDao.graph2(id);
      //TreeMap : key값으로 요소들을 정렬
      //Comparator.reverseOrder() : 내림차순 정렬로 설정.
      Map<String,Integer> map = new TreeMap<>(Comparator.reverseOrder());
      for(Map<String,Object> m : list) { 
         String day =(String)m.get("day");
         long cnt = (long)m.get("cnt"); 
         map.put(day,(int)cnt);
      }
      return map; //{2023-06-07:10,....}
   }
   public List<User> getUserlist(String phoneno,String channel) {
      return userDao.phoneList(phoneno, channel);
   }
   //================================================================
   public User selectUserId(String userid) {
      return userDao.selectId(userid);
   }
   
   public void payInsert(Payment payment) {
      paymentDao.insertkakao(payment);
   }
   public String getBalance(String userid) {
      return paymentDao.getBalance(userid);
   }
   public List<Payment> paymentList(String userid) {
      return paymentDao.list(userid);
   }
   public void setcard(User user) {
      userDao.setcard(user);
   }
   
   public List<Car> carList(Car car) {
      return carDao.list(car);
   }
   
   public int commmaxseq(int num) {
      return commDao.maxseq(num);
   }
   
   public void comminsert(Comment comm) {
      commDao.insert(comm);      
   }
   
   public List<Comment> commentlist(Integer num) {
      return commDao.list(num);
   }
   
   public void commdel(int num, int seq) {
      commDao.delete(num,seq);
   }
   
   public Comment commSelectOne(int num, int seq) {
      return commDao.selectOne(num,seq);
   }
   
   public List<Recog> getRecog(Integer num) {
      return recogDao.getRecog(num);      
   }
   public void doRecog(Integer num, int status) {
      recogDao.doRecog(num, status);
   }
   public List<Recog> getRecog() {
      return recogDao.getRecog();
   }
   
// 차 좋아요
   public Carlike selectUserlike(Carlike carlike) {
      return carlikeDao.select(carlike);
   }
   public List<Carlike> selectUserlike(String userid) {
	      return carlikeDao.selectLike(userid);
	   }
   public void likeInsert(Carlike carlike) {
      carlikeDao.insert(carlike);
   }
   public void likeDelete(Carlike carlike) {
      carlikeDao.delete(carlike);
   }
   public int selectliketotal(Carlike carlike) {
      return carlikeDao.selectliketotal(carlike);
   }
   
   public List<Carlike> carliketotal(){
	   return carlikeDao.selectliketotal();
   }
   
   
   // 차 장바구니
   public Mycar selectMycar(String userid) {
      return mycarDao.select(userid);
   }
   public void mycarInsert(String userid) {
      mycarDao.insert(userid);
   }
   public void mycarDelete(Mycar mycar) {
      mycarDao.delete(mycar);
   }
   public void mycarUpdate(Mycar mycar) {
      mycarDao.update(mycar);
   }
   
   public List<Carlike> selectLike(String userid) {
      return carlikeDao.selectLike(userid);
   }
   
   public List<Carlike> select_rank5() {
	      return carlikeDao.select_rank5();
	   }
public List<Car> getMakers() {
	return carlikeDao.getMakers();
}
public List<Car> getSizes() {
	return carlikeDao.getSizes();
}
public List<Car> getTypes() {
	return carlikeDao.getTypes();
}
public List<User> select_all() {
	return userDao.select_all();
}
public void carUpdate(@Valid Car car) {
	carDao.carUpdate(car);
	
}
public void carDelete(@Valid Car car) {
	carDao.carDelete(car);
	
}
public void carInsert(@Valid Car car) {
	carDao.carInsert(car);
	
}
   
   
   
   
}