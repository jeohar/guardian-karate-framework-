package api.utility.data;


public class GenerateData {
	
	public static String getEmail() {
		String prefix = "stategov_email";
		String provider = "@tekschool.us";
		
		int random = (int) (Math.random() * 1000);
		String email = prefix + random + provider;
		return email;
		
	}
	
	public static String randomEmail() {
		String prefix = "xyz";
		String domainName = "@hasib.com";
		
		int random = (int) (Math.random() * 1000);
		String email = prefix + random + domainName;
		return email;
	}
	public static String randomName() {
		String firstName = "user";
		int random = (int) (Math.random() * 1000);
		String name = firstName + random;
		return name;
	}
	public static String getAddress() {
		String randomAdd = "Reseda Blvd";
		int random = (int) (Math.random() * 1000);
		String address = random + " " + randomAdd;
		return address;
	}
	public static String getCarLicensePlate() {
		String randomAdd = "ABCX";
		int random = (int) (Math.random() * 1000);
		String address = random + randomAdd;
		return address;
	}
//	public static long getPhoneNumber() {
//        Random random = new Random();
//        long lowerBound = 1000000000L; 
//        long upperBound = 9999999999L;
//
//        long randomNum = lowerBound + ((long) (random.nextDouble() * (upperBound - lowerBound + 1)));
//
//        return randomNum;
//    }
//	
	public static String getPhoneNumber() {
		String phoneNumber = "";
		for (int i = 0; i<10; i++) {
			phoneNumber += (int) (Math.random() * 10);
		}
		return phoneNumber;		
	}
	
	public static void main(String[] args) {
        String randomNumber = getPhoneNumber();
        System.out.println("Random 10-digit number: " + randomNumber);
        System.out.println("Random street: " + getAddress());
        
    }
}
