DROP TABLE IF EXISTS staging_caers_events;
CREATE TABLE staging_caers_events (
	report_id varchar(255),
	caers_created_date date,
	date_of_event date,
	product_type text,
	product text,
	product_code text,
	patient_age integer,
	age_units varchar(255),
	sex text,
	terms text,
	outcomes text,
	primary key (report_id, product_type, product, product_code),
	CONSTRAINT staging_caers_events_ibfk_1 FOREIGN KEY (product_code) REFERENCES codeanddescription (product_code)
	);
	
DROP TABLE IF EXISTS codeanddescription;
CREATE TABLE codeanddescription(
	product_code text,
	description text,
	PRIMARY KEY (product_code)
	);