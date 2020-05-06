DROP TABLE IF EXISTS shipments;
DROP TABLE IF EXISTS packages;
DROP TABLE IF EXISTS activities;

CREATE TABLE IF NOT EXISTS shipments (
  id SERIAL primary key,
  shipper_number integer,
  service json, --{code:123, description: 'abc'}
  reference_number json, --{code:01, value: 123}
  identification_number varchar(10),
  pickup_date timestamp,
  delivery_date_unavailable json, --{type:'abc', description: 'xyz'}
  shipper_address json, --{address_line_1, city, state, postal_code, country_code}
  ship_to_address json --{city, state, postal_code, country_code}
);

CREATE TABLE IF NOT EXISTS packages (
  id SERIAL primary key,
  shipment_id integer,
  tracking_number varchar(10),
  package_weight float,
  unit_of_measurement varchar(100)
);

CREATE TABLE IF NOT EXISTS activities (
  id SERIAL primary key,
  package_id integer,
  city varchar(100),
  state varchar(100),
  postal_code varchar(100),
  country_code varchar(100),
  location_code varchar(100),
  location_description varchar(500),
  status_type_code varchar(100),
  status_type_description varchar(500),
  status_code varchar(100),
  activity_date date,
  activity_time time 
);
