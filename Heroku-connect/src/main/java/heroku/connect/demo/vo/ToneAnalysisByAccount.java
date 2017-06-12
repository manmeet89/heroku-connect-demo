/**
 *
 */
package heroku.connect.demo.vo;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ibm.watson.developer_cloud.tone_analyzer.v3.model.ToneAnalysis;

import lombok.Getter;
import lombok.Setter;

/**
 * @author ManmeetFIL
 *
 */
@Component
public class ToneAnalysisByAccount {

	@Getter
	@Setter
	String accountId;

	@Getter
	@Setter
	String accountName;

	@Getter
	@Setter
	List<ToneAnalysis> toneAnalysis;
}
