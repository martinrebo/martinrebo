--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(50) NOT NULL,
    type text NOT NULL,
    age_in_million_years integer NOT NULL,
    mass numeric(15,2) NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(50) NOT NULL,
    planet_id integer NOT NULL,
    is_tidal_locked boolean DEFAULT false NOT NULL,
    diameter integer NOT NULL,
    mass numeric(10,2),
    notes text
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(50) NOT NULL,
    star_id integer NOT NULL,
    has_life boolean DEFAULT false NOT NULL,
    mass numeric(12,3) NOT NULL,
    orbit_radius integer NOT NULL,
    description text
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: satellite; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.satellite (
    satellite_id integer NOT NULL,
    name character varying(50) NOT NULL,
    purpose text NOT NULL,
    is_operational boolean NOT NULL,
    orbit_altitude integer
);


ALTER TABLE public.satellite OWNER TO freecodecamp;

--
-- Name: satellite_satellite_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.satellite_satellite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.satellite_satellite_id_seq OWNER TO freecodecamp;

--
-- Name: satellite_satellite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.satellite_satellite_id_seq OWNED BY public.satellite.satellite_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(50) NOT NULL,
    galaxy_id integer NOT NULL,
    luminosity numeric(10,2) NOT NULL,
    type text NOT NULL,
    age_in_million_years integer,
    is_visible boolean DEFAULT true NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: satellite satellite_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.satellite ALTER COLUMN satellite_id SET DEFAULT nextval('public.satellite_satellite_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Spiral', 13600, 1500000000000.00, true);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'Spiral', 10000, 1230000000000.00, true);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'Spiral', 13000, 50000000000.00, true);
INSERT INTO public.galaxy VALUES (4, 'Messier 81', 'Spiral', 12000, 60000000000.00, false);
INSERT INTO public.galaxy VALUES (5, 'Sombrero', 'Elliptical', 9000, 80000000000.00, true);
INSERT INTO public.galaxy VALUES (6, 'Whirlpool', 'Spiral', 12000, 160000000000.00, true);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 1, true, 3475, 7.35, 'Earth''s moon');
INSERT INTO public.moon VALUES (2, 'Phobos', 2, true, 22, 1.07, 'Mars moon');
INSERT INTO public.moon VALUES (3, 'Deimos', 2, false, 12, 0.16, 'Mars moon');
INSERT INTO public.moon VALUES (4, 'Aphrodite', 3, true, 8, 0.20, 'Venus moon');
INSERT INTO public.moon VALUES (5, 'Promixa I', 4, true, 10, 0.50, 'Proxima b moon');
INSERT INTO public.moon VALUES (6, 'Sirius b I', 5, false, 15, 0.70, 'Sirius b moon');
INSERT INTO public.moon VALUES (7, 'Rigel I a', 6, true, 20, 0.90, 'Rigel I moon 1');
INSERT INTO public.moon VALUES (8, 'Rigel I b', 6, false, 18, 0.60, 'Rigel I moon 2');
INSERT INTO public.moon VALUES (9, 'Rigel II a', 7, true, 16, 0.50, 'Rigel II moon 1');
INSERT INTO public.moon VALUES (10, 'Rigel II b', 7, false, 10, 0.20, 'Rigel II moon 2');
INSERT INTO public.moon VALUES (11, 'Betelgeuse I a', 8, true, 11, 0.80, 'Betelgeuse I moon 1');
INSERT INTO public.moon VALUES (12, 'Betelgeuse II a', 9, false, 9, 0.30, 'Betelgeuse II moon 1');
INSERT INTO public.moon VALUES (13, 'Betelgeuse II b', 9, true, 8, 0.20, 'Betelgeuse II moon 2');
INSERT INTO public.moon VALUES (14, 'Vega I a', 10, true, 12, 0.40, 'Vega I moon 1');
INSERT INTO public.moon VALUES (15, 'Vega II a', 11, true, 13, 0.50, 'Vega II moon 1');
INSERT INTO public.moon VALUES (16, 'Vega II b', 11, false, 14, 0.60, 'Vega II moon 2');
INSERT INTO public.moon VALUES (17, 'Vega III a', 12, true, 15, 0.70, 'Vega III moon 1');
INSERT INTO public.moon VALUES (18, 'Vega III b', 12, true, 16, 0.80, 'Vega III moon 2');
INSERT INTO public.moon VALUES (19, 'Vega III c', 12, false, 17, 0.90, 'Vega III moon 3');
INSERT INTO public.moon VALUES (20, 'Vega III d', 12, true, 18, 1.00, 'Vega III moon 4');


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 1, true, 5.972, 1, 'Home planet');
INSERT INTO public.planet VALUES (2, 'Mars', 1, false, 0.641, 1, 'Red planet');
INSERT INTO public.planet VALUES (3, 'Venus', 1, false, 4.867, 1, 'Hot planet');
INSERT INTO public.planet VALUES (4, 'Proxima b', 2, false, 1.270, 1, 'Closest exoplanet');
INSERT INTO public.planet VALUES (5, 'Sirius b', 3, false, 1.020, 1, 'White dwarf companion');
INSERT INTO public.planet VALUES (6, 'Rigel I', 4, false, 3.010, 2, 'First Rigel planet');
INSERT INTO public.planet VALUES (7, 'Rigel II', 4, false, 2.220, 2, 'Second Rigel planet');
INSERT INTO public.planet VALUES (8, 'Betelgeuse I', 5, false, 5.670, 2, 'First Betelgeuse planet');
INSERT INTO public.planet VALUES (9, 'Betelgeuse II', 5, false, 2.140, 2, 'Second Betelgeuse planet');
INSERT INTO public.planet VALUES (10, 'Vega I', 6, false, 1.450, 1, 'First Vega planet');
INSERT INTO public.planet VALUES (11, 'Vega II', 6, false, 2.010, 1, 'Second Vega planet');
INSERT INTO public.planet VALUES (12, 'Vega III', 6, false, 1.780, 1, 'Third Vega planet');


--
-- Data for Name: satellite; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.satellite VALUES (1, 'Hubble', 'Observation', true, 547);
INSERT INTO public.satellite VALUES (2, 'ISS', 'Research', true, 420);
INSERT INTO public.satellite VALUES (3, 'Voyager 1', 'Exploration', false, 0);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 1.00, 'G-type', 4600, true);
INSERT INTO public.star VALUES (2, 'Alpha Centauri', 1, 1.52, 'G-type', 5500, true);
INSERT INTO public.star VALUES (3, 'Sirius', 1, 25.40, 'A-type', 200, true);
INSERT INTO public.star VALUES (4, 'Rigel', 2, 120000.00, 'B-type', 800, true);
INSERT INTO public.star VALUES (5, 'Betelgeuse', 2, 126000.00, 'M-type', 10000, true);
INSERT INTO public.star VALUES (6, 'Vega', 3, 40.12, 'A-type', 455, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: satellite_satellite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.satellite_satellite_id_seq', 3, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: satellite satellite_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.satellite
    ADD CONSTRAINT satellite_name_key UNIQUE (name);


--
-- Name: satellite satellite_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.satellite
    ADD CONSTRAINT satellite_pkey PRIMARY KEY (satellite_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

