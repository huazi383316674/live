package org.beangle.emsapp.portal.action;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.beangle.commons.collection.CollectUtils;
import org.beangle.commons.property.PropertyConfig;
import org.beangle.commons.property.PropertyConfigFactory;
import org.beangle.ems.config.model.PropertyConfigItemBean;
import org.beangle.ems.security.Category;
import org.beangle.ems.security.SecurityUtils;
import org.beangle.ems.security.User;
import org.beangle.ems.security.model.UserBean;
import org.beangle.ems.security.nav.Menu;
import org.beangle.ems.security.nav.MenuProfile;
import org.beangle.ems.security.nav.service.MenuService;
import org.beangle.ems.web.action.SecurityActionSupport;
import org.beangle.model.query.builder.OqlBuilder;
import org.beangle.model.util.HierarchyEntityUtil;
import org.beangle.security.auth.AuthenticationManager;
import org.beangle.security.core.AuthenticationException;

import com.opensymphony.xwork2.ActionContext;
import com.sad.dao.JokeDao;

/**
 * 加载用户主界面
 */
public class HomeAction extends SecurityActionSupport {

	protected AuthenticationManager authenticationManager;
	protected MenuService menuService;
	protected PropertyConfigFactory configFactory;
	private JokeDao jokeDao;

	public PropertyConfig getSystemConfig() {
		return configFactory.getConfig();
	}

	protected Long getUserCategoryId() {
		Long categoryId = getLong("security.categoryId");
		if (null == categoryId) {
			categoryId = (Long) ActionContext.getContext().getSession().get("security.categoryId");
			if (null == categoryId) {
				User user = entityDao.get(User.class, getUserId());
				categoryId = user.getDefaultCategory().getId();
			}
		}
		ActionContext.getContext().getSession().put("security.categoryId", categoryId);
		return categoryId;
	}

	public String index() {
		Long userId = getUserId();
		if (null == userId) throw new AuthenticationException("without login");
		Long categoryId = getUserCategoryId();
		put("categoryId", categoryId);

		List<Menu> dd = menuService.getMenus(getMenuProfile(categoryId), new UserBean(userId));
		List<Menu> topMenus = CollectUtils.newArrayList();
		for (Menu m : dd) {
			if (null == m.getParent()) topMenus.add(m);
		}
		put("menus", topMenus);
		put("user", SecurityUtils.getPrincipal());
		OqlBuilder<Category> builder = OqlBuilder.from(User.class.getName() + " u");
		builder.where("u.id=:uid", userId).select("u.categories");
		put("categories", entityDao.search(builder));
		return forward();
	}

	public String welcome() {
		put("userName", SecurityUtils.getFullname());
		put("date", new Date(System.currentTimeMillis()));

		// 加载幽默笑话
		loadJokes();
		// 加载天气城市代码
		put("weatherCodeConfig", getPropertyConfigItem("weatherCode"));
		return forward();
	}

	protected MenuProfile getMenuProfile(Long categoryId) {
		Long profileId = getLong("menuProfileId");
		if (null != profileId) {
			getSession().put("menuProfileId", profileId);
		} else {
			profileId = (Long) getSession().get("menuProfileId");
		}
		if (null != profileId) return entityDao.get(MenuProfile.class, profileId);

		OqlBuilder<MenuProfile> query = OqlBuilder.from(MenuProfile.class, "mp");
		query.where("category.id=:categoryId", categoryId);
		query.cacheable(true);
		List<MenuProfile> mps = (List<MenuProfile>) entityDao.search(query);
		if (mps.isEmpty()) {
			return null;
		} else {
			return mps.get(0);
		}
	}

	/**
	 * 加载特定模块下的所有子模块
	 */
	public String submenus() {
		Long menuId = getLong("menu.id");
		User user = new UserBean(getUserId());
		List<Menu> modulesTree = menuService.getMenus(getMenuProfile(getUserCategoryId()), user);
		if (null != menuId) {
			Menu menu = entityDao.get(Menu.class, menuId);
			modulesTree.retainAll(HierarchyEntityUtil.getFamily(menu));
			modulesTree.remove(menu);
		}
		put("submenus", modulesTree);
		return forward();
	}

	/**
	 * 加载笑话
	 */
	private void loadJokes() {
		put("jokes", jokeDao.getRandomJokes(3));
	}

	/**
	 * 加载天气
	 */
	public String getWeather() {
		PropertyConfigItemBean configItem = getPropertyConfigItem("weatherCode");
		if (configItem == null) return forward("json_weather");

		String weatherUrl = "http://m.weather.com.cn/data/" + configItem.getValue() + ".html";
		try {
			HttpURLConnection huc = (HttpURLConnection) new URL(weatherUrl).openConnection();
			huc.setRequestMethod("GET");
			huc.setUseCaches(true);
			huc.connect();
			InputStream is = huc.getInputStream();
			BufferedReader reader = new BufferedReader(new InputStreamReader(is));
			StringBuffer temp = new StringBuffer();
			String str;
			while ((str = reader.readLine()) != null) {
				temp.append(str + "\n");
			}
			is.close();
			reader.close();
			put("weatherInfo", temp.toString());
			//put("weatherInfo", new String(temp.toString().getBytes("GBK"), "UTF-8"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return forward("json_weather");
	}

	protected PropertyConfigItemBean getPropertyConfigItem(String configName) {
		OqlBuilder<PropertyConfigItemBean> query = OqlBuilder.from(PropertyConfigItemBean.class, "config");
		query.where("config.name =:name", configName);
		List<PropertyConfigItemBean> items = entityDao.search(query);
		return CollectionUtils.isNotEmpty(items) ? items.get(0) : null;
	}

	public void setMenuService(MenuService menuService) {
		this.menuService = menuService;
	}

	public final void setPropertyConfigFactory(PropertyConfigFactory configFactory) {
		this.configFactory = configFactory;
	}

	public void setAuthenticationManager(AuthenticationManager authenticationManager) {
		this.authenticationManager = authenticationManager;
	}

	public void setJokeDao(JokeDao jokeDao) {
		this.jokeDao = jokeDao;
	}
}
