--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.1
-- Dumped by pg_dump version 9.2.1
-- Started on 2019-03-24 20:48:23

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 183 (class 3079 OID 11727)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2042 (class 0 OID 0)
-- Dependencies: 183
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 168 (class 1259 OID 40961)
-- Name: actor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE actor (
    id integer NOT NULL,
    version integer NOT NULL,
    city character varying(255),
    country character varying(255),
    medium_stars double precision,
    name character varying(255),
    number_of_trips integer,
    phone character varying(255),
    surname character varying(255),
    user_account integer
);


ALTER TABLE public.actor OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 40969)
-- Name: administrator; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE administrator (
    id integer NOT NULL,
    version integer NOT NULL,
    city character varying(255),
    country character varying(255),
    medium_stars double precision,
    name character varying(255),
    number_of_trips integer,
    phone character varying(255),
    surname character varying(255),
    user_account integer
);


ALTER TABLE public.administrator OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 40977)
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comment (
    id integer NOT NULL,
    version integer NOT NULL,
    date timestamp without time zone,
    star double precision,
    text character varying(255),
    driver integer NOT NULL,
    passenger integer NOT NULL
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 40982)
-- Name: control_point; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE control_point (
    id integer NOT NULL,
    version integer NOT NULL,
    text character varying(255),
    route integer NOT NULL
);


ALTER TABLE public.control_point OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 40987)
-- Name: driver; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE driver (
    id integer NOT NULL,
    version integer NOT NULL,
    city character varying(255),
    country character varying(255),
    medium_stars double precision,
    name character varying(255),
    number_of_trips integer,
    phone character varying(255),
    surname character varying(255),
    user_account integer,
    bank_account_number character varying(255),
    cash double precision,
    childs boolean,
    cvv integer,
    exp_month integer,
    exp_year integer,
    number character varying(255),
    music boolean,
    pets boolean,
    smoke boolean
);


ALTER TABLE public.driver OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 40995)
-- Name: folder; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE folder (
    id integer NOT NULL,
    version integer NOT NULL,
    name character varying(255),
    system boolean NOT NULL,
    actor integer NOT NULL
);


ALTER TABLE public.folder OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 41000)
-- Name: folder_messages; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE folder_messages (
    folder integer NOT NULL,
    messages integer NOT NULL
);


ALTER TABLE public.folder_messages OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 41131)
-- Name: hibernate_sequences; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hibernate_sequences (
    sequence_name character varying(255),
    sequence_next_hi_value integer
);


ALTER TABLE public.hibernate_sequences OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 41003)
-- Name: letter; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE letter (
    id integer NOT NULL,
    version integer NOT NULL,
    alert_type integer,
    body character varying(255),
    is_report boolean,
    moment timestamp without time zone,
    priority character varying(255),
    subject character varying(255),
    folder integer NOT NULL,
    recipient integer NOT NULL,
    sender integer NOT NULL
);


ALTER TABLE public.letter OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 41011)
-- Name: passenger; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE passenger (
    id integer NOT NULL,
    version integer NOT NULL,
    city character varying(255),
    country character varying(255),
    medium_stars double precision,
    name character varying(255),
    number_of_trips integer,
    phone character varying(255),
    surname character varying(255),
    user_account integer,
    bank_account_number character varying(255),
    cash double precision,
    cvv integer,
    exp_month integer,
    exp_year integer,
    number character varying(255)
);


ALTER TABLE public.passenger OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 41019)
-- Name: reserve; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE reserve (
    id integer NOT NULL,
    version integer NOT NULL,
    destination character varying(255),
    luggage_size integer,
    origin character varying(255),
    price double precision,
    seat integer,
    passenger integer NOT NULL,
    route integer NOT NULL
);


ALTER TABLE public.reserve OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 41027)
-- Name: route; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE route (
    id integer NOT NULL,
    version integer NOT NULL,
    avaliable_seats integer,
    days_repeat character varying(255),
    departure_date timestamp without time zone,
    destination character varying(255),
    details character varying(255),
    distance double precision,
    max_lugagge integer,
    origin character varying(255),
    price_per_passenger double precision,
    stimated_duration integer,
    driver integer NOT NULL
);


ALTER TABLE public.route OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 41035)
-- Name: user_account; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_account (
    id integer NOT NULL,
    version integer NOT NULL,
    banned boolean,
    password character varying(255),
    username character varying(255)
);


ALTER TABLE public.user_account OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 41043)
-- Name: user_account_authorities; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_account_authorities (
    user_account integer NOT NULL,
    authority character varying(255)
);


ALTER TABLE public.user_account_authorities OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 41046)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE vehicle (
    id integer NOT NULL,
    version integer NOT NULL,
    description character varying(255),
    image character varying(255),
    model character varying(255),
    plate character varying(255),
    seats_capacity integer NOT NULL,
    type integer,
    vehicle_brand character varying(255),
    driver integer NOT NULL
);


ALTER TABLE public.vehicle OWNER TO postgres;

