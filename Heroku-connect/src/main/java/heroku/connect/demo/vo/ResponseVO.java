/**
 *
 */
package heroku.connect.demo.vo;

import org.springframework.stereotype.Component;

import com.ibm.watson.developer_cloud.tone_analyzer.v3.model.ToneAnalysis;

import lombok.Getter;
import lombok.Setter;

/**
 * @author ManmeetFIL
 *
 */
@Component
public class ResponseVO {

	@Getter
	@Setter
	String meetingNoteId;

	@Getter
	@Setter
	String accountName;

	@Getter
	@Setter
	ToneAnalysis toneAnalysis;
}