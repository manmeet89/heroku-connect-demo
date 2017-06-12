/**
 *
 */
package heroku.connect.demo.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.ibm.watson.developer_cloud.tone_analyzer.v3.ToneAnalyzer;
import com.ibm.watson.developer_cloud.tone_analyzer.v3.model.ElementTone;
import com.ibm.watson.developer_cloud.tone_analyzer.v3.model.ToneAnalysis;
import com.ibm.watson.developer_cloud.tone_analyzer.v3.model.ToneCategory;
import com.ibm.watson.developer_cloud.tone_analyzer.v3.model.ToneScore;

import heroku.connect.demo.GenericDAO;
import heroku.connect.demo.service.DataLoadService;
import heroku.connect.demo.vo.ResponseVO;
import heroku.connect.demo.vo.ToneAnalysisByAccount;

/**
 * @author ManmeetFIL
 *
 */
@Controller
@RequestMapping("")
public class DemoController {

	@Autowired
	ToneAnalyzer service;

	@Autowired
	DataLoadService dataLoadService;

	@Autowired
	GenericDAO genericDAO;

	private Map<String, List<String>> notestByAccount;

	@RequestMapping(value = "/loadData/{object}/{limit}", method = RequestMethod.GET)
	public @ResponseBody String loadData(ModelMap modelMap, @PathVariable Long limit, @PathVariable String object) {
		long startTime = System.currentTimeMillis();
		dataLoadService.dataLoad(object, limit);
		long timeTaken = System.currentTimeMillis() - startTime;
		return "Tme Taken : " + timeTaken + "ms";
		//return "success";
	}

	@RequestMapping(value = "analysisOne", method = RequestMethod.GET)
	public String homePage(ModelMap modelMap) {
		if (null == notestByAccount) {
			notestByAccount = genericDAO.getMeetingNotesByAccount();
		}
		modelMap.put("notestByAccount", notestByAccount);
		Gson g = new Gson();
		List<ResponseVO> result = g.fromJson(
				"[{\"meetingNoteId\":\"001w000001DqFGiAAN\",\"accountName\":\"ABN AMRO Investment Solutions\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.06},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.11},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.13},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.11},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.57}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.65},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.35},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.6},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.26},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.26}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001BEjshAAD\",\"accountName\":\"HDI Lebensversicherung AG\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.03},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.01},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.03},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.65},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.14}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.14},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.33},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.44},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.54},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.12}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001BEnGxAAL\",\"accountName\":\"Skandia Lebensversicherung AG (GER)\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.05},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.01},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.04},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.71},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.08}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.13},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.12},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.43},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.61},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.04}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001D7chaAAB\",\"accountName\":\"FWU Austria AG\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.24},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.08},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.15},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.11},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.43}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.81},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.57}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.62},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.15},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.84},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.17},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.02}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001Bp3dUAAR\",\"accountName\":\"FONDITEL\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.12},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.09},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.1},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.64},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.17}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.2}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.24},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.54},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.68},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.12},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.63}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w0000013Lej4AAC\",\"accountName\":\"Prevision Sanitaria Nacional PSN Mutua de Seguros y Reaseguros a Prima Fija, Suc em Portugal\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.13},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.1},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.04},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.39},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.22}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.9},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.16},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.45},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.5},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.21},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.57}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001DqGYyAAN\",\"accountName\":\"PICTET & CIE\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.13},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.09},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.01},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.65},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.04}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.54}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.44},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.51},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.78},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.66},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.48}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001JSFX7AAP\",\"accountName\":\"Raiffeisenbank Seefeld-Leutasch-Reith-Scharnitz reg.Gen.m.b.H.\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.11},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.05},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.12},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.23},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.38}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.15},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.29},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.63},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.55},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.43}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001D7ce5AAB\",\"accountName\":\"ERSTE-SPARINVEST KAG\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.06},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.03},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.04},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.72},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.43}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.67},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.54},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.53},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.81},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.42},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.39}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001J2SiYAAV\",\"accountName\":\"Märki Baumann & Co AG\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.06},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.03},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.01},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.57},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.18}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.02}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.49},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.9},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.81},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.08},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.86}]}]},\"sentencesTone\":null}}]",
				List.class);
		//List<ResponseVO> result = analyseMeetingNotes();
		modelMap.put("toneAnalysis", result);
		return "ibmlike";
	}

