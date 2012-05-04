
--
-- Table structure for table "dim_actor"
--

DROP TABLE IF EXISTS "dim_actor" CASCADE;
CREATE TABLE "dim_actor" (
  "actor_key" bigserial  NOT NULL,
  "actor_last_update" timestamp NOT NULL,
  "actor_last_name" text NOT NULL,
  "actor_first_name" text NOT NULL,
  "actor_id" bigint NOT NULL,
  PRIMARY KEY ("actor_key")
);

--
-- Table structure for table "dim_customer"
--

DROP TABLE IF EXISTS "dim_customer" CASCADE;
CREATE TABLE "dim_customer" (
  "customer_key" bigserial PRIMARY KEY,
  "customer_last_update" timestamp NOT NULL DEFAULT '1970-01-01 00:00:00',
  "customer_id" bigint ,
  "customer_first_name" text ,
  "customer_last_name" text ,
  "customer_email" text ,
  "customer_active" text ,
  "customer_created" date ,
  "customer_address" text ,
  "customer_district" text ,
  "customer_postal_code" text ,
  "customer_phone_number" text ,
  "customer_city" text ,
  "customer_country" text ,
  "customer_version_number" smallint ,
  "customer_valid_from" date ,
  "customer_valid_through" date
--  ,
--  KEY "customer_id" ("customer_id")
) ;
CREATE INDEX dim_customer_customer_id ON dim_customer(customer_id);
--
-- Table structure for table "dim_date"
--

DROP TABLE IF EXISTS "dim_date" CASCADE;
CREATE TABLE "dim_date" (
  "date_key" bigint PRIMARY KEY,
  "date_value" date UNIQUE NOT NULL,
  "date_short" text NOT NULL,
  "date_medium" text NOT NULL,
  "date_long" text NOT NULL,
  "date_full" text NOT NULL,
  "day_in_year" smallint NOT NULL,
  "day_in_month" smallint NOT NULL,
  "is_first_day_in_month" text NOT NULL,
  "is_last_day_in_month" text NOT NULL,
  "day_abbreviation" text NOT NULL,
  "day_name" text NOT NULL,
  "week_in_year" smallint NOT NULL,
  "week_in_month" smallint NOT NULL,
  "is_first_day_in_week" text NOT NULL,
  "is_last_day_in_week" text NOT NULL,
  "month_number" smallint NOT NULL,
  "month_abbreviation" text NOT NULL,
  "month_name" text NOT NULL,
  "year2" text NOT NULL,
  "year4" smallint NOT NULL,
  "quarter_name" text NOT NULL,
  "quarter_number" smallint NOT NULL,
  "year_quarter" text NOT NULL,
  "year_month_number" text NOT NULL,
  "year_month_abbreviation" text NOT NULL
);

--
-- Table structure for table "dim_film"
--

DROP TABLE IF EXISTS "dim_film" CASCADE;
CREATE TABLE "dim_film" (
  "film_key" bigserial PRIMARY KEY,
  "film_last_update" timestamp NOT NULL,
  "film_title" text NOT NULL,
  "film_description" text NOT NULL,
  "film_release_year" smallint NOT NULL,
  "film_language" text NOT NULL,
  "film_original_language" text NOT NULL,
  "film_rental_duration" smallint ,
  "film_rental_rate" numeric(4,2) ,
  "film_duration" bigint ,
  "film_replacement_cost" numeric(5,2) ,
  "film_rating_code" text ,
  "film_rating_text" text ,
  "film_has_trailers" text ,
  "film_has_commentaries" text ,
  "film_has_deleted_scenes" text ,
  "film_has_behind_the_scenes" text ,
  "film_in_category_action" text ,
  "film_in_category_animation" text ,
  "film_in_category_children" text ,
  "film_in_category_classics" text ,
  "film_in_category_comedy" text ,
  "film_in_category_documentary" text ,
  "film_in_category_drama" text ,
  "film_in_category_family" text ,
  "film_in_category_foreign" text ,
  "film_in_category_games" text ,
  "film_in_category_horror" text ,
  "film_in_category_music" text ,
  "film_in_category_new" text ,
  "film_in_category_scifi" text ,
  "film_in_category_sports" text ,
  "film_in_category_travel" text ,
  "film_id" bigint NOT NULL
);

