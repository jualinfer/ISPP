--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.1
-- Dumped by pg_dump version 9.2.1
-- Started on 2019-05-23 18:06:24

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 186 (class 3079 OID 11727)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2069 (class 0 OID 0)
-- Dependencies: 186
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 168 (class 1259 OID 171956)
-- Name: actor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE actor (
    id integer NOT NULL,
    version integer NOT NULL,
    city character varying(255),
    country character varying(255),
    medium_stars double precision,
    name character varying(255),
    new_alerts integer,
    new_messages integer,
    number_of_trips integer,
    phone character varying(255),
    surname character varying(255),
    user_account integer
);


ALTER TABLE public.actor OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 171964)
-- Name: administrator; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE administrator (
    id integer NOT NULL,
    version integer NOT NULL,
    city character varying(255),
    country character varying(255),
    medium_stars double precision,
    name character varying(255),
    new_alerts integer,
    new_messages integer,
    number_of_trips integer,
    phone character varying(255),
    surname character varying(255),
    user_account integer
);


ALTER TABLE public.administrator OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 171972)
-- Name: alert; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE alert (
    id integer NOT NULL,
    version integer NOT NULL,
    alert_body character varying(255),
    date timestamp without time zone,
    is_read boolean,
    type_alert integer,
    receiver integer NOT NULL,
    related_route integer,
    sender integer NOT NULL
);


ALTER TABLE public.alert OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 171977)
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comment (
    id integer NOT NULL,
    version integer NOT NULL,
    date timestamp without time zone,
    from_driver boolean,
    star double precision,
    text character varying(255),
    driver integer NOT NULL,
    passenger integer NOT NULL,
    route integer NOT NULL
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 171982)
-- Name: control_point; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE control_point (
    id integer NOT NULL,
    version integer NOT NULL,
    arrival_order integer,
    arrival_time timestamp without time zone,
    distance double precision,
    location character varying(255),
    route integer NOT NULL
);


ALTER TABLE public.control_point OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 171987)
-- Name: driver; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE driver (
    id integer NOT NULL,
    version integer NOT NULL,
    city character varying(255),
    country character varying(255),
    medium_stars double precision,
    name character varying(255),
    new_alerts integer,
    new_messages integer,
    number_of_trips integer,
    phone character varying(255),
    surname character varying(255),
    user_account integer,
    bank_account_number character varying(255),
    cash double precision,
    childs boolean,
    image character varying(255),
    music boolean,
    pets boolean,
    smoke boolean
);


ALTER TABLE public.driver OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 171995)
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
-- TOC entry 175 (class 1259 OID 172000)
-- Name: folder_messages; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE folder_messages (
    folder integer NOT NULL,
    messages integer NOT NULL
);


ALTER TABLE public.folder_messages OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 172171)
-- Name: hibernate_sequences; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE hibernate_sequences (
    sequence_name character varying(255),
    sequence_next_hi_value integer
);


ALTER TABLE public.hibernate_sequences OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 172003)
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
-- TOC entry 177 (class 1259 OID 172011)
-- Name: message; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE message (
    id integer NOT NULL,
    version integer NOT NULL,
    content character varying(255),
    from_atob boolean,
    issue_date timestamp without time zone,
    thread integer NOT NULL
);


ALTER TABLE public.message OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 172016)
-- Name: messages_thread; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE messages_thread (
    id integer NOT NULL,
    version integer NOT NULL,
    closed boolean,
    new_messages integer,
    last_message integer,
    participanta integer NOT NULL,
    participantb integer NOT NULL,
    reported_user integer,
    route integer NOT NULL
);


ALTER TABLE public.messages_thread OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 172021)
-- Name: passenger; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE passenger (
    id integer NOT NULL,
    version integer NOT NULL,
    city character varying(255),
    country character varying(255),
    medium_stars double precision,
    name character varying(255),
    new_alerts integer,
    new_messages integer,
    number_of_trips integer,
    phone character varying(255),
    surname character varying(255),
    user_account integer,
    bank_account_number character varying(255),
    cash double precision,
    image character varying(255)
);


ALTER TABLE public.passenger OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 172029)
-- Name: reservation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE reservation (
    id integer NOT NULL,
    version integer NOT NULL,
    charge_id character varying(255),
    destination character varying(255),
    driver_no_picked_me boolean NOT NULL,
    driver_picked_me boolean NOT NULL,
    luggage_size integer,
    origin character varying(255),
    payment_resolved boolean,
    price double precision,
    seat integer,
    status integer,
    passenger integer NOT NULL,
    route integer NOT NULL
);


ALTER TABLE public.reservation OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 172037)
-- Name: route; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE route (
    id integer NOT NULL,
    version integer NOT NULL,
    available_seats integer,
    days_repeat character varying(255),
    departure_date timestamp without time zone,
    destination character varying(255),
    details character varying(255),
    distance double precision,
    estimated_duration integer,
    is_cancelled boolean,
    max_luggage integer,
    origin character varying(255),
    price_per_passenger double precision,
    driver integer NOT NULL,
    vehicle integer NOT NULL
);


ALTER TABLE public.route OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 172045)
-- Name: user_account; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_account (
    id integer NOT NULL,
    version integer NOT NULL,
    banned boolean,
    enabled boolean NOT NULL,
    password character varying(255),
    username character varying(255)
);


ALTER TABLE public.user_account OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 172053)
-- Name: user_account_authorities; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_account_authorities (
    user_account integer NOT NULL,
    authority character varying(255)
);


ALTER TABLE public.user_account_authorities OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 172056)
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
-- TOC entry 2044 (class 0 OID 171956)
-- Dependencies: 168
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2045 (class 0 OID 171964)
-- Dependencies: 169
-- Data for Name: administrator; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO administrator (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account) VALUES (867, 0, 'Seville', 'Spain', 0, 'Admin', 0, 0, NULL, '650496245', '(TROND Team)', 866);


--
-- TOC entry 2046 (class 0 OID 171972)
-- Dependencies: 170
-- Data for Name: alert; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2047 (class 0 OID 171977)
-- Dependencies: 171
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1574, 0, '2019-02-01 13:32:00', false, 4, 'Una persona mu salá', 970, 1001, 1103);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1575, 0, '2019-02-01 13:32:00', true, 1, 'Habla demasiado poco', 970, 1001, 1103);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1576, 0, '2019-05-02 08:32:00', false, 3, 'Muy amable', 975, 1005, 1115);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1577, 0, '2019-05-02 08:32:00', true, 3, 'Muy amable', 975, 1005, 1115);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1578, 0, '2019-05-02 08:32:00', false, 2, 'Conduce de forma temeraria', 975, 1005, 1115);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1579, 0, '2019-05-02 08:32:00', true, 3, 'Una persona mu salá', 975, 1005, 1115);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1580, 0, '2019-02-17 09:32:00', false, 3, 'Mastica chicle con la boca abierta', 976, 1008, 1120);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1581, 0, '2019-02-17 09:32:00', true, 3, 'Muy agradable', 976, 1008, 1120);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1582, 0, '2019-02-17 09:32:00', false, 4, 'Muy agradable', 976, 1008, 1120);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1583, 0, '2019-02-17 09:32:00', true, 4, 'Una persona mu salá', 976, 1008, 1120);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1584, 0, '2019-03-21 10:32:00', false, 4, 'Una persona muy agradable', 977, 1009, 1124);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1585, 0, '2019-03-21 10:32:00', true, 5, 'Muy agradable', 977, 1009, 1124);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1586, 0, '2019-02-25 11:32:00', false, 4, 'Muy agradable', 977, 1009, 1125);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1587, 0, '2019-02-25 11:32:00', true, 2, 'Un poco especial', 977, 1009, 1125);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1588, 0, '2019-02-25 11:32:00', false, 1, 'Mastica chicle con la boca abierta', 977, 1009, 1125);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1589, 0, '2019-02-25 11:32:00', true, 3, 'Una persona mu salá', 977, 1009, 1125);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1590, 0, '2019-01-17 14:32:00', false, 3, 'Muy agradable', 989, 1019, 1152);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1591, 0, '2019-01-17 14:32:00', true, 3, 'Una persona mu salá', 989, 1019, 1152);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1592, 0, '2019-01-19 20:32:00', false, 4, 'Muy agradable', 990, 1020, 1154);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1593, 0, '2019-01-19 20:32:00', true, 5, 'Una persona mu salá', 990, 1020, 1154);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1594, 0, '2019-04-21 11:32:00', false, 0, 'Mastica chicle con la boca abierta', 991, 1021, 1156);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1595, 0, '2019-04-21 11:32:00', true, 3, 'Muy agradable', 991, 1021, 1156);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1596, 0, '2019-01-22 11:32:00', false, 3, 'Muy amable', 995, 1028, 1167);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1597, 0, '2019-01-22 11:32:00', true, 1, 'Desagradable', 995, 1028, 1167);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1598, 0, '2019-01-20 20:32:00', false, 1, 'Poca flexibilidad en la recogida y destino', 996, 1030, 1172);
INSERT INTO comment (id, version, date, from_driver, star, text, driver, passenger, route) VALUES (1599, 0, '2019-01-20 20:32:00', true, 0, 'Habla demasiado', 996, 1030, 1172);


