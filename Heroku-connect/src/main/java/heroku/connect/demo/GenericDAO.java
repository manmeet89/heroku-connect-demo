/**
 *
 */
package heroku.connect.demo;

import java.sql.PreparedStatement;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

/**
 * @author ManmeetFIL
 *
 */
@Repository
public class GenericDAO {

	@Autowired
	JdbcTemplate jdbcTemplate;

	public Map<String, String> getMeetingNotes() {
		Map<String, String> result = new HashMap<String, String>();
		jdbcTemplate.query("SELECT * FROM GISFDEV.FIL_MNCORE__CUSTOM_NOTE__C", (RowMapper<String>) (rs, rowNum) -> {
			result.put(rs.getString("FIL_MNCORE__MEETING_NOTE__C"), rs.getString("FIL_MNCORE__NOTE__C"));
			return null;
		});
		return result;
	}

	public Map<String, Map<String, String>> getSFDataFromHerokuConnect(String object, Long limit) {
		System.err.println("START ::" + new Date());
		Map<String, Map<String, String>> result = new HashMap<>();
		jdbcTemplate.query(
				"SELECT * FROM WHOLESALEUAT." + object + " C WHERE SFID NOT IN (SELECT SFID FROM PROCESSED_RECORDS) LIMIT " + limit,
				(RowMapper<String>) (rs, rowNum) -> {
					ResultSetMetaData metadata = rs.getMetaData();
					result.put(rs.getString("SFID"), new HashMap<String, String>());
					int columnCount = metadata.getColumnCount();
					for (int i = 1; i <= columnCount; i++) {
						if (!StringUtils.isEmpty(rs.getString(metadata.getColumnName(i)))) {
							result.get(rs.getString("SFID")).put(metadata.getColumnName(i) + "--" + metadata.getColumnTypeName(i),
									rs.getString(metadata.getColumnName(i)));
						}
					}
					//			System.err.println(rs.getString("SFID") + "****************************");
					return null;
				});
		System.err.println("END ::" + new Date());
		return result;
	}

	public void insertRecord(List<String> sfIDList) {
		jdbcTemplate.batchUpdate("INSERT INTO PROCESSED_RECORDS(SFID) VALUES (?)", new BatchPreparedStatementSetter() {

			@Override
			public void setValues(PreparedStatement ps, int i) throws SQLException {
				ps.setString(1, sfIDList.get(i));
			}

			@Override
			public int getBatchSize() {
				// TODO Auto-generated method stub
				return sfIDList.size();
			}
		});
	}

	public Map<String, List<String>> getMeetingNotesByAccount() {
		Map<String, List<String>> result = new HashMap<String, List<String>>();
		jdbcTemplate
				.query("SELECT ACC1.SFID AS ACCOUNTID, ACC1.NAME AS ACCOUNTNAME, CN.FIL_MNCORE__NOTE__C AS TEXT FROM (SELECT MN.SFID AS MEETINGNOTEID,MN.FIL_MNCORE__COMPANY__C "
						+ "AS MNACCOUNTID, MN.FIL_MNCORE__OPPORTUNITY__C AS MNOPPORTUNITYID, OPP.ACCOUNTID AS MNOPPACCOUNTID   FROM WHOLESALEUAT.FIL_MNCORE__MEETING_NOTE__C MN "
						+ "LEFT OUTER JOIN WHOLESALEUAT.ACCOUNT ACC ON MN.FIL_MNCORE__COMPANY__C = ACC.SFID LEFT OUTER JOIN WHOLESALEUAT.OPPORTUNITY OPP ON MN.FIL_MNCORE__OPPORTUNITY__C = OPP.SFID) TAB1 "
						+ "INNER JOIN WHOLESALEUAT.ACCOUNT ACC1 ON TAB1.MNACCOUNTID = ACC1.SFID OR TAB1.MNOPPACCOUNTID = ACC1.SFID "
						+ "INNER JOIN WHOLESALEUAT.FIL_MNCORE__CUSTOM_NOTE__C CN ON TAB1.MEETINGNOTEID = CN.FIL_MNCORE__MEETING_NOTE__C "
						+ "LIMIT 10", (RowMapper<String>) (rs, rowNum) -> {
							if (result.containsKey(rs.getString("AccountId") + "$$" + rs.getString("AccountName"))) {
								result.get(rs.getString("AccountId") + "$$" + rs.getString("AccountName")).add(rs.getString("TEXT"));
							} else {
								result.put(rs.getString("AccountId") + "$$" + rs.getString("AccountName"), new ArrayList<String>());
								result.get(rs.getString("AccountId") + "$$" + rs.getString("AccountName")).add(rs.getString("TEXT"));
							}
							return null;
						});
		return result;
	}
}