	@RequestMapping(value = "analysisTwo", method = RequestMethod.GET)
	public String old(ModelMap modelMap) {
		if (null == notestByAccount) {
			notestByAccount = genericDAO.getMeetingNotesByAccount();
		}
		modelMap.put("notestByAccount", notestByAccount);
		return "home";
	}

	@RequestMapping(value = "/dummy", method = RequestMethod.GET)
	public ResponseEntity<?> dummy() {
		Gson g = new Gson();
		List<ResponseVO> result = g.fromJson(
				"[{\"meetingNoteId\":\"001w000001DqFGiAAN\",\"accountName\":\"ABN AMRO Investment Solutions\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.06},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.11},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.13},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.11},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.57}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.65},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.35},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.6},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.26},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.26}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001BEjshAAD\",\"accountName\":\"HDI Lebensversicherung AG\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.03},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.01},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.03},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.65},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.14}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.14},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.33},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.44},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.54},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.12}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001BEnGxAAL\",\"accountName\":\"Skandia Lebensversicherung AG (GER)\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.05},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.01},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.04},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.71},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.08}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.13},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.12},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.43},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.61},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.04}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001D7chaAAB\",\"accountName\":\"FWU Austria AG\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.24},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.08},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.15},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.11},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.43}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.81},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.57}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.62},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.15},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.84},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.17},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.02}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001Bp3dUAAR\",\"accountName\":\"FONDITEL\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.12},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.09},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.1},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.64},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.17}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.2}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.24},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.54},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.68},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.12},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.63}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w0000013Lej4AAC\",\"accountName\":\"Prevision Sanitaria Nacional PSN Mutua de Seguros y Reaseguros a Prima Fija, Suc em Portugal\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.13},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.1},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.04},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.39},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.22}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.9},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.16},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.45},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.5},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.21},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.57}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001DqGYyAAN\",\"accountName\":\"PICTET & CIE\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.13},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.09},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.01},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.65},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.04}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.54}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.44},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.51},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.78},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.66},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.48}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001JSFX7AAP\",\"accountName\":\"Raiffeisenbank Seefeld-Leutasch-Reith-Scharnitz reg.Gen.m.b.H.\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.11},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.05},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.12},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.23},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.38}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.15},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.29},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.63},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.55},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.43}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001D7ce5AAB\",\"accountName\":\"ERSTE-SPARINVEST KAG\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.06},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.03},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.04},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.72},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.43}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.67},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.0}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.54},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.53},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.81},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.42},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.39}]}]},\"sentencesTone\":null}},{\"meetingNoteId\":\"001w000001J2SiYAAV\",\"accountName\":\"Märki Baumann & Co AG\",\"toneAnalysis\":{\"documentTone\":{\"tones\":[{\"id\":\"emotion_tone\",\"name\":\"Emotion Tone\",\"tones\":[{\"id\":\"anger\",\"name\":\"Anger\",\"score\":0.06},{\"id\":\"disgust\",\"name\":\"Disgust\",\"score\":0.03},{\"id\":\"fear\",\"name\":\"Fear\",\"score\":0.01},{\"id\":\"joy\",\"name\":\"Joy\",\"score\":0.57},{\"id\":\"sadness\",\"name\":\"Sadness\",\"score\":0.18}]},{\"id\":\"language_tone\",\"name\":\"Language Tone\",\"tones\":[{\"id\":\"analytical\",\"name\":\"Analytical\",\"score\":0.0},{\"id\":\"confident\",\"name\":\"Confident\",\"score\":0.0},{\"id\":\"tentative\",\"name\":\"Tentative\",\"score\":0.02}]},{\"id\":\"social_tone\",\"name\":\"Social Tone\",\"tones\":[{\"id\":\"openness_big5\",\"name\":\"Openness\",\"score\":0.49},{\"id\":\"conscientiousness_big5\",\"name\":\"Conscientiousness\",\"score\":0.9},{\"id\":\"extraversion_big5\",\"name\":\"Extraversion\",\"score\":0.81},{\"id\":\"agreeableness_big5\",\"name\":\"Agreeableness\",\"score\":0.08},{\"id\":\"emotional_range_big5\",\"name\":\"Emotional Range\",\"score\":0.86}]}]},\"sentencesTone\":null}}]",
				List.class);
		return new ResponseEntity<List<ResponseVO>>(result, HttpStatus.OK);
	}

