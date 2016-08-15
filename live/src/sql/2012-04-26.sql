-- 节日提醒
create sequence seq_a_holiday_reminds;
create table a_holiday_reminds (
	id number(10) primary key,
	name varchar2(100) not null,
	lunar number(1) not null,
	lunar_date varchar2(20),
	year number(4),
	month number(2),
	day number(2),
	user_id number(10),
	holiday_type varchar2(50) not null
);

insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '元旦', 0, 1, 1, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界湿地日', 0, 2, 2, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '情人节', 0, 2, 14 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '青年志愿者服务日', 0, 3, 5, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际妇女节', 0, 3, 8, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '中国植树节', 0, 3, 12, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '白色情人节', 0, 3, 14, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界消费者权益日', 0, 3, 15, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '白色情人节', 0, 3, 14, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '愚人节', 0, 4, 1, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '清明节', 0, 4, 5, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界卫生日', 0, 4, 7, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界地球日', 0, 4, 22, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界知识产权日', 0, 4, 26, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际劳动节', 0, 5, 1, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '中国青年节', 0, 5, 4, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界红十字日', 0, 5, 8, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际护士节', 0, 5, 12, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际家庭日', 0, 5, 15, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界无烟日', 0, 5, 31, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际儿童节', 0, 6, 1, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界环境日', 0, 6, 5, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际奥林匹克日', 0, 6, 23, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际禁毒日', 0, 6, 26, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '中国共产党诞生日', 0, 7, 1, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '中国人民抗日战争纪念日', 0, 7, 7, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界人口日', 0, 7, 11, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '中国人民解放军建军节', 0, 8, 1, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际青年节', 0, 8, 12, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际扫盲日', 0, 9, 8, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '中国教师节', 0, 9, 10, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界旅游日', 0, 9, 27, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '中华人民共和国国庆节', 0, 10, 1, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界动物日', 0, 10, 4, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界教师日', 0, 10, 5, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界邮政日', 0, 10, 9, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际盲人节', 0, 10, 15, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '联合国日', 0, 10, 24, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '中国男性健康日', 0, 10, 28, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '万圣节', 0, 10, 31, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '中国记者节', 0, 11, 8, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '消防宣传日', 0, 11, 9, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际大学生节', 0, 11, 17, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际消除对妇女的暴力日', 0, 11, 25, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界爱滋病日', 0, 12, 1, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '世界残疾人日', 0, 12, 3, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '全国法制宣传日', 0, 12, 4, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '圣诞节', 0, 12, 25, 'holiday');
insert into a_holiday_reminds (id, name, lunar, month, day, holiday_type) values (seq_a_holiday_reminds.nextval, '国际消除对妇女的暴力日', 0, 11, 25, 'holiday');

insert into a_holiday_reminds (id, name, lunar, lunar_date, holiday_type) values (seq_a_holiday_reminds.nextval, '春节', 1, '正月初一', 'holiday');
insert into a_holiday_reminds (id, name, lunar, lunar_date, holiday_type) values (seq_a_holiday_reminds.nextval, '元宵节', 1, '正月十五', 'holiday');
insert into a_holiday_reminds (id, name, lunar, lunar_date, holiday_type) values (seq_a_holiday_reminds.nextval, '端午节', 1, '五月初五', 'holiday');
insert into a_holiday_reminds (id, name, lunar, lunar_date, holiday_type) values (seq_a_holiday_reminds.nextval, '中国情人节', 1, '七月初七', 'holiday');
insert into a_holiday_reminds (id, name, lunar, lunar_date, holiday_type) values (seq_a_holiday_reminds.nextval, '中秋节', 1, '八月十五', 'holiday');
insert into a_holiday_reminds (id, name, lunar, lunar_date, holiday_type) values (seq_a_holiday_reminds.nextval, '重阳节', 1, '九月初九', 'holiday');
insert into a_holiday_reminds (id, name, lunar, lunar_date, holiday_type) values (seq_a_holiday_reminds.nextval, '腊八节', 1, '腊月初八', 'holiday');