--
-- Table structure for table "dim_film_actor_bridge"
--

DROP TABLE IF EXISTS "dim_film_actor_bridge" CASCADE;
CREATE TABLE "dim_film_actor_bridge" (
  "film_key" bigint NOT NULL REFERENCES dim_film(film_key),
  "actor_key" bigint NOT NULL REFERENCES dim_actor(actor_key),
  "actor_weighting_factor" numeric(3,2) NOT NULL,
  PRIMARY KEY ("film_key","actor_key")
);
CREATE INDEX dim_film_actor_bridge_actor_key ON dim_film_actor_bridge(actor_key);

--
-- Table structure for table "dim_staff"
--

DROP TABLE IF EXISTS "dim_staff" CASCADE;
CREATE TABLE "dim_staff" (
  "staff_key" bigserial PRIMARY KEY,
  "staff_last_update" timestamp NOT NULL DEFAULT '1970-01-01 00:00:00',
  "staff_first_name" text ,
  "staff_last_name" text ,
  "staff_id" bigint ,
  "staff_store_id" bigint ,
  "staff_version_number" smallint ,
  "staff_valid_from" date ,
  "staff_valid_through" date ,
  "staff_active" text
);
CREATE INDEX dim_staff_staff_id ON dim_staff(staff_id);

--
-- Table structure for table "dim_store"
--

DROP TABLE IF EXISTS "dim_store" CASCADE;
CREATE TABLE "dim_store" (
  "store_key" bigserial PRIMARY KEY,
  "store_last_update" timestamp NOT NULL DEFAULT '1970-01-01 00:00:00',
  "store_id" bigint ,
  "store_address" text ,
  "store_district" text ,
  "store_postal_code" text ,
  "store_phone_number" text ,
  "store_city" text ,
  "store_country" text ,
  "store_manager_staff_id" bigint ,
  "store_manager_first_name" text ,
  "store_manager_last_name" text ,
  "store_version_number" smallint ,
  "store_valid_from" date ,
  "store_valid_through" date
) ;
CREATE INDEX dim_store_store_id ON dim_store(store_id);

--
-- Table structure for table "dim_time"
--

DROP TABLE IF EXISTS "dim_time" CASCADE;
CREATE TABLE "dim_time" (
  "time_key" bigint PRIMARY KEY,
  "time_value" time UNIQUE NOT NULL,
  "hours24" smallint NOT NULL,
  "hours12" smallint ,
  "minutes" smallint ,
  "seconds" smallint ,
  "am_pm" text
) ;

--
-- Table structure for table "fact_rental"
--

DROP TABLE IF EXISTS "fact_rental" CASCADE;
CREATE TABLE "fact_rental" (
  "customer_key" bigint NOT NULL REFERENCES dim_customer(customer_key),
  "staff_key" bigint NOT NULL REFERENCES dim_staff(staff_key),
  "film_key" bigint NOT NULL REFERENCES dim_film(film_key),
  "store_key" bigint NOT NULL REFERENCES dim_store(store_key),
  "rental_date_key" bigint NOT NULL REFERENCES dim_date(date_key),
  "return_date_key" bigint NOT NULL REFERENCES dim_date(date_key),
  "rental_time_key" bigint NOT NULL REFERENCES dim_time(time_key),
  "count_returns" bigint NOT NULL,
  "count_rentals" bigint NOT NULL,
  "rental_duration" bigint,
  "rental_last_update" timestamp ,
  "rental_id" bigint
) ;
CREATE INDEX fact_rental_customer_key ON fact_rental(customer_key);
CREATE INDEX fact_rental_staff_key ON fact_rental(staff_key);
CREATE INDEX fact_rental_film_key ON fact_rental(film_key);
CREATE INDEX fact_rental_store_key ON fact_rental(store_key);
CREATE INDEX fact_rental_rental_date_key ON fact_rental(rental_date_key);
CREATE INDEX fact_rental_return_date_key ON fact_rental(return_date_key);
CREATE INDEX fact_rental_rental_time_key ON fact_rental(rental_time_key);