--
-- TOC entry 2048 (class 0 OID 171982)
-- Dependencies: 172
-- Data for Name: control_point; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1176, 0, 0, '2019-06-04 12:21:00', 0, 'Felipe II, Sevilla', 1098);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1177, 0, 1, '2019-06-04 12:26:00', 5, 'Torre Sevilla, Sevilla', 1098);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1178, 0, 2, '2019-06-04 12:31:00', 10, 'El Porvenir, Sevilla', 1098);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1179, 0, 3, '2019-06-04 12:36:00', 15, 'Avenida de El Greco, Sevilla', 1098);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1180, 0, 0, '2019-06-26 06:24:00', 0, 'Los Arcos, Avenida de Andalucía, Sevilla', 1099);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1181, 0, 1, '2019-06-26 06:29:00', 5, 'Macarena, Sevilla', 1099);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1182, 0, 2, '2019-06-26 06:34:00', 10, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1099);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1183, 0, 3, '2019-06-26 06:39:00', 15, 'Avenida del Cid, Sevilla', 1099);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1184, 0, 0, '2019-05-14 06:01:00', 0, 'San Bernardo, Sevilla', 1100);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1185, 0, 1, '2019-05-14 06:06:00', 5, 'Los Arcos, Avenida de Andalucía, Sevilla', 1100);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1186, 0, 2, '2019-05-14 06:11:00', 10, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1100);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1187, 0, 0, '2019-06-23 19:11:00', 0, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1101);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1188, 0, 1, '2019-06-23 19:16:00', 5, 'Montequinto, Sevilla', 1101);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1189, 0, 0, '2019-05-23 09:17:00', 0, 'Calle Jilguero, Sevilla', 1102);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1190, 0, 1, '2019-05-23 09:22:00', 5, 'Avenida de El Greco, Sevilla', 1102);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1191, 0, 2, '2019-05-23 09:27:00', 10, 'El Porvenir, Sevilla', 1102);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1192, 0, 0, '2019-02-01 11:00:00', 0, 'San Bernardo, Sevilla', 1103);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1193, 0, 1, '2019-02-01 11:05:00', 5, 'Plaza del Duque de la Victoria, Sevilla', 1103);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1194, 0, 2, '2019-02-01 11:10:00', 10, 'Sevilla Este, Sevilla', 1103);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1195, 0, 3, '2019-02-01 11:15:00', 15, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1103);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1196, 0, 0, '2019-01-02 08:01:00', 0, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1104);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1197, 0, 1, '2019-01-02 08:06:00', 5, 'Calle Jilguero, Sevilla', 1104);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1198, 0, 0, '2019-01-25 19:23:00', 0, 'Sevilla Este, Sevilla', 1105);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1199, 0, 1, '2019-01-25 19:28:00', 5, 'El Porvenir, Sevilla', 1105);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1200, 0, 2, '2019-01-25 19:33:00', 10, 'Calle Jilguero, Sevilla', 1105);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1201, 0, 3, '2019-01-25 19:38:00', 15, 'Gran Plaza, Sevilla', 1105);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1202, 0, 0, '2019-06-16 11:21:00', 0, 'Gran Plaza, Sevilla', 1106);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1203, 0, 1, '2019-06-16 11:26:00', 5, 'Camas, Sevilla', 1106);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1204, 0, 0, '2019-02-20 08:27:00', 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1107);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1205, 0, 1, '2019-02-20 08:32:00', 5, 'Camas, Sevilla', 1107);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1206, 0, 2, '2019-02-20 08:37:00', 10, 'Avenida de El Greco, Sevilla', 1107);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1207, 0, 0, '2019-03-20 18:22:00', 0, 'Montequinto, Sevilla', 1108);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1208, 0, 1, '2019-03-20 18:27:00', 5, 'Los Arcos, Avenida de Andalucía, Sevilla', 1108);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1209, 0, 2, '2019-03-20 18:32:00', 10, 'San Bernardo, Sevilla', 1108);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1210, 0, 3, '2019-03-20 18:37:00', 15, 'Camas, Sevilla', 1108);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1211, 0, 0, '2019-05-08 09:04:00', 0, 'Gran Plaza, Sevilla', 1109);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1212, 0, 1, '2019-05-08 09:09:00', 5, 'Plaza del Duque de la Victoria, Sevilla', 1109);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1213, 0, 2, '2019-05-08 09:14:00', 10, 'Avenida del Cid, Sevilla', 1109);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1214, 0, 3, '2019-05-08 09:19:00', 15, 'Montequinto, Sevilla', 1109);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1215, 0, 0, '2019-01-04 12:03:00', 0, 'Camas, Sevilla', 1110);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1216, 0, 1, '2019-01-04 12:08:00', 5, 'Avenida del Cid, Sevilla', 1110);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1217, 0, 0, '2019-05-28 12:21:00', 0, 'Plaza del Duque de la Victoria, Sevilla', 1111);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1218, 0, 1, '2019-05-28 12:26:00', 5, 'Avenida de El Greco, Sevilla', 1111);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1219, 0, 2, '2019-05-28 12:31:00', 10, 'Torre Sevilla, Sevilla', 1111);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1220, 0, 3, '2019-05-28 12:36:00', 15, 'Los Arcos, Avenida de Andalucía, Sevilla', 1111);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1221, 0, 0, '2019-02-14 20:03:00', 0, 'Gran Plaza, Sevilla', 1112);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1222, 0, 1, '2019-02-14 20:08:00', 5, 'Montequinto, Sevilla', 1112);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1223, 0, 2, '2019-02-14 20:13:00', 10, 'Camas, Sevilla', 1112);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1224, 0, 0, '2019-06-25 19:02:00', 0, 'Montequinto, Sevilla', 1113);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1225, 0, 1, '2019-06-25 19:07:00', 5, 'Torre Sevilla, Sevilla', 1113);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1226, 0, 0, '2019-01-17 19:31:00', 0, 'Plaza del Duque de la Victoria, Sevilla', 1114);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1227, 0, 1, '2019-01-17 19:36:00', 5, 'Camas, Sevilla', 1114);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1228, 0, 2, '2019-01-17 19:41:00', 10, 'Avenida del Cid, Sevilla', 1114);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1229, 0, 0, '2019-05-02 06:28:00', 0, 'Felipe II, Sevilla', 1115);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1230, 0, 1, '2019-05-02 06:33:00', 5, 'El Porvenir, Sevilla', 1115);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1231, 0, 2, '2019-05-02 06:38:00', 10, 'Torre Sevilla, Sevilla', 1115);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1232, 0, 0, '2019-05-08 19:33:00', 0, 'Sevilla Este, Sevilla', 1116);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1233, 0, 1, '2019-05-08 19:38:00', 5, 'Torre Sevilla, Sevilla', 1116);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1234, 0, 2, '2019-05-08 19:43:00', 10, 'Camas, Sevilla', 1116);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1235, 0, 3, '2019-05-08 19:48:00', 15, 'Gran Plaza, Sevilla', 1116);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1236, 0, 0, '2019-04-18 09:21:00', 0, 'Montequinto, Sevilla', 1117);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1237, 0, 1, '2019-04-18 09:26:00', 5, 'El Porvenir, Sevilla', 1117);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1238, 0, 2, '2019-04-18 09:31:00', 10, 'Camas, Sevilla', 1117);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1239, 0, 3, '2019-04-18 09:36:00', 15, 'Torre Sevilla, Sevilla', 1117);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1240, 0, 0, '2019-02-19 20:16:00', 0, 'Los Arcos, Avenida de Andalucía, Sevilla', 1118);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1241, 0, 1, '2019-02-19 20:21:00', 5, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1118);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1242, 0, 2, '2019-02-19 20:26:00', 10, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1118);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1243, 0, 0, '2019-06-07 20:14:00', 0, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1119);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1244, 0, 1, '2019-06-07 20:19:00', 5, 'Camas, Sevilla', 1119);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1245, 0, 0, '2019-02-17 07:20:00', 0, 'Avenida del Cid, Sevilla', 1120);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1246, 0, 1, '2019-02-17 07:25:00', 5, 'Los Arcos, Avenida de Andalucía, Sevilla', 1120);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1247, 0, 2, '2019-02-17 07:30:00', 10, 'Plaza del Duque de la Victoria, Sevilla', 1120);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1248, 0, 3, '2019-02-17 07:35:00', 15, 'El Porvenir, Sevilla', 1120);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1249, 0, 0, '2019-06-15 12:39:00', 0, 'Calle Jilguero, Sevilla', 1121);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1250, 0, 1, '2019-06-15 12:44:00', 5, 'Macarena, Sevilla', 1121);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1251, 0, 0, '2019-02-21 17:31:00', 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1122);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1252, 0, 1, '2019-02-21 17:36:00', 5, 'Avenida de El Greco, Sevilla', 1122);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1253, 0, 2, '2019-02-21 17:41:00', 10, 'Sevilla Este, Sevilla', 1122);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1254, 0, 0, '2019-06-07 18:34:00', 0, 'San Bernardo, Sevilla', 1123);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1255, 0, 1, '2019-06-07 18:39:00', 5, 'Montequinto, Sevilla', 1123);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1256, 0, 2, '2019-06-07 18:44:00', 10, 'El Porvenir, Sevilla', 1123);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1257, 0, 0, '2019-03-21 08:01:00', 0, 'Calle Jilguero, Sevilla', 1124);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1258, 0, 1, '2019-03-21 08:06:00', 5, 'Avenida de El Greco, Sevilla', 1124);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1259, 0, 0, '2019-02-25 09:27:00', 0, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1125);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1260, 0, 1, '2019-02-25 09:32:00', 5, 'Sevilla Este, Sevilla', 1125);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1261, 0, 2, '2019-02-25 09:37:00', 10, 'Avenida de El Greco, Sevilla', 1125);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1262, 0, 0, '2019-01-06 08:13:00', 0, 'Sevilla Este, Sevilla', 1126);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1263, 0, 1, '2019-01-06 08:18:00', 5, 'Montequinto, Sevilla', 1126);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1264, 0, 0, '2019-01-18 18:03:00', 0, 'El Porvenir, Sevilla', 1127);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1265, 0, 1, '2019-01-18 18:08:00', 5, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1127);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1266, 0, 0, '2019-05-28 19:11:00', 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1128);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1267, 0, 1, '2019-05-28 19:16:00', 5, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1128);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1268, 0, 2, '2019-05-28 19:21:00', 10, 'Gran Plaza, Sevilla', 1128);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1269, 0, 3, '2019-05-28 19:26:00', 15, 'Montequinto, Sevilla', 1128);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1270, 0, 0, '2019-06-10 18:08:00', 0, 'Los Arcos, Avenida de Andalucía, Sevilla', 1129);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1271, 0, 1, '2019-06-10 18:13:00', 5, 'Macarena, Sevilla', 1129);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1272, 0, 2, '2019-06-10 18:18:00', 10, 'Felipe II, Sevilla', 1129);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1273, 0, 3, '2019-06-10 18:23:00', 15, 'Avenida de El Greco, Sevilla', 1129);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1274, 0, 0, '2019-03-17 13:03:00', 0, 'Montequinto, Sevilla', 1130);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1275, 0, 1, '2019-03-17 13:08:00', 5, 'Gran Plaza, Sevilla', 1130);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1276, 0, 0, '2019-05-15 17:01:00', 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1131);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1277, 0, 1, '2019-05-15 17:06:00', 5, 'Gran Plaza, Sevilla', 1131);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1278, 0, 2, '2019-05-15 17:11:00', 10, 'El Porvenir, Sevilla', 1131);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1279, 0, 3, '2019-05-15 17:16:00', 15, 'Plaza del Duque de la Victoria, Sevilla', 1131);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1280, 0, 0, '2019-06-01 19:34:00', 0, 'Torre Sevilla, Sevilla', 1132);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1281, 0, 1, '2019-06-01 19:39:00', 5, 'Gran Plaza, Sevilla', 1132);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1282, 0, 2, '2019-06-01 19:44:00', 10, 'Los Arcos, Avenida de Andalucía, Sevilla', 1132);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1283, 0, 0, '2019-04-10 06:23:00', 0, 'Sevilla Este, Sevilla', 1133);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1284, 0, 1, '2019-04-10 06:28:00', 5, 'Calle Jilguero, Sevilla', 1133);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1285, 0, 0, '2019-05-12 20:16:00', 0, 'Los Arcos, Avenida de Andalucía, Sevilla', 1134);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1286, 0, 1, '2019-05-12 20:21:00', 5, 'Plaza del Duque de la Victoria, Sevilla', 1134);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1287, 0, 2, '2019-05-12 20:26:00', 10, 'Torre Sevilla, Sevilla', 1134);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1288, 0, 0, '2019-03-02 20:05:00', 0, 'Felipe II, Sevilla', 1135);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1289, 0, 1, '2019-03-02 20:10:00', 5, 'El Porvenir, Sevilla', 1135);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1290, 0, 0, '2019-05-23 07:23:00', 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1136);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1291, 0, 1, '2019-05-23 07:28:00', 5, 'Gran Plaza, Sevilla', 1136);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1292, 0, 2, '2019-05-23 07:33:00', 10, 'Avenida de El Greco, Sevilla', 1136);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1293, 0, 3, '2019-05-23 07:38:00', 15, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1136);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1294, 0, 0, '2019-06-09 07:20:00', 0, 'Plaza del Duque de la Victoria, Sevilla', 1137);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1295, 0, 1, '2019-06-09 07:25:00', 5, 'Los Arcos, Avenida de Andalucía, Sevilla', 1137);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1296, 0, 2, '2019-06-09 07:30:00', 10, 'Camas, Sevilla', 1137);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1297, 0, 3, '2019-06-09 07:35:00', 15, 'Macarena, Sevilla', 1137);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1298, 0, 0, '2019-04-06 16:36:00', 0, 'Avenida de El Greco, Sevilla', 1138);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1299, 0, 1, '2019-04-06 16:41:00', 5, 'Camas, Sevilla', 1138);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1300, 0, 2, '2019-04-06 16:46:00', 10, 'Montequinto, Sevilla', 1138);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1301, 0, 0, '2019-04-27 08:03:00', 0, 'Los Arcos, Avenida de Andalucía, Sevilla', 1139);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1302, 0, 1, '2019-04-27 08:08:00', 5, 'Plaza del Duque de la Victoria, Sevilla', 1139);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1303, 0, 2, '2019-04-27 08:13:00', 10, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1139);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1304, 0, 0, '2019-05-03 08:33:00', 0, 'San Bernardo, Sevilla', 1140);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1305, 0, 1, '2019-05-03 08:38:00', 5, 'Gran Plaza, Sevilla', 1140);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1306, 0, 0, '2019-06-07 14:24:00', 0, 'Sevilla Este, Sevilla', 1141);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1307, 0, 1, '2019-06-07 14:29:00', 5, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1141);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1308, 0, 2, '2019-06-07 14:34:00', 10, 'Felipe II, Sevilla', 1141);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1309, 0, 3, '2019-06-07 14:39:00', 15, 'El Porvenir, Sevilla', 1141);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1310, 0, 0, '2019-04-10 19:19:00', 0, 'Avenida de El Greco, Sevilla', 1142);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1311, 0, 1, '2019-04-10 19:24:00', 5, 'Avenida del Cid, Sevilla', 1142);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1312, 0, 2, '2019-04-10 19:29:00', 10, 'San Bernardo, Sevilla', 1142);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1313, 0, 0, '2019-02-16 13:30:00', 0, 'Camas, Sevilla', 1143);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1314, 0, 1, '2019-02-16 13:35:00', 5, 'Calle Jilguero, Sevilla', 1143);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1315, 0, 2, '2019-02-16 13:40:00', 10, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1143);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1316, 0, 0, '2019-04-11 13:18:00', 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1144);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1317, 0, 1, '2019-04-11 13:23:00', 5, 'El Porvenir, Sevilla', 1144);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1318, 0, 2, '2019-04-11 13:28:00', 10, 'Avenida de El Greco, Sevilla', 1144);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1319, 0, 3, '2019-04-11 13:33:00', 15, 'Macarena, Sevilla', 1144);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1320, 0, 0, '2019-06-21 18:12:00', 0, 'Plaza del Duque de la Victoria, Sevilla', 1145);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1321, 0, 1, '2019-06-21 18:17:00', 5, 'Gran Plaza, Sevilla', 1145);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1322, 0, 2, '2019-06-21 18:22:00', 10, 'El Porvenir, Sevilla', 1145);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1323, 0, 3, '2019-06-21 18:27:00', 15, 'Los Arcos, Avenida de Andalucía, Sevilla', 1145);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1324, 0, 0, '2019-06-16 20:30:00', 0, 'Torre Sevilla, Sevilla', 1146);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1325, 0, 1, '2019-06-16 20:35:00', 5, 'Felipe II, Sevilla', 1146);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1326, 0, 2, '2019-06-16 20:40:00', 10, 'Plaza del Duque de la Victoria, Sevilla', 1146);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1327, 0, 3, '2019-06-16 20:45:00', 15, 'El Porvenir, Sevilla', 1146);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1328, 0, 0, '2019-04-20 09:14:00', 0, 'Torre Sevilla, Sevilla', 1147);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1329, 0, 1, '2019-04-20 09:19:00', 5, 'Los Arcos, Avenida de Andalucía, Sevilla', 1147);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1330, 0, 2, '2019-04-20 09:24:00', 10, 'El Porvenir, Sevilla', 1147);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1331, 0, 3, '2019-04-20 09:29:00', 15, 'Macarena, Sevilla', 1147);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1332, 0, 0, '2019-05-28 10:08:00', 0, 'San Bernardo, Sevilla', 1148);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1333, 0, 1, '2019-05-28 10:13:00', 5, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1148);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1334, 0, 0, '2019-01-08 08:11:00', 0, 'Macarena, Sevilla', 1149);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1335, 0, 1, '2019-01-08 08:16:00', 5, 'Gran Plaza, Sevilla', 1149);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1336, 0, 2, '2019-01-08 08:21:00', 10, 'Avenida del Cid, Sevilla', 1149);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1337, 0, 3, '2019-01-08 08:26:00', 15, 'Camas, Sevilla', 1149);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1338, 0, 0, '2019-04-10 14:02:00', 0, 'Avenida del Cid, Sevilla', 1150);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1339, 0, 1, '2019-04-10 14:07:00', 5, 'El Porvenir, Sevilla', 1150);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1340, 0, 2, '2019-04-10 14:12:00', 10, 'Avenida de El Greco, Sevilla', 1150);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1341, 0, 0, '2019-01-05 07:11:00', 0, 'Torre Sevilla, Sevilla', 1151);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1342, 0, 1, '2019-01-05 07:16:00', 5, 'Montequinto, Sevilla', 1151);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1343, 0, 2, '2019-01-05 07:21:00', 10, 'Felipe II, Sevilla', 1151);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1344, 0, 0, '2019-01-17 12:27:00', 0, 'Calle Jilguero, Sevilla', 1152);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1345, 0, 1, '2019-01-17 12:32:00', 5, 'Macarena, Sevilla', 1152);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1346, 0, 2, '2019-01-17 12:37:00', 10, 'El Porvenir, Sevilla', 1152);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1347, 0, 3, '2019-01-17 12:42:00', 15, 'Sevilla Este, Sevilla', 1152);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1348, 0, 0, '2019-01-23 10:09:00', 0, 'Torre Sevilla, Sevilla', 1153);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1349, 0, 1, '2019-01-23 10:14:00', 5, 'Montequinto, Sevilla', 1153);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1350, 0, 2, '2019-01-23 10:19:00', 10, 'Calle Jilguero, Sevilla', 1153);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1351, 0, 0, '2019-01-19 18:26:00', 0, 'Macarena, Sevilla', 1154);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1352, 0, 1, '2019-01-19 18:31:00', 5, 'Plaza del Duque de la Victoria, Sevilla', 1154);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1353, 0, 2, '2019-01-19 18:36:00', 10, 'El Porvenir, Sevilla', 1154);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1354, 0, 3, '2019-01-19 18:41:00', 15, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1154);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1355, 0, 0, '2019-06-23 13:11:00', 0, 'Los Arcos, Avenida de Andalucía, Sevilla', 1155);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1356, 0, 1, '2019-06-23 13:16:00', 5, 'Macarena, Sevilla', 1155);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1357, 0, 0, '2019-04-21 09:31:00', 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1156);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1358, 0, 1, '2019-04-21 09:36:00', 5, 'Gran Plaza, Sevilla', 1156);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1359, 0, 2, '2019-04-21 09:41:00', 10, 'Plaza del Duque de la Victoria, Sevilla', 1156);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1360, 0, 0, '2019-02-18 14:31:00', 0, 'Calle Jilguero, Sevilla', 1157);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1361, 0, 1, '2019-02-18 14:36:00', 5, 'Avenida de El Greco, Sevilla', 1157);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1362, 0, 0, '2019-06-18 15:11:00', 0, 'Camas, Sevilla', 1158);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1363, 0, 1, '2019-06-18 15:16:00', 5, 'Gran Plaza, Sevilla', 1158);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1364, 0, 2, '2019-06-18 15:21:00', 10, 'Avenida de El Greco, Sevilla', 1158);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1365, 0, 0, '2019-04-27 06:24:00', 0, 'Sevilla Este, Sevilla', 1159);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1366, 0, 1, '2019-04-27 06:29:00', 5, 'San Bernardo, Sevilla', 1159);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1367, 0, 2, '2019-04-27 06:34:00', 10, 'Felipe II, Sevilla', 1159);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1368, 0, 3, '2019-04-27 06:39:00', 15, 'El Porvenir, Sevilla', 1159);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1369, 0, 0, '2019-01-15 09:28:00', 0, 'Camas, Sevilla', 1160);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1370, 0, 1, '2019-01-15 09:33:00', 5, 'Felipe II, Sevilla', 1160);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1371, 0, 0, '2019-04-13 07:09:00', 0, 'Avenida de El Greco, Sevilla', 1161);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1372, 0, 1, '2019-04-13 07:14:00', 5, 'Felipe II, Sevilla', 1161);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1373, 0, 2, '2019-04-13 07:19:00', 10, 'Los Arcos, Avenida de Andalucía, Sevilla', 1161);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1374, 0, 3, '2019-04-13 07:24:00', 15, 'Gran Plaza, Sevilla', 1161);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1375, 0, 0, '2019-05-25 11:08:00', 0, 'Plaza del Duque de la Victoria, Sevilla', 1162);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1376, 0, 1, '2019-05-25 11:13:00', 5, 'El Porvenir, Sevilla', 1162);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1377, 0, 0, '2019-01-23 08:26:00', 0, 'Torre Sevilla, Sevilla', 1163);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1378, 0, 1, '2019-01-23 08:31:00', 5, 'San Bernardo, Sevilla', 1163);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1379, 0, 0, '2019-05-22 12:12:00', 0, 'San Bernardo, Sevilla', 1164);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1380, 0, 1, '2019-05-22 12:17:00', 5, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1164);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1381, 0, 2, '2019-05-22 12:22:00', 10, 'Gran Plaza, Sevilla', 1164);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1382, 0, 3, '2019-05-22 12:27:00', 15, 'Camas, Sevilla', 1164);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1383, 0, 0, '2019-05-05 19:32:00', 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1165);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1384, 0, 1, '2019-05-05 19:37:00', 5, 'Los Arcos, Avenida de Andalucía, Sevilla', 1165);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1385, 0, 2, '2019-05-05 19:42:00', 10, 'Avenida del Cid, Sevilla', 1165);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1386, 0, 3, '2019-05-05 19:47:00', 15, 'Sevilla Este, Sevilla', 1165);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1387, 0, 0, '2019-03-06 09:24:00', 0, 'Plaza del Duque de la Victoria, Sevilla', 1166);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1388, 0, 1, '2019-03-06 09:29:00', 5, 'Avenida de El Greco, Sevilla', 1166);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1389, 0, 2, '2019-03-06 09:34:00', 10, 'Montequinto, Sevilla', 1166);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1390, 0, 0, '2019-01-22 09:16:00', 0, 'Avenida de El Greco, Sevilla', 1167);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1391, 0, 1, '2019-01-22 09:21:00', 5, 'Gran Plaza, Sevilla', 1167);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1392, 0, 2, '2019-01-22 09:26:00', 10, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1167);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1393, 0, 3, '2019-01-22 09:31:00', 15, 'Montequinto, Sevilla', 1167);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1394, 0, 0, '2019-01-13 07:39:00', 0, 'Gran Plaza, Sevilla', 1168);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1395, 0, 1, '2019-01-13 07:44:00', 5, 'Camas, Sevilla', 1168);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1396, 0, 0, '2019-03-09 19:06:00', 0, 'Felipe II, Sevilla', 1169);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1397, 0, 1, '2019-03-09 19:11:00', 5, 'Gran Plaza, Sevilla', 1169);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1398, 0, 0, '2019-06-01 20:29:00', 0, 'Gran Plaza, Sevilla', 1170);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1399, 0, 1, '2019-06-01 20:34:00', 5, 'Camas, Sevilla', 1170);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1400, 0, 2, '2019-06-01 20:39:00', 10, 'San Bernardo, Sevilla', 1170);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1401, 0, 3, '2019-06-01 20:44:00', 15, 'Plaza del Duque de la Victoria, Sevilla', 1170);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1402, 0, 0, '2019-02-01 19:35:00', 0, 'Macarena, Sevilla', 1171);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1403, 0, 1, '2019-02-01 19:40:00', 5, 'El Porvenir, Sevilla', 1171);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1404, 0, 2, '2019-02-01 19:45:00', 10, 'Calle Jilguero, Sevilla', 1171);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1405, 0, 0, '2019-01-20 18:16:00', 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1172);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1406, 0, 1, '2019-01-20 18:21:00', 5, 'El Porvenir, Sevilla', 1172);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1407, 0, 0, '2019-03-21 17:23:00', 0, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1173);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1408, 0, 1, '2019-03-21 17:28:00', 5, 'Calle Jilguero, Sevilla', 1173);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1409, 0, 2, '2019-03-21 17:33:00', 10, 'Macarena, Sevilla', 1173);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1410, 0, 0, '2019-05-26 12:39:00', 0, 'Los Arcos, Avenida de Andalucía, Sevilla', 1174);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1411, 0, 1, '2019-05-26 12:44:00', 5, 'Avenida de El Greco, Sevilla', 1174);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1412, 0, 2, '2019-05-26 12:49:00', 10, 'Calle Jilguero, Sevilla', 1174);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1413, 0, 3, '2019-05-26 12:54:00', 15, 'Torre Sevilla, Sevilla', 1174);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1414, 0, 0, '2019-05-24 17:24:00', 0, 'Felipe II, Sevilla', 1175);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1415, 0, 1, '2019-05-24 17:29:00', 5, 'El Porvenir, Sevilla', 1175);
INSERT INTO control_point (id, version, arrival_order, arrival_time, distance, location, route) VALUES (1416, 0, 2, '2019-05-24 17:34:00', 10, 'Plaza del Duque de la Victoria, Sevilla', 1175);


