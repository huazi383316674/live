package com.sad;

import org.beangle.emsapp.portal.action.HomeAction;
import org.beangle.spring.bind.AbstractBindModule;
import org.beangle.spring.bind.Scope;

import com.sad.service.baseCode.impl.BaseCodeServiceImpl;
import com.sad.service.other.impl.HolidayRemindServiceImpl;
import com.sad.service.suggest.impl.SuggestGenCodeServiceImpl;
import com.sad.service.suggest.impl.SuggestServiceImpl;
import com.sad.service.system.impl.MoneyDataServiceImpl;
import com.sad.web.action.MoneyCommonAction;
import com.sad.web.action.baseCode.MoneyBaseCodeAction;
import com.sad.web.action.commonUser.CommonUserAction;
import com.sad.web.action.commonUser.CommonUserConsumeAction;
import com.sad.web.action.commonUser.CommonUserWorkRecordAction;
import com.sad.web.action.debt.DebtRecordAction;
import com.sad.web.action.debt.DebtReturnAction;
import com.sad.web.action.debt.DebtStatAction;
import com.sad.web.action.money.IncomePaymentRecordAction;
import com.sad.web.action.other.HolidayRemindAction;
import com.sad.web.action.shopping.ShoppingGoodsAction;
import com.sad.web.action.shopping.ShoppingOrderAction;
import com.sad.web.action.shopping.ShoppingOrderManageAction;
import com.sad.web.action.stat.CalendarStatementAction;
import com.sad.web.action.stat.InPayStatAction;
import com.sad.web.action.suggest.SuggestAction;
import com.sad.web.action.suggest.SuggestForManagerAction;
import com.sad.web.action.suggest.SuggestForUserAction;
import com.sad.web.action.system.MoneyDataAction;

public class MoneyModule extends AbstractBindModule {

	@Override
	protected void doBinding() {
		/** 公共 */
		bind(MoneyCommonAction.class).in(Scope.PROTOTYPE);

		/** 系统相关、基础数据 */
		bind("home", HomeAction.class).in(Scope.PROTOTYPE);
		bind("moneyBaseCode", MoneyBaseCodeAction.class).in(Scope.PROTOTYPE);
		bind("moneyData", MoneyDataAction.class).in(Scope.PROTOTYPE);

		/** 公共用户管理 */
		bind("commonUser", CommonUserAction.class).in(Scope.PROTOTYPE);
		bind("commonUserConsume", CommonUserConsumeAction.class).in(Scope.PROTOTYPE);
		bind("commonUserWorkRecord", CommonUserWorkRecordAction.class).in(Scope.PROTOTYPE);

		/** 收支管理、债务管理、债务统计 */
		bind("debtRecord", DebtRecordAction.class).in(Scope.PROTOTYPE);
		bind("debtReturn", DebtReturnAction.class).in(Scope.PROTOTYPE);
		bind("debtStat", DebtStatAction.class).in(Scope.PROTOTYPE);
		bind("incomePaymentRecord", IncomePaymentRecordAction.class).in(Scope.PROTOTYPE);

		/** 其他功能（节日提醒） */
		bind("holidayRemind", HolidayRemindAction.class).in(Scope.PROTOTYPE);

		/** 统计相关 */
		bind("calendarStatement", CalendarStatementAction.class).in(Scope.PROTOTYPE);
		bind("inPayStat", InPayStatAction.class).in(Scope.PROTOTYPE);

		/** 购物相关管理 */
		bind("shoppingGoods", ShoppingGoodsAction.class).in(Scope.PROTOTYPE);
		bind("shoppingOrder", ShoppingOrderAction.class).in(Scope.PROTOTYPE);
		bind("shoppingOrderManage", ShoppingOrderManageAction.class).in(Scope.PROTOTYPE);

		/** 功能意见管理 */
		bind("suggest", SuggestAction.class).in(Scope.PROTOTYPE);
		bind("suggestForManager", SuggestForManagerAction.class).in(Scope.PROTOTYPE);
		bind("suggestForUser", SuggestForUserAction.class).in(Scope.PROTOTYPE);

		/**
		 * services
		 */
		bind("baseCodeService", BaseCodeServiceImpl.class);
		bind("holidayRemindService", HolidayRemindServiceImpl.class);
		bind("moneyDataService", MoneyDataServiceImpl.class);
		bind("suggestGenCodeService", SuggestGenCodeServiceImpl.class);
		bind("suggestService", SuggestServiceImpl.class);
	}

}
