package com.sad.dao;

import java.util.List;

import com.sad.model.Joke;

public interface JokeDao {

	/**
	 * 随机获取若干条幽默笑话
	 * @param randomCount
	 * @return
	 */
	public List<Joke> getRandomJokes(int randomCount);

}