--
-- TOC entry 2049 (class 0 OID 171987)
-- Dependencies: 173
-- Data for Name: driver; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (968, 0, 'Seville', 'Spain', 0, 'Alexia', 0, 0, NULL, '648181742', 'Velasco', 868, 'ES5123396749879208632450', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, true, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (969, 0, 'Seville', 'Spain', 0, 'Álex', 0, 0, NULL, '670125076', 'Ortega', 869, 'ES9538055139958753264760', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, true, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (970, 0, 'Seville', 'Spain', 4, 'Francisco', 0, 0, NULL, '629851407', 'Vargas', 870, 'ES8753661876936783628484', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, true, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (971, 0, 'Seville', 'Spain', 0, 'Joel', 0, 0, NULL, '688353776', 'Iglesias', 871, 'ES9122187947554310166470', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (972, 0, 'Seville', 'Spain', 0, 'Andrés', 0, 0, NULL, '623241893', 'Herrera', 872, 'ES6813851658592882089655', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, true, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (973, 0, 'Seville', 'Spain', 0, 'Elisa', 0, 0, NULL, '686750359', 'Vargas', 873, 'ES1074680617264341092678', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, false, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (974, 0, 'Seville', 'Spain', 0, 'Alan', 0, 0, NULL, '637763267', 'Gallego', 874, 'ES1360599931369445912408', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, true, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (975, 0, 'Seville', 'Spain', 2.5, 'Mara', 0, 0, NULL, '670056868', 'Cortes', 875, 'ES8009494236702376467467', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (976, 0, 'Seville', 'Spain', 3.5, 'Gabriel', 0, 0, NULL, '695412011', 'Santiago', 876, 'ES9514420011962365097523', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, false, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (977, 0, 'Seville', 'Spain', 3, 'Eloy', 0, 0, NULL, '684956438', 'Herrero', 877, 'ES2396112032031704870321', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, true, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (978, 0, 'Seville', 'Spain', 0, 'Alba', 0, 0, NULL, '633678856', 'Navarro', 878, 'ES4278100317538857934428', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (979, 0, 'Seville', 'Spain', 0, 'Ander', 0, 0, NULL, '644917340', 'Márquez', 879, 'ES1009375442666352857860', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, true, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (980, 0, 'Seville', 'Spain', 0, 'Arlet', 0, 0, NULL, '626497978', 'Vicente', 880, 'ES9896448056799172742126', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, true, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (981, 0, 'Seville', 'Spain', 0, 'Joan', 0, 0, NULL, '625818651', 'Aguilar', 881, 'ES9872717102164885402492', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, true, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (982, 0, 'Seville', 'Spain', 0, 'Jimena', 0, 0, NULL, '620000106', 'Medina', 882, 'ES5741423077553816278827', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (983, 0, 'Seville', 'Spain', 0, 'Luca', 0, 0, NULL, '676994843', 'Medina', 883, 'ES6094903955038831431902', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, true, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (984, 0, 'Seville', 'Spain', 0, 'Kilian', 0, 0, NULL, '624510298', 'Bravo', 884, 'ES2466620797487323043075', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (985, 0, 'Seville', 'Spain', 0, 'Iván', 0, 0, NULL, '652056891', 'Mora', 885, 'ES8658459971090580796837', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (986, 0, 'Seville', 'Spain', 0, 'Naia', 0, 0, NULL, '639175894', 'Ferrer', 886, 'ES1675628879337908634307', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, false, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (987, 0, 'Seville', 'Spain', 0, 'Romeo', 0, 0, NULL, '614745260', 'Santiago', 887, 'ES4349923113787713917924', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (988, 0, 'Seville', 'Spain', 0, 'Naia', 0, 0, NULL, '692461412', 'Parra', 888, 'ES2670540608114624618364', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, true, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (989, 0, 'Seville', 'Spain', 3, 'Naiara', 0, 0, NULL, '650060697', 'Santos', 889, 'ES5993990431456192801470', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, false, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (990, 0, 'Seville', 'Spain', 4, 'Neizan', 0, 0, NULL, '619579070', 'Román', 890, 'ES5364627207210487833330', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (991, 0, 'Seville', 'Spain', 0, 'Saúl', 0, 0, NULL, '669904337', 'Montero', 891, 'ES9320363774743957616121', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, false, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (992, 0, 'Seville', 'Spain', 0, 'Alicia', 0, 0, NULL, '677447351', 'Herrera', 892, 'ES4698190777839579812883', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (993, 0, 'Seville', 'Spain', 0, 'Jan', 0, 0, NULL, '656961515', 'Calvo', 893, 'ES3799078311772578218594', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, true, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (994, 0, 'Seville', 'Spain', 0, 'Laura', 0, 0, NULL, '632807008', 'Benítez', 894, 'ES8286335861243819561091', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (995, 0, 'Seville', 'Spain', 3, 'Rocío', 0, 0, NULL, '684854331', 'Méndez', 895, 'ES8042572276048487321972', 100, true, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', false, false, true);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (996, 0, 'Seville', 'Spain', 1, 'Martín', 0, 0, NULL, '617353553', 'Lozano', 896, 'ES2906149354313514168382', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, false);
INSERT INTO driver (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, childs, image, music, pets, smoke) VALUES (997, 0, 'Seville', 'Spain', 0, 'Isabel', 0, 0, NULL, '641394927', 'Ruiz', 897, 'ES1572938996176741807269', 100, false, 'https://d30y9cdsu7xlg0.cloudfront.net/png/48705-200.png', true, false, false);


--
-- TOC entry 2050 (class 0 OID 171995)
-- Dependencies: 174
-- Data for Name: folder; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2051 (class 0 OID 172000)
-- Dependencies: 175
-- Data for Name: folder_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2061 (class 0 OID 172171)
-- Dependencies: 185
-- Data for Name: hibernate_sequences; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO hibernate_sequences (sequence_name, sequence_next_hi_value) VALUES ('domain_entity', 1);


--
-- TOC entry 2052 (class 0 OID 172003)
-- Dependencies: 176
-- Data for Name: letter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2053 (class 0 OID 172011)
-- Dependencies: 177
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1625, 0, 'Dónde nos vemos?', true, '2019-01-01 01:00:00', 1600);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1626, 0, 'Dónde nos vemos?', false, '2019-01-01 01:01:00', 1600);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1627, 0, 'Hola', true, '2019-01-01 01:00:00', 1601);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1628, 0, 'Meh', false, '2019-01-01 01:01:00', 1601);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1629, 0, 'Ey', true, '2019-01-01 01:02:00', 1601);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1630, 0, 'todo bien?', false, '2019-01-01 01:03:00', 1601);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1631, 0, 'Vale gracias', true, '2019-01-01 01:00:00', 1602);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1632, 0, 'Hola', false, '2019-01-01 01:01:00', 1602);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1633, 0, 'todo bien?', true, '2019-01-01 01:02:00', 1602);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1634, 0, 'todo bien?', false, '2019-01-01 01:03:00', 1602);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1635, 0, 'todo bien?', true, '2019-01-01 01:00:00', 1603);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1636, 0, 'Dónde nos vemos?', false, '2019-01-01 01:01:00', 1603);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1637, 0, 'Meh', true, '2019-01-01 01:02:00', 1603);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1638, 0, 'No me quejo', false, '2019-01-01 01:03:00', 1603);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1639, 0, 'qué te ocurre?', true, '2019-01-01 01:04:00', 1603);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1640, 0, 'Meh', false, '2019-01-01 01:05:00', 1603);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1641, 0, 'qué te ocurre?', true, '2019-01-01 01:00:00', 1604);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1642, 0, 'Que tal', false, '2019-01-01 01:01:00', 1604);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1643, 0, 'Dónde nos vemos?', true, '2019-01-01 01:02:00', 1604);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1644, 0, 'Que tal', true, '2019-01-01 01:00:00', 1605);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1645, 0, 'Hola', false, '2019-01-01 01:01:00', 1605);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1646, 0, 'Hola', true, '2019-01-01 01:02:00', 1605);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1647, 0, 'Hola', false, '2019-01-01 01:03:00', 1605);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1648, 0, 'Meh', true, '2019-01-01 01:04:00', 1605);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1649, 0, 'Que tal', true, '2019-01-01 01:00:00', 1606);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1650, 0, 'Que tal', false, '2019-01-01 01:01:00', 1606);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1651, 0, 'Que tal', true, '2019-01-01 01:02:00', 1606);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1652, 0, 'No me quejo', false, '2019-01-01 01:03:00', 1606);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1653, 0, 'Meh', true, '2019-01-01 01:00:00', 1607);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1654, 0, 'Meh', false, '2019-01-01 01:01:00', 1607);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1655, 0, 'todo bien?', true, '2019-01-01 01:02:00', 1607);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1656, 0, 'Hola', false, '2019-01-01 01:03:00', 1607);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1657, 0, '...', true, '2019-01-01 01:00:00', 1608);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1658, 0, 'todo bien?', false, '2019-01-01 01:01:00', 1608);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1659, 0, 'No me quejo', true, '2019-01-01 01:02:00', 1608);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1660, 0, 'todo bien?', false, '2019-01-01 01:03:00', 1608);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1661, 0, 'No me quejo', true, '2019-01-01 01:00:00', 1609);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1662, 0, 'Ey', false, '2019-01-01 01:01:00', 1609);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1663, 0, 'Vale gracias', true, '2019-01-01 01:00:00', 1610);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1664, 0, 'Ey', false, '2019-01-01 01:01:00', 1610);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1665, 0, '?', true, '2019-01-01 01:02:00', 1610);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1666, 0, 'qué te ocurre?', false, '2019-01-01 01:03:00', 1610);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1667, 0, 'qué te ocurre?', true, '2019-01-01 01:04:00', 1610);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1668, 0, 'Ey', true, '2019-01-01 01:00:00', 1611);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1669, 0, 'todo bien?', false, '2019-01-01 01:01:00', 1611);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1670, 0, 'Vale gracias', true, '2019-01-01 01:02:00', 1611);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1671, 0, 'Dónde nos vemos?', true, '2019-01-01 01:00:00', 1612);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1672, 0, 'Hola', false, '2019-01-01 01:01:00', 1612);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1673, 0, 'qué te ocurre?', true, '2019-01-01 01:00:00', 1613);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1674, 0, '...', false, '2019-01-01 01:01:00', 1613);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1675, 0, 'todo bien?', true, '2019-01-01 01:02:00', 1613);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1676, 0, 'qué te ocurre?', false, '2019-01-01 01:03:00', 1613);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1677, 0, 'No me quejo', true, '2019-01-01 01:04:00', 1613);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1678, 0, 'Que tal', false, '2019-01-01 01:05:00', 1613);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1679, 0, 'No me quejo', true, '2019-01-01 01:00:00', 1614);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1680, 0, 'Dónde nos vemos?', false, '2019-01-01 01:01:00', 1614);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1681, 0, 'Que tal', true, '2019-01-01 01:02:00', 1614);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1682, 0, 'Hola', false, '2019-01-01 01:03:00', 1614);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1683, 0, 'Meh', true, '2019-01-01 01:00:00', 1615);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1684, 0, '?', false, '2019-01-01 01:01:00', 1615);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1685, 0, 'todo bien?', true, '2019-01-01 01:00:00', 1616);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1686, 0, 'Vale gracias', false, '2019-01-01 01:01:00', 1616);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1687, 0, 'Vale gracias', true, '2019-01-01 01:02:00', 1616);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1688, 0, 'Vale gracias', false, '2019-01-01 01:03:00', 1616);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1689, 0, 'No me quejo', true, '2019-01-01 01:04:00', 1616);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1690, 0, 'Ey', true, '2019-01-01 01:00:00', 1617);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1691, 0, '?', false, '2019-01-01 01:01:00', 1617);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1692, 0, 'todo bien?', true, '2019-01-01 01:02:00', 1617);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1693, 0, 'Ey', false, '2019-01-01 01:03:00', 1617);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1694, 0, '?', true, '2019-01-01 01:04:00', 1617);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1695, 0, 'qué te ocurre?', true, '2019-01-01 01:00:00', 1618);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1696, 0, 'qué te ocurre?', false, '2019-01-01 01:01:00', 1618);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1697, 0, 'Meh', true, '2019-01-01 01:02:00', 1618);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1698, 0, 'todo bien?', false, '2019-01-01 01:03:00', 1618);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1699, 0, 'Vale gracias', true, '2019-01-01 01:00:00', 1619);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1700, 0, 'todo bien?', false, '2019-01-01 01:01:00', 1619);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1701, 0, 'todo bien?', true, '2019-01-01 01:02:00', 1619);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1702, 0, 'Que tal', false, '2019-01-01 01:03:00', 1619);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1703, 0, 'Ey', true, '2019-01-01 01:04:00', 1619);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1704, 0, 'Vale gracias', true, '2019-01-01 01:00:00', 1620);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1705, 0, 'qué te ocurre?', false, '2019-01-01 01:01:00', 1620);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1706, 0, 'Meh', true, '2019-01-01 01:02:00', 1620);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1707, 0, '?', false, '2019-01-01 01:03:00', 1620);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1708, 0, '...', true, '2019-01-01 01:04:00', 1620);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1709, 0, '...', false, '2019-01-01 01:05:00', 1620);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1710, 0, 'Meh', true, '2019-01-01 01:00:00', 1621);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1711, 0, 'Vale gracias', false, '2019-01-01 01:01:00', 1621);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1712, 0, 'Meh', true, '2019-01-01 01:02:00', 1621);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1713, 0, 'Ey', true, '2019-01-01 01:00:00', 1622);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1714, 0, 'Meh', false, '2019-01-01 01:01:00', 1622);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1715, 0, 'qué te ocurre?', true, '2019-01-01 01:02:00', 1622);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1716, 0, '...', false, '2019-01-01 01:03:00', 1622);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1717, 0, '?', true, '2019-01-01 01:04:00', 1622);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1718, 0, '...', false, '2019-01-01 01:05:00', 1622);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1719, 0, 'todo bien?', true, '2019-01-01 01:00:00', 1623);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1720, 0, 'Hola', false, '2019-01-01 01:01:00', 1623);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1721, 0, 'Que tal', true, '2019-01-01 01:02:00', 1623);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1722, 0, 'todo bien?', false, '2019-01-01 01:03:00', 1623);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1723, 0, 'Ey', true, '2019-01-01 01:04:00', 1623);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1724, 0, '...', false, '2019-01-01 01:05:00', 1623);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1725, 0, 'Meh', true, '2019-01-01 01:00:00', 1624);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1726, 0, 'Que tal', false, '2019-01-01 01:01:00', 1624);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1727, 0, 'Que tal', true, '2019-01-01 01:02:00', 1624);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1728, 0, 'todo bien?', false, '2019-01-01 01:03:00', 1624);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1729, 0, 'Meh', true, '2019-01-01 01:04:00', 1624);
INSERT INTO message (id, version, content, from_atob, issue_date, thread) VALUES (1730, 0, '...', false, '2019-01-01 01:05:00', 1624);