--
-- TOC entry 2020 (class 0 OID 40961)
-- Dependencies: 168
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY actor (id, version, city, country, medium_stars, name, number_of_trips, phone, surname, user_account) FROM stdin;
\.


--
-- TOC entry 2021 (class 0 OID 40969)
-- Dependencies: 169
-- Data for Name: administrator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY administrator (id, version, city, country, medium_stars, name, number_of_trips, phone, surname, user_account) FROM stdin;
\.


--
-- TOC entry 2022 (class 0 OID 40977)
-- Dependencies: 170
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY comment (id, version, date, star, text, driver, passenger) FROM stdin;
\.


--
-- TOC entry 2023 (class 0 OID 40982)
-- Dependencies: 171
-- Data for Name: control_point; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY control_point (id, version, text, route) FROM stdin;
\.


--
-- TOC entry 2024 (class 0 OID 40987)
-- Dependencies: 172
-- Data for Name: driver; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY driver (id, version, city, country, medium_stars, name, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, cvv, exp_month, exp_year, number, music, pets, smoke) FROM stdin;
\.


--
-- TOC entry 2025 (class 0 OID 40995)
-- Dependencies: 173
-- Data for Name: folder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY folder (id, version, name, system, actor) FROM stdin;
\.


--
-- TOC entry 2026 (class 0 OID 41000)
-- Dependencies: 174
-- Data for Name: folder_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY folder_messages (folder, messages) FROM stdin;
\.


--
-- TOC entry 2034 (class 0 OID 41131)
-- Dependencies: 182
-- Data for Name: hibernate_sequences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY hibernate_sequences (sequence_name, sequence_next_hi_value) FROM stdin;
domain_entity	1
\.


--
-- TOC entry 2027 (class 0 OID 41003)
-- Dependencies: 175
-- Data for Name: letter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY letter (id, version, alert_type, body, is_report, moment, priority, subject, folder, recipient, sender) FROM stdin;
\.


--
-- TOC entry 2028 (class 0 OID 41011)
-- Dependencies: 176
-- Data for Name: passenger; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY passenger (id, version, city, country, medium_stars, name, number_of_trips, phone, surname, user_account, bank_account_number, cash, cvv, exp_month, exp_year, number) FROM stdin;
\.


--
-- TOC entry 2029 (class 0 OID 41019)
-- Dependencies: 177
-- Data for Name: reserve; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reserve (id, version, destination, luggage_size, origin, price, seat, passenger, route) FROM stdin;
\.


--
-- TOC entry 2030 (class 0 OID 41027)
-- Dependencies: 178
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY route (id, version, avaliable_seats, days_repeat, departure_date, destination, details, distance, max_lugagge, origin, price_per_passenger, stimated_duration, driver) FROM stdin;
\.


--
-- TOC entry 2031 (class 0 OID 41035)
-- Dependencies: 179
-- Data for Name: user_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_account (id, version, banned, password, username) FROM stdin;
5	0	\N	21232f297a57a5a743894a0e4a801fc3	admin@gmail.com
6	0	\N	1b3231655cebb7a1f783eddf27d254ca	super@gmail.com
7	0	\N	b85aef08608180db9d4ddad38ae40545	driver1@gmail.com
8	0	\N	31d087d1d02e86ab7a25d13a7f7c61d1	passenger1@gmail.com
\.


--
-- TOC entry 2032 (class 0 OID 41043)
-- Dependencies: 180
-- Data for Name: user_account_authorities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_account_authorities (user_account, authority) FROM stdin;
5	ADMIN
6	ADMIN
6	DRIVER
6	PASSENGER
7	DRIVER
8	PASSENGER
\.


--
-- TOC entry 2033 (class 0 OID 41046)
-- Dependencies: 181
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) FROM stdin;
\.


--
-- TOC entry 1980 (class 2606 OID 40968)
-- Name: actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (id);


--
-- TOC entry 1982 (class 2606 OID 40976)
-- Name: administrator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY administrator
    ADD CONSTRAINT administrator_pkey PRIMARY KEY (id);


--
-- TOC entry 1984 (class 2606 OID 40981)
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 1986 (class 2606 OID 40986)
-- Name: control_point_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY control_point
    ADD CONSTRAINT control_point_pkey PRIMARY KEY (id);


--
-- TOC entry 1988 (class 2606 OID 40994)
-- Name: driver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (id);


--
-- TOC entry 1990 (class 2606 OID 40999)
-- Name: folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY folder
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);


--
-- TOC entry 1992 (class 2606 OID 41010)
-- Name: letter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY letter
    ADD CONSTRAINT letter_pkey PRIMARY KEY (id);


--
-- TOC entry 1994 (class 2606 OID 41018)
-- Name: passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (id);


--
-- TOC entry 1996 (class 2606 OID 41026)
-- Name: reserve_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reserve
    ADD CONSTRAINT reserve_pkey PRIMARY KEY (id);


--
-- TOC entry 1998 (class 2606 OID 41034)
-- Name: route_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY route
    ADD CONSTRAINT route_pkey PRIMARY KEY (id);


