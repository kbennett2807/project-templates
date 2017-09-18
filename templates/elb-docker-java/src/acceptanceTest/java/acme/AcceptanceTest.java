package acme;

import io.restassured.RestAssured;
import org.junit.BeforeClass;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AcceptanceTest
{
	private static Logger logger = LoggerFactory.getLogger(AcceptanceTest.class);
	
	@BeforeClass
	public static void setup()
	{
		setPort();
		setHost();
		setPath();
	}

	private static void setPath()
	{
		String basePath = System.getProperty("server.base");
		if (basePath == null)
		{
			basePath = "/";
		}
		RestAssured.basePath = basePath;
	}

	private static void setHost()
	{
		String baseHost = System.getProperty("server.host");
		if (baseHost == null)
		{
			baseHost = "http://localhost";
		}
		RestAssured.baseURI = baseHost;
	}

	private static void setPort()
	{
		String port = System.getProperty("server.port");
		logger.debug(port);
		
		if (port == null)
		{
			RestAssured.port = Integer.valueOf(8080);
		}
		else
		{
			RestAssured.port = Integer.valueOf(port);
		}
	}
}