--
-- TOC entry 2054 (class 0 OID 172016)
-- Dependencies: 178
-- Data for Name: messages_thread; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1600, 1, false, 0, 1626, 999, 968, NULL, 1099);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1601, 1, false, 0, 1630, 999, 968, NULL, 1100);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1602, 1, false, 0, 1634, 1001, 970, NULL, 1103);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1603, 1, false, 0, 1640, 1003, 972, NULL, 1109);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1604, 1, false, 0, 1643, 1005, 974, NULL, 1113);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1605, 1, false, 0, 1648, 1005, 975, NULL, 1115);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1606, 1, false, 0, 1652, 1005, 975, NULL, 1115);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1607, 1, false, 0, 1656, 1008, 976, NULL, 1120);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1608, 1, false, 0, 1660, 1008, 976, NULL, 1120);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1609, 1, false, 0, 1662, 1008, 976, NULL, 1121);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1610, 1, false, 0, 1667, 1009, 977, NULL, 1123);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1611, 1, false, 0, 1670, 1009, 977, NULL, 1124);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1612, 1, false, 0, 1672, 1009, 977, NULL, 1125);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1613, 1, false, 0, 1678, 1009, 977, NULL, 1125);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1614, 1, false, 0, 1682, 1012, 982, NULL, 1132);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1615, 1, false, 0, 1684, 1012, 983, NULL, 1134);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1616, 1, false, 0, 1689, 1013, 983, NULL, 1136);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1617, 1, false, 0, 1694, 1013, 983, NULL, 1136);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1618, 1, false, 0, 1698, 1015, 985, NULL, 1141);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1619, 1, false, 0, 1703, 1019, 989, NULL, 1152);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1620, 1, false, 0, 1709, 1020, 990, NULL, 1154);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1621, 1, false, 0, 1712, 1021, 991, NULL, 1156);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1622, 1, false, 0, 1718, 1028, 995, NULL, 1167);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1623, 1, false, 0, 1724, 1030, 996, NULL, 1172);
INSERT INTO messages_thread (id, version, closed, new_messages, last_message, participanta, participantb, reported_user, route) VALUES (1624, 1, false, 0, 1730, 1031, 997, NULL, 1175);


