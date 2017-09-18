package acme;

import static io.restassured.RestAssured.given;

import org.junit.Test;

public class ProductTest extends AcceptanceTest
{
	@Test
	public void basicPingTest()
	{
		given().when().get("/products").then().statusCode(200);
	}
}
