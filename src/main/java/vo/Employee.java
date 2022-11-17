package vo;

// 필드를 숨기는 것 정보은닉
// 캡슐화 단계 : public(전부 다 오픈) > protected(같은 패키지와 상속관계 오픈) > default(같은 패키지 오픈) > private(this오픈 나만 오픈 나한테만 오픈 this는 자바에서는 나의~ 라는 의미)
//  protected, default 단계의 캡슐화는 입문자는 사용하지 않는다
/*
public class Employee {
	public int empNo;
	
	
	//정보은닉
	private String birthDate; //private라는 접근제한자를 통해 정보은닉
	
	
	//캡슐화(읽기)
	public String firstName;
	public String gender;
	public String hireDate;
	
	public String getBirthDate() { //호출이 되면 이 코드가 읽히기 시작한다
		return this.birthDate; // 위에 private String=birthDate 와는 별개 return birthDate라도 적어도 컴파일러가 this를 넣어서 실행 
		// static은 클래스 이름으로 호출 
	}
	
	
	//캡슐화(쓰기) 
	public void setBirthDate(String birthDate) { //메소드 실행후에 특별히 리턴할 것이 없을 때 void (String birthDate)=birthDate 값을 받아와라
		this.birthDate=birthDate;
	}
}
*/




// 필드는 private로 만들고 우클릭해서 source getter and setter 만들기
//@Data getter읽기 setter쓰기를 자동으로 만들어 주는 것
public class Employee {
	private int empNo;
	private String birthDate;
	private String firstName;
	private String lastName;
	private String gender;
	private String hireDate;
	public int getEmpNo() {
		return empNo;
	}
	public void setEmpNo(int empNo) {
		this.empNo = empNo;
	}
	public String getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getHireDate() {
		return hireDate;
	}
	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}
	
}