--
-- TOC entry 2000 (class 2606 OID 41055)
-- Name: uk_castjbvpeeus0r8lbpehiu0e4; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_account
    ADD CONSTRAINT uk_castjbvpeeus0r8lbpehiu0e4 UNIQUE (username);


--
-- TOC entry 2002 (class 2606 OID 41042)
-- Name: user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id);


--
-- TOC entry 2004 (class 2606 OID 41053)
-- Name: vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (id);


--
-- TOC entry 2006 (class 2606 OID 41061)
-- Name: fk_7ohwsa2usmvu0yxb44je2lge; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administrator
    ADD CONSTRAINT fk_7ohwsa2usmvu0yxb44je2lge FOREIGN KEY (user_account) REFERENCES user_account(id);


--
-- TOC entry 2014 (class 2606 OID 41101)
-- Name: fk_89ybpmvuu58cqappc2xh352n; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY passenger
    ADD CONSTRAINT fk_89ybpmvuu58cqappc2xh352n FOREIGN KEY (user_account) REFERENCES user_account(id);


--
-- TOC entry 2007 (class 2606 OID 41066)
-- Name: fk_98rnmdie3oie8dg1yqol90hdr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT fk_98rnmdie3oie8dg1yqol90hdr FOREIGN KEY (driver) REFERENCES driver(id);


--
-- TOC entry 2017 (class 2606 OID 41116)
-- Name: fk_dffo7urokcw2cn9r0r6lt55qr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY route
    ADD CONSTRAINT fk_dffo7urokcw2cn9r0r6lt55qr FOREIGN KEY (driver) REFERENCES driver(id);


--
-- TOC entry 2016 (class 2606 OID 41111)
-- Name: fk_hb97c9573ne496mn8qs2q1r7o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reserve
    ADD CONSTRAINT fk_hb97c9573ne496mn8qs2q1r7o FOREIGN KEY (route) REFERENCES route(id);


--
-- TOC entry 2005 (class 2606 OID 41056)
-- Name: fk_i7xei45auwq1f6vu25985riuh; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY actor
    ADD CONSTRAINT fk_i7xei45auwq1f6vu25985riuh FOREIGN KEY (user_account) REFERENCES user_account(id);


--
-- TOC entry 2010 (class 2606 OID 41081)
-- Name: fk_io5y53xvplfwhg963q7gkqfrf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY driver
    ADD CONSTRAINT fk_io5y53xvplfwhg963q7gkqfrf FOREIGN KEY (user_account) REFERENCES user_account(id);


--
-- TOC entry 2019 (class 2606 OID 41126)
-- Name: fk_nag238mutkrwt14u74eaeolr8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vehicle
    ADD CONSTRAINT fk_nag238mutkrwt14u74eaeolr8 FOREIGN KEY (driver) REFERENCES driver(id);


--
-- TOC entry 2012 (class 2606 OID 41091)
-- Name: fk_p4c0hkadh5uwpdsjbyqfkauak; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY folder_messages
    ADD CONSTRAINT fk_p4c0hkadh5uwpdsjbyqfkauak FOREIGN KEY (folder) REFERENCES folder(id);


--
-- TOC entry 2018 (class 2606 OID 41121)
-- Name: fk_pao8cwh93fpccb0bx6ilq6gsl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_account_authorities
    ADD CONSTRAINT fk_pao8cwh93fpccb0bx6ilq6gsl FOREIGN KEY (user_account) REFERENCES user_account(id);


--
-- TOC entry 2011 (class 2606 OID 41086)
-- Name: fk_pd7js9rp0nie7ft4b2ltq7jx0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY folder_messages
    ADD CONSTRAINT fk_pd7js9rp0nie7ft4b2ltq7jx0 FOREIGN KEY (messages) REFERENCES letter(id);


--
-- TOC entry 2013 (class 2606 OID 41096)
-- Name: fk_rf9130814jneq8lvkefpr7ux3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY letter
    ADD CONSTRAINT fk_rf9130814jneq8lvkefpr7ux3 FOREIGN KEY (folder) REFERENCES folder(id);


--
-- TOC entry 2008 (class 2606 OID 41071)
-- Name: fk_s5e5esct5k89my48q1bwwtgeq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT fk_s5e5esct5k89my48q1bwwtgeq FOREIGN KEY (passenger) REFERENCES passenger(id);


--
-- TOC entry 2015 (class 2606 OID 41106)
-- Name: fk_sov1eh5ploe3imhp8patoqoev; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reserve
    ADD CONSTRAINT fk_sov1eh5ploe3imhp8patoqoev FOREIGN KEY (passenger) REFERENCES passenger(id);


--
-- TOC entry 2009 (class 2606 OID 41076)
-- Name: fk_taegm7kl65r8306gof05rwly5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_point
    ADD CONSTRAINT fk_taegm7kl65r8306gof05rwly5 FOREIGN KEY (route) REFERENCES route(id);


--
-- TOC entry 2041 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2019-03-24 20:48:24

--
-- PostgreSQL database dump complete
--

