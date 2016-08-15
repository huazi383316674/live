create table se_departments (
  id     number(10) primary key,
  code   varchar2(20) not null,
  name   varchar2(255) not null,
  enable number(1) not null,
  remark varchar2(255)
);

alter table se_users add department_id number(10) references se_departments(id);

---
create table s_suggest_handle_types (
  id     number(10) primary key,
  code   varchar2(20) not null,
  name   varchar2(255) not null,
  enable number(1) not null,
  remark varchar2(255)
);
create sequence seq_s_suggest_handle_types start with 4;
insert into s_suggest_handle_types (id, code, name, enable) values (1, '1', '未解决', 1);
insert into s_suggest_handle_types (id, code, name, enable) values (2, '2', '已解决', 2);
insert into s_suggest_handle_types (id, code, name, enable) values (3, '3', '不解决', 3);

create table s_suggests (
  id                number(19) primary key,
  appoint_user_id   number(19) references se_users(id),
  content           varchar2(1000),
  created_at        timestamp(6) not null,
  first_module      varchar2(100) not null,
  handle_type_id    number(19) references S_SUGGEST_HANDLE_TYPES(id),
  new_require       number(1),
  no                varchar2(20) not null,
  passed            number(1),
  predict_handle_at timestamp(6),
  remark            varchar2(1000),
  second_module     varchar2(100),
  speaker_id        number(19) references se_users(id),
  updated_at        timestamp(6)
);

create table s_suggest_tails (
	id	number(19)	primary key,
	suggest_id	number(19)	references s_suggests(id),
	created_at	timestamp(6),
	tail_user_id	number(19)	references se_users(id),
	tail_explain	varchar2(500),
	handle_type_id	number(19)	references s_suggest_handle_types(id),
	appoint_user_id	number(19)	references se_users(id)
);
create sequence seq_s_suggest_tails;

create table s_suggest_attachments (
	id number(10) primary key,
	name varchar2(255) not null,
	file_name varchar2(255) not null,
	created_at timestamp(6) not null,
	uploader_id number(19) not null references se_users(id),
	suggest_id number(19) references s_suggests(id),
	suggest_tail_id number(19) references s_suggest_tails(id)
);
create sequence seq_s_suggest_attachments;
commit;