--
-- TOC entry 2055 (class 0 OID 172021)
-- Dependencies: 179
-- Data for Name: passenger; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (998, 0, 'Seville', 'Spain', 0, 'Pedro', 0, 0, NULL, '669309725', 'Ortega', 898, 'ES4963116815932885489285', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (999, 0, 'Seville', 'Spain', 0, 'Ona', 0, 0, NULL, '663538277', 'Ramírez', 899, 'ES3734261183375157458249', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1000, 0, 'Seville', 'Spain', 0, 'Nil', 0, 0, NULL, '629340543', 'Nieto', 900, 'ES5635671357466542932208', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1001, 0, 'Seville', 'Spain', 1, 'Iván', 0, 0, NULL, '682794718', 'Vicente', 901, 'ES8843439472935902285359', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1002, 0, 'Seville', 'Spain', 0, 'Noelia', 0, 0, NULL, '699707442', 'Castillo', 902, 'ES7363103115932495783156', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1003, 0, 'Seville', 'Spain', 0, 'Juan', 0, 0, NULL, '649410980', 'Iglesias', 903, 'ES7195807468304784341667', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1004, 0, 'Seville', 'Spain', 0, 'Claudia', 0, 0, NULL, '610506665', 'Soto', 904, 'ES1590738463913639423990', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1005, 0, 'Seville', 'Spain', 3, 'Lucas', 0, 0, NULL, '699597263', 'Castillo', 905, 'ES1545570198654697561932', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1006, 0, 'Seville', 'Spain', 0, 'Mara', 0, 0, NULL, '686050672', 'López', 906, 'ES7426797348487241014247', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1007, 0, 'Seville', 'Spain', 0, 'Laia', 0, 0, NULL, '638506335', 'Hernández', 907, 'ES3237010161458231604848', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1008, 0, 'Seville', 'Spain', 3.5, 'Nicolás', 0, 0, NULL, '657416849', 'Domínguez', 908, 'ES8817901306699703541945', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1009, 0, 'Seville', 'Spain', 3.3300000000000001, 'Ángela', 0, 0, NULL, '618427931', 'Iglesias', 909, 'ES5298991086495821801670', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1010, 0, 'Seville', 'Spain', 0, 'Pablo', 0, 0, NULL, '665691739', 'Navarro', 910, 'ES8389368438341501307970', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1011, 0, 'Seville', 'Spain', 0, 'Eduardo', 0, 0, NULL, '671059717', 'Carrasco', 911, 'ES2008996156255469322356', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1012, 0, 'Seville', 'Spain', 0, 'Samuel', 0, 0, NULL, '662533753', 'Méndez', 912, 'ES4788293784475296893784', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1013, 0, 'Seville', 'Spain', 0, 'Irati', 0, 0, NULL, '644737024', 'Méndez', 913, 'ES2509551597297357212812', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1014, 0, 'Seville', 'Spain', 0, 'Cayetana', 0, 0, NULL, '612173454', 'Reyes', 914, 'ES7705763505278077866813', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1015, 0, 'Seville', 'Spain', 0, 'Elisa', 0, 0, NULL, '640359268', 'Torres', 915, 'ES4185613564340132577846', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1016, 0, 'Seville', 'Spain', 0, 'Leyre', 0, 0, NULL, '635236830', 'Gallardo', 916, 'ES4428745428566877163782', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1017, 0, 'Seville', 'Spain', 0, 'Claudia', 0, 0, NULL, '614125859', 'Rubio', 917, 'ES5985959991779432867266', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1018, 0, 'Seville', 'Spain', 0, 'Álvaro', 0, 0, NULL, '640394313', 'Moreno', 918, 'ES6242734224953741487330', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1019, 0, 'Seville', 'Spain', 3, 'Liam', 0, 0, NULL, '623967087', 'Ramírez', 919, 'ES8997854878451823611280', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1020, 0, 'Seville', 'Spain', 5, 'Rubén', 0, 0, NULL, '660556733', 'Ortiz', 920, 'ES1720224766868493400345', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1021, 0, 'Seville', 'Spain', 3, 'Izan', 0, 0, NULL, '620260182', 'Carrasco', 921, 'ES6686798454204079139850', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1022, 0, 'Seville', 'Spain', 0, 'Ian', 0, 0, NULL, '628982807', 'Ibáñez', 922, 'ES8630155221964575625833', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1023, 0, 'Seville', 'Spain', 0, 'Ana', 0, 0, NULL, '629805831', 'Peña', 923, 'ES2705851024918495080856', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1024, 0, 'Seville', 'Spain', 0, 'Aitor', 0, 0, NULL, '626007396', 'Caballero', 924, 'ES9458263330212911578297', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1025, 0, 'Seville', 'Spain', 0, 'Celia', 0, 0, NULL, '693060821', 'Álvarez', 925, 'ES5388679566353917728034', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1026, 0, 'Seville', 'Spain', 0, 'Aarón', 0, 0, NULL, '677255721', 'Gallardo', 926, 'ES8880181251847965501812', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1027, 0, 'Seville', 'Spain', 0, 'Álex', 0, 0, NULL, '686795904', 'Santana', 927, 'ES2410614414200158804077', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1028, 0, 'Seville', 'Spain', 1, 'Berta', 0, 0, NULL, '615507283', 'Fuentes', 928, 'ES4899664639375564050131', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1029, 0, 'Seville', 'Spain', 0, 'Paola', 0, 0, NULL, '658587645', 'Moreno', 929, 'ES8363654986440073290883', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1030, 0, 'Seville', 'Spain', 0, 'Ainara', 0, 0, NULL, '624863279', 'Moya', 930, 'ES6386045416647048555381', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1031, 0, 'Seville', 'Spain', 0, 'Sergio', 0, 0, NULL, '682403134', 'Calvo', 931, 'ES6170731220974080665743', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1032, 0, 'Seville', 'Spain', 0, 'Martina', 0, 0, NULL, '665168577', 'Martin', 932, 'ES7379302995606622577619', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1033, 0, 'Seville', 'Spain', 0, 'Sergio', 0, 0, NULL, '621459659', 'Ruiz', 933, 'ES1712547558555160714199', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1034, 0, 'Seville', 'Spain', 0, 'Blanca', 0, 0, NULL, '654332683', 'Nieto', 934, 'ES9090373924838983256648', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1035, 0, 'Seville', 'Spain', 0, 'Martina', 0, 0, NULL, '635619786', 'Duran', 935, 'ES8361753380279990570903', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1036, 0, 'Seville', 'Spain', 0, 'Ángela', 0, 0, NULL, '696026173', 'Morales', 936, 'ES9802553272787173376798', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1037, 0, 'Seville', 'Spain', 0, 'África', 0, 0, NULL, '650628056', 'Esteban', 937, 'ES9342704705613371910007', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1038, 0, 'Seville', 'Spain', 0, 'Leo', 0, 0, NULL, '640785162', 'Suarez', 938, 'ES9375353895412134283189', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1039, 0, 'Seville', 'Spain', 0, 'Gael', 0, 0, NULL, '627078311', 'Ramírez', 939, 'ES3031926928118333090111', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1040, 0, 'Seville', 'Spain', 0, 'Marina', 0, 0, NULL, '633777314', 'López', 940, 'ES4443719784061996930307', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1041, 0, 'Seville', 'Spain', 0, 'Noah', 0, 0, NULL, '619543488', 'Marín', 941, 'ES1853273310231050389994', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1042, 0, 'Seville', 'Spain', 0, 'Nicolás', 0, 0, NULL, '634275391', 'Aguilar', 942, 'ES8089712979849613908760', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1043, 0, 'Seville', 'Spain', 0, 'Eduardo', 0, 0, NULL, '688310704', 'Herrera', 943, 'ES2121121336574502636183', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1044, 0, 'Seville', 'Spain', 0, 'Gael', 0, 0, NULL, '612732576', 'Calvo', 944, 'ES3856009741409176382119', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1045, 0, 'Seville', 'Spain', 0, 'Iria', 0, 0, NULL, '666026289', 'Morales', 945, 'ES9540383299325160835078', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1046, 0, 'Seville', 'Spain', 0, 'Vega', 0, 0, NULL, '627737385', 'López', 946, 'ES6939405803861001767858', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1047, 0, 'Seville', 'Spain', 0, 'Ian', 0, 0, NULL, '619254119', 'García', 947, 'ES6276842306515477166869', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1048, 0, 'Seville', 'Spain', 0, 'Rocío', 0, 0, NULL, '679818311', 'Calvo', 948, 'ES9503712570739662336913', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1049, 0, 'Seville', 'Spain', 0, 'Paola', 0, 0, NULL, '685694180', 'Suarez', 949, 'ES1930733701380528951476', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1050, 0, 'Seville', 'Spain', 0, 'Ainara', 0, 0, NULL, '620258633', 'Herrero', 950, 'ES2492094861064955930430', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1051, 0, 'Seville', 'Spain', 0, 'Antonio', 0, 0, NULL, '676819845', 'Guerrero', 951, 'ES9635289174136708388237', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1052, 0, 'Seville', 'Spain', 0, 'Víctor', 0, 0, NULL, '634129391', 'Calvo', 952, 'ES4654198670042837623338', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1053, 0, 'Seville', 'Spain', 0, 'Rocío', 0, 0, NULL, '648549188', 'García', 953, 'ES9342315633757289987752', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1054, 0, 'Seville', 'Spain', 0, 'Carla', 0, 0, NULL, '699991383', 'Muñoz', 954, 'ES2335798588809851346502', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1055, 0, 'Seville', 'Spain', 0, 'Adriana', 0, 0, NULL, '621114493', 'Fuentes', 955, 'ES9715689624853431542596', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1056, 0, 'Seville', 'Spain', 0, 'Diego', 0, 0, NULL, '657997098', 'Soto', 956, 'ES6843488149131950142358', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1057, 0, 'Seville', 'Spain', 0, 'Carlos', 0, 0, NULL, '625421843', 'Álvarez', 957, 'ES5110087204905726983379', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1058, 0, 'Seville', 'Spain', 0, 'Aleix', 0, 0, NULL, '645168893', 'Pastor', 958, 'ES8243034781157465040874', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1059, 0, 'Seville', 'Spain', 0, 'Ona', 0, 0, NULL, '636577536', 'Jiménez', 959, 'ES6563554729435751636015', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1060, 0, 'Seville', 'Spain', 0, 'Enzo', 0, 0, NULL, '679971768', 'Caballero', 960, 'ES9960800458808015505794', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1061, 0, 'Seville', 'Spain', 0, 'África', 0, 0, NULL, '666897667', 'Blanco', 961, 'ES8267567559222709842394', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1062, 0, 'Seville', 'Spain', 0, 'Nil', 0, 0, NULL, '693030485', 'Benítez', 962, 'ES4129676454975032718377', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1063, 0, 'Seville', 'Spain', 0, 'Mía', 0, 0, NULL, '630435397', 'Rodríguez', 963, 'ES4191807538610844783092', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1064, 0, 'Seville', 'Spain', 0, 'Marina', 0, 0, NULL, '643235619', 'Jiménez', 964, 'ES5710799351144652785130', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1065, 0, 'Seville', 'Spain', 0, 'Ander', 0, 0, NULL, '659790762', 'Muñoz', 965, 'ES9592266091441019631797', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1066, 0, 'Seville', 'Spain', 0, 'Santiago', 0, 0, NULL, '619459662', 'Calvo', 966, 'ES1653272500533166843645', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');
INSERT INTO passenger (id, version, city, country, medium_stars, name, new_alerts, new_messages, number_of_trips, phone, surname, user_account, bank_account_number, cash, image) VALUES (1067, 0, 'Seville', 'Spain', 0, 'Juan', 0, 0, NULL, '622876312', 'Aguilar', 967, 'ES4336238799159609878650', 100, 'https://cdn4.iconfinder.com/data/icons/dot/256/taxi_passanger.png');


--
-- TOC entry 2056 (class 0 OID 172029)
-- Dependencies: 180
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1417, 0, NULL, 'El Porvenir, Sevilla', false, false, 2, 'Avenida del Cid, Sevilla', false, 1.1000000000000001, 1, 0, 998, 1120);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1418, 0, NULL, 'El Porvenir, Sevilla', false, false, 0, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 1, 999, 1123);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1419, 0, NULL, 'Camas, Sevilla', false, false, 0, 'Gran Plaza, Sevilla', false, 1.1000000000000001, 1, 1, 999, 1168);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1420, 0, NULL, 'Macarena, Sevilla', false, false, 1, 'Plaza del Duque de la Victoria, Sevilla', false, 1.1000000000000001, 1, 0, 1000, 1137);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1421, 0, NULL, 'Gran Plaza, Sevilla', false, false, 2, 'Montequinto, Sevilla', false, 1.1000000000000001, 1, 0, 1000, 1130);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1422, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 2, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 1, 1001, 1134);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1423, 0, NULL, 'El Porvenir, Sevilla', false, false, 1, 'Sevilla Este, Sevilla', false, 1.1000000000000001, 1, 2, 1001, 1141);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1424, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Avenida del Cid, Sevilla', false, 1.1000000000000001, 1, 0, 1001, 1150);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1425, 0, NULL, 'Gran Plaza, Sevilla', false, false, 0, 'Avenida de El Greco, Sevilla', false, 1.1000000000000001, 1, 0, 1002, 1161);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1426, 0, NULL, 'Montequinto, Sevilla', false, false, 0, 'Avenida de El Greco, Sevilla', false, 1.1000000000000001, 1, 2, 1002, 1167);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1427, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 0, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, 1.1000000000000001, 1, 2, 1002, 1125);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1428, 0, NULL, 'El Porvenir, Sevilla', false, false, 0, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 1, 1003, 1123);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1429, 0, NULL, 'Montequinto, Sevilla', false, false, 0, 'Avenida de El Greco, Sevilla', false, 1.1000000000000001, 1, 3, 1003, 1167);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1430, 0, NULL, 'Avenida del Cid, Sevilla', false, false, 0, 'Camas, Sevilla', false, 1.1000000000000001, 1, 3, 1003, 1110);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1431, 0, NULL, 'Sevilla Este, Sevilla', false, false, 1, 'Calle Jilguero, Sevilla', false, 1.1000000000000001, 1, 0, 1004, 1152);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1432, 0, NULL, 'Calle Jilguero, Sevilla', false, false, 0, 'Sevilla Este, Sevilla', false, 1.1000000000000001, 1, 3, 1005, 1133);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1433, 0, NULL, 'Macarena, Sevilla', false, false, 1, 'Plaza del Duque de la Victoria, Sevilla', false, 1.1000000000000001, 1, 0, 1005, 1137);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1434, 0, NULL, 'Felipe II, Sevilla', false, false, 3, 'Camas, Sevilla', false, 1.1000000000000001, 1, 1, 1005, 1160);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1435, 0, NULL, 'El Porvenir, Sevilla', false, false, 2, 'Plaza del Duque de la Victoria, Sevilla', false, 1.1000000000000001, 1, 0, 1006, 1162);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1436, 0, NULL, 'Camas, Sevilla', false, false, 0, 'Gran Plaza, Sevilla', false, 1.1000000000000001, 1, 0, 1007, 1168);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1437, 0, NULL, 'Plaza del Duque de la Victoria, Sevilla', false, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1007, 1156);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1438, 0, NULL, 'Los Arcos, Avenida de Andalucía, Sevilla', false, false, 1, 'Torre Sevilla, Sevilla', false, 1.1000000000000001, 1, 0, 1007, 1132);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1439, 0, NULL, 'Macarena, Sevilla', false, false, 3, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 1, 1008, 1155);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1440, 0, NULL, 'Felipe II, Sevilla', false, false, 3, 'Camas, Sevilla', false, 1.1000000000000001, 1, 1, 1008, 1160);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1441, 0, NULL, 'Sevilla Este, Sevilla', false, false, 1, 'Calle Jilguero, Sevilla', false, 1.1000000000000001, 1, 0, 1008, 1152);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1442, 0, NULL, 'El Porvenir, Sevilla', false, false, 1, 'Calle Jilguero, Sevilla', false, 1.1000000000000001, 1, 3, 1009, 1102);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1443, 0, NULL, 'Felipe II, Sevilla', false, false, 3, 'Camas, Sevilla', false, 1.1000000000000001, 1, 1, 1009, 1160);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1444, 0, NULL, 'Montequinto, Sevilla', false, false, 1, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, 1.1000000000000001, 1, 2, 1009, 1101);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1445, 0, NULL, 'Montequinto, Sevilla', false, false, 1, 'Sevilla Este, Sevilla', false, 1.1000000000000001, 1, 0, 1010, 1126);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1446, 0, NULL, 'Plaza del Duque de la Victoria, Sevilla', false, false, 2, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1010, 1131);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1447, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 2, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 0, 1010, 1134);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1448, 0, NULL, 'El Porvenir, Sevilla', false, false, 3, 'Sevilla Este, Sevilla', false, 1.1000000000000001, 1, 0, 1011, 1159);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1449, 0, NULL, 'Calle Jilguero, Sevilla', false, false, 0, 'Sevilla Este, Sevilla', false, 1.1000000000000001, 1, 3, 1011, 1133);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1450, 0, NULL, 'Plaza del Duque de la Victoria, Sevilla', false, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1011, 1156);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1451, 0, NULL, 'Plaza del Duque de la Victoria, Sevilla', false, false, 0, 'Gran Plaza, Sevilla', false, 1.1000000000000001, 1, 1, 1012, 1170);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1452, 0, NULL, 'Gran Plaza, Sevilla', false, false, 0, 'Avenida de El Greco, Sevilla', false, 1.1000000000000001, 1, 3, 1012, 1161);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1453, 0, NULL, 'Macarena, Sevilla', false, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 3, 1012, 1144);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1454, 0, NULL, 'El Porvenir, Sevilla', false, false, 3, 'Torre Sevilla, Sevilla', false, 1.1000000000000001, 1, 2, 1013, 1146);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1455, 0, NULL, 'Avenida del Cid, Sevilla', false, false, 0, 'Camas, Sevilla', false, 1.1000000000000001, 1, 3, 1013, 1110);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1456, 0, NULL, 'El Porvenir, Sevilla', false, false, 3, 'Sevilla Este, Sevilla', false, 1.1000000000000001, 1, 2, 1014, 1159);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1457, 0, NULL, 'Los Arcos, Avenida de Andalucía, Sevilla', false, false, 0, 'Plaza del Duque de la Victoria, Sevilla', false, 1.1000000000000001, 1, 3, 1014, 1145);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1458, 0, NULL, 'Plaza del Duque de la Victoria, Sevilla', false, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1014, 1156);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1459, 0, NULL, 'Montequinto, Sevilla', false, false, 1, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, 1.1000000000000001, 1, 0, 1015, 1101);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1460, 0, NULL, 'Montequinto, Sevilla', false, false, 0, 'Avenida de El Greco, Sevilla', false, 1.1000000000000001, 1, 1, 1015, 1167);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1461, 0, NULL, 'Gran Plaza, Sevilla', false, false, 0, 'Avenida de El Greco, Sevilla', false, 1.1000000000000001, 1, 0, 1016, 1161);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1462, 0, NULL, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, false, 2, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 0, 1016, 1139);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1463, 0, NULL, 'El Porvenir, Sevilla', false, false, 0, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 2, 1016, 1123);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1464, 0, NULL, 'Felipe II, Sevilla', false, false, 3, 'Camas, Sevilla', false, 1.1000000000000001, 1, 3, 1017, 1160);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1465, 0, NULL, 'El Porvenir, Sevilla', false, false, 2, 'Avenida del Cid, Sevilla', false, 1.1000000000000001, 1, 3, 1017, 1120);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1466, 0, NULL, 'Calle Jilguero, Sevilla', false, false, 2, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, 1.1000000000000001, 1, 2, 1017, 1104);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1467, 0, NULL, 'Plaza del Duque de la Victoria, Sevilla', false, false, 2, 'Felipe II, Sevilla', false, 1.1000000000000001, 1, 0, 1018, 1175);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1468, 0, NULL, 'Montequinto, Sevilla', false, false, 0, 'Gran Plaza, Sevilla', false, 1.1000000000000001, 1, 2, 1018, 1109);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1469, 0, NULL, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, false, 2, 'Macarena, Sevilla', false, 1.1000000000000001, 1, 0, 1019, 1154);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1470, 0, NULL, 'Macarena, Sevilla', false, false, 2, 'Torre Sevilla, Sevilla', false, 1.1000000000000001, 1, 3, 1019, 1147);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1471, 0, NULL, 'Sevilla Este, Sevilla', false, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 1, 1019, 1165);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1472, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Avenida del Cid, Sevilla', false, 1.1000000000000001, 1, 3, 1020, 1150);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1473, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 0, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, 1.1000000000000001, 1, 1, 1020, 1125);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1474, 0, NULL, 'Camas, Sevilla', false, false, 1, 'Montequinto, Sevilla', false, 1.1000000000000001, 1, 0, 1020, 1108);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1475, 0, NULL, 'El Porvenir, Sevilla', false, false, 3, 'Torre Sevilla, Sevilla', false, 1.1000000000000001, 1, 3, 1021, 1146);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1476, 0, NULL, 'Los Arcos, Avenida de Andalucía, Sevilla', false, false, 3, 'Plaza del Duque de la Victoria, Sevilla', false, 1.1000000000000001, 1, 3, 1021, 1111);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1477, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 1, 'Felipe II, Sevilla', false, 1.1000000000000001, 1, 0, 1021, 1115);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1478, 0, NULL, 'Montequinto, Sevilla', false, false, 0, 'Gran Plaza, Sevilla', false, 1.1000000000000001, 1, 2, 1022, 1109);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1479, 0, NULL, 'Gran Plaza, Sevilla', false, false, 2, 'Montequinto, Sevilla', false, 1.1000000000000001, 1, 3, 1022, 1130);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1480, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Felipe II, Sevilla', false, 1.1000000000000001, 1, 3, 1023, 1098);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1481, 0, NULL, 'Camas, Sevilla', false, false, 1, 'Montequinto, Sevilla', false, 1.1000000000000001, 1, 2, 1024, 1108);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1482, 0, NULL, 'Camas, Sevilla', false, false, 1, 'Macarena, Sevilla', false, 1.1000000000000001, 1, 3, 1025, 1149);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1483, 0, NULL, 'El Porvenir, Sevilla', false, false, 2, 'Plaza del Duque de la Victoria, Sevilla', false, 1.1000000000000001, 1, 0, 1025, 1162);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1484, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Calle Jilguero, Sevilla', false, 1.1000000000000001, 1, 3, 1026, 1157);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1485, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Felipe II, Sevilla', false, 1.1000000000000001, 1, 0, 1027, 1098);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1486, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 2, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 3, 1028, 1100);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1487, 0, NULL, 'Camas, Sevilla', false, false, 3, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 3, 1028, 1164);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1488, 0, NULL, 'Calle Jilguero, Sevilla', false, false, 0, 'Sevilla Este, Sevilla', false, 1.1000000000000001, 1, 0, 1029, 1133);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1489, 0, NULL, 'Montequinto, Sevilla', false, false, 0, 'Avenida de El Greco, Sevilla', false, 1.1000000000000001, 1, 0, 1029, 1167);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1490, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 3, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 0, 1030, 1174);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1491, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 2, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 1, 1030, 1134);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1492, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1031, 1107);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1493, 0, NULL, 'Gran Plaza, Sevilla', false, false, 0, 'Avenida de El Greco, Sevilla', false, 1.1000000000000001, 1, 3, 1031, 1161);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1494, 0, NULL, 'San Bernardo, Sevilla', false, false, 3, 'Torre Sevilla, Sevilla', false, 1.1000000000000001, 1, 1, 1031, 1163);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1495, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 0, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, 1.1000000000000001, 1, 0, 1032, 1125);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1496, 0, NULL, 'El Porvenir, Sevilla', false, false, 2, 'Avenida del Cid, Sevilla', false, 1.1000000000000001, 1, 0, 1033, 1120);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1497, 0, NULL, 'Gran Plaza, Sevilla', false, false, 3, 'Sevilla Este, Sevilla', false, 1.1000000000000001, 1, 0, 1034, 1105);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1498, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 3, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 0, 1035, 1174);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1499, 0, NULL, 'El Porvenir, Sevilla', false, false, 2, 'Plaza del Duque de la Victoria, Sevilla', false, 1.1000000000000001, 1, 0, 1036, 1162);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1500, 0, NULL, 'El Porvenir, Sevilla', false, false, 0, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 0, 1036, 1123);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1501, 0, NULL, 'Montequinto, Sevilla', false, false, 3, 'Avenida de El Greco, Sevilla', false, 1.1000000000000001, 1, 0, 1036, 1138);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1502, 0, NULL, 'El Porvenir, Sevilla', false, false, 2, 'Avenida del Cid, Sevilla', false, 1.1000000000000001, 1, 0, 1037, 1120);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1503, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 2, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 0, 1038, 1100);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1504, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 0, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 0, 1038, 1118);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1505, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 0, 'Camas, Sevilla', false, 1.1000000000000001, 1, 0, 1038, 1143);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1506, 0, NULL, 'Gran Plaza, Sevilla', false, false, 0, 'Sevilla Este, Sevilla', false, 1.1000000000000001, 1, 0, 1039, 1116);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1507, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 0, 1039, 1129);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1508, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 1, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 0, 1039, 1103);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1509, 0, NULL, 'Macarena, Sevilla', false, false, 0, 'Calle Jilguero, Sevilla', false, 1.1000000000000001, 1, 0, 1040, 1121);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1510, 0, NULL, 'Macarena, Sevilla', false, false, 0, 'Calle Jilguero, Sevilla', false, 1.1000000000000001, 1, 0, 1040, 1121);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1511, 0, NULL, 'Felipe II, Sevilla', false, false, 3, 'Torre Sevilla, Sevilla', false, 1.1000000000000001, 1, 0, 1040, 1151);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1512, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 2, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 0, 1041, 1100);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1513, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 3, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 0, 1041, 1174);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1514, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1042, 1136);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1515, 0, NULL, 'Macarena, Sevilla', false, false, 0, 'Calle Jilguero, Sevilla', false, 1.1000000000000001, 1, 0, 1042, 1121);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1516, 0, NULL, 'Montequinto, Sevilla', false, false, 1, 'Sevilla Este, Sevilla', false, 1.1000000000000001, 1, 0, 1043, 1126);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1517, 0, NULL, 'Camas, Sevilla', false, false, 3, 'Gran Plaza, Sevilla', false, 1.1000000000000001, 1, 0, 1043, 1112);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1518, 0, NULL, 'Avenida del Cid, Sevilla', false, false, 0, 'Camas, Sevilla', false, 1.1000000000000001, 1, 0, 1043, 1110);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1519, 0, NULL, 'El Porvenir, Sevilla', false, false, 2, 'Avenida del Cid, Sevilla', false, 1.1000000000000001, 1, 0, 1044, 1120);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1520, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1044, 1136);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1521, 0, NULL, 'Plaza del Duque de la Victoria, Sevilla', false, false, 2, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1044, 1131);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1522, 0, NULL, 'Avenida del Cid, Sevilla', false, false, 0, 'Camas, Sevilla', false, 1.1000000000000001, 1, 0, 1045, 1110);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1523, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1045, 1136);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1524, 0, NULL, 'Avenida del Cid, Sevilla', false, false, 0, 'Camas, Sevilla', false, 1.1000000000000001, 1, 0, 1045, 1110);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1525, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 1, 'Felipe II, Sevilla', false, 1.1000000000000001, 1, 0, 1046, 1115);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1526, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Felipe II, Sevilla', false, 1.1000000000000001, 1, 0, 1046, 1098);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1527, 0, NULL, 'Montequinto, Sevilla', false, false, 3, 'Avenida de El Greco, Sevilla', false, 1.1000000000000001, 1, 0, 1047, 1138);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1528, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 2, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 0, 1048, 1100);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1529, 0, NULL, 'Plaza del Duque de la Victoria, Sevilla', false, false, 0, 'Gran Plaza, Sevilla', false, 1.1000000000000001, 1, 0, 1048, 1170);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1530, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 2, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 0, 1048, 1100);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1531, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 0, 'Montequinto, Sevilla', false, 1.1000000000000001, 1, 0, 1049, 1113);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1532, 0, NULL, 'Macarena, Sevilla', false, false, 1, 'Plaza del Duque de la Victoria, Sevilla', false, 1.1000000000000001, 1, 0, 1050, 1137);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1533, 0, NULL, 'El Porvenir, Sevilla', false, false, 1, 'Calle Jilguero, Sevilla', false, 1.1000000000000001, 1, 0, 1050, 1102);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1534, 0, NULL, 'Montequinto, Sevilla', false, false, 0, 'Gran Plaza, Sevilla', false, 1.1000000000000001, 1, 0, 1050, 1109);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1535, 0, NULL, 'El Porvenir, Sevilla', false, false, 3, 'Torre Sevilla, Sevilla', false, 1.1000000000000001, 1, 0, 1051, 1146);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1536, 0, NULL, 'Camas, Sevilla', false, false, 1, 'Macarena, Sevilla', false, 1.1000000000000001, 1, 0, 1051, 1149);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1537, 0, NULL, 'Calle Jilguero, Sevilla', false, false, 1, 'Macarena, Sevilla', false, 1.1000000000000001, 1, 0, 1051, 1171);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1538, 0, NULL, 'Calle Jilguero, Sevilla', false, false, 2, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, 1.1000000000000001, 1, 0, 1052, 1104);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1539, 0, NULL, 'El Porvenir, Sevilla', false, false, 2, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1052, 1172);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1540, 0, NULL, 'El Porvenir, Sevilla', false, false, 1, 'Felipe II, Sevilla', false, 1.1000000000000001, 1, 0, 1053, 1135);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1541, 0, NULL, 'Camas, Sevilla', false, false, 1, 'Montequinto, Sevilla', false, 1.1000000000000001, 1, 0, 1054, 1108);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1542, 0, NULL, 'Calle Jilguero, Sevilla', false, false, 1, 'Torre Sevilla, Sevilla', false, 1.1000000000000001, 1, 0, 1054, 1153);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1543, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 0, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, 1.1000000000000001, 1, 0, 1054, 1125);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1544, 0, NULL, 'El Porvenir, Sevilla', false, false, 2, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1055, 1172);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1545, 0, NULL, 'El Porvenir, Sevilla', false, false, 3, 'Sevilla Este, Sevilla', false, 1.1000000000000001, 1, 0, 1055, 1159);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1546, 0, NULL, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', false, false, 1, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 0, 1056, 1103);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1547, 0, NULL, 'Gran Plaza, Sevilla', false, false, 2, 'Montequinto, Sevilla', false, 1.1000000000000001, 1, 0, 1056, 1130);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1548, 0, NULL, 'Avenida del Cid, Sevilla', false, false, 1, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 0, 1057, 1099);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1549, 0, NULL, 'Sevilla Este, Sevilla', false, false, 2, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1057, 1122);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1550, 0, NULL, 'Camas, Sevilla', false, false, 1, 'Macarena, Sevilla', false, 1.1000000000000001, 1, 0, 1057, 1149);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1551, 0, NULL, 'El Porvenir, Sevilla', false, false, 1, 'Felipe II, Sevilla', false, 1.1000000000000001, 1, 0, 1058, 1135);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1552, 0, NULL, 'Calle Jilguero, Sevilla', false, false, 1, 'Torre Sevilla, Sevilla', false, 1.1000000000000001, 1, 0, 1058, 1153);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1553, 0, NULL, 'Montequinto, Sevilla', false, false, 3, 'Plaza del Duque de la Victoria, Sevilla', false, 1.1000000000000001, 1, 0, 1058, 1166);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1554, 0, NULL, 'El Porvenir, Sevilla', false, false, 0, 'San Bernardo, Sevilla', false, 1.1000000000000001, 1, 0, 1059, 1123);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1555, 0, NULL, 'Sevilla Este, Sevilla', false, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1059, 1165);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1556, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1059, 1107);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1557, 0, NULL, 'Macarena, Sevilla', false, false, 0, 'Calle Jilguero, Sevilla', false, 1.1000000000000001, 1, 0, 1060, 1121);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1558, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 0, 'Montequinto, Sevilla', false, 1.1000000000000001, 1, 0, 1061, 1113);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1559, 0, NULL, 'Montequinto, Sevilla', false, false, 3, 'Avenida de El Greco, Sevilla', false, 1.1000000000000001, 1, 0, 1061, 1138);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1560, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Calle Jilguero, Sevilla', false, 1.1000000000000001, 1, 0, 1062, 1157);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1561, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 2, 'Calle Jilguero, Sevilla', false, 1.1000000000000001, 1, 0, 1062, 1124);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1562, 0, NULL, 'Avenida del Cid, Sevilla', false, false, 0, 'Camas, Sevilla', false, 1.1000000000000001, 1, 0, 1063, 1110);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1563, 0, NULL, 'Sevilla Este, Sevilla', false, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1063, 1165);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1564, 0, NULL, 'El Porvenir, Sevilla', false, false, 2, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1063, 1172);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1565, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1064, 1107);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1566, 0, NULL, 'Avenida de El Greco, Sevilla', false, false, 3, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 0, 1065, 1129);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1567, 0, NULL, 'Calle Jilguero, Sevilla', false, false, 1, 'Macarena, Sevilla', false, 1.1000000000000001, 1, 0, 1065, 1171);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1568, 0, NULL, 'Plaza del Duque de la Victoria, Sevilla', false, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', false, 1.1000000000000001, 1, 0, 1066, 1156);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1569, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 3, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 0, 1066, 1174);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1570, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 1, 'Felipe II, Sevilla', false, 1.1000000000000001, 1, 0, 1066, 1115);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1571, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 0, 'Montequinto, Sevilla', false, 1.1000000000000001, 1, 0, 1067, 1113);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1572, 0, NULL, 'Avenida del Cid, Sevilla', false, false, 1, 'Los Arcos, Avenida de Andalucía, Sevilla', false, 1.1000000000000001, 1, 0, 1067, 1099);
INSERT INTO reservation (id, version, charge_id, destination, driver_no_picked_me, driver_picked_me, luggage_size, origin, payment_resolved, price, seat, status, passenger, route) VALUES (1573, 0, NULL, 'Torre Sevilla, Sevilla', false, false, 1, 'Felipe II, Sevilla', false, 1.1000000000000001, 1, 0, 1067, 1115);


