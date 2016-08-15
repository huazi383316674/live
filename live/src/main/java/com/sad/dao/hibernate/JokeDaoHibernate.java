package com.sad.dao.hibernate;

import java.util.List;

import org.beangle.commons.collection.CollectUtils;
import org.beangle.ems.security.model.UserBean;
import org.beangle.model.persist.hibernate.BaseDaoHibernate;
import org.hibernate.SQLQuery;

import com.sad.dao.JokeDao;
import com.sad.model.Joke;

public class JokeDaoHibernate extends BaseDaoHibernate implements JokeDao {

	@SuppressWarnings("unchecked")
	public List<Joke> getRandomJokes(int randomCount) {
		String sql = "select id, title, content, user_id from (select a_jokes.*, dbms_random.random as randomKey from a_jokes order by randomKey) where rownum <= :randomCount";

		SQLQuery query = getSession().createSQLQuery(sql);
		query.setParameter("randomCount", randomCount);
		List<Object[]> objResults = query.list();

		List<Joke> jokes = CollectUtils.newArrayList();
		for (Object[] obj : objResults) {
			Joke joke = new Joke(Long.valueOf(obj[0].toString()), obj[1] != null ? obj[1].toString() : null,
			        obj[2].toString(), obj[3] != null ? new UserBean((Long) obj[3]) : null);
			jokes.add(joke);
		}
		return jokes;
	}
}
