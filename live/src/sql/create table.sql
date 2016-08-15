create table a_base_coders (
	id number(10) primary key,
	name varchar2(255) not null,
	eng_name varchar2(255) not null,
	class_name varchar2(255) not null
);

insert into a_base_coders(id, name, eng_name, class_name) values (1, '收支类型', 'incomepaymenttype', 'com.sad.model.basecode.incomepaymenttype');

---- 业务类型
create table a_business_types (
	id number(10) primary key,
	code varchar2(20) not null,
	name varchar2(255) not null,
	enable number(1) not null,
	remark varchar(255)
);

insert into a_business_types(id, code, name, enable) values(1, '1', '收入', 1);
insert into a_business_types(id, code, name, enable) values(2, '2', '支出', 1);
insert into a_business_types(id, code, name, enable) values(3, '3', '借入', 1);
insert into a_business_types(id, code, name, enable) values(4, '4', '借出', 1);

---- 收支类型
create table a_income_payment_types (
	id number(10) primary key,
	code varchar2(20) not null,
	name varchar2(255) not null,
	enable number(1) not null,
	remark varchar(255),
	business_type_id number(10) not null
);

insert into a_income_payment_types(id, code, name, enable, business_type_id) values(1, '1', '工资', 1, 1);
insert into a_income_payment_types(id, code, name, enable, business_type_id) values(2, '2', '奖金', 1, 1);
insert into a_income_payment_types(id, code, name, enable, business_type_id) values(3, '3', '其他', 1, 1);
insert into a_income_payment_types(id, code, name, enable, business_type_id) values(4, '4', '餐饮', 1, 2);
insert into a_income_payment_types(id, code, name, enable, business_type_id) values(5, '5', '生活品', 1, 2);
insert into a_income_payment_types(id, code, name, enable, business_type_id) values(6, '6', '零食', 1, 2);
insert into a_income_payment_types(id, code, name, enable, business_type_id) values(7, '7', '服装', 1, 2);
insert into a_income_payment_types(id, code, name, enable, business_type_id) values(8, '8', '化妆品', 1, 2);
insert into a_income_payment_types(id, code, name, enable, business_type_id) values(9, '9', '其他', 1, 2);


-- 账单记录
create sequence seq_a_income_payment_records;
create table a_income_payment_records (
	id number(10) primary key,
	name varchar2(255) not null,
	sum float not null,
	type_id number(10) not null,
	create_at timestamp not null,
	user_id number(10) not null,
	remark varchar2(255)
);
alter table a_income_payment_records add constraint fk_incomepayment_record_type foreign key (type_id) references a_income_payment_types(id);


--- 债务管理
create sequence seq_a_debt_records;
create table a_debt_records (
	id number(10) primary key,
	name varchar2(255) not null,
	amount float not null,
	debt_type varchar2(50) not null,
	debt_user_name varchar(100) not null,
	user_id number(10) not null,
	remark varchar2(255),
	create_on timestamp not null,
	pre_return_on timestamp,
	return_on timestamp,
	finished number(1) not null
);

create sequence seq_a_debt_return_records;
create table a_debt_return_records (
	id number(10) primary key,
	debt_record_id number(10) not null,
	amount float not null,
	return_on timestamp not null,
	remark varchar2(255) 
);


-- 公共用户消费管理
create sequence seq_a_commonuser_users;
create table a_commonuser_users (
	id number(10) primary key,
	name varchar2(100) not null,
	create_on timestamp not null,
	enable number(1) not null
);

create sequence seq_a_commonuser_consumes;
create table a_commonuser_consumes (
	id number(10) primary key,
	common_user_id number(10) not null,
	amount float not null,
	business_type_id number(10) not null,
	create_on timestamp not null
);
alter table a_commonuser_consumes add constraint fk_commonuser_consume_user foreign key (common_user_id) references a_commonuser_users(id);
alter table a_commonuser_consumes add constraint fk_commonuser_consume_type foreign key (business_type_id) references a_business_types(id);