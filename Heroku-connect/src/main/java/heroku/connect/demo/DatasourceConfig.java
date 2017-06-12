/**
 *
 */
package heroku.connect.demo;

import java.net.URI;
import java.net.URISyntaxException;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

/**
 * @author ManmeetFIL
 *
 */
@Configuration
public class DatasourceConfig {

	private static final String DATABASE_URL = "DATABASE_URL";

	private static final String JDBC_PREFIX = "jdbc:postgresql://";

	private static final Logger LOGGER = LoggerFactory.getLogger(DatasourceConfig.class);

	private static final String DRIVER_CLASS_NAME = "org.postgresql.Driver";

	private String password;

	private String url;

	private String username;

	@Bean(name = "dataSource")
	@Profile("heroku")
	public DataSource herokuDataSource() {
		String databaseUrl = System.getenv(DATABASE_URL);
		try {
			URI uri = new URI(databaseUrl);
			url = JDBC_PREFIX + uri.getHost() + ":" + uri.getPort() + uri.getPath();
			username = uri.getUserInfo().split(":")[0];
			password = uri.getUserInfo().split(":")[1];
		} catch (URISyntaxException e) {
			LOGGER.error("Some error in getting DB connection .... " + e.toString());
		}
		return DataSourceBuilder.create().username(username).password(password).url(url).driverClassName(DRIVER_CLASS_NAME).build();
	}

	@Bean(name = "dataSource")
	@Profile("!heroku")
	public DataSource localDataSource() {
		String databaseUrl = "postgres://afpnoxpddhpnrx:3de7d7679f31aa2865e25ee3fb9eec84b89c0378cf76d73da312f735c5aaa7c7@ec2-54-247-120-169.eu-west-1.compute.amazonaws.com:5432/d1oatm4b8enbgn";
		try {
			URI uri = new URI(databaseUrl);
			url = JDBC_PREFIX + uri.getHost() + ":" + uri.getPort() + uri.getPath()
					+ "?ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory";
			username = uri.getUserInfo().split(":")[0];
			password = uri.getUserInfo().split(":")[1];
		} catch (URISyntaxException e) {
			LOGGER.error("Some error in getting DB connection .... " + e.toString());
		}
		return DataSourceBuilder.create().username(username).password(password).url(url).driverClassName(DRIVER_CLASS_NAME).build();
	}
}
