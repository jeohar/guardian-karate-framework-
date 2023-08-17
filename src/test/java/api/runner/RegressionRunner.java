package api.runner;

import com.intuit.karate.junit5.Karate;

public class RegressionRunner {
	@Karate.Test
	public Karate runTest() {
		//Adddress for our feature files and then tag name
	return Karate.run("classpath:features")
			.tags("@Regression");
}
}