--
-- TOC entry 2057 (class 0 OID 172037)
-- Dependencies: 181
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1098, 0, 4, 'FRIDAY', '2019-06-04 12:21:00', 'Avenida de El Greco, Sevilla', '', 9, 15, false, 3, 'Felipe II, Sevilla', 1.1000000000000001, 968, 1068);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1099, 0, 4, 'WEDNESDAY', '2019-06-26 06:24:00', 'Avenida del Cid, Sevilla', '', 9, 15, false, 1, 'Los Arcos, Avenida de Andalucía, Sevilla', 1.1000000000000001, 968, 1068);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1100, 0, 4, 'WEDNESDAY', '2019-05-14 06:01:00', 'Reina Mercedes (Escuela de Arquitectura), Sevilla', '', 8, 10, false, 2, 'San Bernardo, Sevilla', 1.1000000000000001, 968, 1068);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1101, 0, 4, 'THURSDAY', '2019-06-23 19:11:00', 'Montequinto, Sevilla', '', 8, 5, false, 1, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1.1000000000000001, 969, 1069);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1102, 0, 4, 'WEDNESDAY', '2019-05-23 09:17:00', 'El Porvenir, Sevilla', '', 4, 10, false, 1, 'Calle Jilguero, Sevilla', 1.1000000000000001, 970, 1070);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1103, 0, 4, 'SATURDAY', '2019-02-01 11:00:00', 'Reina Mercedes (Escuela de Arquitectura), Sevilla', '', 4, 15, false, 1, 'San Bernardo, Sevilla', 1.1000000000000001, 970, 1070);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1104, 0, 4, 'FRIDAY', '2019-01-02 08:01:00', 'Calle Jilguero, Sevilla', '', 3, 5, false, 2, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1.1000000000000001, 971, 1071);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1105, 0, 4, 'FRIDAY', '2019-01-25 19:23:00', 'Gran Plaza, Sevilla', '', 6, 15, false, 3, 'Sevilla Este, Sevilla', 1.1000000000000001, 971, 1071);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1106, 0, 4, 'TUESDAY', '2019-06-16 11:21:00', 'Camas, Sevilla', '', 4, 5, false, 1, 'Gran Plaza, Sevilla', 1.1000000000000001, 971, 1071);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1107, 0, 1, 'SATURDAY', '2019-02-20 08:27:00', 'Avenida de El Greco, Sevilla', '', 7, 10, false, 3, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1.1000000000000001, 972, 1072);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1108, 0, 1, 'MONDAY', '2019-03-20 18:22:00', 'Camas, Sevilla', '', 6, 15, false, 1, 'Montequinto, Sevilla', 1.1000000000000001, 972, 1072);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1109, 0, 1, 'WEDNESDAY', '2019-05-08 09:04:00', 'Montequinto, Sevilla', '', 11, 15, false, 0, 'Gran Plaza, Sevilla', 1.1000000000000001, 972, 1072);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1110, 0, 4, 'SUNDAY', '2019-01-04 12:03:00', 'Avenida del Cid, Sevilla', '', 9, 5, false, 0, 'Camas, Sevilla', 1.1000000000000001, 973, 1073);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1111, 0, 4, 'THURSDAY', '2019-05-28 12:21:00', 'Los Arcos, Avenida de Andalucía, Sevilla', '', 3, 15, false, 3, 'Plaza del Duque de la Victoria, Sevilla', 1.1000000000000001, 973, 1073);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1112, 0, 4, 'SUNDAY', '2019-02-14 20:03:00', 'Camas, Sevilla', '', 10, 10, false, 3, 'Gran Plaza, Sevilla', 1.1000000000000001, 973, 1073);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1113, 0, 4, 'MONDAY', '2019-06-25 19:02:00', 'Torre Sevilla, Sevilla', '', 9, 5, false, 0, 'Montequinto, Sevilla', 1.1000000000000001, 974, 1074);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1114, 0, 4, 'WEDNESDAY', '2019-01-17 19:31:00', 'Avenida del Cid, Sevilla', '', 8, 10, false, 2, 'Plaza del Duque de la Victoria, Sevilla', 1.1000000000000001, 974, 1074);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1115, 0, 4, 'MONDAY', '2019-05-02 06:28:00', 'Torre Sevilla, Sevilla', '', 11, 10, false, 1, 'Felipe II, Sevilla', 1.1000000000000001, 975, 1075);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1116, 0, 4, 'TUESDAY', '2019-05-08 19:33:00', 'Gran Plaza, Sevilla', '', 10, 15, false, 0, 'Sevilla Este, Sevilla', 1.1000000000000001, 975, 1075);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1117, 0, 4, 'TUESDAY', '2019-04-18 09:21:00', 'Torre Sevilla, Sevilla', '', 5, 15, false, 0, 'Montequinto, Sevilla', 1.1000000000000001, 975, 1075);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1118, 0, 4, 'THURSDAY', '2019-02-19 20:16:00', 'Reina Mercedes (Escuela de Arquitectura), Sevilla', '', 10, 10, false, 0, 'Los Arcos, Avenida de Andalucía, Sevilla', 1.1000000000000001, 975, 1075);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1119, 0, 4, 'FRIDAY', '2019-06-07 20:14:00', 'Camas, Sevilla', '', 9, 5, false, 1, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1.1000000000000001, 976, 1076);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1120, 0, 4, 'SUNDAY', '2019-02-17 07:20:00', 'El Porvenir, Sevilla', '', 6, 15, false, 2, 'Avenida del Cid, Sevilla', 1.1000000000000001, 976, 1076);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1121, 0, 4, 'WEDNESDAY', '2019-06-15 12:39:00', 'Macarena, Sevilla', '', 11, 5, false, 0, 'Calle Jilguero, Sevilla', 1.1000000000000001, 976, 1076);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1122, 0, 4, 'MONDAY', '2019-02-21 17:31:00', 'Sevilla Este, Sevilla', '', 6, 10, false, 2, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1.1000000000000001, 976, 1076);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1123, 0, 4, 'SATURDAY', '2019-06-07 18:34:00', 'El Porvenir, Sevilla', '', 5, 10, false, 0, 'San Bernardo, Sevilla', 1.1000000000000001, 977, 1077);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1124, 0, 4, 'THURSDAY', '2019-03-21 08:01:00', 'Avenida de El Greco, Sevilla', '', 3, 5, false, 2, 'Calle Jilguero, Sevilla', 1.1000000000000001, 977, 1077);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1125, 0, 4, 'WEDNESDAY', '2019-02-25 09:27:00', 'Avenida de El Greco, Sevilla', '', 10, 10, false, 0, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1.1000000000000001, 977, 1077);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1126, 0, 4, 'THURSDAY', '2019-01-06 08:13:00', 'Montequinto, Sevilla', '', 9, 5, false, 1, 'Sevilla Este, Sevilla', 1.1000000000000001, 978, 1078);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1127, 0, 4, 'WEDNESDAY', '2019-01-18 18:03:00', 'Nervión Plaza, Calle Luis de Morales, Sevilla', '', 3, 5, false, 2, 'El Porvenir, Sevilla', 1.1000000000000001, 979, 1079);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1128, 0, 4, 'WEDNESDAY', '2019-05-28 19:11:00', 'Montequinto, Sevilla', '', 10, 15, false, 1, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1.1000000000000001, 980, 1080);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1129, 0, 4, 'MONDAY', '2019-06-10 18:08:00', 'Avenida de El Greco, Sevilla', '', 4, 15, false, 3, 'Los Arcos, Avenida de Andalucía, Sevilla', 1.1000000000000001, 980, 1080);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1130, 0, 4, 'TUESDAY', '2019-03-17 13:03:00', 'Gran Plaza, Sevilla', '', 4, 5, false, 2, 'Montequinto, Sevilla', 1.1000000000000001, 981, 1081);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1131, 0, 4, 'SATURDAY', '2019-05-15 17:01:00', 'Plaza del Duque de la Victoria, Sevilla', '', 9, 15, false, 2, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1.1000000000000001, 981, 1081);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1132, 0, 1, 'SUNDAY', '2019-06-01 19:34:00', 'Los Arcos, Avenida de Andalucía, Sevilla', '', 7, 10, false, 1, 'Torre Sevilla, Sevilla', 1.1000000000000001, 982, 1082);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1133, 0, 1, 'FRIDAY', '2019-04-10 06:23:00', 'Calle Jilguero, Sevilla', '', 5, 5, false, 0, 'Sevilla Este, Sevilla', 1.1000000000000001, 982, 1082);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1134, 0, 4, 'THURSDAY', '2019-05-12 20:16:00', 'Torre Sevilla, Sevilla', '', 4, 10, false, 2, 'Los Arcos, Avenida de Andalucía, Sevilla', 1.1000000000000001, 983, 1083);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1135, 0, 4, 'SATURDAY', '2019-03-02 20:05:00', 'El Porvenir, Sevilla', '', 9, 5, false, 1, 'Felipe II, Sevilla', 1.1000000000000001, 983, 1083);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1136, 0, 4, 'WEDNESDAY', '2019-05-23 07:23:00', 'Reina Mercedes (Escuela de Arquitectura), Sevilla', '', 7, 15, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1.1000000000000001, 983, 1083);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1137, 0, 4, 'MONDAY', '2019-06-09 07:20:00', 'Macarena, Sevilla', '', 6, 15, false, 1, 'Plaza del Duque de la Victoria, Sevilla', 1.1000000000000001, 983, 1083);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1138, 0, 4, 'SUNDAY', '2019-04-06 16:36:00', 'Montequinto, Sevilla', '', 5, 10, false, 3, 'Avenida de El Greco, Sevilla', 1.1000000000000001, 984, 1084);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1139, 0, 4, 'TUESDAY', '2019-04-27 08:03:00', 'Nervión Plaza, Calle Luis de Morales, Sevilla', '', 9, 10, false, 2, 'Los Arcos, Avenida de Andalucía, Sevilla', 1.1000000000000001, 984, 1084);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1140, 0, 4, 'WEDNESDAY', '2019-05-03 08:33:00', 'Gran Plaza, Sevilla', '', 11, 5, false, 1, 'San Bernardo, Sevilla', 1.1000000000000001, 984, 1084);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1141, 0, 4, 'TUESDAY', '2019-06-07 14:24:00', 'El Porvenir, Sevilla', '', 8, 15, false, 1, 'Sevilla Este, Sevilla', 1.1000000000000001, 985, 1085);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1142, 0, 4, 'SUNDAY', '2019-04-10 19:19:00', 'San Bernardo, Sevilla', '', 11, 10, false, 2, 'Avenida de El Greco, Sevilla', 1.1000000000000001, 985, 1085);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1143, 0, 4, 'TUESDAY', '2019-02-16 13:30:00', 'Reina Mercedes (Escuela de Arquitectura), Sevilla', '', 6, 10, false, 0, 'Camas, Sevilla', 1.1000000000000001, 986, 1086);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1144, 0, 4, 'SATURDAY', '2019-04-11 13:18:00', 'Macarena, Sevilla', '', 8, 15, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1.1000000000000001, 986, 1086);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1145, 0, 4, 'SUNDAY', '2019-06-21 18:12:00', 'Los Arcos, Avenida de Andalucía, Sevilla', '', 9, 15, false, 0, 'Plaza del Duque de la Victoria, Sevilla', 1.1000000000000001, 986, 1086);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1146, 0, 4, 'WEDNESDAY', '2019-06-16 20:30:00', 'El Porvenir, Sevilla', '', 8, 15, false, 3, 'Torre Sevilla, Sevilla', 1.1000000000000001, 987, 1087);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1147, 0, 4, 'WEDNESDAY', '2019-04-20 09:14:00', 'Macarena, Sevilla', '', 5, 15, false, 2, 'Torre Sevilla, Sevilla', 1.1000000000000001, 987, 1087);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1148, 0, 4, 'THURSDAY', '2019-05-28 10:08:00', 'Reina Mercedes (Escuela de Arquitectura), Sevilla', '', 11, 5, false, 1, 'San Bernardo, Sevilla', 1.1000000000000001, 987, 1087);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1149, 0, 1, 'MONDAY', '2019-01-08 08:11:00', 'Camas, Sevilla', '', 3, 15, false, 1, 'Macarena, Sevilla', 1.1000000000000001, 988, 1088);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1150, 0, 1, 'THURSDAY', '2019-04-10 14:02:00', 'Avenida de El Greco, Sevilla', '', 3, 10, false, 3, 'Avenida del Cid, Sevilla', 1.1000000000000001, 988, 1088);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1151, 0, 1, 'FRIDAY', '2019-01-05 07:11:00', 'Felipe II, Sevilla', '', 6, 10, false, 3, 'Torre Sevilla, Sevilla', 1.1000000000000001, 989, 1089);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1152, 0, 1, 'THURSDAY', '2019-01-17 12:27:00', 'Sevilla Este, Sevilla', '', 6, 15, false, 1, 'Calle Jilguero, Sevilla', 1.1000000000000001, 989, 1089);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1153, 0, 1, 'FRIDAY', '2019-01-23 10:09:00', 'Calle Jilguero, Sevilla', '', 8, 10, false, 1, 'Torre Sevilla, Sevilla', 1.1000000000000001, 989, 1089);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1154, 0, 1, 'SUNDAY', '2019-01-19 18:26:00', 'Nervión Plaza, Calle Luis de Morales, Sevilla', '', 10, 15, false, 2, 'Macarena, Sevilla', 1.1000000000000001, 990, 1090);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1155, 0, 1, 'TUESDAY', '2019-06-23 13:11:00', 'Macarena, Sevilla', '', 6, 5, false, 3, 'Los Arcos, Avenida de Andalucía, Sevilla', 1.1000000000000001, 990, 1090);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1156, 0, 1, 'SATURDAY', '2019-04-21 09:31:00', 'Plaza del Duque de la Victoria, Sevilla', '', 3, 10, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1.1000000000000001, 991, 1091);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1157, 0, 1, 'WEDNESDAY', '2019-02-18 14:31:00', 'Avenida de El Greco, Sevilla', '', 8, 5, false, 3, 'Calle Jilguero, Sevilla', 1.1000000000000001, 991, 1091);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1158, 0, 4, 'TUESDAY', '2019-06-18 15:11:00', 'Avenida de El Greco, Sevilla', '', 4, 10, false, 3, 'Camas, Sevilla', 1.1000000000000001, 992, 1092);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1159, 0, 4, 'SATURDAY', '2019-04-27 06:24:00', 'El Porvenir, Sevilla', '', 6, 15, false, 3, 'Sevilla Este, Sevilla', 1.1000000000000001, 992, 1092);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1160, 0, 4, 'THURSDAY', '2019-01-15 09:28:00', 'Felipe II, Sevilla', '', 9, 5, false, 3, 'Camas, Sevilla', 1.1000000000000001, 992, 1092);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1161, 0, 4, 'FRIDAY', '2019-04-13 07:09:00', 'Gran Plaza, Sevilla', '', 11, 15, false, 0, 'Avenida de El Greco, Sevilla', 1.1000000000000001, 993, 1093);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1162, 0, 4, 'SUNDAY', '2019-05-25 11:08:00', 'El Porvenir, Sevilla', '', 11, 5, false, 2, 'Plaza del Duque de la Victoria, Sevilla', 1.1000000000000001, 993, 1093);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1163, 0, 4, 'THURSDAY', '2019-01-23 08:26:00', 'San Bernardo, Sevilla', '', 7, 5, false, 3, 'Torre Sevilla, Sevilla', 1.1000000000000001, 994, 1094);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1164, 0, 4, 'SUNDAY', '2019-05-22 12:12:00', 'Camas, Sevilla', '', 4, 15, false, 3, 'San Bernardo, Sevilla', 1.1000000000000001, 994, 1094);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1165, 0, 4, 'FRIDAY', '2019-05-05 19:32:00', 'Sevilla Este, Sevilla', '', 3, 15, false, 0, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1.1000000000000001, 994, 1094);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1166, 0, 4, 'TUESDAY', '2019-03-06 09:24:00', 'Montequinto, Sevilla', '', 5, 10, false, 3, 'Plaza del Duque de la Victoria, Sevilla', 1.1000000000000001, 995, 1095);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1167, 0, 4, 'MONDAY', '2019-01-22 09:16:00', 'Montequinto, Sevilla', '', 5, 15, false, 0, 'Avenida de El Greco, Sevilla', 1.1000000000000001, 995, 1095);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1168, 0, 4, 'SATURDAY', '2019-01-13 07:39:00', 'Camas, Sevilla', '', 11, 5, false, 0, 'Gran Plaza, Sevilla', 1.1000000000000001, 995, 1095);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1169, 0, 4, 'WEDNESDAY', '2019-03-09 19:06:00', 'Gran Plaza, Sevilla', '', 5, 5, false, 1, 'Felipe II, Sevilla', 1.1000000000000001, 995, 1095);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1170, 0, 1, 'MONDAY', '2019-06-01 20:29:00', 'Plaza del Duque de la Victoria, Sevilla', '', 7, 15, false, 0, 'Gran Plaza, Sevilla', 1.1000000000000001, 996, 1096);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1171, 0, 1, 'WEDNESDAY', '2019-02-01 19:35:00', 'Calle Jilguero, Sevilla', '', 9, 10, false, 1, 'Macarena, Sevilla', 1.1000000000000001, 996, 1096);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1172, 0, 1, 'SUNDAY', '2019-01-20 18:16:00', 'El Porvenir, Sevilla', '', 7, 5, false, 2, 'Nervión Plaza, Calle Luis de Morales, Sevilla', 1.1000000000000001, 996, 1096);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1173, 0, 1, 'TUESDAY', '2019-03-21 17:23:00', 'Macarena, Sevilla', '', 5, 10, false, 2, 'Reina Mercedes (Escuela de Arquitectura), Sevilla', 1.1000000000000001, 997, 1097);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1174, 0, 1, 'WEDNESDAY', '2019-05-26 12:39:00', 'Torre Sevilla, Sevilla', '', 7, 15, false, 3, 'Los Arcos, Avenida de Andalucía, Sevilla', 1.1000000000000001, 997, 1097);
INSERT INTO route (id, version, available_seats, days_repeat, departure_date, destination, details, distance, estimated_duration, is_cancelled, max_luggage, origin, price_per_passenger, driver, vehicle) VALUES (1175, 0, 1, 'TUESDAY', '2019-05-24 17:24:00', 'Plaza del Duque de la Victoria, Sevilla', '', 9, 10, false, 2, 'Felipe II, Sevilla', 1.1000000000000001, 997, 1097);


