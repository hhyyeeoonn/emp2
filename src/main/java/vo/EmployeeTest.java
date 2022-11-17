package vo;

public class EmployeeTest {
	public static void main(String[] args) {
		Employee e=new Employee();
		e.birthDate="2000-01-01";
		e.setBirthDate("2000-01-01");
			System.out.println(e.getbirthDate()); // this=e
			System.out.println(e.birthDate);
		Employee e2=new Employee();
		e2.setBirthDate("2000-01-02");
			System.out.println()
	}
}
