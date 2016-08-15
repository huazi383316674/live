alter table a_income_payment_records rename column create_at to create_on;

alter table a_debt_records add in_pay_record_id number(10);
alter table a_debt_return_records add in_pay_record_id number(10);