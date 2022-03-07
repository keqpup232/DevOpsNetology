--
-- PostgreSQL database dump
--

-- Dumped from database version 12.10 (Debian 12.10-1.pgdg110+1)
-- Dumped by pg_dump version 12.10 (Debian 12.10-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    clients_id integer NOT NULL,
    lastname character varying(30) NOT NULL,
    country character varying(30) NOT NULL,
    orders_id integer
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    orders_id integer NOT NULL,
    orders_name character varying(250) NOT NULL,
    price integer NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (clients_id, lastname, country, orders_id) FROM stdin;
4	Ронни Джеймс Дио	Russia	\N
5	Ritchie Blackmore	Russia	\N
1	Иванов Иван Иванович	USA	3
2	Петров Петр Петрович	Canada	4
3	Иоганн Себастьян Бах	Japan	5
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (orders_id, orders_name, price) FROM stdin;
1	Шоколад	10
2	Принтер	3000
3	Книга	500
4	Монитор	7000
5	Гитара	4000
\.


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (clients_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (orders_id);


--
-- Name: country_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX country_idx ON public.clients USING btree (country);


--
-- Name: clients fk_orders; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT fk_orders FOREIGN KEY (orders_id) REFERENCES public.orders(orders_id);


--
-- Name: TABLE clients; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.clients TO "test-simple-user";


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.orders TO "test-simple-user";


--
-- PostgreSQL database dump complete
--

