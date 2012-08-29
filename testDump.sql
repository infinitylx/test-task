--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: authors; Type: TABLE; Schema: public; Owner: testUser; Tablespace: 
--

CREATE TABLE authors (
    id integer NOT NULL,
    name character varying(100)
);


ALTER TABLE public.authors OWNER TO "testUser";

--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: testUser
--

CREATE SEQUENCE authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authors_id_seq OWNER TO "testUser";

--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testUser
--

ALTER SEQUENCE authors_id_seq OWNED BY authors.id;


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testUser
--

SELECT pg_catalog.setval('authors_id_seq', 2, true);


--
-- Name: book_to_authors; Type: TABLE; Schema: public; Owner: testUser; Tablespace: 
--

CREATE TABLE book_to_authors (
    left_id integer,
    right_id integer
);


ALTER TABLE public.book_to_authors OWNER TO "testUser";

--
-- Name: books; Type: TABLE; Schema: public; Owner: testUser; Tablespace: 
--

CREATE TABLE books (
    id integer NOT NULL,
    title character varying(100)
);


ALTER TABLE public.books OWNER TO "testUser";

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: testUser
--

CREATE SEQUENCE books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_id_seq OWNER TO "testUser";

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: testUser
--

ALTER SEQUENCE books_id_seq OWNED BY books.id;


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: testUser
--

SELECT pg_catalog.setval('books_id_seq', 1, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: testUser
--

ALTER TABLE ONLY authors ALTER COLUMN id SET DEFAULT nextval('authors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: testUser
--

ALTER TABLE ONLY books ALTER COLUMN id SET DEFAULT nextval('books_id_seq'::regclass);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: testUser
--

COPY authors (id, name) FROM stdin;
1	wlad
2	igor
\.


--
-- Data for Name: book_to_authors; Type: TABLE DATA; Schema: public; Owner: testUser
--

COPY book_to_authors (left_id, right_id) FROM stdin;
1	2
1	1
\.


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: testUser
--

COPY books (id, title) FROM stdin;
1	Java2
\.


--
-- Name: authors_name_key; Type: CONSTRAINT; Schema: public; Owner: testUser; Tablespace: 
--

ALTER TABLE ONLY authors
    ADD CONSTRAINT authors_name_key UNIQUE (name);


--
-- Name: authors_pkey; Type: CONSTRAINT; Schema: public; Owner: testUser; Tablespace: 
--

ALTER TABLE ONLY authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: books_pkey; Type: CONSTRAINT; Schema: public; Owner: testUser; Tablespace: 
--

ALTER TABLE ONLY books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: books_title_key; Type: CONSTRAINT; Schema: public; Owner: testUser; Tablespace: 
--

ALTER TABLE ONLY books
    ADD CONSTRAINT books_title_key UNIQUE (title);


--
-- Name: book_to_authors_left_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testUser
--

ALTER TABLE ONLY book_to_authors
    ADD CONSTRAINT book_to_authors_left_id_fkey FOREIGN KEY (left_id) REFERENCES books(id);


--
-- Name: book_to_authors_right_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: testUser
--

ALTER TABLE ONLY book_to_authors
    ADD CONSTRAINT book_to_authors_right_id_fkey FOREIGN KEY (right_id) REFERENCES authors(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