	@RequestMapping(value = "/MeetingNotesTones", method = RequestMethod.GET)
	public ResponseEntity<?> test() {
		List<ResponseVO> result = analyseMeetingNotes();
		return new ResponseEntity<List<ResponseVO>>(result, HttpStatus.OK);
	}

	private List<ResponseVO> analyseMeetingNotes() {
		List<ResponseVO> result = new ArrayList<>();
		if (null == notestByAccount) {
			notestByAccount = genericDAO.getMeetingNotesByAccount();
		}
		System.err.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		System.err.println(notestByAccount);
		System.err.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		List<ToneAnalysisByAccount> resultByAccount = new ArrayList<>();
		for (String accId : notestByAccount.keySet()) {
			List<String> notesofAccount = notestByAccount.get(accId);
			ToneAnalysisByAccount analysisByAccount = new ToneAnalysisByAccount();
			analysisByAccount.setAccountId(accId.split(Pattern.quote("$$"))[0]);
			analysisByAccount.setAccountName(accId.split(Pattern.quote("$$"))[1]);
			analysisByAccount.setToneAnalysis(new ArrayList<>());
			resultByAccount.add(analysisByAccount);
			for (String text : notesofAccount) {
				System.err.println("Getting tone analysis from IBM STARTs...");
				analysisByAccount.getToneAnalysis().add(service.getTone(text, null).execute());
				System.err.println("Getting tone analysis from IBM ENDs...");
			}
		}
		for (ToneAnalysisByAccount analysisByAccount : resultByAccount) {
			ResponseVO vo = new ResponseVO();
			result.add(vo);
			vo.setMeetingNoteId(analysisByAccount.getAccountId());
			vo.setAccountName(analysisByAccount.getAccountName());
			vo.setToneAnalysis(new ToneAnalysis());
			vo.getToneAnalysis().setDocumentTone(new ElementTone());
			vo.getToneAnalysis().getDocumentTone().setTones(new ArrayList<ToneCategory>());
			for (ToneAnalysis toneAnalysis : analysisByAccount.getToneAnalysis()) {
				int numberOfNotes = analysisByAccount.getToneAnalysis().size();
				for (ToneCategory category : toneAnalysis.getDocumentTone().getTones()) {
					ToneCategory toneCategory = getToneCategoryById(vo.getToneAnalysis().getDocumentTone().getTones(), category.getId());
					toneCategory.setName(category.getName());
					for (ToneScore toneScore : category.getTones()) {
						if (null == toneCategory.getTones()) {
							toneCategory.setTones(new ArrayList<ToneScore>());
						}
						ToneScore score = getToneScoreById(toneCategory.getTones(), toneScore.getId());
						score.setName(toneScore.getName());
						if (null == score.getScore()) {
							score.setScore(new Double(0.0));
						}
						score.setScore(score.getScore() + (toneScore.getScore() / numberOfNotes));
						DecimalFormat df = new DecimalFormat("####0.00");
						score.setScore(new Double(df.format(score.getScore())));
					}
				}
			}
		}
		return result;
	}

	private ToneCategory getToneCategoryById(List<ToneCategory> toneCategories, String id) {
		for (ToneCategory category : toneCategories) {
			if (category.getId().equalsIgnoreCase(id)) {
				return category;
			}
		}
		ToneCategory category = new ToneCategory();
		category.setId(id);
		toneCategories.add(category);
		return category;
	}

	private ToneScore getToneScoreById(List<ToneScore> toneScores, String id) {
		for (ToneScore score : toneScores) {
			if (score.getId().equalsIgnoreCase(id)) {
				return score;
			}
		}
		ToneScore toneScore = new ToneScore();
		toneScore.setId(id);
		toneScores.add(toneScore);
		return toneScore;
	}
}
