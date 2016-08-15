package com.sad.service.suggest;

import com.sad.model.suggest.Suggest;
import com.sad.model.suggest.SuggestTail;

public interface SuggestService {

	/**
	 * 更新意见状态
	 * 
	 * @param suggest
	 * @param suggestTail
	 */
	public void syncUpdateSuggest(Suggest suggest, SuggestTail suggestTail);

}
