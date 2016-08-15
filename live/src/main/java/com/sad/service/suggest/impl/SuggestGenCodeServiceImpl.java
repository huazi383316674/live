package com.sad.service.suggest.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beangle.model.persist.impl.BaseServiceImpl;

import com.sad.service.suggest.SuggestGenCodeService;

public class SuggestGenCodeServiceImpl extends BaseServiceImpl implements SuggestGenCodeService {

	public String prefix = "";

	public int length = 4;

	public String generate() {
		int serialNo = initSerialNo();
		return prefix + buildNormalSerialnumber(serialNo);
	}

	private Integer initSerialNo() {
		String hql = "select max(suggest.no) from com.sad.model.suggest.Suggest suggest where suggest.no like :prefixNo";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("prefixNo", prefix + "%");
		List<Object> objs = entityDao.searchHQLQuery(hql, params);

		if (objs == null || objs.get(0) == null) {
			return 1;
		} else {
			String max_examNo = objs.get(0).toString();
			String serialNo = max_examNo.substring(prefix.length(), max_examNo.length());
			return Integer.valueOf(serialNo) + 1;
		}
	}

	private String buildNormalSerialnumber(int number) {
		StringBuffer genNum = new StringBuffer();
		String num = String.valueOf(number);
		if (num.length() < length) {
			for (int i = 0; i < (length - num.length()); i++) {
				genNum.append("0");
			}
		}
		genNum.append(num);
		return genNum.toString();
	}

}