--
-- TOC entry 2058 (class 0 OID 172045)
-- Dependencies: 182
-- Data for Name: user_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (866, 0, false, true, '21232f297a57a5a743894a0e4a801fc3', 'admin@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (868, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver1@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (869, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver2@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (870, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver3@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (871, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver4@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (872, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver5@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (873, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver6@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (874, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver7@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (875, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver8@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (876, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver9@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (877, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver10@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (878, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver11@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (879, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver12@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (880, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver13@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (881, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver14@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (882, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver15@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (883, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver16@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (884, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver17@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (885, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver18@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (886, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver19@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (887, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver20@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (888, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver21@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (889, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver22@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (890, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver23@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (891, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver24@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (892, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver25@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (893, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver26@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (894, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver27@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (895, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver28@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (896, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver29@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (897, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'driver30@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (898, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger31@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (899, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger32@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (900, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger33@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (901, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger34@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (902, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger35@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (903, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger36@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (904, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger37@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (905, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger38@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (906, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger39@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (907, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger40@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (908, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger41@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (909, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger42@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (910, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger43@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (911, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger44@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (912, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger45@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (913, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger46@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (914, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger47@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (915, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger48@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (916, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger49@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (917, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger50@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (918, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger51@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (919, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger52@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (920, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger53@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (921, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger54@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (922, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger55@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (923, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger56@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (924, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger57@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (925, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger58@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (926, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger59@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (927, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger60@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (928, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger61@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (929, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger62@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (930, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger63@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (931, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger64@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (932, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger65@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (933, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger66@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (934, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger67@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (935, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger68@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (936, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger69@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (937, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger70@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (938, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger71@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (939, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger72@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (940, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger73@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (941, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger74@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (942, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger75@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (943, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger76@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (944, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger77@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (945, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger78@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (946, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger79@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (947, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger80@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (948, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger81@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (949, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger82@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (950, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger83@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (951, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger84@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (952, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger85@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (953, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger86@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (954, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger87@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (955, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger88@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (956, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger89@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (957, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger90@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (958, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger91@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (959, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger92@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (960, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger93@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (961, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger94@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (962, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger95@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (963, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger96@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (964, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger97@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (965, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger98@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (966, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger99@gmail.com');
INSERT INTO user_account (id, version, banned, enabled, password, username) VALUES (967, 0, false, true, '7815696ecbf1c96e6894b779456d330e', 'passenger100@gmail.com');


--
-- TOC entry 2059 (class 0 OID 172053)
-- Dependencies: 183
-- Data for Name: user_account_authorities; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO user_account_authorities (user_account, authority) VALUES (866, 'ADMIN');
INSERT INTO user_account_authorities (user_account, authority) VALUES (868, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (869, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (870, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (871, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (872, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (873, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (874, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (875, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (876, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (877, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (878, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (879, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (880, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (881, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (882, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (883, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (884, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (885, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (886, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (887, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (888, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (889, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (890, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (891, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (892, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (893, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (894, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (895, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (896, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (897, 'DRIVER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (898, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (899, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (900, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (901, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (902, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (903, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (904, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (905, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (906, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (907, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (908, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (909, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (910, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (911, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (912, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (913, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (914, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (915, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (916, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (917, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (918, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (919, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (920, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (921, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (922, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (923, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (924, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (925, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (926, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (927, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (928, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (929, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (930, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (931, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (932, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (933, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (934, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (935, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (936, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (937, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (938, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (939, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (940, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (941, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (942, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (943, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (944, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (945, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (946, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (947, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (948, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (949, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (950, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (951, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (952, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (953, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (954, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (955, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (956, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (957, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (958, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (959, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (960, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (961, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (962, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (963, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (964, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (965, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (966, 'PASSENGER');
INSERT INTO user_account_authorities (user_account, authority) VALUES (967, 'PASSENGER');


--
-- TOC entry 2060 (class 0 OID 172056)
-- Dependencies: 184
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1068, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 968);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1069, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 969);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1070, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 970);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1071, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 971);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1072, 0, ' ', 'https://www.motofichas.com//images/phocagallery/Kwang_Yang_Motor_Co/Agility_City_125_2016/01-kymco-agility-city-125-2016-estatica.jpg', 'Agility', 'AB1234XY', 2, 1, 'Kymco', 972);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1073, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 973);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1074, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 974);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1075, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 975);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1076, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 976);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1077, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 977);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1078, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 978);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1079, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 979);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1080, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 980);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1081, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 981);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1082, 0, ' ', 'https://www.motofichas.com//images/phocagallery/Kwang_Yang_Motor_Co/Agility_City_125_2016/01-kymco-agility-city-125-2016-estatica.jpg', 'Agility', 'AB1234XY', 2, 1, 'Kymco', 982);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1083, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 983);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1084, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 984);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1085, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 985);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1086, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 986);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1087, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 987);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1088, 0, ' ', 'https://www.motofichas.com//images/phocagallery/Kwang_Yang_Motor_Co/Agility_City_125_2016/01-kymco-agility-city-125-2016-estatica.jpg', 'Agility', 'AB1234XY', 2, 1, 'Kymco', 988);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1089, 0, ' ', 'https://www.motofichas.com//images/phocagallery/Kwang_Yang_Motor_Co/Agility_City_125_2016/01-kymco-agility-city-125-2016-estatica.jpg', 'Agility', 'AB1234XY', 2, 1, 'Kymco', 989);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1090, 0, ' ', 'https://www.motofichas.com//images/phocagallery/Kwang_Yang_Motor_Co/Agility_City_125_2016/01-kymco-agility-city-125-2016-estatica.jpg', 'Agility', 'AB1234XY', 2, 1, 'Kymco', 990);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1091, 0, ' ', 'https://www.motofichas.com//images/phocagallery/Kwang_Yang_Motor_Co/Agility_City_125_2016/01-kymco-agility-city-125-2016-estatica.jpg', 'Agility', 'AB1234XY', 2, 1, 'Kymco', 991);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1092, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 992);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1093, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 993);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1094, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 994);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1095, 0, ' ', 'https://cochesnuevos.autofacil.es/img/RENAULT_CLIO_ST.jpg', 'Clio', 'AB1234XY', 5, 0, 'Renault', 995);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1096, 0, ' ', 'https://www.motofichas.com//images/phocagallery/Kwang_Yang_Motor_Co/Agility_City_125_2016/01-kymco-agility-city-125-2016-estatica.jpg', 'Agility', 'AB1234XY', 2, 1, 'Kymco', 996);
INSERT INTO vehicle (id, version, description, image, model, plate, seats_capacity, type, vehicle_brand, driver) VALUES (1097, 0, ' ', 'https://www.motofichas.com//images/phocagallery/Kwang_Yang_Motor_Co/Agility_City_125_2016/01-kymco-agility-city-125-2016-estatica.jpg', 'Agility', 'AB1234XY', 2, 1, 'Kymco', 997);


--
-- TOC entry 1992 (class 2606 OID 171963)
-- Name: actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (id);


--
-- TOC entry 1994 (class 2606 OID 171971)
-- Name: administrator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY administrator
    ADD CONSTRAINT administrator_pkey PRIMARY KEY (id);


--
-- TOC entry 1996 (class 2606 OID 171976)
-- Name: alert_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY alert
    ADD CONSTRAINT alert_pkey PRIMARY KEY (id);


--
-- TOC entry 1998 (class 2606 OID 171981)
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 2000 (class 2606 OID 171986)
-- Name: control_point_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY control_point
    ADD CONSTRAINT control_point_pkey PRIMARY KEY (id);


--
-- TOC entry 2002 (class 2606 OID 171994)
-- Name: driver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (id);


--
-- TOC entry 2004 (class 2606 OID 171999)
-- Name: folder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY folder
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);


--
-- TOC entry 2006 (class 2606 OID 172010)
-- Name: letter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY letter
    ADD CONSTRAINT letter_pkey PRIMARY KEY (id);


--
-- TOC entry 2008 (class 2606 OID 172015)
-- Name: message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- TOC entry 2010 (class 2606 OID 172020)
-- Name: messages_thread_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messages_thread
    ADD CONSTRAINT messages_thread_pkey PRIMARY KEY (id);


--
-- TOC entry 2012 (class 2606 OID 172028)
-- Name: passenger_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY passenger
    ADD CONSTRAINT passenger_pkey PRIMARY KEY (id);


--
-- TOC entry 2014 (class 2606 OID 172036)
-- Name: reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (id);


--
-- TOC entry 2016 (class 2606 OID 172044)
-- Name: route_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY route
    ADD CONSTRAINT route_pkey PRIMARY KEY (id);


--
-- TOC entry 2018 (class 2606 OID 172065)
-- Name: uk_castjbvpeeus0r8lbpehiu0e4; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_account
    ADD CONSTRAINT uk_castjbvpeeus0r8lbpehiu0e4 UNIQUE (username);


--
-- TOC entry 2020 (class 2606 OID 172052)
-- Name: user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id);


--
-- TOC entry 2022 (class 2606 OID 172063)
-- Name: vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (id);


--
-- TOC entry 2024 (class 2606 OID 172071)
-- Name: fk_7ohwsa2usmvu0yxb44je2lge; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administrator
    ADD CONSTRAINT fk_7ohwsa2usmvu0yxb44je2lge FOREIGN KEY (user_account) REFERENCES user_account(id);


--
-- TOC entry 2037 (class 2606 OID 172136)
-- Name: fk_89ybpmvuu58cqappc2xh352n; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY passenger
    ADD CONSTRAINT fk_89ybpmvuu58cqappc2xh352n FOREIGN KEY (user_account) REFERENCES user_account(id);


--
-- TOC entry 2026 (class 2606 OID 172081)
-- Name: fk_98rnmdie3oie8dg1yqol90hdr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT fk_98rnmdie3oie8dg1yqol90hdr FOREIGN KEY (driver) REFERENCES driver(id);


--
-- TOC entry 2038 (class 2606 OID 172141)
-- Name: fk_aky1e3gwolgvmuvvnx4jufrc0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservation
    ADD CONSTRAINT fk_aky1e3gwolgvmuvvnx4jufrc0 FOREIGN KEY (passenger) REFERENCES passenger(id);


--
-- TOC entry 2040 (class 2606 OID 172151)
-- Name: fk_dffo7urokcw2cn9r0r6lt55qr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY route
    ADD CONSTRAINT fk_dffo7urokcw2cn9r0r6lt55qr FOREIGN KEY (driver) REFERENCES driver(id);


--
-- TOC entry 2028 (class 2606 OID 172091)
-- Name: fk_ektg0a1h57bv6nhuyjygxon0u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT fk_ektg0a1h57bv6nhuyjygxon0u FOREIGN KEY (route) REFERENCES route(id);


--
-- TOC entry 2034 (class 2606 OID 172121)
-- Name: fk_hqxmy0j46uxrkx58w0l8vfhty; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY message
    ADD CONSTRAINT fk_hqxmy0j46uxrkx58w0l8vfhty FOREIGN KEY (thread) REFERENCES messages_thread(id);


--
-- TOC entry 2023 (class 2606 OID 172066)
-- Name: fk_i7xei45auwq1f6vu25985riuh; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY actor
    ADD CONSTRAINT fk_i7xei45auwq1f6vu25985riuh FOREIGN KEY (user_account) REFERENCES user_account(id);


--
-- TOC entry 2030 (class 2606 OID 172101)
-- Name: fk_io5y53xvplfwhg963q7gkqfrf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY driver
    ADD CONSTRAINT fk_io5y53xvplfwhg963q7gkqfrf FOREIGN KEY (user_account) REFERENCES user_account(id);


--
-- TOC entry 2025 (class 2606 OID 172076)
-- Name: fk_ll61qq6sp8gvn7cuw6vs8tfu2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY alert
    ADD CONSTRAINT fk_ll61qq6sp8gvn7cuw6vs8tfu2 FOREIGN KEY (related_route) REFERENCES route(id);


--
-- TOC entry 2043 (class 2606 OID 172166)
-- Name: fk_nag238mutkrwt14u74eaeolr8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vehicle
    ADD CONSTRAINT fk_nag238mutkrwt14u74eaeolr8 FOREIGN KEY (driver) REFERENCES driver(id);


--
-- TOC entry 2036 (class 2606 OID 172131)
-- Name: fk_nmlnnjwjvocanbvk2pe8t1pxw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages_thread
    ADD CONSTRAINT fk_nmlnnjwjvocanbvk2pe8t1pxw FOREIGN KEY (route) REFERENCES route(id);


--
-- TOC entry 2035 (class 2606 OID 172126)
-- Name: fk_ovdsa5b3iudpdsk6qjgbtrs7q; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages_thread
    ADD CONSTRAINT fk_ovdsa5b3iudpdsk6qjgbtrs7q FOREIGN KEY (last_message) REFERENCES message(id);


--
-- TOC entry 2032 (class 2606 OID 172111)
-- Name: fk_p4c0hkadh5uwpdsjbyqfkauak; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY folder_messages
    ADD CONSTRAINT fk_p4c0hkadh5uwpdsjbyqfkauak FOREIGN KEY (folder) REFERENCES folder(id);


--
-- TOC entry 2042 (class 2606 OID 172161)
-- Name: fk_pao8cwh93fpccb0bx6ilq6gsl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_account_authorities
    ADD CONSTRAINT fk_pao8cwh93fpccb0bx6ilq6gsl FOREIGN KEY (user_account) REFERENCES user_account(id);


--
-- TOC entry 2031 (class 2606 OID 172106)
-- Name: fk_pd7js9rp0nie7ft4b2ltq7jx0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY folder_messages
    ADD CONSTRAINT fk_pd7js9rp0nie7ft4b2ltq7jx0 FOREIGN KEY (messages) REFERENCES letter(id);


--
-- TOC entry 2041 (class 2606 OID 172156)
-- Name: fk_quglivso3l8v25vtwv9x3592; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY route
    ADD CONSTRAINT fk_quglivso3l8v25vtwv9x3592 FOREIGN KEY (vehicle) REFERENCES vehicle(id);


--
-- TOC entry 2033 (class 2606 OID 172116)
-- Name: fk_rf9130814jneq8lvkefpr7ux3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY letter
    ADD CONSTRAINT fk_rf9130814jneq8lvkefpr7ux3 FOREIGN KEY (folder) REFERENCES folder(id);


--
-- TOC entry 2027 (class 2606 OID 172086)
-- Name: fk_s5e5esct5k89my48q1bwwtgeq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT fk_s5e5esct5k89my48q1bwwtgeq FOREIGN KEY (passenger) REFERENCES passenger(id);


--
-- TOC entry 2039 (class 2606 OID 172146)
-- Name: fk_sxm5ki53gmtiydmgspnpemu4e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reservation
    ADD CONSTRAINT fk_sxm5ki53gmtiydmgspnpemu4e FOREIGN KEY (route) REFERENCES route(id);


--
-- TOC entry 2029 (class 2606 OID 172096)
-- Name: fk_taegm7kl65r8306gof05rwly5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY control_point
    ADD CONSTRAINT fk_taegm7kl65r8306gof05rwly5 FOREIGN KEY (route) REFERENCES route(id);


--
-- TOC entry 2068 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2019-05-23 18:06:24

--
-- PostgreSQL database dump complete
--

