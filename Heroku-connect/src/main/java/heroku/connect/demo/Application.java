package heroku.connect.demo;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
import org.springframework.boot.autoconfigure.security.SecurityAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.scheduling.annotation.AsyncConfigurerSupport;

import com.ibm.watson.developer_cloud.tone_analyzer.v3.ToneAnalyzer;

/**
 *
 */
/**
 * @author ManmeetFIL
 *
 */
@Configuration
@EnableAutoConfiguration(exclude = { DataSourceAutoConfiguration.class, DataSourceTransactionManagerAutoConfiguration.class,
		SecurityAutoConfiguration.class })
@ComponentScan(basePackages = { "heroku.connect.demo" })
public class Application extends AsyncConfigurerSupport {

	@Value("${bluemix.username}")
	String bluemixUsername;

	@Value("${bluemix.password}")
	String bluemixPassword;

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	@Autowired
	DataSource dataSource;

	@Bean
	public JdbcTemplate jdbcTemplate() {
		return new JdbcTemplate(dataSource);
	}

	@Bean(name = "transactionManager")
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource);
	}

	@Bean(name = "toneAnalyzer")
	public ToneAnalyzer getToneAnalyser() {
		ToneAnalyzer service = new ToneAnalyzer(ToneAnalyzer.VERSION_DATE_2016_05_19, bluemixUsername, bluemixPassword);
		return service;
	}
}
