--
-- PostgreSQL database dump
--

\restrict rgqNnK9JaMKOxl6E38d7s8C3JY2NsyW0k8rJRebXgXlFoj2M1UVHhkcbgJErsjr

-- Dumped from database version 18.4 (Debian 18.4-1.pgdg13+1)
-- Dumped by pg_dump version 18.4 (Debian 18.4-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: Day; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Day" AS ENUM (
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
);


ALTER TYPE public."Day" OWNER TO postgres;

--
-- Name: FriendRequestStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."FriendRequestStatus" AS ENUM (
    'PENDING',
    'ACCEPTED',
    'REJECTED'
);


ALTER TYPE public."FriendRequestStatus" OWNER TO postgres;

--
-- Name: Gender; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Gender" AS ENUM (
    'MIXED',
    'MEN',
    'WOMEN'
);


ALTER TYPE public."Gender" OWNER TO postgres;

--
-- Name: Level; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Level" AS ENUM (
    'BEGINNER',
    'INTERMEDIATE',
    'ADVANCED',
    'PRO'
);


ALTER TYPE public."Level" OWNER TO postgres;

--
-- Name: MatchStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."MatchStatus" AS ENUM (
    'OPEN',
    'ALMOST_FULL',
    'FULL',
    'CANCELLED'
);


ALTER TYPE public."MatchStatus" OWNER TO postgres;

--
-- Name: ParticipantStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ParticipantStatus" AS ENUM (
    'PENDING',
    'ACCEPTED',
    'REJECTED'
);


ALTER TYPE public."ParticipantStatus" OWNER TO postgres;

--
-- Name: PaymentStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PaymentStatus" AS ENUM (
    'PENDING',
    'PAID',
    'FAILED'
);


ALTER TYPE public."PaymentStatus" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Availability; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Availability" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "dayOfWeek" text NOT NULL,
    "startTime" text NOT NULL,
    "endTime" text NOT NULL
);


ALTER TABLE public."Availability" OWNER TO postgres;

--
-- Name: Badge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Badge" (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL
);


ALTER TABLE public."Badge" OWNER TO postgres;

--
-- Name: Badge_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Badge_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Badge_id_seq" OWNER TO postgres;

--
-- Name: Badge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Badge_id_seq" OWNED BY public."Badge".id;


--
-- Name: Equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Equipment" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Equipment" OWNER TO postgres;

--
-- Name: Equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Equipment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Equipment_id_seq" OWNER TO postgres;

--
-- Name: Equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Equipment_id_seq" OWNED BY public."Equipment".id;


--
-- Name: Field; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Field" (
    id integer NOT NULL,
    "locationId" integer NOT NULL,
    name text NOT NULL,
    price double precision DEFAULT 70.0 NOT NULL
);


ALTER TABLE public."Field" OWNER TO postgres;

--
-- Name: Field_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Field_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Field_id_seq" OWNER TO postgres;

--
-- Name: Field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Field_id_seq" OWNED BY public."Field".id;


--
-- Name: FriendRequest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FriendRequest" (
    id text NOT NULL,
    "senderId" text NOT NULL,
    "receiverId" text NOT NULL,
    status public."FriendRequestStatus" DEFAULT 'PENDING'::public."FriendRequestStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."FriendRequest" OWNER TO postgres;

--
-- Name: Location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Location" (
    id integer NOT NULL,
    "sportId" integer NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    iban text DEFAULT 'BE76 3000 6000 0112'::text NOT NULL,
    role text DEFAULT 'PLAYER'::text NOT NULL
);


ALTER TABLE public."Location" OWNER TO postgres;

--
-- Name: Location_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Location_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Location_id_seq" OWNER TO postgres;

--
-- Name: Location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Location_id_seq" OWNED BY public."Location".id;


--
-- Name: Match; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Match" (
    id integer NOT NULL,
    "creatorId" text NOT NULL,
    "sportId" integer NOT NULL,
    "locationId" integer NOT NULL,
    "matchDate" timestamp(3) without time zone NOT NULL,
    "startTime" text NOT NULL,
    "endTime" text NOT NULL,
    "maxPlayers" integer NOT NULL,
    "levelRequired" public."Level" NOT NULL,
    gender public."Gender" NOT NULL,
    price integer NOT NULL,
    "isPublic" boolean DEFAULT true NOT NULL,
    "privateCode" text,
    "autoValidate" boolean DEFAULT true NOT NULL,
    deadline timestamp(3) without time zone,
    description text,
    status public."MatchStatus" DEFAULT 'OPEN'::public."MatchStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "scheduleId" integer
);


ALTER TABLE public."Match" OWNER TO postgres;

--
-- Name: MatchParticipant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MatchParticipant" (
    id integer NOT NULL,
    "matchId" integer NOT NULL,
    "userId" text NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    "joinedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    team text NOT NULL,
    confirmed boolean DEFAULT false NOT NULL,
    "invitedById" text,
    role text DEFAULT 'PLAYER'::text NOT NULL,
    "lastSeenAt" timestamp(3) without time zone
);


ALTER TABLE public."MatchParticipant" OWNER TO postgres;

--
-- Name: MatchParticipant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."MatchParticipant_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."MatchParticipant_id_seq" OWNER TO postgres;

--
-- Name: MatchParticipant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."MatchParticipant_id_seq" OWNED BY public."MatchParticipant".id;


--
-- Name: Match_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Match_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Match_id_seq" OWNER TO postgres;

--
-- Name: Match_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Match_id_seq" OWNED BY public."Match".id;


--
-- Name: Message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Message" (
    id integer NOT NULL,
    "matchId" integer NOT NULL,
    "senderId" text NOT NULL,
    content text NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "sentAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Message" OWNER TO postgres;

--
-- Name: Message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Message_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Message_id_seq" OWNER TO postgres;

--
-- Name: Message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Message_id_seq" OWNED BY public."Message".id;


--
-- Name: Payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Payment" (
    id integer NOT NULL,
    "matchId" integer NOT NULL,
    "userId" text NOT NULL,
    amount double precision NOT NULL,
    status public."PaymentStatus" DEFAULT 'PENDING'::public."PaymentStatus" NOT NULL,
    "stripeId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Payment" OWNER TO postgres;

--
-- Name: Payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Payment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Payment_id_seq" OWNER TO postgres;

--
-- Name: Payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Payment_id_seq" OWNED BY public."Payment".id;


--
-- Name: Rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rating" (
    id integer NOT NULL,
    "matchId" integer NOT NULL,
    "raterId" text NOT NULL,
    "ratedUserId" text NOT NULL,
    score integer NOT NULL,
    comment text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Rating" OWNER TO postgres;

--
-- Name: Rating_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Rating_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Rating_id_seq" OWNER TO postgres;

--
-- Name: Rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rating_id_seq" OWNED BY public."Rating".id;


--
-- Name: Schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Schedule" (
    id integer NOT NULL,
    "fieldId" integer NOT NULL,
    day text NOT NULL,
    start text NOT NULL,
    "end" text NOT NULL,
    "isAvailable" boolean DEFAULT true NOT NULL
);


ALTER TABLE public."Schedule" OWNER TO postgres;

--
-- Name: Schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Schedule_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Schedule_id_seq" OWNER TO postgres;

--
-- Name: Schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Schedule_id_seq" OWNED BY public."Schedule".id;


--
-- Name: Sport; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sport" (
    id integer NOT NULL,
    name text NOT NULL,
    icon text
);


ALTER TABLE public."Sport" OWNER TO postgres;

--
-- Name: Sport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Sport_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Sport_id_seq" OWNER TO postgres;

--
-- Name: Sport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Sport_id_seq" OWNED BY public."Sport".id;


--
-- Name: UserBadge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserBadge" (
    "userId" text NOT NULL,
    "badgeId" integer NOT NULL,
    "earnedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."UserBadge" OWNER TO postgres;

--
-- Name: UserEquipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserEquipment" (
    "userId" text NOT NULL,
    "equipmentId" integer NOT NULL
);


ALTER TABLE public."UserEquipment" OWNER TO postgres;

--
-- Name: UserSport; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserSport" (
    id integer NOT NULL,
    "userId" text NOT NULL,
    "sportId" integer NOT NULL,
    level text NOT NULL,
    "position" text
);


ALTER TABLE public."UserSport" OWNER TO postgres;

--
-- Name: UserSport_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserSport_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserSport_id_seq" OWNER TO postgres;

--
-- Name: UserSport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserSport_id_seq" OWNED BY public."UserSport".id;


--
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    id text NOT NULL,
    "accountId" text NOT NULL,
    "providerId" text NOT NULL,
    "userId" text NOT NULL,
    "accessToken" text,
    "refreshToken" text,
    "idToken" text,
    "accessTokenExpiresAt" timestamp(3) without time zone,
    "refreshTokenExpiresAt" timestamp(3) without time zone,
    scope text,
    password text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.account OWNER TO postgres;

--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    id text NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    token text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "ipAddress" text,
    "userAgent" text,
    "userId" text NOT NULL
);


ALTER TABLE public.session OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    password text,
    pseudo text,
    "photoUrl" text,
    age integer,
    city text,
    bio text,
    image text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "emailVerified" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: verification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.verification (
    id text NOT NULL,
    identifier text NOT NULL,
    value text NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.verification OWNER TO postgres;

--
-- Name: Badge id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Badge" ALTER COLUMN id SET DEFAULT nextval('public."Badge_id_seq"'::regclass);


--
-- Name: Equipment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Equipment" ALTER COLUMN id SET DEFAULT nextval('public."Equipment_id_seq"'::regclass);


--
-- Name: Field id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Field" ALTER COLUMN id SET DEFAULT nextval('public."Field_id_seq"'::regclass);


--
-- Name: Location id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location" ALTER COLUMN id SET DEFAULT nextval('public."Location_id_seq"'::regclass);


--
-- Name: Match id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Match" ALTER COLUMN id SET DEFAULT nextval('public."Match_id_seq"'::regclass);


--
-- Name: MatchParticipant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MatchParticipant" ALTER COLUMN id SET DEFAULT nextval('public."MatchParticipant_id_seq"'::regclass);


--
-- Name: Message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message" ALTER COLUMN id SET DEFAULT nextval('public."Message_id_seq"'::regclass);


--
-- Name: Payment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment" ALTER COLUMN id SET DEFAULT nextval('public."Payment_id_seq"'::regclass);


--
-- Name: Rating id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rating" ALTER COLUMN id SET DEFAULT nextval('public."Rating_id_seq"'::regclass);


--
-- Name: Schedule id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Schedule" ALTER COLUMN id SET DEFAULT nextval('public."Schedule_id_seq"'::regclass);


--
-- Name: Sport id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sport" ALTER COLUMN id SET DEFAULT nextval('public."Sport_id_seq"'::regclass);


--
-- Name: UserSport id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSport" ALTER COLUMN id SET DEFAULT nextval('public."UserSport_id_seq"'::regclass);


--
-- Data for Name: Availability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Availability" (id, "userId", "dayOfWeek", "startTime", "endTime") FROM stdin;
\.


--
-- Data for Name: Badge; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Badge" (id, name, description) FROM stdin;
1	10 Matchs de suite !	Jouer 10 matchs d'affilés
\.


--
-- Data for Name: Equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Equipment" (id, name) FROM stdin;
\.


--
-- Data for Name: Field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Field" (id, "locationId", name, price) FROM stdin;
1	1	Terrain 1	70
2	1	Terrain 2	70
3	1	Terrain 3	70
4	1	Terrain 4	70
5	1	Terrain 5	70
6	2	Terrain 1	70
7	2	Terrain 2	70
8	2	Terrain 3	70
9	2	Terrain 4 (4x4)	70
10	3	Terrain 1	70
11	3	Terrain 2	70
12	3	Terrain 3	70
13	3	Terrain 4	70
14	3	Terrain 5 (3x3)	70
15	4	Terrain 1	70
16	4	Terrain 2	70
17	4	Terrain 3	70
18	5	Terrain 1	70
19	5	Terrain 2	70
20	5	Terrain 3	70
21	5	Terrain 4	70
22	6	Terrain 1	70
23	6	Terrain 2	70
24	6	Terrain 3	70
25	6	Terrain 4	70
26	6	Terrain 5	70
27	7	Terrain 1	70
28	7	Terrain 2	70
29	7	Terrain 3	70
30	7	Terrain 4	70
31	10	Terrain 1	70
32	10	Terrain 2	70
33	10	Terrain 3	70
34	10	Terrain 4	70
\.


--
-- Data for Name: FriendRequest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FriendRequest" (id, "senderId", "receiverId", status, "createdAt", "updatedAt") FROM stdin;
a9da9ff6-c745-4e09-9482-74e9ffcb96a1	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	Ubb6EGrM2c4GyOhTn1ESKaKpfYbG7xSC	PENDING	2026-03-03 21:06:07.467	2026-03-03 21:06:07.467
9e983be1-9338-42af-8217-2bfe34655fea	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	ACCEPTED	2026-03-03 21:20:43.103	2026-03-03 21:21:27.056
7cbeed80-315a-4e29-9f86-27b2ad9061b0	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	ACCEPTED	2026-04-24 07:21:48.441	2026-04-24 07:22:57.81
\.


--
-- Data for Name: Location; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Location" (id, "sportId", name, address, iban, role) FROM stdin;
1	1	City Five Laeken	Rue Tielemans 2, 1020 Bruxelles	BE76 3000 6000 0112	PLAYER
3	1	City Five Molenbeek	Rue de l'Indépendance 83, 1080 Molenbeek-Saint-Jean	BE76 3000 6000 0112	PLAYER
2	1	City Five Forest	Rue de Lusambo 36, 1190 Forest	BE76 3000 6000 0112	PLAYER
4	2	Centre Sportif Mounier	Avenue Emmanuel Mounier 87, 1200 Woluwe Saint Lambert	BE76 3000 6000 0112	PLAYER
5	2	Complexe sportif de Laeken	Rue du Champ de l'Eglise 73/89, 1020 Laeken	BE76 3000 6000 0112	PLAYER
6	2	Hall Omnisports du CERIA	Sentier de la Drève 16, 1070 Anderlecht	BE76 3000 6000 0112	PLAYER
7	3	SportCity	Avenue Salome 2, 1150 Woluwe Saint Pierre	BE76 3000 6000 0112	PLAYER
8	3	B.Sports	Avenue de la Basilique 14, 1082 Berchem-Sainte-Agathe	BE76 3000 6000 0112	PLAYER
9	3	Tennis Club du Bois de la Cambre	Square du Vieux Tilleul 11 ,1050 Ixelles	BE76 3000 6000 0112	PLAYER
10	4	Padel Tennis Club Montjoie	rue Edith Cavell 91, 1180 Uccle	BE76 3000 6000 0112	PLAYER
11	4	Urban Padel Brussels	Rue Dante 22, 1070 Anderlecht	BE76 3000 6000 0112	PLAYER
12	4	Vertuoza Padel Tour	bvd Lambermont 76, 1030 Bruxelles	BE76 3000 6000 0112	PLAYER
\.


--
-- Data for Name: Match; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Match" (id, "creatorId", "sportId", "locationId", "matchDate", "startTime", "endTime", "maxPlayers", "levelRequired", gender, price, "isPublic", "privateCode", "autoValidate", deadline, description, status, "createdAt", "scheduleId") FROM stdin;
957	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	1	1	2026-04-20 12:26:32.515	04h00	05h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-04-20 12:26:13.211	5
1051	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	1	1	2026-05-13 14:16:57.034	07h00	08h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-05-13 14:16:57.042	176
1052	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	1	1	2026-05-13 14:17:13.278	19h00	20h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-05-13 14:17:13.278	19
397	54U9K5nz949C47LxepSOHVJqigCoAy2e	1	1	2026-05-13 14:18:54.946	10h00	11h00	10	BEGINNER	MIXED	0	t	\N	t	\N	\N	OPEN	2026-03-08 16:05:24.919	11
580	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	1	1	2026-03-26 13:12:58.2	22h00	23h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-03-26 11:52:00.084	22
1027	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	2	4	2026-05-13 13:03:07.512	13h00	14h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-05-13 13:03:07.513	230
1028	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	3	7	2026-05-13 13:04:35.245	15h00	16h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-05-13 13:04:32.039	281
1021	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	1	1	2026-05-13 14:19:03.26	23h00	00h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-05-13 12:58:24.076	23
1000	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	2	4	2026-04-23 11:14:05.999	23h00	00h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-04-23 11:14:06.006	240
1001	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	3	7	2026-04-23 11:14:24.118	19h00	20h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-04-23 11:14:24.118	285
359	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	1	1	2026-03-04 08:48:30.159	03h00	04h00	10	BEGINNER	MIXED	0	t	\N	t	\N	\N	OPEN	2026-03-04 08:48:28.057	172
170	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	1	1	2026-05-13 14:19:13.694	09h00	10h00	10	BEGINNER	MIXED	0	t	\N	t	\N	\N	OPEN	2026-02-27 09:57:55.376	10
317	Ubb6EGrM2c4GyOhTn1ESKaKpfYbG7xSC	1	1	2026-05-13 13:05:53.179	00h00	01h00	10	BEGINNER	MIXED	0	t	\N	t	\N	\N	OPEN	2026-03-02 08:05:57.956	1
714	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	2	4	2026-05-13 14:19:26.282	17h00	18h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-04-01 10:29:33.413	234
58	uc7y1cWlf0F2YDmOzUXDv4luv1GFntWU	1	1	2026-02-24 12:32:47.201	13h00	14h00	10	BEGINNER	MIXED	0	t	\N	t	\N	\N	OPEN	2026-02-24 12:32:47.201	13
18	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	1	1	2026-05-13 13:06:12.331	12h00	13h00	10	BEGINNER	MIXED	0	t	\N	t	\N	\N	OPEN	2026-02-23 14:17:35.67	12
1050	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	1	1	2026-05-14 17:58:43.675	14h00	15h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-05-13 13:42:39.584	14
1034	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	4	10	2026-05-13 13:07:04	15h00	16h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-05-13 13:06:54.092	305
69	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	1	1	2026-05-13 14:19:55.109	17h00	18h00	10	BEGINNER	MIXED	0	t	\N	t	\N	\N	OPEN	2026-02-26 08:18:07.202	17
165	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	1	1	2026-04-01 08:44:59.579	20h00	21h00	10	BEGINNER	MIXED	0	t	\N	t	\N	\N	OPEN	2026-02-27 09:57:42.793	20
164	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	1	1	2026-04-01 10:26:15.763	21h00	22h00	10	BEGINNER	MIXED	0	t	\N	t	\N	\N	OPEN	2026-02-27 09:57:34.412	21
759	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	1	1	2026-04-14 11:26:35.106	02h00	03h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-04-10 09:05:25.542	3
1141	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	1	1	2026-05-15 17:13:47.035	07h00	08h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-05-14 20:00:20.187	8
575	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	3	7	2026-03-25 22:36:32.762	02h00	03h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-03-25 22:36:32.765	268
171	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	1	1	2026-03-01 12:27:08.813	01h00	02h00	10	BEGINNER	MIXED	0	t	\N	t	\N	\N	OPEN	2026-02-27 09:59:20.62	2
576	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	4	10	2026-03-25 22:52:40.099	17h00	18h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-03-25 22:52:35.721	307
339	99YneHrHAILof7dvLAUZk2hbzR6U88N9	1	1	2026-04-06 19:12:05.132	08h00	09h00	10	BEGINNER	MIXED	0	t	\N	t	\N	\N	OPEN	2026-03-02 09:57:58.344	9
961	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	1	1	2026-05-14 17:57:40.09	05h00	06h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-04-21 16:34:26.604	6
814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	1	1	2026-04-24 15:06:06.903	03h00	04h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-04-13 20:14:57.49	4
1037	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	4	10	2026-05-13 13:18:44.339	11h00	12h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-05-13 13:07:38.1	301
1080	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	1	1	2026-05-14 20:07:42.185	06h00	07h00	10	BEGINNER	MIXED	70	t	\N	t	\N	\N	OPEN	2026-05-14 17:32:57.545	7
\.


--
-- Data for Name: MatchParticipant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MatchParticipant" (id, "matchId", "userId", status, "joinedAt", team, confirmed, "invitedById", role, "lastSeenAt") FROM stdin;
90	18	Ubb6EGrM2c4GyOhTn1ESKaKpfYbG7xSC	ACCEPTED	2026-03-16 14:48:50.517	YELLOW	t	\N	PLAYER	\N
91	18	6zuuUAYiMaL0DNTuh37xy6W08xWuMUEf	ACCEPTED	2026-03-16 14:50:04.02	YELLOW	t	\N	PLAYER	\N
92	18	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	ACCEPTED	2026-03-16 14:50:28.061	YELLOW	t	\N	PLAYER	\N
204	961	f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	ACCEPTED	2026-05-14 17:31:55.846	YELLOW	t	\N	PLAYER	2026-05-14 17:31:55.971
93	18	f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	ACCEPTED	2026-03-16 14:51:00.244	YELLOW	t	\N	PLAYER	\N
190	961	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	ACCEPTED	2026-04-21 16:42:25.584	PURPLE	t	\N	ADMIN	2026-05-14 17:56:57.688
191	814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	ACCEPTED	2026-04-22 07:40:39.113	PURPLE	f	\N	ADMIN	2026-04-24 15:06:06.964
205	961	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	ACCEPTED	2026-05-14 17:32:13.521	YELLOW	t	\N	PLAYER	2026-05-14 17:32:13.625
95	317	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	ACCEPTED	2026-03-17 08:43:43.863	PURPLE	t	\N	PLAYER	\N
192	961	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	ACCEPTED	2026-04-22 07:51:43.847	PURPLE	t	\N	PLAYER	2026-04-22 07:51:44.07
196	1028	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	ACCEPTED	2026-05-13 13:04:35.224	PURPLE	f	\N	ADMIN	2026-05-13 13:04:35.264
96	317	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	ACCEPTED	2026-03-17 08:46:47.198	PURPLE	t	\N	PLAYER	\N
98	317	99YneHrHAILof7dvLAUZk2hbzR6U88N9	ACCEPTED	2026-03-17 08:50:42.842	PURPLE	t	\N	PLAYER	2026-04-06 14:46:06.367
94	18	99YneHrHAILof7dvLAUZk2hbzR6U88N9	ACCEPTED	2026-03-16 14:51:22.89	YELLOW	t	\N	PLAYER	2026-04-06 14:46:10.421
74	359	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	ACCEPTED	2026-03-04 08:48:28.847	PURPLE	t	\N	PLAYER	\N
193	961	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	ACCEPTED	2026-04-22 07:52:12.644	PURPLE	t	\N	PLAYER	2026-04-22 07:52:12.792
194	961	mBA4Xkqq9JEuK2myGtaYqFqRsjpP93ey	ACCEPTED	2026-04-22 07:52:29.806	PURPLE	t	\N	PLAYER	2026-04-22 07:52:29.989
97	317	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	ACCEPTED	2026-03-17 08:49:35.737	PURPLE	t	\N	PLAYER	2026-05-13 13:05:53.245
87	18	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	ACCEPTED	2026-03-16 14:46:56.824	PURPLE	t	\N	PLAYER	2026-05-13 13:06:07.103
105	317	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	ACCEPTED	2026-03-17 08:58:15.344	YELLOW	t	\N	PLAYER	2026-04-24 07:25:36.65
206	961	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	ACCEPTED	2026-05-14 17:32:39.595	YELLOW	t	\N	PLAYER	2026-05-14 17:32:39.719
214	1080	f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	ACCEPTED	2026-05-14 17:59:30.676	YELLOW	t	\N	PLAYER	2026-05-14 17:59:30.774
70	18	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	ACCEPTED	2026-03-04 08:27:31.199	PURPLE	t	\N	PLAYER	\N
199	1037	99YneHrHAILof7dvLAUZk2hbzR6U88N9	ACCEPTED	2026-05-13 13:08:07.911	PURPLE	t	\N	PLAYER	2026-05-13 13:08:07.989
88	18	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	ACCEPTED	2026-03-16 14:48:12.928	PURPLE	t	\N	PLAYER	\N
89	18	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	ACCEPTED	2026-03-16 14:48:31.797	PURPLE	t	\N	PLAYER	\N
198	1037	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	ACCEPTED	2026-05-13 13:07:38.821	PURPLE	t	\N	ADMIN	2026-05-13 13:18:44.356
195	1021	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	ACCEPTED	2026-05-13 13:02:52.331	PURPLE	t	\N	ADMIN	2026-05-13 14:19:03.329
99	317	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	ACCEPTED	2026-03-17 08:51:10.959	PURPLE	t	\N	PLAYER	\N
102	317	Ubb6EGrM2c4GyOhTn1ESKaKpfYbG7xSC	ACCEPTED	2026-03-17 08:54:04.898	YELLOW	t	\N	PLAYER	\N
103	317	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	ACCEPTED	2026-03-17 08:54:33.756	YELLOW	t	\N	PLAYER	\N
104	317	54U9K5nz949C47LxepSOHVJqigCoAy2e	ACCEPTED	2026-03-17 08:56:59.3	YELLOW	t	\N	PLAYER	\N
208	1080	99YneHrHAILof7dvLAUZk2hbzR6U88N9	ACCEPTED	2026-05-14 17:57:55.563	PURPLE	t	\N	PLAYER	2026-05-14 17:57:55.664
200	69	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	ACCEPTED	2026-05-13 14:19:53.988	PURPLE	t	\N	ADMIN	2026-05-13 14:19:54.036
146	164	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	ACCEPTED	2026-04-01 10:26:04.303	PURPLE	f	\N	ADMIN	\N
201	961	99YneHrHAILof7dvLAUZk2hbzR6U88N9	ACCEPTED	2026-05-14 17:31:04.366	PURPLE	t	\N	PLAYER	2026-05-14 17:31:04.493
209	1080	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	ACCEPTED	2026-05-14 17:58:13.251	PURPLE	t	\N	PLAYER	2026-05-14 17:58:13.368
202	961	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	ACCEPTED	2026-05-14 17:31:22.701	YELLOW	t	\N	PLAYER	2026-05-14 17:31:22.804
203	961	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	ACCEPTED	2026-05-14 17:31:38.488	YELLOW	t	\N	PLAYER	2026-05-14 17:31:38.654
107	317	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	ACCEPTED	2026-03-17 08:59:07.08	YELLOW	t	\N	PLAYER	2026-04-06 14:37:49.772
21	18	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	ACCEPTED	2026-02-23 14:17:36.767	PURPLE	t	\N	PLAYER	2026-04-06 14:37:59.833
210	1080	mBA4Xkqq9JEuK2myGtaYqFqRsjpP93ey	ACCEPTED	2026-05-14 17:58:27.699	PURPLE	t	\N	PLAYER	2026-05-14 17:58:27.824
215	1080	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	ACCEPTED	2026-05-14 17:59:45.376	YELLOW	t	\N	PLAYER	2026-05-14 17:59:45.506
211	1080	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	ACCEPTED	2026-05-14 17:58:47.715	PURPLE	t	\N	PLAYER	2026-05-14 17:58:47.846
212	1080	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	ACCEPTED	2026-05-14 17:59:02.861	YELLOW	t	\N	PLAYER	2026-05-14 17:59:02.986
213	1080	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	ACCEPTED	2026-05-14 17:59:16.548	YELLOW	t	\N	PLAYER	2026-05-14 17:59:16.654
218	1080	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	ACCEPTED	2026-05-14 19:59:58.994	YELLOW	t	\N	PLAYER	2026-05-14 19:59:59.14
207	1080	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	ACCEPTED	2026-05-14 17:57:38.83	PURPLE	t	\N	ADMIN	2026-05-14 20:00:24.015
\.


--
-- Data for Name: Message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Message" (id, "matchId", "senderId", content, "isSystem", "sentAt") FROM stdin;
18	317	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	Bonjour tout le monde !	f	2026-03-25 22:53:11.79
19	317	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	test	f	2026-03-26 13:04:04.494
20	18	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	Bonjour !	f	2026-03-26 13:04:41.741
21	317	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	bonjour	f	2026-04-06 13:21:45.219
22	18	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	Bonjour	f	2026-04-06 13:22:00.523
23	317	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	lets go	f	2026-04-06 14:37:56.825
24	18	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	on joue ?	f	2026-04-06 14:38:07.788
25	317	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	vamos	f	2026-04-06 14:43:31.167
27	317	99YneHrHAILof7dvLAUZk2hbzR6U88N9	yesss	f	2026-04-06 14:45:56.447
28	18	99YneHrHAILof7dvLAUZk2hbzR6U88N9	joga	f	2026-04-06 14:46:15.132
29	759	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	Hello	f	2026-04-13 19:41:36.522
30	759	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	Bonjour	f	2026-04-13 19:47:40.277
34	1037	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	hello	f	2026-05-13 13:07:48.121
\.


--
-- Data for Name: Payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Payment" (id, "matchId", "userId", amount, status, "stripeId", "createdAt") FROM stdin;
120	961	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	7	PAID	\N	2026-05-14 17:40:45.706
117	961	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	7	PAID	\N	2026-05-14 17:40:45.706
101	961	f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	7	PAID	\N	2026-05-14 17:33:04.305
102	961	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	7	PAID	\N	2026-05-14 17:33:04.305
111	961	f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	7	PENDING	\N	2026-05-14 17:40:45.706
112	961	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	7	PENDING	\N	2026-05-14 17:40:45.706
103	961	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	7	PAID	\N	2026-05-14 17:33:04.305
113	961	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	7	PAID	\N	2026-05-14 17:40:45.706
104	961	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	7	PAID	\N	2026-05-14 17:33:04.305
114	961	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	7	PAID	\N	2026-05-14 17:40:45.706
105	961	mBA4Xkqq9JEuK2myGtaYqFqRsjpP93ey	7	PAID	\N	2026-05-14 17:33:04.305
115	961	mBA4Xkqq9JEuK2myGtaYqFqRsjpP93ey	7	PAID	\N	2026-05-14 17:40:45.706
106	961	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	7	PAID	\N	2026-05-14 17:33:04.305
116	961	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	7	PAID	\N	2026-05-14 17:40:45.706
108	961	99YneHrHAILof7dvLAUZk2hbzR6U88N9	7	PAID	\N	2026-05-14 17:33:04.305
118	961	99YneHrHAILof7dvLAUZk2hbzR6U88N9	7	PAID	\N	2026-05-14 17:40:45.706
109	961	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	7	PAID	\N	2026-05-14 17:33:04.305
119	961	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	7	PAID	\N	2026-05-14 17:40:45.706
107	961	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	7	PAID	\N	2026-05-14 17:33:04.305
110	961	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	7	PAID	\N	2026-05-14 17:33:04.305
121	1080	f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	7	PAID	\N	2026-05-14 20:00:25.264
122	1080	99YneHrHAILof7dvLAUZk2hbzR6U88N9	7	PAID	\N	2026-05-14 20:00:25.264
41	18	Ubb6EGrM2c4GyOhTn1ESKaKpfYbG7xSC	7	PENDING	\N	2026-03-16 14:51:26.391
42	18	6zuuUAYiMaL0DNTuh37xy6W08xWuMUEf	7	PENDING	\N	2026-03-16 14:51:26.391
44	18	f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	7	PENDING	\N	2026-03-16 14:51:26.391
47	18	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	7	PENDING	\N	2026-03-16 14:51:26.391
48	18	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	7	PENDING	\N	2026-03-16 14:51:26.391
49	18	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	7	PENDING	\N	2026-03-16 14:51:26.391
50	18	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	7	PENDING	\N	2026-03-16 14:51:26.391
45	18	99YneHrHAILof7dvLAUZk2hbzR6U88N9	7	PAID	\N	2026-03-16 14:51:26.391
46	18	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	7	PAID	\N	2026-03-16 14:51:26.391
43	18	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	7	PAID	\N	2026-03-16 14:51:26.391
51	317	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	7	PENDING	\N	2026-03-17 08:59:09.549
52	317	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	7	PENDING	\N	2026-03-17 08:59:09.549
53	317	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	7	PENDING	\N	2026-03-17 08:59:09.549
54	317	99YneHrHAILof7dvLAUZk2hbzR6U88N9	7	PENDING	\N	2026-03-17 08:59:09.549
55	317	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	7	PENDING	\N	2026-03-17 08:59:09.549
56	317	Ubb6EGrM2c4GyOhTn1ESKaKpfYbG7xSC	7	PENDING	\N	2026-03-17 08:59:09.549
57	317	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	7	PENDING	\N	2026-03-17 08:59:09.549
58	317	54U9K5nz949C47LxepSOHVJqigCoAy2e	7	PENDING	\N	2026-03-17 08:59:09.549
59	317	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	7	PENDING	\N	2026-03-17 08:59:09.549
60	317	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	7	PAID	\N	2026-03-17 08:59:09.549
123	1080	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	7	PAID	\N	2026-05-14 20:00:25.264
124	1080	mBA4Xkqq9JEuK2myGtaYqFqRsjpP93ey	7	PAID	\N	2026-05-14 20:00:25.264
125	1080	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	7	PAID	\N	2026-05-14 20:00:25.264
126	1080	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	7	PAID	\N	2026-05-14 20:00:25.264
127	1080	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	7	PAID	\N	2026-05-14 20:00:25.264
128	1080	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	7	PAID	\N	2026-05-14 20:00:25.264
129	1080	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	7	PAID	\N	2026-05-14 20:00:25.264
130	1080	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	7	PAID	\N	2026-05-14 20:00:25.264
\.


--
-- Data for Name: Rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Rating" (id, "matchId", "raterId", "ratedUserId", score, comment, "createdAt") FROM stdin;
22	339	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	4	\N	2026-04-05 20:05:12.356
23	339	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	4	\N	2026-04-05 20:05:12.356
24	339	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	5	\N	2026-04-05 20:05:12.356
25	339	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	99YneHrHAILof7dvLAUZk2hbzR6U88N9	4	\N	2026-04-05 20:05:12.356
26	339	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	mBA4Xkqq9JEuK2myGtaYqFqRsjpP93ey	4	\N	2026-04-05 20:05:12.356
27	339	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	4	\N	2026-04-05 20:05:12.356
28	339	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	4	\N	2026-04-05 20:05:12.356
29	339	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	4	\N	2026-04-05 20:05:12.356
30	339	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	4	\N	2026-04-05 20:05:12.356
31	339	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	4	\N	2026-04-05 20:05:12.356
32	814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	4	\N	2026-04-21 20:22:40.09
33	814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	5	\N	2026-04-21 20:22:40.09
34	814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	5	\N	2026-04-21 20:22:40.09
35	814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	Ubb6EGrM2c4GyOhTn1ESKaKpfYbG7xSC	4	\N	2026-04-21 20:22:40.09
36	814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	3	\N	2026-04-21 20:22:40.09
37	814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	99YneHrHAILof7dvLAUZk2hbzR6U88N9	4	\N	2026-04-21 20:22:40.09
38	814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	5	\N	2026-04-21 20:22:40.09
39	814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	4	\N	2026-04-21 20:22:40.09
40	814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	5	\N	2026-04-21 20:22:40.09
41	814	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	5	\N	2026-04-21 20:22:40.09
\.


--
-- Data for Name: Schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Schedule" (id, "fieldId", day, start, "end", "isAvailable") FROM stdin;
8	1	MONDAY	07h00	08h00	t
10	1	MONDAY	09h00	10h00	t
13	1	MONDAY	13h00	14h00	t
14	1	MONDAY	14h00	15h00	t
15	1	MONDAY	15h00	16h00	t
16	1	MONDAY	16h00	17h00	t
18	1	MONDAY	18h00	19h00	t
19	1	MONDAY	19h00	20h00	t
23	1	MONDAY	23h00	00h00	t
169	1	THURSDAY	00h00	01h00	t
181	1	THURSDAY	12h00	13h00	t
184	1	THURSDAY	15h00	16h00	t
185	1	THURSDAY	16h00	17h00	t
186	1	THURSDAY	17h00	18h00	t
187	1	THURSDAY	18h00	19h00	t
188	1	THURSDAY	19h00	20h00	t
189	1	THURSDAY	20h00	21h00	t
190	1	THURSDAY	21h00	22h00	t
191	1	THURSDAY	22h00	23h00	t
192	1	THURSDAY	23h00	00h00	t
265	24	MONDAY	00h00	01h00	t
267	27	MONDAY	01h00	02h00	t
268	27	MONDAY	02h00	03h00	t
11	1	MONDAY	10h00	11h00	f
269	27	MONDAY	03h00	04h00	t
12	1	MONDAY	12h00	13h00	f
1	1	MONDAY	00h00	01h00	f
193	4	MONDAY	00h00	01h00	t
194	4	MONDAY	01h00	02h00	t
195	4	MONDAY	02h00	03h00	t
196	4	MONDAY	03h00	04h00	t
197	4	MONDAY	04h00	05h00	t
198	4	MONDAY	05h00	06h00	t
199	4	MONDAY	06h00	07h00	t
200	4	MONDAY	07h00	08h00	t
201	4	MONDAY	08h00	09h00	t
202	4	MONDAY	09h00	10h00	t
203	4	MONDAY	10h00	11h00	t
204	4	MONDAY	11h00	12h00	t
205	4	MONDAY	12h00	13h00	t
21	1	MONDAY	21h00	22h00	t
206	4	MONDAY	13h00	14h00	t
207	4	MONDAY	14h00	15h00	t
208	4	MONDAY	15h00	16h00	t
270	27	MONDAY	04h00	05h00	t
17	1	MONDAY	17h00	18h00	t
2	1	MONDAY	01h00	02h00	t
271	27	MONDAY	05h00	06h00	t
209	4	MONDAY	16h00	17h00	t
272	27	MONDAY	06h00	07h00	t
24	1	TUESDAY	00h00	01h00	t
25	1	TUESDAY	01h00	02h00	t
26	1	TUESDAY	02h00	03h00	t
27	1	TUESDAY	03h00	04h00	t
28	1	TUESDAY	04h00	05h00	t
29	1	TUESDAY	05h00	06h00	t
30	1	TUESDAY	06h00	07h00	t
31	1	TUESDAY	07h00	08h00	t
32	1	TUESDAY	08h00	09h00	t
33	1	TUESDAY	09h00	10h00	t
34	1	TUESDAY	10h00	11h00	t
35	1	TUESDAY	11h00	12h00	t
36	1	TUESDAY	12h00	13h00	t
37	1	TUESDAY	13h00	14h00	t
38	1	TUESDAY	14h00	15h00	t
39	1	TUESDAY	15h00	16h00	t
40	1	TUESDAY	16h00	17h00	t
41	1	TUESDAY	17h00	18h00	t
42	1	TUESDAY	18h00	19h00	t
43	1	TUESDAY	19h00	20h00	t
44	1	TUESDAY	20h00	21h00	t
45	1	TUESDAY	21h00	22h00	t
46	1	TUESDAY	22h00	23h00	t
47	1	TUESDAY	23h00	00h00	t
48	1	WEDNESDAY	00h00	01h00	t
49	1	WEDNESDAY	01h00	02h00	t
50	1	WEDNESDAY	02h00	03h00	t
51	1	WEDNESDAY	03h00	04h00	t
52	1	WEDNESDAY	04h00	05h00	t
53	1	WEDNESDAY	05h00	06h00	t
54	1	WEDNESDAY	06h00	07h00	t
55	1	WEDNESDAY	07h00	08h00	t
56	1	WEDNESDAY	08h00	09h00	t
57	1	WEDNESDAY	09h00	10h00	t
58	1	WEDNESDAY	10h00	11h00	t
59	1	WEDNESDAY	11h00	12h00	t
60	1	WEDNESDAY	12h00	13h00	t
61	1	WEDNESDAY	13h00	14h00	t
62	1	WEDNESDAY	14h00	15h00	t
63	1	WEDNESDAY	15h00	16h00	t
64	1	WEDNESDAY	16h00	17h00	t
65	1	WEDNESDAY	17h00	18h00	t
66	1	WEDNESDAY	18h00	19h00	t
67	1	WEDNESDAY	19h00	20h00	t
68	1	WEDNESDAY	20h00	21h00	t
69	1	WEDNESDAY	21h00	22h00	t
70	1	WEDNESDAY	22h00	23h00	t
71	1	WEDNESDAY	23h00	00h00	t
210	4	MONDAY	17h00	18h00	t
211	4	MONDAY	18h00	19h00	t
212	4	MONDAY	19h00	20h00	t
213	4	MONDAY	20h00	21h00	t
214	4	MONDAY	21h00	22h00	t
215	4	MONDAY	22h00	23h00	t
216	4	MONDAY	23h00	00h00	t
3	1	MONDAY	02h00	03h00	t
241	7	MONDAY	00h00	01h00	t
242	7	MONDAY	01h00	02h00	t
243	7	MONDAY	02h00	03h00	t
247	7	MONDAY	06h00	07h00	t
248	7	MONDAY	07h00	08h00	t
249	7	MONDAY	08h00	09h00	t
252	7	MONDAY	11h00	12h00	t
9	1	MONDAY	08h00	09h00	t
253	7	MONDAY	12h00	13h00	t
255	7	MONDAY	14h00	15h00	t
259	7	MONDAY	18h00	19h00	t
260	7	MONDAY	19h00	20h00	t
273	27	MONDAY	07h00	08h00	t
274	27	MONDAY	08h00	09h00	t
275	27	MONDAY	09h00	10h00	t
276	27	MONDAY	10h00	11h00	t
277	27	MONDAY	11h00	12h00	t
278	27	MONDAY	12h00	13h00	t
279	27	MONDAY	13h00	14h00	t
280	27	MONDAY	14h00	15h00	t
281	27	MONDAY	15h00	16h00	t
282	27	MONDAY	16h00	17h00	t
283	27	MONDAY	17h00	18h00	t
20	1	MONDAY	20h00	21h00	f
5	1	MONDAY	04h00	05h00	t
6	1	MONDAY	05h00	06h00	f
4	1	MONDAY	03h00	04h00	t
7	1	MONDAY	06h00	07h00	f
170	1	THURSDAY	01h00	02h00	t
171	1	THURSDAY	02h00	03h00	t
173	1	THURSDAY	04h00	05h00	t
174	1	THURSDAY	05h00	06h00	t
175	1	THURSDAY	06h00	07h00	t
176	1	THURSDAY	07h00	08h00	t
177	1	THURSDAY	08h00	09h00	t
178	1	THURSDAY	09h00	10h00	t
179	1	THURSDAY	10h00	11h00	t
180	1	THURSDAY	11h00	12h00	t
182	1	THURSDAY	13h00	14h00	t
183	1	THURSDAY	14h00	15h00	t
172	1	THURSDAY	03h00	04h00	t
217	15	MONDAY	00h00	01h00	t
218	15	MONDAY	01h00	02h00	t
219	15	MONDAY	02h00	03h00	t
220	15	MONDAY	03h00	04h00	t
221	15	MONDAY	04h00	05h00	t
222	15	MONDAY	05h00	06h00	t
223	15	MONDAY	06h00	07h00	t
224	15	MONDAY	07h00	08h00	t
225	15	MONDAY	08h00	09h00	t
226	15	MONDAY	09h00	10h00	t
227	15	MONDAY	10h00	11h00	t
228	15	MONDAY	11h00	12h00	t
229	15	MONDAY	12h00	13h00	t
230	15	MONDAY	13h00	14h00	t
231	15	MONDAY	14h00	15h00	t
232	15	MONDAY	15h00	16h00	t
233	15	MONDAY	16h00	17h00	t
234	15	MONDAY	17h00	18h00	t
235	15	MONDAY	18h00	19h00	t
236	15	MONDAY	19h00	20h00	t
237	15	MONDAY	20h00	21h00	t
238	15	MONDAY	21h00	22h00	t
239	15	MONDAY	22h00	23h00	t
240	15	MONDAY	23h00	00h00	t
244	7	MONDAY	03h00	04h00	t
245	7	MONDAY	04h00	05h00	t
246	7	MONDAY	05h00	06h00	t
250	7	MONDAY	09h00	10h00	t
251	7	MONDAY	10h00	11h00	t
254	7	MONDAY	13h00	14h00	t
256	7	MONDAY	15h00	16h00	t
257	7	MONDAY	16h00	17h00	t
258	7	MONDAY	17h00	18h00	t
261	7	MONDAY	20h00	21h00	t
262	7	MONDAY	21h00	22h00	t
263	7	MONDAY	22h00	23h00	t
264	7	MONDAY	23h00	00h00	t
266	27	MONDAY	00h00	01h00	t
284	27	MONDAY	18h00	19h00	t
285	27	MONDAY	19h00	20h00	t
286	27	MONDAY	20h00	21h00	t
287	27	MONDAY	21h00	22h00	t
288	27	MONDAY	22h00	23h00	t
289	27	MONDAY	23h00	00h00	t
290	31	MONDAY	00h00	01h00	t
291	31	MONDAY	01h00	02h00	t
292	31	MONDAY	02h00	03h00	t
293	31	MONDAY	03h00	04h00	t
294	31	MONDAY	04h00	05h00	t
295	31	MONDAY	05h00	06h00	t
296	31	MONDAY	06h00	07h00	t
297	31	MONDAY	07h00	08h00	t
298	31	MONDAY	08h00	09h00	t
299	31	MONDAY	09h00	10h00	t
300	31	MONDAY	10h00	11h00	t
301	31	MONDAY	11h00	12h00	t
302	31	MONDAY	12h00	13h00	t
303	31	MONDAY	13h00	14h00	t
304	31	MONDAY	14h00	15h00	t
306	31	MONDAY	16h00	17h00	t
308	31	MONDAY	18h00	19h00	t
309	31	MONDAY	19h00	20h00	t
310	31	MONDAY	20h00	21h00	t
311	31	MONDAY	21h00	22h00	t
312	31	MONDAY	22h00	23h00	t
313	31	MONDAY	23h00	00h00	t
307	31	MONDAY	17h00	18h00	t
22	1	MONDAY	22h00	23h00	f
305	31	MONDAY	15h00	16h00	t
\.


--
-- Data for Name: Sport; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sport" (id, name, icon) FROM stdin;
1	Football	\N
2	Basketball	\N
3	Tennis	\N
4	Padel	\N
\.


--
-- Data for Name: UserBadge; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserBadge" ("userId", "badgeId", "earnedAt") FROM stdin;
\.


--
-- Data for Name: UserEquipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserEquipment" ("userId", "equipmentId") FROM stdin;
\.


--
-- Data for Name: UserSport; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserSport" (id, "userId", "sportId", level, "position") FROM stdin;
\.


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account (id, "accountId", "providerId", "userId", "accessToken", "refreshToken", "idToken", "accessTokenExpiresAt", "refreshTokenExpiresAt", scope, password, "createdAt", "updatedAt") FROM stdin;
YLidGa2ByLz0RjOp942AvgsRhnPyXqu0	irHVfUitjRkBPmWNBtaN6inoYdOZi0dz	credential	irHVfUitjRkBPmWNBtaN6inoYdOZi0dz	\N	\N	\N	\N	\N	\N	c938fa10839c9bab1504d18c5cc82333:d24aece49d1de63b75483cb3536131df0199d733682fd012870734d9ab319a701623eac338e3bd470d007cc65e42011dc0d22ea55518db16d5449eaa3f72c45f	2026-02-23 17:12:19.704	2026-02-23 17:12:19.704
o3qSwVTbyR2N3sgD3REVTnjoiyziZaEy	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	credential	IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	\N	\N	\N	\N	\N	\N	575dfa0a7ce82ac70817a8007b0eee84:c469c6a241557ae0d8a27acb72789ec1179b394d62ced055afc4a60424b712e80a38af066dd0e5ccdb63a8611fdffce8e629c1498e3a46ce984561b7e98f8693	2026-02-23 17:12:54.374	2026-02-23 17:12:54.374
mp7m5PodQAlKryHkZzQb73GWD5eKUOPX	3Q4Nh0nogv7CAaVWgAnA2iKitJjm22Ha	credential	3Q4Nh0nogv7CAaVWgAnA2iKitJjm22Ha	\N	\N	\N	\N	\N	\N	2026ad4b4a7272654a3d832a426938be:3c1fc642ab9e73a6e56ff319b2b6a2aa1c9841a151ac285ee2a1e703754a511cff599f6626d3d4c70905ab92c669c1fea560486afe78b0224b100de6d28499b5	2026-02-23 17:13:27.937	2026-02-23 17:13:27.937
LluGNzFTO5SEto6WBME7QisM82sjlkOF	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	credential	rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	\N	\N	\N	\N	\N	\N	a8b218892979ef82de874c98b54d58cc:e71217fa4c75ca0ef9cd6d75d9976beab6d7a111c906c599148a6d250bafea6174f93bbfa0e9870bc48c52b382ecd38279be73ac124f584a361763c93f5087cd	2026-02-23 17:13:54.932	2026-02-23 17:13:54.932
wmc7iJaVVplU0y4flo5kboMe8OGkDac4	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	credential	ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	\N	\N	\N	\N	\N	\N	98daefbbd181cd628aba6d5d782221b0:c2fcfb1521f68644c7c2755f2c68027e4d975354ee116a32c01daca6ce2b9e460cdfbdb265994afb18de0fb501af067f50da86bdbd9639d598287ec84b5c7968	2026-02-23 17:14:19.688	2026-02-23 17:14:19.688
ALw7lJ87gucsrZwqPafeXk3BsXnOG6ny	Ubb6EGrM2c4GyOhTn1ESKaKpfYbG7xSC	credential	Ubb6EGrM2c4GyOhTn1ESKaKpfYbG7xSC	\N	\N	\N	\N	\N	\N	a9e6b60ddbf74c69d19d8287774803e9:d634798063e765d9068c816dba5d7d68fee06d10ec7206f8a862cbeeb3ed7dbccb0c78b3e6e09623a28048d4b470152610ce6a15537f8976aa2e50bcb980a7e6	2026-02-23 17:15:11.195	2026-02-23 17:15:11.195
6G5DVgdLPqXvVOPzFH4mNE6J2nr6EYgq	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	credential	O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	\N	\N	\N	\N	\N	\N	4e46807af397fdd93bfd903298d17ad7:7b662972ccfb71e9d6cdfd63bb9c89fc2323bb2bc31bbe9b65532fbea2c460dcb1ec60ef8116280698fd07cca2c1d9fd838de9d8cd402128f618c1534f87accf	2026-02-23 17:16:14.512	2026-02-23 17:16:14.512
8qJjuECW6RLEu0X5Cl1HvfnYb0TNtzbl	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	credential	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	\N	\N	\N	\N	\N	\N	fe5da8b54a40d2c51f3425308b2fd06d:af45d77a2f34085c3dc0e33b4c81f4550d6a4bf00125ccf38115fa86b17c7aea4282e870c6fbbce6e22ffd090989ba98562eb33a5aa245f16a29a5bf5999a70b	2026-02-27 08:51:34.593	2026-02-27 08:51:34.593
04UQByjWv5PpnL0nClKNNTmabyoLBIB8	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	credential	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	\N	\N	\N	\N	\N	\N	6572960a57744af15f4cbe35e98560f8:865d45adf46a2a0de6a91e15bc6e4ac1a4e21d4633540fa2f6dbbd91cf42bae77a38e9ead65c4ec0b8d419c724de51819401771dd404304a590be61f9a64baaa	2026-02-21 17:53:21.762	2026-02-27 11:02:09.432
ZvmIUroPpHgQM8HWc8x77uAMGVkA3oyH	99YneHrHAILof7dvLAUZk2hbzR6U88N9	credential	99YneHrHAILof7dvLAUZk2hbzR6U88N9	\N	\N	\N	\N	\N	\N	c6cc938d975bfdb7f90015e12f3650a5:7b76bb8002a9bcf6c84affa98ee48bccf384f388cb975122f1fb430a0c91299b957a9105459862993d1cc753a1ef89ff1ceda8cba3aa600dd5b2d0cfbc9648c2	2026-03-02 08:24:12.18	2026-03-02 08:24:12.18
IEMkLfnHWNIWgOCTWtfZRNqRISwGErq0	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	credential	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	\N	\N	\N	\N	\N	\N	f07df42fbd7ac0921bd6ef67090e0189:1047f6223bcb552ee279af4e64ad8b38e2ce10f9a34a2943b151273892058d71fdcfc82cdd3f3ec82b54aa11583cf32d63842a7856e716986783b1058224ef3f	2026-03-08 16:00:52.886	2026-03-08 16:00:52.886
aYnnfXxF5vTHthKFaN4zKSSBBI4E5scl	mBA4Xkqq9JEuK2myGtaYqFqRsjpP93ey	credential	mBA4Xkqq9JEuK2myGtaYqFqRsjpP93ey	\N	\N	\N	\N	\N	\N	a127dd58514c1a8b340a97f4c7d32f8e:1e46a9731df4dfceb9363e68162cf06306e77fa33cc2b77efb8a89adb7c3ed914edfb48671f4686cbaf12e24da589005fc867b18ae0f1c6592f02a7841942707	2026-03-08 16:01:29.829	2026-03-08 16:01:29.829
BghzSOR5Dv2LoeC40UH8O3nEuCiukwzX	54U9K5nz949C47LxepSOHVJqigCoAy2e	credential	54U9K5nz949C47LxepSOHVJqigCoAy2e	\N	\N	\N	\N	\N	\N	d07e096b11298133349b1c63b43649e2:be3d5f71e370477ab4adab2c1e5031b8ffd39689370e82830e8d7302fd12450926e53289988d23473091670d8597d916cc8488f3aec5ffe88291fad474ddb8c3	2026-03-08 16:05:20.221	2026-03-08 16:05:20.221
TsVFfNCe4ArDOKWiURgDVpW4fKjkTMOS	6zuuUAYiMaL0DNTuh37xy6W08xWuMUEf	credential	6zuuUAYiMaL0DNTuh37xy6W08xWuMUEf	\N	\N	\N	\N	\N	\N	269cfe73eb0a36ce29e502321687078b:c18d6705a52382ae321e2df51ff90dcd8e55af959e97cc5dc2c0f1115f4f8142bb2f869a37e5cccf4b26e3140ce3a1358d2e3a1b4287e98b680e4afaf23d0799	2026-03-16 14:49:58.996	2026-03-16 14:49:58.996
ZZoYntPd6kIzTlhIaKU3wft7uQX0fsHE	f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	credential	f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	\N	\N	\N	\N	\N	\N	4c01e8ac0a0e4ca93953c7a63f60dd89:2b6678df097220c9eeb447749b3558b8a2c949925b449e8e5c150b5e2419782ecb9e6465e517d926ed2bd582e8500893a6507f5df9f7e7d85dddbbc91b519509	2026-03-16 14:50:51.91	2026-03-16 14:50:51.91
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (id, "expiresAt", token, "createdAt", "updatedAt", "ipAddress", "userAgent", "userId") FROM stdin;
6Xg56KgnSeOxgD17LEZVB7j5qeLVsmYs	2026-04-29 20:31:33.473	KhFOhjq3Zf2z1XrhQHlfri3fYoC9TQUP	2026-04-22 20:31:33.473	2026-04-22 20:31:33.473	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL
BqOsLRhxLZjl7NV6hgqftjQx3Lz2KoFH	2026-03-29 10:04:27.238	9caJ1G8tC70dsSPXQ7L5wRtRjTNl4lNB	2026-03-17 08:59:01.077	2026-03-22 10:04:27.238	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC
43WwC87xxrw0RGdgxf4TauoYbwI4N9lV	2026-05-01 07:30:04.385	8awPMSWAx0esqK8ardCvR6kBCS97CBHv	2026-04-24 07:30:04.385	2026-04-24 07:30:04.385	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL
CwK6Ry7Tx2jo50xXOgDcisFZ7JTwww56	2026-05-21 17:32:52.063	yJP7m2swJgfvp19rkv5YXuddQz4QUQhh	2026-05-14 17:32:52.063	2026-05-14 17:32:52.063	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.120.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL
CD2AbHlGze0WOPpDmKeB4fgxHvxbSIRQ	2026-03-11 08:48:54.521	KjYUEggtISHCfal4D5JrLjLgFBpwIiBb	2026-03-04 08:48:54.521	2026-03-04 08:48:54.521	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC
h4ASIdc88X4rjcFHqiNjVhxYY069IAeh	2026-05-21 19:58:47.617	iwFvxWSN1xPaEaFC9L09UxSxbisDjJOg	2026-05-14 19:58:47.618	2026-05-14 19:58:47.618	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL
bsZSyTyNvcZIKVaaWyekwrNrWep0Y5NS	2026-05-21 20:00:16.735	3HP05hjWySRiv1QHBn7Bn1mD6ENfcHqJ	2026-05-14 20:00:16.735	2026-05-14 20:00:16.735	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL
yeSHZUzdCNhNPm4uoPG9ZJxpU5arMWXT	2026-03-15 16:07:35.13	NMehir5rYajVU582Lqcxwp5EQE8wkMIF	2026-03-08 16:07:35.13	2026-03-08 16:07:35.13	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, name, email, password, pseudo, "photoUrl", age, city, bio, image, "createdAt", "updatedAt", "emailVerified") FROM stdin;
irHVfUitjRkBPmWNBtaN6inoYdOZi0dz	John 	john@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-02-23 17:12:19.692	2026-02-23 17:12:19.692	f
IqsSmFAm7iWKhgRubcwRtQf1R7g6AqtE	Adyl	adyl@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-02-23 17:12:54.37	2026-02-23 17:12:54.37	f
3Q4Nh0nogv7CAaVWgAnA2iKitJjm22Ha	Anas	anastfr@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-02-23 17:13:27.933	2026-02-23 17:13:27.933	f
rPdy53TpLDoXE7PYMkZuMfVR8xqvI3ht	Houssem	houssem@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-02-23 17:13:54.929	2026-02-23 17:13:54.929	f
ubifJomQgU2Qt3FPGnsD4M1aM59qSDdJ	Evan	evan@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-02-23 17:14:19.685	2026-02-23 17:14:19.685	f
O7WWVVpFP8sLulf6M2GQ6MkyHaykyRV2	Paolo	paolo@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-02-23 17:16:14.504	2026-02-23 17:16:14.504	f
uc7y1cWlf0F2YDmOzUXDv4luv1GFntWU	Ibrahim	ibo@gmail.com	\N	\N	\N	\N	\N	\N	blob:http://localhost:8081/df8947e1-e12c-4cf8-b96c-ad8a69249552	2026-02-23 17:16:40.862	2026-02-25 13:46:43.819	f
LAOUs8sVKc8F3zK8pCOKVX9RCxeoraXY	Kobe	kobe@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-02-27 08:51:34.587	2026-02-27 08:51:34.587	f
Ubb6EGrM2c4GyOhTn1ESKaKpfYbG7xSC	Timothé	timothe@gmail.com	\N	\N	\N	\N	\N	\N	blob:http://localhost:8081/b592b773-b992-4bb2-9371-94ac3e8582d5	2026-02-23 17:15:11.189	2026-03-01 11:27:02.837	f
xTS5GJd1XoDCI9wCOJmnodw4nvwx9SwC	Aymane	aymane@gmail.com	\N	\N	\N	\N	\N	\N	data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wgARCAKiBK8DASIAAhEBAxEB/8QAGwAAAwEBAQEBAAAAAAAAAAAAAAECAwQFBgf/xAAZAQEBAQEBAQAAAAAAAAAAAAAAAQIDBAX/2gAMAwEAAhADEAAAAfz9p/Q8rAsAAAsGmNp02nY6mrGDsbTpsdgx0MaFKh0qQZSDdCqrki7uM9L0yzvXTLB9DjmfSHKdQci65rmXTNmBsrMylUpqpi86iampVKkqSpgIaEmqUtUOXX6h+XfpH5v5+2MXHo5SmlSallNCTQgIAFeueqd37X+Nfsvi9Pyv5p+k/m3XmVz+p1x4iczQBIA4VJl1FlNOmmCTAAAZCYxDBDFGmjarQudehNXY7VaDQMTACgAAIEwSaPnHNeHswAAsALGANp03NWOpqxtVqNqrGx2Aym1SFKh0VBRaFmkhb0yWl6ZRre2NZ3tpjWF9GmNch2NeJdyOGe6Lnijtz1njz68t45o6c95wnWNM40jUzm1bKoqClSVISaWU5RS1aa59q/afnn3fwfHpnFz35wqSyqkU0olMVJkJjHtn0H0X6h8r9V832fI/nP2/w3r8+frePe886aUBwmMTbClQ2mMAAAGQAAwAAExQHTZepQq6Q0VUwVMkLExgAAAIaASM48By/F2oTACmIRuXTctG5epdRVXU1rNVN6jadgxoUmOlSVSuHauHrOuZWq6MVbPfnVu+jl1jXXbn0xve8b530teWeyTjz7s7ngy78emOHLux6cuLPqx6c+bPoz6Y542jUxjWNpmptSc00IJcBJNAFr9jyPoca7Pjvp/l5qJueuJmkspqFNTKk0ICClRp7Xk/rPHfr6Lm+d7fzX5rq4/qeHOaqsxvNl0EuiE2xNgMYhgmAhqVgDEwABgDTsqproq1Opo8pNpyI0eVVteWujEDEDTQJyTlWceI0eLs3LGIGBTEI3LqnLsqoqy7zvedLitZtqrBjBlBRSO5qL0nTMvaNsNOnPo56veenj1fSujl2Wxvy6Z69FY3k9ajDPsVedHpc2pxZdmW8cOPbh15cXP3c3XjyZdOPXlz575dM45656ZzcaSnNEuaUtWymgadV9h8h+hcenyfh9fH1zKc6yk0qmplU1MqTQgIdxR1ft34j+3eP0afG/Z/mvHp8nz64/R8iAlGPNGMTHCbAGxMBDBDIQCiAYiG5ZQimIs0vFbWZkWQRZFFVGm5tc30AAAAAKKwEmZeGNePsMKAAaYAIAU2mjqXpdxWs63nes6VFazVTQ2qR3No7V5VtGuWm0b87r0ZdXLpr1ZdXDtpvO/Hte03x6JtwWqpiVNlVx8/o8es8eHXh15cXN283blyY9OPbjz5b5dOeGW2e5jGuekRcaTNTUpyqBU6miv0r82/TPP2/MMtcvTyhNCQhJpVLUqTUIEO87jp/afxb9Z8vf3PyL9c/Gee/Lz0z9vmQE02nDaYxMbTBgMCAAQAgJUmgQopwFkC0ZhZmFvNluGl1N7laxt0XSe4AAACIIikLQuPnRnj6oYIYAAMKAEYMGq0dS7NLyrWdrwvWd3ndl1FpVxcmmuWsabY7Ybb4b89dHXy9nHr09PP1efvv0YdXHq9M9eemyqTdEqypGqWO0nnY9HP15c3L18vbly4b8/bhllpl1555aZbznFRtMVGkzU1KaVTSouLOz9A+K+w8vo/N8tcvVxhNIkxZTQppSymhJkqqXHT+jfm323Hf6H+X/qHxPl7/nmXRz+/zIBWJw2gpqgYwYABAggQAAqTmEkpWSDUzLRCLeYavN1pWd3OumW3WabTp0DTsAAQgzsIpsBo+dA8XUAAGAygZYhgmMGOxsdFJ6jqaS7zvWdLztNbztnXTLTLXXHXLo35+jlrq7OPr49ezq5erh6Onp5+vh1nSbxXU3VUqpDKgoM50g8/m6eTrzw5Onk7ccOfbm7cM8ry685yvLcmKz2majRS0KaVSNUVNH0P0HhfR+P1fnGO+Ps8+aqRJoSalSaJTQk1mjTXT3/n+nN/cvL6ur5vs/Dub3vE+n4sRgmOExjaatpjBDQoBEMQoIhSRKJJaQoUtQk0o00dS9LuL3nXqw7O2aaegANACaAAAATR8+M8XVDdibdIoqSgkYiY6G2AyxidOopLvO7NLzu50vPRNNM9MzTbHbLfo5ujnrr6uTp4de3r4evj37PR8r0+PWy1jRQxgwAoGrFF4HncuvL1548uvL245c+nP24zlWXTCzee4Q52UVOiloSFQhFXndnt/o/5X+seL1fjnP1cvs4RLViTUqTQk0KWRI1Kmhb359I/Ufqfyb9T8Hq+Z/OP2/8AG+3PzZ0j08fQ87o55Rpo6lq2kMlQySWiSKJYImVZuJWkFCATUIBQHRavWXrPV1l7D65AFZJZQiASKSYABBGXkFnm3Lp6iKdQUiQFQEDApp2MTEMsGmVUVZpeVs7aY62a6Y6RtrhridO/Lvi9nTxdXHp29XF0ce/d1+d0cevtnJ189ukwAoABCDzOjy9SeXTl68subTn7cc8NMevKMtMumYio3FDnQkWhLkEISatdRaeh+q/ln6d4/T+R4b4+vz5KppJpUmoSapJqVJqENSuoZ0/SfK7S/ufxfn/f+L0fimHseR7fPAIbTG0DSIJJlZKinJLRAUlKkNQCJWIGmgBoUr0NDbpmutX2gBRBkaVio3nAjYzuy2i2oUwS5xOF0YsunZJSWZuCBrNQCgEU5dNpowEGnTaaVcVZredprpjom2mGmZ0b8uub29HDvz16HR5/Rx6eh0+d0ce3od3kdGOnt15HVnXcsHLssMTs4ebmuawXN0w+Y5+vJc9YdeSyeXTBBnuEONQkWiQrSXNAIEIdS67P138b/W/J3/LOL635Pvzymo3kQgTCVSJVJZGpUBCaB6Z1HR+p/lH1vLfr/n37d+TY34s6x6OSEQxA0ISalSc5rEoYhQECFKAQADAoZeotDbcOwvvlgUS+eJzmOdszcaVn06j0jPTQgLQpBBmcrTzoGrAAU0lhWiFopYKUIBW00bTsGmNplXFXN3nSa3lRrpjcm2vPeXVvx7Zvdvw789d+/Bty36G/m68+vo3wXnXccZL1xzwb5ZY6zfOsunMwMenMxM95UEbyQRs5U05JpyTTSKaSGkiqhm/6P+a/ccOt/B/ov52uM1HfkCYFMhahjO2cuaqZUBAAo0Rp0clr+5ZfFfoXz/T+LcH7H+T+vjw+jw+30x4KasScyiFKS5zQCAQNCVoAQQwKbL1CzXpDsWnXLaegjng5jPnWpWFUuits8Hto4tHpWVMTkBmZyNE02nYDZBZWZaiJtEKlLIyVMYMLBpjaZVKrHSbNNMu8rjW8dI30w0k6NuXTN7NOTTF7NeHTGu6+G867TkcvTPOGueedl5RnvFZLPceajWSCdCBaJE0IlRCoSBpJWkDcBr9d8b6XO/pH5b+1fnvn7fI57ZevgmqL9z1vX49Mq+Z9bnrwfE/YPybrnjm46YSaUEoYkrrMjp+p+PrN/ap/HfsuHXxeL9p/Nt5+TjfHtziXECJzppENIVgQAAmUmAUVRotN5rsnXvAJsqccY0xmOenAsAA0Jdl1NaV1Q9xSCFKswGScQE26ikupqhNIppLM3JM2llUQmMTKJLZFU7FTtJqqsh2yKtxOjuQt3C0VZlXmS7Xz1HRXM5eo53G6xDSIiriYqs1OoQToSTRIqJEqQgQhCSghREw1MrpXPUv6H9t+GfrPk7fB+T+y/A9c/Lfc7+ll5fwKx7Y2fO+mPuD4/wDR/P1/Mstse/OUKUQoEKUEpaJJdOjktP27q/OP0/yd/wAX4P0f4L1cfOz6uWyUEoBADAGAFIbE29Qp3uHWa9YzLnN+eIy0iZxaSIAIGVYUXouqZ3m0hG0xtVIMDgAzsaChFlOQslgmqSaEMlTGKlQ2Vclq7CigoqCy5E7qIqgKTkbThiQxKKeYavJmhmFSpHKm1yppyTRIqSFaIUEtCTm0QoEKVS5VQTjScEu3q+Nqfu3R+R/qvj7+D8Z6/wAV6OUZk9+brOjX7v4L3sXn8n7f4is5c0SLNEKARKAiqzo3+9/Ptz93/I/0nj8/T5v4j9j/ACLtjkWi1mCglsE2AN0iq1Jda6T1uOkvmjOKmZxaUmTEwYxOqqa021nO3OohiDdEuhFQ4Bh5rRnbApiaMTpiYxFAAhskYFKrHatBthSpHc0XpGmVVLhghoSNJDJRTkKEiyQsgKlIEkokqETQhCTSoECEJEqJTm0oJpxUxEaRnUpkpcNN/c+es/Z/yT0fp+evzybjthOWadXHvqfoP51+p/lnLeUuNRIJUBAAIYJtj2y2s+4/Q/x39l83Xn/Jf2H81r4yds/TxhWllsEMQY6G99w2wy00yU5EixUmSpjCirlVV6TstbK0q0iNZjE1VkjBDEE0osePOmIVuXYySqJC3mWaEBZDLcuyhOnc2jpOnUuSnLLvOjXTG41MyNDNGswykkNCRkhZIUSDSS0pQ0lTQgSQ0JRCoTQpcQSomhJY00iWnNQ1TMo6Ucy3iWGKtPt/hdZfofnf1n8ujjNZ3lb5bWfqX5T+k/nHPfPFxqSBmpjEU0l06l0xaTdnR+x/jn6fy39L+WfqH4xz3wZ6R6uElIQ2S6ekXcWOWgTUTNTKk1nQDgb1si+nSzlrodmGt3WjHERpkiQqYhGhUef0fO8u1GZ5u3siPX5mIGhUxAxAxFU5Etw9NHBZreNWbPKk0ebTR5utKycbXz3Gxk10MyNDNpbhrSRDEWMSKEAhAhUIQ0kNJK0KmhDQhZ3MucaRnUqlnQMhMcNpxTl04pGcaQTSF+s7fif0znr85j0vL64u+fSvufiPqvlsa58+mN4wNDNh0QnRSbAGIXN1r+ifnf7Tx6eH+afYfF6mctdMJopsuylmUxAAoAUKXjnWhzYc99k8ZnXdv5aPrb+Z9XWO8zveG5dlEqwhxQhUDEQ1WXzP0Xzvn9CTXDt7SD1+UARAlAFBFjAGBY2iyhFVUOzSs6s0cOyyQpwGjzcaPNmjyZq83GrzZZJFOWMGIaBOaScghAhAmqE1QhAggQSqaFzLUsFEsprJkktkpbIByJEmlfRzUfo3556XuYvyFuuuftPjP0X8856zmp6YlUpZbUAAMEGmruLs0/afyH9b4dfzf53bn785QkBA3LpuQoljEIIxmuMivN2ck50xARUg05Tt4lZ9Tt8n9D349iR05JNaiBiGqE0R8/8AQ+Bx7cia8vo9ka9nlAQJqVJoGqoG0QyxMKYAMLHUuy3DqyWNyDcstxQ2nDqWVUUlVDLqKigATkJc0S5BCAFQCBACECEAAAAmpUmlmbWUK1LBSlQAACAlGir+7+E6I9Hh/QvgbP0r8y/UPzDGsZqeuEmoQEqGCYAxj1j27PZ9H6f858/X5vHXL0cpTQIAAhiLW0I0Aed0cvHrKqOXRiJW5BggQpRCK7uCrn6x8+3t8rBXLBDQUJyT4HvfOcO2Q15vR7SpevzSmCGEqgmyxGhZmtVWbsSSyodCSU6lspMQxENpjqaKaY2qBphUiXWdGhAlzKKUKqJRSSGhAkqZIUkDQAmhiAAlSaVAQlSiVSlkalQ0IYJjV3Fp+m/Dev6nPXo/n/2PzNeTFz1xKpQkwTCAYDKH9r8b+g419h+NfcfnWdRnUd+aQQgJUAAAwAwWHPaVTx6TFxKhE0xMYpGkQ0EFTVex6fzH0Xq8+zT7cQCkCBGEs+Btj5PSk3z37Q16vOpsILCCyptUMZYigTbSSysi0KirJLZlO0VkXImgq8mbPKy6hlCIbkKcOqcNGJiTQlSpJoJaRIKAAAAAQAAAmpUAomCVKJVESqUslBJQIbFao2/W/wAi+/5b5PP+gvN/Oc+jH0coVKVDBMYmMLXSd36Th6nl7/lHkdHN6+ERcCTUAOWS2kFFKdnL5K0w83e40WbmXEsgSiYJNABKAA0y+/z9umPo6l+3xtCBEj8L0fD8/dtPh3BOOvXyTpn3a8L0t462PfNFFJjsGmDApp0wBKhEx0MaJUGc6qso3kxWkA0Gl40amYaGbLchSlVbyDYyaaKSmhBLViAAAE0MQAAAgTUoAoAAEIASZKhghgAwaaafVfK/Q419/wChry+L0/lnk/qP5j7PNhOkbyhoGFMAv9A+A/TuPT6P4b7r8u49fn8tM/Z5om0QWLNXtE9c9JidKjOdc5fH8n3/AAOHaqk56WdKVFJUrZkbBgXMIBRpw7i95+kfPv7vHSWJXn8eXn9BDXDqNMYgyELTh2dPq+FpvPvvDo78EMsQwBlDQNyxuSKcMtw7LExJzQgSZpEKlSAGIG0VTkKQCABpoxOgBEBSGCGCGhDQAgBK0ECaUAgBDEQAAwAAAAYy/Y8ful/aPzP9M/HfN3/Svzbu97WfgI2y78pVJEAAOtPvvz/0ca/ZPyj9U/JuHXx4uPXwSaBqjTqjfNukQ5USqMfNzb49J4dc51yzqG21M0DVTA5AlyQMlTCKuK1PQ9P531PTw7vP7vFuedC8vpEyVMBAGQAAUNBt73zvr9efeD78ABACkNKAABABKxIusVqbzm7LUoaSGkI0Km5Y2mDAGnSYAMQGWIbpFCSUqkoJVIkaVDUJMVAQJpQCEAAEAAwYhgmAVNF7ZbL+2fkn6x+W+btwfrv45+xWfkXJ+v8A55vPz8659OcglZLL2596/V/y/wDWvyPh0551nvyzLCKeg+rHbNsUwYvCXi5dJ49ZYsaiE5ROWoudiI0kmSM2iQAUNoKEVTh2a5IG0SoRDEAJmQFAFDVC1zVn0teT6Xp8+onrABSacJgoIARKImFJFUZqzd4VWhAWpaUSVTljaqwYA06GmDTRgWNjsQykMEmVKpEqlLKZEjQgJRMEmpQAAIGAMAAAQOouNP0r81/ZePXzfh/pfhKf6t+TfpKed9p+M/U41x/Mfs343vOMXPTKYRXf5/Uv7b+QfrvP5e35EfrP5135eXei3iCpGpkvOYHnUy+Sllw7b4U86lBNAqglStuESnMAEAANMABiYIBBRJoiWwkpGACjTpuasE0OodnT7nznvduW4n14iAECiShiFEBGe6jnnpVc9OC6zZZLpuRNHF6lNMoToADnPP570qK5dN+vyXvHt153Z25bAdMAwSpEzaqFSJVTCTUqAlABASiaACGADQMQAEFzRr+1/jH7b5+/xHwv2/w/TB+hfnf358MTO8fsX516+/n7fAxs+3PN/Yezz38B2fpcZvN2fL+3z1wxw+n0z8XOePflrGCNsJqVa8d5us78p5+O/Pw7UqUqJFaRKSwSuIlBAADTABQCACwKZLlSsAYgYgxAoaB3DspUWQ2iujmqz3Oj5z2+/HcDphJoSalTAGEDAAZz49GZDpkO6rOtNDGtlZm6gfDjy8unVPO8btxUaVnQSpNtMOmyvR8xdMexXz+nXHuAu3ITVSqklNZJNKk1KAlAUAAAQxMAAYADBqjr/avxL9l83f4/4X7/AOA6Zj774H7lfjsevh1jv/UvyL9n5b/Jfr+/08acZ4899lc/QeBrvwdMeH7/AMz9LvP59m8+vO6x9CJ8/wBTkl5TZZ3hm5xrDOlz2XBEolaauWNM0azmBFTABKwKAIBpCgpIJQAAAAEMMQABg1VjuLqVpnYNBW+Ds+gfD3engJqxJqAAGgbTG1RMbi4PcTG9dDLTSzHPqLObwfe+X59UBy6FVvEW9k466OWyS5WtI2Lx2zTFaZV7HX4vtezzCa6YU0iZpRKaVJkqTFSagAlAEYmAAxMbTCky/ovnHNfqP5X+k/mnm9S+q+R6uPvfPrl38ev67+QfqOcenEPlZeXmWept5PSdHjdvn6x899R819Z1x+a5enzdefHpOUryU43Tic3N51jUFLNlUlxQ8a0lAJyAgEwQErEwAHpGlkS0IZKhMAAAAAxAGDBhY2maZXnYxFVUVXd6fnej34gGsIaEMEMUByFS6uoa3WdJpeLOi+ejeI5Y8DGp4eh0iWqhpprjadON2nIrm16RpLpltgiyuVv0fOfXn7oHt8qm5JmlEqpVJqVDUqVKEAoIkYMAYMYmMGnTac19n8L9t8P4PsP0eLtdMeX6PwIz+g8Ls5+j73xTw54+Hfzenhz0eXOn030/53+hezzeb7XD2enj8Zzb4deXHxvDG2ksbvOjN56gzq0kVheGNOs6loljSJRAMTBMEwACtKlpJQLPTOVAQxAxOgYYADc0UJggsaAAVVU6WdHr+D6nXn1AdeQAIYJsE2AMExjaY2mjuaGnK/KNV5vQ0EpSLLqdS9EmTHRWzpFy6Y7pOfPSFqp33n2Bv3eOFojOdJM1SllUlkZLIyJVKWRoGmNpo2MTGDKE6pr2vH39jx/U+U1w2x3+z+L/AEP8/wC/z8unB+b6Xd5s+d5709nn7Y8vXnERP3v5z9z6uHu78/R6/P8AF+f3+P25cpWPLqSTjVJKEglU3jLMNY0VLlYgaENzUDCgAAYmVY2mCEE1KymZIAbVhVFcYwAB1LGmVLENDR7c+9jqI1PoXF+nzg2IYibBFFIYDGJsBhDDxZro4uV8eqLjO2JwxUPfCjrrHS5rPW7OKtsJaqCXETW/Q876bvxmtj1ebFbBzx1ZrzTtBktZlhXKyqUJNSpMEMBqodGlQ9GRqtkejuVfReD9Hy7/ABXH7XneX6v2Hzk+tc+Fh2cfPrz+d2Y+e8+mMa8fpYcwk/d/EfQd+P2vf4fv+rh8L4XueF0xlip49WlObu8pzXFZL18ukpgms6AUrc1AmCaCxFMTsYnK6mrBy0YJVApQCAAe+d05TTlaagANBQAkyk0BcOy9+f0947ri/R5206ALATKFQk1Q5aW5qVgjzfKc+f0Dkxu0gYA2gpy401wpOvo5L1nbKLOY2ymspvPN6frfmvpvV55KXXjKqanPSFxjWDNVCzBIIUogEwgbqldaxG1amdasyrQRUOH7Hj6zXvfKfoXwvH1cPXXo+f6Pg8/s8M34ufVvy35uOtb8FvWrnz/Q34e/L2/v/wAz+v3j5Xw/Q83Wc1Jz0JGbTlyvO4idct7OcKzpZ6Zytp5AAhqqE6YAADqQHIAmIagGAFGk1NFJpzTpKpjErBAAgEAMCx+l5nodMenUV6fPTh2WpClxcedetl5zzru18+9T03x67xvXH0mmG/LL4jpeb0wrM3N6oms9AbZDYFMi9+WrLBJWbGpmiPV9z4/6f0cOhZnbjahF5qFM1jVZpQIBDayUyadIamwbGsTdsguYkFYOWNpn1nzenr8u3ys+drn0+7zdviYvPrOj0Tj0Lt5mJ7wY3MZd2Hkc7GW/P57krreMDfKVNOVoMl0YbanONZ0Z6RKAZAFMsqVoiRghqHIBU6VIAgIBgUqGN0qKTkE1RcjcsItRAFAA2qsjs5N9T2nL9XmYFHH1+RjTA57bl1prjt0yDdAKzTI5caM9MePRiJXebBVlHVGYtyqSryo315dlReTIklollel5b1n6J8O3r83QsM06M+VZ30Ll1s0Q9RNtE6qoejM6p2FxRrpzVHdXHR0TiGhnSU5qKqePG/S9H5f0Off5z2U8Xbzez5uvffPr12eTv2R5Hq8M4duGMYvrcPPzybzhPm67Kcu/HonHornXRlEgSm2V1iBmk0pUmQmmUIqhMABJqEMC5YgBOgRQPSbsQwVmqeY02mnRDihuaMlcA0xuasKkr3ax19PnpzyG/mC5dLc3SdLUeud6lOXqUJE8ekctmdLlsBK0A4qYGmOpooaG5Z2ZRtZzJEtiCkJK9nwezrz9LFT0wZ3GbLUaei1p15KqvUmqpINCs1okh0CbKGMGOChjpEX87p4/n9XXv5+t9P13zGpnlp567suh9D7SSsjn6PP6cXXyvb8jm4pU4OKWbrENHrD1Ogy1Iy3gzHEqAlAJUqUIYAMGAACVIQyBp0WrGwsBgqTBlo9YtPIaJu3FUZ64lOLDPVmN0WJWiQD0evzOnvynmDGgCV1L1LqK3KqVZTzDaY54ly+XRtqWU1AACahNMKlliYNIemYIqCyWMlD6Ofel04q565c9eYnNdHd5Nbz7Fzr25KnSS6dZrVJktPIl7o8ypfW18T1a3YXNOfGl9teDtnXpfM9XBw66zNc+lirWtPT8v1ZNwXecEnRxcnXnrbvzdMafPZ7Y8agIlhkXLrRtWOXI87jNEyaAIEwQEFTVNMEMEMEMBjC00GAwKYNHSsYknliqdG00rOpFUsvTO6pMslgZxvgXthWpoJ2AwGOxuXqUSUxELDWM6Q1jVSAgIQAACaBtMbQNOSkSul4WVFRA4Y7zDesb1Owy06cyW7INMj0/S+Y9Xty9SufPrz7TzrruObljPgS59HWbmtHmR6PR4a1PR8+TNt5rOshHPTaB1LNfW8j1V6kp7Xy6OThNergJfdnjnpeXD3vC5MhuySiJbZq1pZjOuUTLWdpp5oBAACYFJ0MYigRQktuk2xNtJKCQ0Wa0US+NHUsA5altU5octmbaStMtLLBUJoeWkk3npVNVrIx0MdiGJI0AEsqlLCqc6E1AmCABAMbFU0W1ROXRmZpzKNBTmzM1oypUITrbfm33zbmbKyaAma7ezxr6Y9TLhnU7J5Kl3lzQBDE4Q0IFK87zlQGaDYm2ldnH2521njdTntGZmN2d3KGN3j28ON40V34ItmbshWmjw2zlyVzjcscqGCGQDdJukkpktukNDL6Y5H1SYG/PE68+svbtyku/Fly1rBI6zDNhRUum0I5pDuKssToAEqRnQJo09RuaqmnYMLJm5EqUpGmc1KpZqKCS1EJoSalLgNRTZpeFmoAYbhzG8y5NBWmdGmemYAD35tNZ1lmsSXKwCBMBF2QXB0GGm5YyxMEAJZTRKZLLbhNupKB64641UXHm9Mq36fNktVqRarNpLXzejlN16vNDsrNaKIKmFFTmpU86xdksFqJdAmUM37l8rp+g2jzOjn4Jfa2+b5I+n83ytzTHXeuV9+JRjZycnqcxjpzZ1rOcmizCweomEoMsAdJuS3NUwaAMhaZpVRdOkWWx6gUJBaIVizlrnjUDFRTM6uCJ1mM1cSjTDXJlFVZmXBdxQ5qYyVITGtIAAQYjo1ze8Zq2YlAmOpVoSKErEWsVqUmayJkszojMslltiGJJSFtnsSWvL6mrn0eeZtVFOiZ0jzejoz1j0eeFRZMVlmuFOdAEtGnuy/Oz9jOb8ht9NwR43o70ZJqWeP10cFPzgUovs5yu6PJk9Dn55LiZBoKrKqqGyFcgV0GQywGUMYiiiLEmkymOgbFh1YIqVLVTVlVFamgNlJhM1nNSms2RpUxFJAKghWolUEAD0zouWhkhQgkpCbBDITGIbqtM9NZdlWTjtBDt2QrCK0mJFquR1o530Vqch1ynObwuYADEBSWTnLrrlpjel8+XPfq5edz6dVcNXPbXHdnS+fPn0754NNY6axZ6VeROb6nnLSWk5O3krA9A8vM78+YOjCKJ0lirHI6sqZxPrZlzdkHPVBOm8k1mjeuSDuz5CuicmW6op5szB6gMAYOk6QxENg2qdzqk47wZNgNUNzVaVnpcpCFFzNQqnJDSpUhMdMTErDOdZM1RCbYhhI1Dc6CfV0HmHpB5p3ZnLTyXu6fO1O+ePOzs5OLY16OLY7ThDsnBVrgTLv2ecHsPzNDvfnpe1cbOuuOjswhnDl6XPJy3fMukZaROfQo4+nSTd8vTVHUo576kYrXFW+TBPQPO1XonHmk7cedGo/RPLn28jy36NHlv1g8l+hmZ6PEtceZ2zyM6ZwDSBiNKMDoDmXTiQ9WYPYM9FIyVW1YWNhqNgDAdAgBQwGBT2BJkCEA2A2FlaBZKAlBnUoIECoAAKGBQEJBWYEMAACaA30CPQ6gWQBgFAW/PcgRmBBQBIAwEAEgDAr0QqgKpgMAYB5yCNMwMwIzsI0wCgCFQBoB7eoK/LA5sQEAgwhsAYHueiBpIESBnmAvnwMGAIA1AugUQBIJAA2BMgIAKCv/EADQQAAIBAwIFAwMDBAIDAQEAAAABAgMEEQUSEBMgMEAUITEGIlAyM0EjJDRgJUIVJjUWQ//aAAgBAQABBQL8HgwYMGDBgwYMGDBgwYMGDHW/Bpvl6cx99FD3mfUP+HIpy21b2HLu/PXFfk8GDBgSEjBgwYMGDBgwYMGPIvny9Kl4CLNbrg+ov8SXyzV1/e+cvy+DBgSEhIwbTabTabTabTabTBjrfgQW6Wt+1kx99GiUuZfn1E/7eXDVHuX+qIQkJCQkJGDabTabTabTaYMDQ0YMDXiWi3XWvy/ovwIo0Chstz6jn/VlwnUlOH5F/gkISEhISEhIUTaYNptNptMDQ0NDQ0YGhrw9Ljuvtfl9z76LC2ldV4xUIms1eZfS/C5M8V2n+CQhCQkJCQkJCQkYMGDBgwNDQ0NDQ0MY/C0SOb3XHm7feRE0i2VvaFzVVC3rS3SfBbdvnfBkyZM9C7T89cUIihCEhISEhGBQZyzlo5Y4MwYGhoaGhoaGMY/A0CHvqkt18+8iBT/bPqKr7S/AIzgz2I9l/gUIQhCEiKEhIRGIsLqaySjjg0NDQxjGMY+/okNtlXlvqd5ESn+2a/LN9L8BnsoXYY/wKEIQhESKEhEV0rpnEaGhokMYxjGPvUf6WlvvoiWst1sjU5771/iULsPivMXFCEIREQhEe2ySwMZIYxjGMfdXuX/2aex95EDR579ORdx213+IQuw+KXnLghCERIkSIhC7c17MZIkMYxjGPuWq3XOse1gx9+J9OTzQNcp7L+X4hfikIQhCIkSJEXBdtjGSJDGMYx93Slu1DW3/AGDH34n07PFyfUdP2l+GQhfi0IQhESJERH5fdn8skSGMYxjH3NEjm/17/EY++jSavLvzU6PPspD/AAqIL8MuK4rghCIkSJEh892p+qRIkSGMfB93Q/8AO1uG6ykPvogy1q862NSoenvJfhYr8chCERIkSJHvSfvIkSJDHwfe0qW2+qwVSnP2b8CJ9PVd1mfUNvvoSXG5pKNDwX30iC/FoQhCEIiIiREU3mPbqvEWSZJkhjGPv2rxcFX9b8BGlXfpbinUhVhOKqU7ik6NV8HVk6Pnogvxa6EIQiJEiREUpYfbrTzKTJMkMYxj7yLNZupvEJD8GLNIvFbXJ9QW+SQ/wCIxF0Poz+EXFCEIiREIixMpT7VapgZJkmNjGMY+/Y/5dx/jsfhRZpOoujKpTjUhf20rW4f4CKEuhsybjcZ4r8IuCEIRFkWJiYmJkKguupVGxskyTJMbGMfgUZbajWY1oOnUfhITNEuOfZfUdLMH5yIoSx0yZkz0RXDP4ZCExMixMTExMTIzaFWObE5kTmRHWJzbGxsbGxsbGxj8FFnPm2uvUtty/DR9P1+XeVaca1PUbSdnWfmIiiKx0yl1RiOX4lMTExMTExMTFI3G4ybjcZGxsbGxsbGx+GjQ57rH6iX9N+JSm6c6NRVqN3bwuqF3bztazGX1vyKvkJEVjpnLpXu0lTHLPR8fhkITExMTExMTFIyZNxuNw2NjY2NjYx+Gj6dka+s2kuvBgx24s0PUFS4ahZwvKNxRnQqkX6nTvHSIrHTKQ+iKcjco9CPj8QhCYmJiYmZMm43G43GTI2NjY2N+Lk+n54u9WoutZMfTZ6dXuSGi0EnotvjULGpZt9tM07V6lsWt7b3Rf2dO8p3dlWtXRnKjPxURRFY6GxyG+nd0xWE/w64oQmZMmTJuMmTJkyNjfk2Vf09ympLWrDkyfRo2nbi81WlRJandSlba1JFenTvrOrB05vtZMikaXqsoTaUlrNj6Wqx+IiCxxbwORkz2oxwN/iF15MmTJkyZMmTJkz4+RM0C+KkIzhqFnK0rYMGkaWtus6hyzJkyaBdYqfUVDE33EyLNNq86wuaMbihc0ZUKzH4SRCPGUzPcUdo3nuZM+HgwY4YMGDBgS7GTJkyZMmTJnycmSEsPSb31lC6oQuaM9IulOy0fZU1i7drQk+ilUdOd+1e6Q+6maHqCtpn1Dbb6VKk61atTlSqeAkRjjg5DfcSbPaP4jBgx3s+dksbqVrcUKsK9IravToz1W99ZVfQj6dq7o6hb+mun3UzQdR2yqwVSnKlK1vPqShis134rJFYG8EpZM9xRM/6xFml6hKzqUqsK1P6iobasulGjVOXqH1JH+o+6iJpN16uy1y2VS11Kh6rTpLvRjkSwSlgb7eBREsf62madf1LOpU5Wo2VenKlV6EUZbZ/Ucc20u8j6aq7bmcVKNCO2jqdHk3r7kYmcEp9xISEjaYHE2mPwq/KaZfSs6ut2quaHQiJrMN2lS7yNOq8i74fUP+c+0lkW2I593HBCXcqVIwPVeavxuDBjq+n7za9YsvS13xRE1F7tHl3kRNOq86xNanvv32dpnu4McMCF269faZz+CyZMmfxGDBjojJxcdmqaZODhJoxwiVZZ+nZD7qIGgTzZTlshXm5zfWlk9l3UhQNhtMGBLt15baX+ovo0K75Fx9QW2ys+KKs//W2PvRPpyMlS1y65VGT68Ge25RRzEKshXEE4tOPW+xP3j5+TJkz+TRpt1DUbS/tpWlfgivn/APPcMd1Fukrf6il/cvpSM47LHUQ6jHl9NvXdJ+rpEakJd6ss0v8ARceDRqSpVKrjq+nPgitH/wBc7yEWy222s1eZqD77e59qhXlBwkpdxlwsVv8AVtOunaXOuWajIRt3fT779pT5txdVVQt5ttvvVJYj3E2i3qcyn2mXX7/+rI0O5VWne2ztblFst2ivvI+nrfdW+oq2KUh96b3Pu2tTZU7dz71v9WRSnKlU1imrmwNK+/S5d1Gl2yuru3owt6Wt1N+oPvVZeBSlup9qfvP/AFZCNCmq+m1abpVtAlm0rrFXuI+mo/3HwXdTm3D7s5+DZT9uzVltj/rCNAr8q9163xU+n5f1dQjtve4j6bh/S1m/2RfdqPpfdi3GUJ749dSahGpUc3/rCINxcXC/sdJTo6lrcNuoPtosbSpdz0639Na6hPmXbH238fwh+DaTxNddzPdPzcGPziPpyr9t7Dk6rr9tvovt04OctKtXa21aapUKjy+vBt44FEksS/ni+9SeKvVXq7I9PqBVoCafk4MeBkz+JRoEsX+o0edb+1SF/bO1uX2UfT1vHYa9dNzl1YMEUKJy0ctG0wXdP3/7cH3189E5qCqXI3nsJ4dOsn/qaNFeNRI1Yc/W7bn2rH2I/Ogf/PNZf/IPqQokULoZc/tJZ4Pqx26Mt1PhUlsjUm5y7cKkoFOamv8AUEaY8XxeXEv/ACFjdwu6V9R5F0+xE+na3DV3/wAh1JEelsbK8t/F+DaS43cvbuwk4OnUU1/qFo9tz/NX93SqnLv/AKht8xfYRa1pUK9OaqU9Ueb/AKURF0NlSait7mN8fniyI+58FKtu4V5bqnei9rg90fAz+eRD2aeS9W28py2VK9ONehWpypVGuxE0v7NMrS5lTqiLixsumL2XCT6Yj725+DayzHwcmTP5tEVkgsQ1RY1Atpbra7s6V1G/0+raD60bNlizBgwYMCiJC4tjLj3qS/UP2Pl9L4PzYS2yTyvByZMmfzKNKsKMKWp3DtqupzjO+NKlu0621eSq/bUhrNh6WfVZrdcv3K9J0a2DabTBjjkyNj4V3/V3ZeT56UN/gaFbC3R/01FksWf1E/bhocv+NyaLe8upe0PU2rWOqjPl1YyUo1LejOrst7mF3Q9PcdeeM/3EfPZfgY8GNSURfHdfiVKm0zI3TI1pEJxn+EQiittH6jf3vhoL/wCOEywr+otNZo8q/fCMXKW0hRlIVrUNIlKNHUp7LLRJf1Negs8GzJkdRIw5myBL7TJP57T8DPhUXmn3cG02kljwKlTb0P2l/MKzIzjL8HSWZn1H+6+H0572vD6duMVfqOl7NCjk0mxzUen05XEcQVapKMLFypanrcsWekT23uvv+m5DkZMn6m3CBuIz2iqJp4RPgutIwPvZ8SnUcCnVjPwJ92Vc50h1ZPiuEj+eEZyiU5qaz+Aofun1J+t8Ppn9NVbapaVeTcalR59lCjKoadYR5ZOShFe6L6MaVbX5f2+ly/5D6i/ZbMmRZZy3GMk0+GcCb5b4vstfg6M98O9Je+DBgwYMG02mDBJqKq1XPsM/kXDLRnJCcoefTeHRqwr0vqNfa+H00/uvf8wXxby3W9taRp1UlGKzKVSKIVNzFaLfq3vp2m//AEPqP/GfGktqbHNY+1mCr8r9vqQ34D8N9NOeySeV3sGDBgwJGOOC5ea3Qomzh89CY/iPsfEi3nuh52jXnp7jWaPOsnw+nqm26rPdWIFlL+wfyUv0SSkbfvKspRjfPmaVp/8An/UKzaNGBe0lMlLL45zOP6eP8fjLWX2+DgSMGDBtLioqMOKQuCJRzwlxXCXxL3ikUpbJ+fG5dTQhstK07etNpzEWUv8Ai4yzAqVYUl/5OzIX1rNyuIRJ3dLbU99FsF/fa372soEok1hL9fF/EBfPGXwR+e8vHfz0Wv6vCyZ4zmoQqTdSQulcJrIuMeEz5iuFvPK87S/v0Zv7UsKwjuubulyrrJuLe+jG202o5Wd9qUt0qsVL11yTu60ijUp5pTcpY/4fTof3ms/syGVvaH/bhjJL9MPj+eLfuR768d9Nr491Fzo9hcGsPhHhP54r2l530+8wmv6b+bN7bnWobb7hX/xNNq/09W+yrCPGcMlvPmKhU5ulaev7vWf0SGTluk378MmfaA/1cG/CXQ/HRRnsl4z/AEi64ieB+/FcHw/n8BodTl3+oU+XcL3IPEvqCGU+E5rkafVcC9unWUH9/CTwR/d06WbHT/8AL1r9MitPHCXSv1S/U/gl5+O6uNvPdDxW8LqQkIa6FwY2LhSWanmYMFB8qtrtPF5+iaKy9Xoz4fpqU20qv66bJv2h+mpg3fdpT/sNP/yta/bZ/wBEN9Mj5GvYfmrvxFwhLZPw84J3fvVryqdiL44JR45MkyPC0iYMccGPGSEhIwXMfU6VUjkX2y0Kv9l1S5VxGJWZU+2VQjIbyRZVkRNL/wALT3/da1+xIqfbUb+3jEk88Ivg/HfXHwmR/T4VervfZQnxwTj0SFwp09kcGDBgwNeCjBgwYELjpX3xq03GdWnuVhW2V9SxKtP7Yzj9kpbhocTDPuOWzHtp9Wap2FROvq/vaSLiSdR9GeiDJ/PgLuIzwXeQvmlHdPwrqr3VIR8L9RKPshkhFBZuOp+BgSEjBgx06XPbd6xRxNolTUyrRuIU8MeW3H+pJYJfCfsuChvlD+nUp1J06t+1UsrmW2L9uxI/mT+7g/K/jgu6xCLb9Pgt4TeX3YkvjI5e80lNj4WEc3PU+h9tISEhIwYMdNOWyd4lXspIjHJb3MWtRioSowwofO3JXpOKjSeOVM5CHH2yqjjU+6nV5un3DbJ9iQvlr38BdtD6Md5Fp8deUjmwHWOcyNRS6qv7fDHQuOOlMz7fAz56NOwpdT4ZM9pISFESMGOzpdXfSu06RIcsm3nW7+eWthgpQ2dEqcZHJplpcQpVKWHCfYYh9rHhLqfdRadc6o3npjUOYjmkZJ8K37XYwRJi6f46U3F06m+GTJkyZMjY320IQu3b1OVV1GlCZQl9qqRcp1NtW7ntpw/T0zltjGSnEq05Tqxe6lL3NptHHrfw/wAfbfudNafSupVGitV3LqkIQ/l+/RAaP4XVaS+3JkyZHI3oz30xMyZM9aL3dU0uEZOc6Udrcp1f1y4P4mlUdLfGMJ7o1aqgUZfeKeyuvab9pmeDXVLw13Uuw+xSeKnR/HSuuX6/46Xwz1xkNH8dPw6VTejI30QeV3smTPXK6ihXk09JuObcKmrUUkyXvBV6hTmpxbwveu0sKtlVoc2I6eE2SrSExv7XPI+GRDRt6JePgwY6l0vpfUxdNWSUeldUnhRH4FP7oyWOpkZbZZyh8Hwi8S8e6hGlVKNTlVtRlC+pCuJQVKO6fLRyk+Mv3ySzGZJmTGTaOXvwi+OB+3CXjLsYI9p9T4QeYcJ1u7UYvBhLbJvcPgumlV2G+MuqPx4uouW5RY24tSyW9Z0KlVw3stoYqcZSUTdJ1Ybsx+a0NkpdS4RfFiH566n0PiuL4W7+wqzz3W8Lw9329KFwaKcty6Kc9pHDXa3xObEjJS7FVpQyezNhnhBYLb3415VElQ98SVWMOF0s05/PUuGeD+P485dzBtMCGuNB4lVl3pPPipZ6l854L2n0wm4ODUo9b9lVq7nngpNOlUU1xqV3JqpIjcSRc1t/RkyItP2uFR7q+Sr7wpS3wJLdB+6H89iX4h8V1NcF7DeX3H4y4Y6MmeHyk8rgzDPctJe3Xc1MvoT2v1J6intr193BPsItf2uFPPqZzEyi8VBsbTnIfUuL/AuSN2ep9tC7r8fJkfUin8cFwbItxdO5RzEOqc2RGsc6BWr+3bfWi1/Z4Tf9VmcG7C5rkbHIpzjTg/jqXBj8vIozZyqhKm4r3ZsPsiczwJC7z764YGu1/L40/njJ9FKeDJkckOaM57j60UqsYU985G2Q1JVP5Z/15kcKbm5RXLqfPZl5LYoIpOETmm+qVf1Slkwz27D7L4LyUY6pLrwYQz+OFP8AVwb6tzNz4p+GiNPl03VQ6k8yluXBCY/aUT+OzPwskYzmemrnp6gqMzlRRU5eEYkQp4J1FElVbMo+4wfajK8Jd1d2L931tdKExi4p4l3U8+Eio91vH4fvN9OMqm8xn+5jsvvUqFSqRsPb0lsK3t0LZAqXOCVySuJDqNijKQrdCgkbkipLJsRGjM/SSxwfhMXiPtJ9TXahwwbWYZhnv0YHxT8Je5D9L/XjpRH2nL5aMeHTpzmQtPeFGnAdRIuLmSPVe0ryY6k5HuxUJsVqRpwiOSQ6kRuLEkOUEOqyTlIw/Ffe/jqTH1/JgxxXQ+yvmKz3vjwY/MPj/wDr0on7Tqfpkvfu/JKnOKpwdSas0j01M/oUSV2O6kQd1UJUbgnBI+0UckaUTMUSrYHWHURvRu4ZNzN5uM+LL47r6cdtdC4sfah8cMe3XgwY8KJ/3X7nSir+3L9K94cXxzxpwnVdHR7yof8AirakOWlUB6lXnFKmlF0E81WOnKRGjQi+ZaQHeqJO+qslOUzDE4kZxzOoNt8cGOnDMM2sw+CWRQXgv4/AMXeXDHD+OnHUu82kR3McKrkqFfPpKuJ0JRW9Z3LjP9tfMGoQc4G7JFSlJW9Mm7WkeulElUqVZKNNLmQjKWp3W1O5rlKhOJUhAcraJz6SHc1WOpWZ97FTQ0k9pujEdaQ3kSy3LajJkyYkzls5ZsiYXB9CWf8ARVwfYyiEXM5LOTI5EzkVD09Y9PVOTMcWhvBlcco3xMyPvzzOWesqkr2oerqtzrSZzGZyKKNkDbA9iTcSVWcyNxOI7y4a9TXmZuWciqz01UVnVZ6PBy4wOdWgSr3VQ2zZsF7G6ZmfDImSlIxKQqJyEck5RyR0sGxiQmkOojms5jN7NxkyZF7iWDPiPrXn46oRc2reZC29vSo9MOjNDe174kYTkck5JyWcqRy6hy5JxhJkaddG2ucuuciuz0kmeiPQo9DEVjTPR0CduoraNwN0Dno55zpDqzY3wp0qkz0dwekrno7g9JcHo7g9BcnoaiHbU0cujE/oHMpI5uSU6pvrI59UdWqzMz7zMjLN8jfI3yNzNzOZMjUyt+eG+KHWOczms3yN0uzjhgwfBkz4j618+ZFZape7tWelZ6VnppDt6g6Uom4hWnBermeskO6myUstVXjm+6uT1DOeznnPOejnI5yQrgVfJzWb2ZZkyZNzN8jmM5hKrHLnHEtjPsE6SOZSOcjn1Dm1DmyKdaWfVI9RPKqzY1uNkCcZDbQ/cwcxxHcVGZfGESEbaZKzieiZ6KR6JnoT0Q7RnpZHpWOhURKMl14MGOjHmP8ABR4RKXyPoiVUmpEu+hfHYqfMB8P5fBdiDeVwZV9nLsZaI1JlFtpdL4fxW9p9K8H/xAAqEQACAgAGAgICAgIDAAAAAAAAAQIRAxIgITAxEFBAQQQyIlETQhQzYP/aAAgBAwEBPwH4tFFFc2J9cOAY37C9bRlMpkMhlKK40YvfDhKkYv7C9YkKIomUymUyjiOI+KHZid8GHDMzobt+sRFCQkUUUUNDQ0NcOF2Pvg/HMV7etiRQlqaGiSGuHD+3w4Jj9L1sRC1skPhw/wBXw4ezMVbesREiLWyQ+HD/AOvh6O0desiRFrZIfDgdVxYUrRire/l2X8CJFiepsbGPhwemPhTo/desQmJiZflsbGx8WD9okqfFB0zEj9+sQmKRmLLLGxvjwuzF744vMiccvrLLMxmMxZfJHZmJG9/Kh9sWQnGtStGe9mShW69ZZZZZfLRB/RLD/ojCt2Sd+FuuCLtDjT99GVk2+vMdmNU9adDWZEtvfP8Akr0S74MN2jEW3xVFv1K2Gq8z74MLsxX8TDje5XoVwrdV5lwYa3JvfgSFEymVDgyteH16x7+J8GH/AGPfWlqqyUK1YXfrLokqJ/WvsksseCC1tWPThete6H0tcOzEl9a4x4cSNb6ErIRr1sO6K2rXCNcC4ZK1owo/fnIhw9VHsonGnpw+zEdLgjwsZRGGqUbH6hGIx/yWmLpmJ1rSFwsnD7ILfgmvU4nRhEoNacT61x5EuGUa9PhoxHvRh9kZ/wBk41olHMONal8bEXwYxKHBMcWvhYRPsh34e68ZTIfR/r5oooXx5RrmjD+zKtMoWf4vgYRNbkFuNECMfL6F15XivktVyQXBRNU+dbChmZh/ibbmJg0yOHRXmQuvnT740LhkrXOj8SO1mLiNS2P+RF9ow8kzFwql4aMSFdC/XwtK+PNffGuJj5kfiYlbGNC90S2Z+Gz8jvzidH0LSvRJWKKXFivb4GFKmYOJezMb8f7R+MspjrzPo+iOlfIltxRVceL38CLojOmYX5H9kZ7mONmdDdjQo182fWhRMo4lMoXfJiL7+DFlinTJ42Yb8okq+a/MVqS5JK0VRRlGuSMW+iGG12TluR30UIfXz6Eq1Jcs42Jc2Eq3LJRKrVfzmtxKtSXO1flxHoSMo14SsykNizOX4boT9Qvhyj4ooSKKMqEq0rw0IrUueiivQPzQ4GQy8USh+I9k1pXHRRXpHrrhTJdeUx7x0r3L4f8AXRDdD814r29FMysysooooysyI+qKRlMhHYcTKV7OijKZSiiv/Y//xAArEQACAgAFBAICAgIDAAAAAAAAAQIRAxASIDAhMUBBBDIiUBMzQlEjYGH/2gAIAQIBAT8B8Oyyyyyy+X467vh+T3R8f6j7+AvLsbGzUajUajUJlifE+x8f68OPLVMwFUB868tjY2OQ5Go1GoUhSFITFw4nSLMH6cGPiaInciqVeAsrL3vhXAxsbGxs1FliYmJiYmLgx3USCpVwfK9Hx1c/BssssXOt7GSZJjY9qYiIhC3/ACPS4flLoj43d+BZeaEvGYyQyW9ERCFvxv7Fw46uBgup+GhIXjMZIZLeiIhC34n9q4WrVHZidq/CRFcVcrGSJEt6IiELf8n7Ji4caGmR8eXTTkudEVwNlFFFcrJEkNbkhIiIQt/yPsLhktSplPCkJ3150JCVZ2XsfgsaJIaGis6EhISFw/JXZmHLVG+LGjcTAn/jzISEqyY3kvGaGhocSiihREhISFw/IX4mB9eOUXBmFiah8iQlWbeSL8doaGjSaTSUJFFcWItUWjAnXR5yxXemI44hhYmpU9zSl0Y8Jx6ohjauj40hKstQ35tFFFFFcdlmLCuqMPGTX5E8TV+MSEdCrKS0zT4JrSyEtSvhSEixyL2ryqKKK5u5OGkwox+2eIriQdx3yjqVEJaHTIO1uoSF0HIsvOiv11aujI/8brP0YXbejGVSMF9dyRdDZe68r2OSX6F8ElaIO+mSMLgx10MBdb2Vw2XuxJ10L/Qvhf4vUd8sPs+DGfSjCVR4G6HNGtmtimi9+N3/AFi/F1lh++DG9ISpVvbG9qdEZ3uxu36ySshLUjD7ve3Ssi9c74Jy9b06Ftxn0/Wx/GdEek3vxfqYMa675S9cOFK1Wxuic9X63FXSzV+Se/EnqYu25j4YOnsxZes9bFP9VP6vLDlqW3G+pgq5cE+GIiyWK/W6MqF+okuhgq2L8J1txI6lRgfbe5UN3wohMxJdOCD/AFOB3Mf0yGIpbcHu3vlx2Xwxlf6fGfQwo9LMbsTw/aMKVrZCekjiatz8bDfgynXRGoWI0KafhY/owvqYvbKP4zrJ4nU/lZVs7T2WNj8ayEr5pTNT2WRxGhYvgY/owvqYvbLF9MlO8490P7rN5PyEJ3yTfBZhytc8laoi6VEsYjPoYrvK8o9yX3WT8yPbjY+GEqfgY3RshDoaH6J3EcugxMwp6h/bJva/Hg/XG+KPfwMdGHL0R7GOJjRRgrqf5ZN+WuNuhyfFgrqXzzRKNdUQxDF6iyowu57GPzIdXxSd8eF28BqyrRLD/wBElSIQ1H8TF8eRo0ZOQ/Mh32OZqEy8nyYT9eDJURofUhh0KOc/xRGd7V5Ee+cnms5PkjLS7E7LNQpb6KKzbJshHoPoIfUuhzaZOeo9+asrocrzWcny4cqHLJckp9RTUug1R7KyRid8tPnJ9BvJZ2OXOnWaltbNQnk3RqJu2UamLvlLqyP+iStCH5y3vwFnCfrOxsss1sbsvZ7ysumajs9r57LL4V46zsjiUfyn8he17PY5LOTdEHtfHZZfiPwFvUuGSF3FkxdJC2PdZZfkvyFwr7Czl3E8rLyssv8Aa2WakakWWWWakaz/ANLZqNRLqKRqL/aWWWaiyy/+4f/EAEAQAAECAwIJCgUDBAIDAQAAAAEAAgMRIRAxEiIwMkBBUWFxBCAzQlBSYHKBkRMjYoKhkrHBFGNw0TRzJEOig//aAAgBAQAGPwLwY092HP8AGhN42M89jHbHAqM3Y8+P3eUN0KENrxZD89pd32td+PHzRtKA+oaFD2MxrIQ+q3kj+9BH48fQR9YUIbXaE6Kb33cLITNjZ2w2uuYJDx9B3Gagt3E6CIbbusdgQa2jRQWRdgxf8Az2NKA2N0FtMd+M6x8Q9UIk32umDhavD96vV+mxn8Ao24y0FvCyFCGvGP8AgIO7xJT3bTPQWcBYR3Wgf4CG6FPQoR2tFkY/V/gGSijYyWhQt2LZEadTj/gGCNrwovp++hRWbHTsee8ML/AMHjNHzDQoje82yDF+3/AIOxpTfPoUE6p4NkRuuUx4rOjcWlT7rp6FRQ4g6wnZEZqvHDxUdGg76JzHXOEtDLO46wRm3sv4czk0Roz2V4g+PIR+oWO46EHHo3UcsKG4ObuTmOucJJ8N17TK0QuoDhDxLw0eCPqCcd2iY/RvoVMJvKGj6XeHZHJSF+kQPOFF8p0UQop+SbvpTmOq11E6G6ovB2jw7jZCTdJY7Y4IjUU5jr2mWigOzoeKVCijVinw9RVFl6vVAq6XCftamxB1xovwzdEEvVOhxBNrr1guqw5rtvZVVTwng90yUE7yNFa9uc0zCZEbc4TRhxLtuxGHFFdR22jB6N7Q5vYkgq383f4QjN4FMOx+jfAjmTDmnZZgOo4ZrtiMOKJOFjoZ6SBjN8uvsSTPfws5veanht4xufMDAZ3nLHe9x9lR0QHihM4TDc7KhkX5kL8hfKiDC7poVgvo4XO2L5jcXvC5YTeHYchQeF4cXU014IFpmCvjwh8t147p5oj8obi9Rp170WwvmP8AwFP4stwUuUMmNrUQDNrxQpzHiTm0OWbD5S7ChmgcbwpETCw4fQu/B7HmfCg5NFPkP8IteJtNCFgmrDmm1sflImb2sP8AKMCCcfrHZzDydxxXVbxTI462K7LwX68GRToT7nJ0OJnN7Frf4VmKFY3Sszv9ow4l37KTWtcO9NB/KXB0rmhYnSPoN3Na5uc0zC+IzZh5cwop+U/X3SqIcobnMo7gmQ2kAuMqpzIgk5t/YNFv8Ltis1XjaE2JCM2useyJCfNplSSa5oIY0SAPOjcnddnBPh6rxwy7eTRjinMOzcnMdc4SQa69jgocYdYSPYFVTwzthOzmoRITptOtNji51Dx58LY7FUB20EaA1xzxiu4oxQPmQ6+icBnSwm+O6Y0M5zUcEzY8X7CnQ4gk5tOc1w1Gagv2O0CJC1PbNFpuNExp1CSjMF05jK18XTvhnOam8r5PjECstbee76ZHQIMTY6to8gydFtOm1v2LN8Jf0sQ0dmf6WEwfKfdu3c57tsMaDBfrlI2Rd2LksZbtNwWX7fCgLaEVCre4ezkWuEnCh5oP9sDQS3uuTnG4Cac43kzyNL9OcR4W+G8/LifgoR2jFfR3Hmwt5wfzoMV3VJovggY0QX7MhjZS9a1cVcVNtRoBnd4XMCPWIBI796MN/wBp2jmcm/7D/Ogw8ASGCEwbGc7YqZOiqebtaVefZYrgcs7wu18MycFhMEuUQ9W/mQdxn+dBhDY0KJK5uLpcnGbVimeVdLwu2J1bnDcv6qDWFEvlbL+3PQIUPvOknxO6FM3nL8crQyU9evKHww7kUeoliz/ZOhm69p2ixo/taA6ObmUHFQ4I62MdAnltxyjvDDYjM5pmmcoZ1RhelkMbiMuGOzBUoQ4Qk0KJ9Mm5fBGgNOTcfDJhP6mL6J8N17TJOZ3XJ42OOWjHY1TKiv7zictIaCWeoyRPhrAObFEvVNjtuNHKM3aAVHH1nLRn7TJROTMnhEVdsy0hoUxegRkJlV8NAtvFQgTdEb7FfDdfVqifVI5UthypeSmwzLCvMlGdtdlTLRMDUchuHhyLBOrGC5PG1PMihHbey/hlA1omTcFJ8viOMynxDc0Ty7hobePPkM486oWxUM/CoG1pWLnMOGFWrXBOhm69p3ZN3KHZ08Fu6z+nbRrau35f4g9dIm5YirkKKTqHwpB9rHQRntE5LDAx4dfTJ/cbI/H+Mu7RBbNTOU3bFMeEuT+eyJEYZEOovrGc1RIeoGnDJRIB8zbOUebLy1aIW2huWmFS/wAIwj9Ysf5ioWwnBKZHAuxXZJkVt7SmvZmuEwuUefKzKmfbRaKTr7Dl5hA+EAUCo4+sprthBT2OucE6G8YzclBnsmnOPWM8q3snB2eEJBNGwKP5rITtrQpRG11OF4UzjQ+8MjgDVDl+Ms0I9kAhT8HwuUSJiObOupcmfM4MzhDaFFcwhzTrFkHcJKXKKsneNS1OY4e6ESF0Lv8A5PPgt2vFj4buqe18FyvHg6APoCgDjbwcbBAiHEdm7iokLaKcVW/nMeOq4FBzbjUIRHw2l41lGjHtuonw9QuybuzKHsOQvV5WcVUAqnY0MbGhQBuNsbzH9rYcTXKvFRJXOxrQGiZNlASujf8ApXwImezVuUQjXRRW7pqE/XUc/GoNizVtHZ7ewaX87GE1Q9htG+yD5Tbygb/4tfANzsYKDF+02tjPo1pmN6iPfmuMwApMEgsQFzzQJrXGc5tQ3uCaO8CFB4nm4KOAK7eY5w4aTXRaXLfs03FC1K/mjmUPot/YLPMLIHA28oG8J42E2Qog6rlEaL5TCODqE0IkYTnmiwuNwQNkKM3OwqhQpd/+FB4qD5jzKKl6rzHce0N+vSpuUrhlcJl9lDTTwdibEhmbSuTneRbHHBR/ObCoR2tCjzFHTaOCDRcKIyo0KpJntUrMJzpkqFO9rpLk/mULz/xzK32VqtlgHaM1MaS7dTLC2WsafgOPyn0O47U6WdDxxa9veaoh2uNsA/2wjYFVNIuFk2gFYRvw5rk/nCZ5/wCLQedPtIjZpE+tqyG+yfOnYD79gPi9YQy02SAmU2IRMDYnFtxNsL/rTTusnEe1o3mS/wCQxSbHhz4qpRvmj5v5UDzpnmtnzz2i7Ry46lhOvyM8lgm/T+Ws2T/ZTW/WmA66J7WtoDcs1yzXL4MnB8pAoYWqiMPk1JZ0Q/wsJw+I/vRMYrFc4DdRfOAePqAK+W50A7qt9lgRAGxb6XOG0KXH91DUPjaV6cw9pu0cy46IDp/K4W1ql9VkI/UEd4BthHY5OaOKwu8pm+2YvQhuOCQcR3dKnc6ocNhTPVQuJtOwc0jtOtx0c8O0wO+C1RmbHzUwgdigRRwtZD1lHypofnDWpzoeZxCiE9YpvAqFxNkhf21LWNGJOiN0+HE7pmg8XPbNfSbARVwaD7Wgm7BkggpKU70FVU2UQBvwim8CofGwk3kqfbM9EqsVqlcMpTIF3p2BCidaFQ2YLvQp8B+qqiM2GwyuaUQLK8zimz7xTeBTPNY4dtjQ5DN0YN2dgRoJucEWm8UsbOjxfvQeOsFi57rlghellLNdgTgJX4oKhvbtkdy4EWUyMu0d2h4DfXQd45rBv7BbvohFHWvsE/dYQd8Rg23rCfnHVsCAbeVIKvNpdtXw9V7U2IyrtY7yfg8VS8+DZqeggrjzJ7BPsFrhqWEPNbXo20B7ywxmmqw3ZzvwE7aqqbTiqklnD2WOS5UUFpOBEDpV1IsdLDbQpwm4ECUxemkvwtVWyIyZ7QdkKlXqgVy2c53DR3jrHsJ0F2q5PumNqx3/ABd0pNsDH9T5npZCdcS2f5tI1auZjCazAnw80ObrKm6fxP47bdz8XnVsutdo823hB23sFrwsI5jxVGswDQrBBqpDrcnYpDOdRNB1CXOnVTF1kTArJs0JXtu/0qdtenOwRlJaQW7OwiwGRF/BCHDN/wCEwNAxD7oxIhE5YIAuaF8R2vN4cz5bfVEtdjNvaUHDWq37EcXBnZEcDqkqa/3VLnXdtN7CkchRb9P+WMPfOQXRwz9yjMj3xU5r3D4pzv8ASoU4bkK3CSmFVbIf7qQTDDzkQGUJ9lhGrttmy0bj20OaRrOncMgHKY06THAg1vusZE7pmv6uCMF7cWK39jZtdqUvVTFDuWMS7jazgbHcy9X9ti3F98rLQzsyEjcqHnDRmtniSVFWzCbUXOaesNiPwjib7wqJ3l5lSpsExKVVjO9Aq3ItOrt/hZIXdgyyO9b+bIqmTvspkCTKm2yqzqrGoqKZvUY+UWmWCAgXvJKwXPdI3FZzvexr+7in+O35bVIdmA7edMIEZCqpdbMLfzKGQWcVjVQAu58fzt/Y2sbsrZLXqQNjm94IdvAqfaZGQwRcObMLNU5+iky7JxvOP2Nri7YqWEanVtfs7MvVK+BZtMl8z35mMr5KTPfRIv8A2D9ja/y2h2wrEb6lY7p7lEa4Yj2FqHY1GlZqxokNqxS4qpsp2+chI6S8E1w5y9FQYI3rpCsasxfzb5BE9YV7EkKlY7/QLUFiNnvK6SXlCwnmZ3qniNj3XvGEsWqFwmpTnw5ocOBW40VbxTTcRjjwC6OXFdX3VSAsaKfQLELp7TZcsaps1NW1UbJYzgryVd4ga0gTh3O3bLBPUOcRYfqE9IxGmW1Tixf0hXxHeq6KfFyxGMb6LPVFeqmytVctS6SQ3BUJPoqNEtpVYo+wLrniujVzVq8C3K7SpIL057h6qH6jRcVpWO72VGj1sk2QG0rWViiSxiqBXgKr1QLUs8LPCpJX+yxKKpmr1f4l+3nsO2insM9AxmObxEkGiUztWPGH2ia6xVwmqBUvWKx3ssd7W+qrEwjuVATxWoKZKoFePRXhXuKo1avFbvdfbzxuKKad2SlCY55+kTWMwQh9ZX/k8sHpILFaYx31WByLk8OCNoABRPLHsfFOsvwlODDe87gqMYziZrHin7RJYwLuLlSDC9ar5YhjytV6rMr/AGqu9liMmdrltKr4uqVisefRdE65TDR6lAmLAG4m5UiwH8HKTqFX2uQQa4gOG1Z4WKHHgFIMI40XzI/pCaXKnJYsTfFfL8BfL5NyaH/+c/3U3GvsvmRK7G1U2QmHz1WC2OITe7CEl/7og4qsGD90yvmxBLY3FCuB/KxGfhUCzlV61KWCtivnwWLi8FVUWC335ty1K/wxSnFZzV1fddX9SuH6guj/ACFmf/QXV/WFq9HBVpzL1SvBUYfVVFNyxITWnbeVjVVzR6LPkqmdtTJZ66Ry6Qq8FDCkZLEDG/aFIxXS2K+for3+9mpVLVjRP0tKpyeLE81F8vkzGfYsZ0RVZGcuheuhKow+yqCrirnLNcrpWYxWcs5ZyvV9urwXJomur7rHdXcs8+yz/wAKhaVJ4LeNl0hvWePZZ/4WePZZ/wCFnBVqqNVA39S6OH+pZkP9S6n6lWK0fcumaumb7Lph7LGi/hdIfZUbDf8AcVXk/wCSuh/JXRD3VGflXLUs5Xk2YrHFdGVmfldEV0Tl0RXR/lY74TeL1WPPytVcI8Srmes1SXoFiBxVGyVS5Z7lV7vdZx91efdXlXrOPus53us4+6vKvKzisZwVKqtLKBXBalerz4Izh7LPCzx7LP8Aws4KkljB/stikJK4LNC1BTJJKznKchbnFZxV5Wuyhsv596vsuCuWo+iuIXWVWPP3LoPdypBhqkhwCrEd7rPcpueZKkRzeIX/ACAfRdN7LGLz6q78rFkqtWuyhV/MqpOBY7isV5Wf+FnhZ49ln/hZ/wCFR4V4WcqLGB8GjIVA7Kv5lMjQlZ7vdCZORpo//8QAKhAAAgEDAwMEAgMBAQAAAAAAAAERECExIEFRMGFxQIGRobHB0eHw8VD/2gAIAQEAAT8hF6BdJCqhISEhBBBBBBFdP/EEaHQ+o9OKY0MfUVKQOUX2YUH1f4Zkf64GRPiB89BCF6ZaIQX/AJaqhISEhBBBVKuj/wB1jRGhjH02OuxAP+6EZDGPqKiN9j9j3P8AH2dRAtj5FR60IXpUkwIQvWrUughUQkJCQkIILRVRWsAwwyw0NDQ6Oh1gjWx17Ki+x/G35rPqoUmUWG/tj7pHu27+F/dDELdm/LND6CF6RCUUQl6BvrrQhdBCEJCEJCCagFRQWkDDLrVh0DQ0MY+kx6O+H5CDmj+F/dDHqepCRMRrvx4P7pJzL5P+hhselL1nZufWoVjIhKskki6TG66EKiF0EIQhCQgnQI9EFohh6qqOoGhoaGuixsejyI+CJOJQGPU9SFLZmQCr4MHCESROWw9qHogggj06ohKk0MSJ9Mw+uhCEIQtaEIQhBBej/wCqtAMPWVKQQQaGhj1tjerzTfo7aa/NTHpesoxHZr9Cpyri7vYawSzl15CWTTsuZ9ahXLJpCSRPpWOProQhCELUhCoQkKJQUXTWILgNdhB3A02CXcYes+UgglDGMY9DHpR7UT+SebI+K0HR1etvN3x/FHp1aX4EPcfr0kaYUSSSTVdI/okIQhC0oQhCoQWhRdMUhJnAmAlCjQnMYw1oIUUQQQQQYxj0vQhCHn+Vfoa0y/7D0ur1sWPLv9QI/wA8Fxh+vZkkkkmqox6DQNSPQIQhC1oQhUIKKKKJUkOUVVRJNGpsyHGNBSCiiCCCCDGMYxj0oQnHbvpNDHodH0G47nr6Mi/cqaXtal+skkkkkknQhC9Ax6p6FCEIQtKoQhBBRaUFFFEFWBLQqXqCYIKIKLqAxjGMY9KEkk3sLEf4RUfWZne6tvZmY7PEvul+rkkkkkkkkmiFQotbUj0YqJiYmJioqIVCE0ogglCQqEiCBKkEVZN49RMDGMYx6EI7ej7H8ppVPqoe6Ow18l/QsFpLK/z49SdZJJJJJJJJohCFFrdIEvSoQmJiYmIQhdQProWiNVyLX0pgxjGPWiF8fUmRL5TUfVQx59fh/wBiwTqLEt+V+xR+mbG6yNjZJJJImSIVCyLHSj1KEJiEIQukf8RkIQhC0wOmes/QwMYx60d7p+hoVyn4forJbhpPewsEJqV92rlyEv6VjY3oY9SEKnc/8RCoQqEKhdD5jGhKiELUyKgwww4ww2MMYx9BDxD/ACgZAWJvGP2ZehGJzY1dCtpPuo2JvfvhPStjel60IRMxL0cEdJalRCEIQhdFwaGhKUQQJC1ukzu4w4ww4w2MNjGMetCJfyfzQhyWGEbE8pxQ+sh7kn5cvZ3/AJpD7b8v90GqQ+k73xP9aFpknWxhk9NCVCNT129EEEEddCEIQugDccYYfRC6DJfl2HqDDjjDDY6PQ9KERxt+ajyzu/ND6yHL+XY1xz7CA/t2kXBLjH5u8Eoy7TbsXTa6Ukkkk0kbGPpoSEJRdCSSdDZJBBBBHokITE6EIWk2GGGHPDdS1LFQMOPoDGMfRVCHOH+Y7Xs/oab0PrpkJeSET8cMTTSYmndNEbBf0v8AQnTOkk0kkkbH00hIQmYkaGFSRiSRVbHSCCCCCCPQoQhDCYmMMMOMMOPUpvqouhBn/gNoCccYahjH00f7HJO3/tCWVD9AnRmf2We7+BTMCSGpdAZmjHSaSSSTR9JCQkTsgWiJGRbgmXkiqkbo6QQQQRRjH10IQhCoTGGHH1jVbfyGlSrrRJI2kpbhH85rtAYYYbGxj0PWjvdPsVtQ18i8ocah+hYmsxjFLvIthqdZ32JwKNerQkISsiaGyVjoSSJkuRtIYnpsfoEIQhCExMTGG6NH+5FB/XCbvHlHZjXy9j++Gt3Qf+GGGxsY+ojBo7LU+RWKX/K/yofoUMSLPxi6/ZHQUINc9xxP5EH6lCQhKyBoZxDZJNEb4UrCSaO3TdII6qqhCEITE+kFf4gqph9CvUMNjY2NjH1EPchtz/2PD/qUPTBBA1R9BMdbCXtGOPqL3uuky3KLNxdGF5QhgKv7cbc2a/n0yEhImdiF3FVs2ENjZJIriJYmvniP8ROil4MesgjroQmITExMTGG6MQqLRj1lSGGGxsbGxukj1ToTGLBvaA/DoehIiow0PoSXDNUS/DcPsM5Ojcf+D6d4a5XYaM2Pfmw9qP0aEhImdhKd9DZxDDZJI8hY3fBF+XeyWxCEmyFC9x56kEegQqqiEIVDaiVRRVQwy9UUGxsbGxsY+sgj/LoVbL0i5gv0EISKa+54W55iRNBx1yyD/Q91W6FF+GuRBj1yJ0VST2038L/RlJ/gIhLsLIeLmy838Fk8w2Tw01DQ0MYx+gSEGtiV0JQ90G6qJvZDkoOzRCFQHl9OCCKRV9RCELQhUITGGoIIIooLR7rRsbGxsbGxsYx9WSTw0H2FNEpTW6JO6rX+IYo0QI8tH2jsPbJtb8wsSR2UkOIXi38CospxvZkvZQd6H0JEEImnusMbk/YJe6HhJtmndMhF3bL6haGP0CQkIQKpHGMMN6UIVIgT46SEiNb6EEECQhCQkQQQISEEIQhMTEEEFpcwwww2NjY2MY+tJNSt+6X+ewhYrI3QzSXfOv5GGLsZYLLv/AjccX9V3HSRf9ZLuXuLX/2Fh0voSSTQkTRNTn5hWEa2onh8iNoZHnvWfXSEqEF3RtLJwDDY2N6kISnAq72uokxUJ6qpBAkIIIRoCCoEhLRJPQAMMNjY2NjY9T6bY3QgxTWi6a2EXSxLyEz3XTWW5RfcdkVL+i7pZw2+7Etblv2Y9ttttu7bGySR0cIMHxc2IuGsr80sfSREyPk6fyPBZpNpTw0LTfsP6MiyGPAf1ehB9WBISGNwjeZpHgexsknUiCB7AWzfkNz1pJJJ6aokJCQkJCRAkJVEEqLXJJJNEjY2NjZI2MY+sxsbGyRMQvUYfIIhaqV/AmIZn3kwvdFIdxhskTGM6Utvh2aIs73uxQx9JUnbDz936C5ZcYXLDqeVOSIVvelj6pNdGCCCBIa1hK2yIQaGJG9cCQkbtiHZFi9chCEIVEIQkJEEaZJJJJJJJJJJJJGxvQx9ZjGOqZAzc7n9i7inC8pBqbb9tj6/Aw3VUSycj+5HBv8AAOl0fRQw7mzh7MkPPxrf3LH5v53IhBKL5kpoNEEEEa0hIf4CEsJwyMeRsbJ1QJCEggNNkUQkQQQR6dCFRCohCELVJJJJJJJJJJJJJOt9SSRjGOqE6E7+6e67iKl2Td/IiTQpIekzPl/Yijh+V/VDH01TOTwPlf0IdlbZdmMvhq+FiOEfGO4g10kboaLcY8WQ2NjetIjQAk0AjBBBHqEJC0IQqF6GSSSRvrMY2Nkk1aGtKYmZ+/75dyCiR+y9hj0L7cncKfHBmMfRiip4VUvB2YzCEXcvfLpfRc8JQjHiw2MetISEhBC0o6aW6eA7vv0J0STqQkLShC1J1ySTokkkkknqNjY2Nkk6IoZYiqYmStxTLnf3G+jnvbhNDA7tT8GYx9CCCBKi9QSA5b3itS0sR+C1oIooXsXG47IVuGhj0wJCQghAgpjRj6F95PAbtLcsnoSSSSSSSJk1QhakyRMTJJ0hJPRkkkknqMbGxvUtDDDDVEOKlScMgLFcdonvFo71SQliad/sJVHogggggikUZCt8b93E5mm9jMmm99SCBjQjyuRnOlj0pE+vMVGPWzKMDfopJJExMkkkkkkkkTEySSSSSSehPQnpMYx61ogaEIojHxsfhf6G/SAf2qtREjh+z+KUGiCCCCCCCNCoYdNJLuayS7bbzsk0nqUVNi43HbCsug65RDtsTbwChMPIpOTMOjVVSRh60SeRXH6OSRMTEySSaSSTQqiSfXMaH1GMdWIJ4Fe3gXblkR0Y8CRjQxBBBHQRgKlFkS8H+uXdL0Mal2csS478sbbct9BklLaSEcS/AxgkPkHobGpNPKQrAEv2xJNJGx9CIrMenTExMkmkkkkiZJJJJJJJPrGqIII6LHob1flNEGFx2cPDMrkGBL2v7v5GhjIpHQVGDO3a+hU1gX2HHolvLr76mPkdXWR6ENju3gSShOwmT0yFLFn06YidM0kkkkkkkkknpMfppJJJJJJJ0oXyW/lBKjuNpN7+GQKWnZ+Dmh9RCGrNj2DX4e1+hqbLJb7jdbzVhMCY3oemR7Lm7EM2NhPRdH4v49Quqqz0WMfpmPrIeHt3FuJ8mQJc7gOvpmA+ohCLtr339fknhdvYWPsbrG4Usldmwyeg6og0+N9JjH/8pIX/AJp5kJIJzloTzyJXG/yWWIPpqid+BxuLLY4BumSITZUf73pfVtbm9H1djuauixj98fTQkQQQQQQQQQR00Kq0ySSSSSST0pJ9YyLi0m67sfszoIf75k7Nj7H01RJxVfL/AKLI2QldsjXCjxQ+pBdvyRRjpOhsnSi4NuiMSw9h1gaI0QQJCRBBBBBBBBBBBBBGtCqha5JJJpJJOifXqi8cfArogl+W2ZF/RV/3S8fTQpE3sr7L+xSzCcSPbyPLGPp2d55q2SXdRC0+wVhTFqY5+0uSTYbIemCCCCCBIVYIIIIGqwQQQNDWlMT6Ukk/+WaVD5O5zMT/ABsx/swd/vYkUWT6f6EH0YEISSWcND8/G3CWd8n6tUfSV8yLC3DWG466o6R2fPQS6T2F1ULXBBBGmBhiNEiYn/6iLGObrL23ki5Qqzvj8EJNv/XAo10UOtNQjcb1JYbnwh6sMhjG8u4xj0qRIggT8DJwNc7MSDoxuqiZ0TpU7+AotC/osay35IW2vD00EEDoNaExMT6E1J/8dUdot+xrYSp5UNOpMgnumS4P3gJcfQzFlCbNJsWWZL3oHcbDSxjHSBBUaXsN+wlbEOBrwRexTQbrIsR8MTlaJIDHZY7sczbS3rkfM0M+ZTprqxRjWlMkkkkmjrJJJJJP/hqjy1v6OjbCEPA+CVlW/fchBOiPZbBok7SL6UOkEECVFKtjDq8MaSL0PSoUaQ1qVJHvEUkxuYeD6A8D0yTpxjnkPk6uPQLosaI6Ek/+YqJd2I3FrfZl2sSqyRH+tj+ywXQg9eRC28/3fqkn+GEPSqSCpI3RjVyIkeUsfYgtWmI0MY9Cpdb5VYOdfpzWcptZuXWkkknoP/1kI7JN+z9ianz+wa6nHspmd74mwg10G6Co5W6GbSgzsyQdwx6SaDdSZIbbbUUDHcRVlpSMelMTbJtDQtMH5iZaWFbqzR6MyEocNegkQkbJJJG/Tx/4CobsjTIHIkztj+UjLP3hsp7x3I2TIdR6UMO2Nr+yWx+RMb3HpQxjVqWF5ZY8kUgQqOw8iaDdXqkktZfoELbuuXoZ0KSf/YVDGgbbskMaZQn8EB8/o5O5S+jF14AOGrjV+eBBj0IvVsk96MuQ6iWgKRRuk1JbSyNhkG7hNGJSyIVT9aSes3MkKWmGp67GyaioST/6ypcZELOz9hEEW1wIc/BNYHZE3J6/6THZCfhX/mK/XvhIIULsR9HgY9COHEfsRTTw7CqGmxX42IOtEhSaHSMMmeNoHfRBYhyw7CGJEEPY3ZGw/RQQR0lbTsxWo+brMYySSSSSaT/6io7HfjIPO/gbJJPG/syH3U7n/qGKaZ9psHM0kJZoel2bfEsclK5OzEplhI2GnR10FZjGstlz3Ww6OjGxsg8NDpe/vRkOyoqOy0Naj6yDJ6jojPkcMaUfK1ySTVj0kxMkkkkmi6HOfxGxy5vIkYJD+IMovw8/+KwZ2BH0e8P7QxuTI4EnYuWcPZl5b4eLIhdIjX3z9yIQPSNQktxNJdlnZSPxc9xONZVK6bZjHSGi+bPMk+H/AEstcmjG6LLG9S+EK9/fFqyLuhGstvlGqUzYS58sYrEXvXA3NNx9clIhiazSekqIeXEdWKIDUl9ugha1rF34ifORMVA+FmLKPMWTH88O3/hI7kIvsiLcH+9zU3+HcO1qTXs+6s/RMosN/mX7oPYZP0yYz/gvb4IfIqKirJIh9o39sbzlY/8AdyAC/wBoF/0RO/1FcdBylPd8EUuLSLlcc1vg4M+CymLBuaPFGToY8Up1Utw7Oshqqo7u7kywq3N6bBAkRXCbdki/Frlj/wCYVw7OwqsFybgmwTvBEm7i5E7VkyhostLy/Xo/3OTcS72fxX/sdmdoV9kjNtTfjciJPyauOUVZMvYRR3u2I5Z4MBpLGsjUqYYmM4UEf7DtRh/h8Ms/2W0YjYzExVzZZbRoVHBI8xuzDDEYaMkXLJDaLMi6atdjv6BMa0pxdO5DN4W66TUAiqDpT8hCSC/boQhDdhosJ5DynwXjwxXNEBXZu+41Ul10TxjQ/Uo7nExAe/T/AEf6qsjOntp/yWQY/eSfXNwZX0O2RyD+RgNUngedJiJ3bLZTLcIb9uT6JBvOcZFfIF7Si3xTN7qkk57pamRqAN7A85IJHe7My7jq2Oiy+1R1fSj0JUQml8TG6EIwPrND0IqVBogRjGzQoqJNnIXKUIwHnRZH2G8THD1tsSnYvLh1P06EMVdP4ANf/gGV8DTRLr/izvivum7wePsqrPef2Q0ZjBwCQkkaO41sOVHllgH+D3U2G88NVt2xzm2SSSXTD3IdGNZU3JhQqPqpQvRKiGpWqRvdPVVIIIFQrQW6T4/sbbbbyxiuI3ERI8qDPQlp9xJs9xCFsbC5LYTuCQubbHh61Vc6/nRWkZE/AeCUFbvNDkk3GmqPDFzTFy/J3NRknfuag5ITfEsnfcIp/Z+iCBJtDECTvIssrYJA/wBs6j4A5PouPFWhqbUDVGWovQiyxjq+sqrQIR9bqqqEJiCEkmARJHVst9USaSJiGJMZk+rIgVTxA2nRVwkx3Wl+qft517/1I34/k8uuE4VP6HZoB4Jf0C/4SIp41hkipbv4kpFgQlLsm7INW949nYSFHFoKJ44X+tGfcM3+Xx7DAsFBNPId0XsSJ/d/gaz3/iq6kZdkLKpMja2Ec9Fl0WSZnTLr40dGoXokzIYqIW7+F6KSRMTJEA8Rd3imXoQhGAjxTojKmMShizRmiymqv1naif5QxI+YIubydhin/wDsj9DEWcwY6YtP4f0YRWwXLIHkfeqtguGPuy3+OzJhlA+4l0f4nB/gcGVLnNyEMuNiRQHPmGMcDluxJEiaLr4VQw/QoeR6Fs66WlCpenljbURI1jdEBAq1bcmBZUi68o30vqrqTPj3zK/A9QsyfkZLsMgncmRis5f3uv3U9ElT9r5GMN2+riEJfKTgxL7KEyRaXMsYmGuG97pQz/A4P8jijv39GJRBJc0kkks86knYa/oULS9aQujQ86CQ1Yg24PTLxhK9FrCj5tgwNqpMxsQ1QfvNIIGiB+lRAgixJsjZXkY1Mn/GzcmY+g+chLSQKxbmn3IGbTuj2BDdlHHnYmWKmYRaTbBOVij2BiNLEZ/f+DMTUlL0kLtsSE20YSthKc9SF0FpgelCSNQY6uVT1LjcV0msP0bRG2hIQoTLlsVfAWtG0KjVm58KIQwGlmFJZfAVCBoYYaIpBHUVIIEibQvcB3tY/gSjTVh2l1mHejBdtzjlseNiRi42Bfl7i7EmULN3kVKlHcW8RPcTELYUt78F03vYSVhNFjK/2xkLwUyIXkSNiFU3wTsJRwPBAx3ViwfRWtam1ISEN9ZZEybmQsJ4S9F5Jxtn3RdIpiE7LtrMaad8iubCXMR3ssuxAmzXAaGiCOohBVKCiCEOt2n9ClbsiwrKwSiVknARxygZoXA7eWK4qUIUyjgn5RysyvAScJ+wpqDZliRwbEr6Zbjle5IhFo8twxLnKplW1Q2MSSSJ1Persy/IQOi9AmkjY9S3H1hDHoRcqy7ELqJ6d68v0OiG9CqhOg8kjKa+SZgyMjAc71KNEEVdDGqMY30UhVAqhIVEQJ4VhabZY8qTa4mtmUb62iyBAmiF/wAI7SpfyIntTLGNHzLHIFaoaFbHegibPCblMjLS0n4Xv37jmusocD4eAWhskb1E7CRlRKROsqyTrREdc30GM3vIugqOqEJkiWcFIxjb36EaEIWxO5MW8sIsDAsYsoViL2OD0uhjGMN64IEtIoqiKoflDSOF20C4Nbtu+CHZ/cO3ZDHFDchy070fAiL7mWNEhJHlzkuB9ZOtmLgQnX7NhEMVS44HJDTvY2Io86BOU/BMDDZsBkvnhya638mQ6N6cC9C6G4rL0B9Jb6KHoRRamLen7QtbwBDR/EXzeRbyjiIlWavBlgiw+BDL1OlynTENXDZkSh4MBuCTHKtRLkZ8dhR4pJNJHQxhhvVBAlpGUUII1yIvd4DW1mwpQvcZQk5lsh+2WMeX4S4EkwdnyQPMn5FA9wLe4gaNQ1KIaXM57O2jFvlQUalxuJNKxOIvSm3kZD6CxowY10IojVtWCOkRFEoqR0FQ119xUkkkk2ceRjS3LJoqbHzGjFxNOB218Ojx4RK1U6NSYFdGA0OhkyxCEhpoz3om1d6JLouJiV9oXXfRGGHUDeqCCBKpChIij1Idth38Dnhrjmhs4TstbD3KUXHWWU7K8nh9eNxGnEwaiXOmjZCxfYYj0khlvBCrrvhuEsdyeBM8ihuIfkaaz1otEa0R0FVaGoFV60LI8MuQtP7DUVUSb3K7kSqiXcYyaJ0TcYuLQ0BWExMg3DITLLdGD4HYkbrn2U6OzBlj5Bq8MnVBBBAkIQnRSQoYknQhBodNP3SEg8+E5IrrkTa9yccjwqNBCOyFPGLOAqPF2ByuRyhEgjYZGMBErm2EyKhlmhvcY+ILbeTIa6SII7rse6HRJMhqNOC6C6p6khIislcrSmpDyTbm2luGfCJly9RaWNPgNh1aEy5UUBuaZoiTwBeMMh0eBUTaGzT5QniXKJojG5JG0zKZVYIEhIgggisiYqiSdCxLshxHdN9jcuhPhNI/CnG1lEL2L/Q9i2GHmSRZbfgyc0pU1shR9xcCWNkktxu2lO+5ShEJbCqK5Oe5aQpCvYXpuXDl5WBlRbuRmI5byXHDkHdySRciRD0HsugumtKRIgS0lLqjmJ6MtKMxobcMWj22FFpLTJMudzjq20rS1ncTGN0QqYDlm2RIjAxjUakdw7OiQkJCQkQRpgjShCosOYjeRHXaCUvAkciu158F/wCK4P8AiC6crI1pxBlsQ/C4vXOYN9OK2awlChYGJPYZRErZSNcgYg0W8GZ3QU2axSCC1WrEYVx9L9ChGhVwkTcWjYiHoWiIrsNiY9qTCvg2Cbbcty6IVVqmdF36aNtEQ9tyOyVmCx1b0d0xMiRt7XwbSGxsYxk73AkJCQkQQQQQR0Fox0aXljrwhEcgxXkR+TltDMsYhtdP4nkZJ5NvnLGTbtL9taE0qS7j2qg7BL3tFh0rE4PwMux4PlbMzQsDxVMgPsclXszAy9KhdDiidOInXCrcjQjJUljyp9iaEIWiSSScZMuax0kLTKsmNkjXGvSdSsDI4ZHTJBBuNfgaU0oSEhIggggggY17fY8vwZrrkTS8JUJuTHh+QkyuxYTqyS5HD5MTeT+IkOL9z/VXp9w2Sho+KDrexA5k80clN7Dv+yFGwzbS3omsfSXTQuiQ6p0dURJGhnA4B0ndgh+7WhCG6yTu1EIb9A8HKGmno3Ly4PsSPxljHVskyEW65MATEtcGNoSHRWcRCRSZDRwJcqsxd4GWTZSE1ZPuWiyTZKTJJJIguAx9FoMRtt0yIPZxl5HKrz5p4LPfKLxvhjoPGhCwNCMB46a9EhCrJNEyTKioWneo8kbExy6M6Htobt6JjKHAZNLHYvEzKiJZNGF4hwyiafhyhC1XuuX7skkkkelkNEd/uKA0fC5Cebl8k0G7DcvSqXpYxINFzX4GzDwuS7IntY87kkBHOblPaRNzI2I0YjVqn01qggggggjUqSluJ7BJhfs6JC0u6GYv/wAVWgI3MOjQNeuHVErvJk20IEgYyQ+BZlORmyHyDVhK7CZu8kKbb2Q6ySTqe0dCwBI2YjivsfYcA2QZmN1NeBG6k4WQvXIVGHs/lIR3sjFggggitd/TI1QmMvtRGux8skHbLtjljusQiHf7C4JfcbPgqLQ1VC1ZGYs+tIVFjXFdgtpNhDg6I2VWULvrPAwxylQcA/QlS69O0V4kbO5Ln8Dbn4UOUoQIQcyJZe5FOfYfohcGV21Snbc4qIggggQqLD6cEEEEEEEEakp+wDV5Ak7J5G38QQ/6AINmX7uNtw4RNmxC92W7LokLXWdaNayPI+lchUIVdxUehNRcvwRCtLwTIVMngbEbCq6rkY3ZZJJcH0n0LBbMsvxdr9GErftgVU2TAjTMpRq5ZQhaCYQmHyPDGnBZEvYaEhIggjRc1R9FIjU0W594YxPUt170hrCV8Zcf0wGA7yP0LGBOwLB/wDKXZbk0eZY5d3E3WJ4G2w95Ln4EHG/zqQ6JC1u2mtL0n1IrxIdqJ6IRE9LEhcjCKxDeCZ6sTv0HR6II0HvduX1eWJaIoaUxjCRF6ru1W8kG9xPCj9WMJCRBBGjOjWqCBISoy7Ncll8i1YO032xLV/ZF+jB+5MhfDKIybwmcZvyMYReDJLFtl7sXu7YU2RIdlMvI6afYOG0aypT8H8kbe+JRn28olbJ7tjdolf8APSXRlVaXoQ9KUiD1JyoJgmpKJo0TK1UWJsLQ1oGJng8XyPjoo5CHwQ+KKwworEuenGpFh8lBd4j8uiBoimYnH4e5d5PlqoIIIo6PNWiCCNEpZZs45dkMdr4O97m5nsJaDmA4opb8DqhPlcbS19hcwZdMQsz8If5Hy7mQaeWcL8GWZ7imAzKeLjbF3MdT750jL89RC1LYQqrXFID1bDMtSLJXlonTzqh402iRceBqk6cDcoSGhITYV10o0oxFjLhtCv7n5GqtEC3F7CbDR2AQMRVjGMepXQrvhC81DxmfJFGwSgYZvDvsJe6u7gbZm+bExj8scd/sRl4uXARQppZ7BkL9oJFwUVwuRbs7sTl4gp4V5ln6cUDkse9xvwnhUly6HgNxs+q1RaVUQhGGKkUggggYdUXMhQQMga0oajREVz1Bi3TcEmxqKwNECoSQritqaIIIIIIIIEhBqPKvkfnflD1MjhYsp5TH7wjHVhsb5IbMklHbMLBducwfSHg18fuXFcpfJp+kMkBYoXkcVaXIfR3CRCvljxK8g298A+mQiT+e7/YwQ9hHAxxLhypIJP8AGkfh7wR7D5z3eDKKsPS7TO0dg7Q00Oawpm76i0pUhGwham6PTJNWQQNVQqsCeq8UQjYhKiCCCBSLKsa0EEaIIIMOIRMpeU5JFA0V4Q8itxFkckV5YX4Ey7Nf+0QQH3hNwvySnuIuX2kdXcTckjimrN6NikoeWiO5PdYL3ZLULfNfmyMyW1z/AMckG1bNS/Mi8y3CSEqn/wA04EjQ1zu9hHjagv0i++c2guKr72/CYwo8BfAjBfKHenZUZHXkykPBLs3uMJNtm9pLAJE3CTvYedLx/I41Pl8jGlm33HISS2LnZe4lkq6wHE3LQS7syLb5ZHsiENwSMlDchJJWJ1wRRogWiDYavVOiExY0MfSgir0IkemCCNcCEYVwQQQQRCsQNGWbYTmw/wCmzjbBf8I4XeA7z/Xc8Lz/ACEOY/55Msn8j9iN3yEzDVJ7ojynycxt2Db/AAhDpPzTQJ/dh+QSH+ShBXdk7KDMT92NmyG+YxhC/wCASP4BKLSu2wR0KeBYsS1Sj6kpvsSIJ7DZMeBEvYS5cT3YmDGpe4988NE/3CafC/k+xKm/lmea4SZ+dkjb+aTg9xM40JH+OTAf5IuzN7C9k8ydu/I9rD4udx8Ef+CxWh7E/wDk3i/BBlMRN0J8p4Nkmx7KQ+2eMbPJInyTEbCfI7SWLWtKVUJUS+hdC+nFGumiKI03Kgxv9ol3CDh9wNlhB8Jcwy/G7DuT4L5DvCYJ8CxvEhf9aP8AYQ4hc+UjOv2EopdgPIiWsEvyfOCEKN5V2/uL9OJ/25JY4ZCQd4eSWxa7iFRB4DbZfdj24exwDwd8culke9kcivLR/qh/1Uf6kf8AdQm715RH4Tn6MPvw79n8YH4EkUpS7mGNdpv2Qjn8xryshx2+SjJNkl28GjPyHcfJBj5R/wB4Sfyj/rl2b3kj/cx0iD4OQ/A7x8jnz4E7vzQPC9hv4Ddn5iXz0JEEhcxWDCCZOtaYqsioupVHRjH1IGujI5SWOR7VLySP6K6QfED2PtOeeGZlCSslDglCi8EGWn/aF9n4UM7zAnCRcMTrJcoYlgb949hb/wAB3/ANaITXdNH9AGd17jcG+Tz/ACT7v5G7LqS5EvdSeF+w+QJwbN9rj+PaY/Qrkj/KP0if0R4R+VkLtfKb/ZtOntobEUk/yCkgTaSRXzyGLDjt/KMt7XQq7yZ4nCT2+46vIg9mzEiYs+XaRRDSPA3ZbJbojMPEkRzdemfwzI9hB/wRbxFyOC3hfI8o5zcWM+DL0/DHNo++mYJkUsCMSFxRifcSSpCo3oTJ1roLIsDMNSN6PQ+qx6mZUwoZHdr0VTbI8oRXtpIeOlkYugxnuowRsMYKt4GKqGLJDL3HELYRMhHgw6Eaw8MkfsE4DyzGjHUyE4NSKmQS8aVqMY9D1f/aAAwDAQACAAMAAAAQ/BCDrAUpTODQQoDDcLCiLHt50U5J5lv/AFr9/wBgBGMEO0X+ykC1yT/v9vNP/wCyrNVL64qo2+s8+++aDCnfJJr5fDWb/Dc/WVocqMQ/CXxxJ7blRMrGFPLzlf5TnoiN2vLL3aPHP/tltZdWJ22qW+++6qfz9Sqj9e14O/vjT+navOBfxUD0huJLRX1DzH0l9yavfVP3rsP4DlnT3r3/AP3Sdb/4DZ+qyHvvlpP7/wDG4oDvmcP/AKyklfwTgscfN4AIUhAfnvT4i0hFF/V/R/HigWk+or2bu+z/AOQ/416YIim0PvqpM/7fafnv5FVx604f5FtAdgrl54Yq/CGGd185pxjEsD+XU5S1jr/uoXaNLqq//WRSqqrp0YLvuiha888X5v0+LjzU6/7CeEH232e2QVp0Pqm4Xcaka1Mv+qUheP105PGhEMNPm3486q7oJxEyWqwnkswzz3hkVOlwrSiPhU8bjUNqXS6a1rMZ9TRYGkIRkmNv8wff7HvZCa8zPNAv+a6pF+1K5Dcx/wB54PPHJ99zo+zJd3qoLjMFzal3EFt70P2wRCYBBqx4EUggMMFuewK5Y1Tu6S+oKnN52UehiGpPq0Odvstd9quz74P/AN/Z/wCTP1X4G04/eexKqt9fWSVz/G4S4wRzXn9jlJSBmiC1x4iZGTnHu7d2imOPj2HI5edrf7Egu8/3/UiE1CPemcVHF9CFNpty/lpv9Kexz+/+IKLY/ZeT6w8Zh67Tg99iOtDn5jb3JAzT97zlcIfgwf8A6W8bHfhgs7U5afkl69w9Zfs//cbaE1dOuW8IZadZhnVhbM1TB9ZFy/reW/8AsPme/vhCpjbpKLlr+wnTLfLEJ9Ry46DKLyYlmpZAY873PdlP8LQOktf8yXd0bcyDQminZ7xsf2nDO8qXxPqDaXYbLLSnL991lK7G5kT71gZJB5Z9DuqGcglAhsNYOsRyhS3Mox8e6+M6FVtiUWJH5Et3sb11+V8KNNupqdpz2vfUtzkiuKj3iMHJpDTEcf5LthN9Io2gYa/q1JRTALPt3eZePxFPOuyTHX41vD/1L8ass6+Frz7l/u8Tcsk0QAZiokjzvLtjK1wafH1qqUcO48E8ySvVtUsPKUvt7xAHw6dFROfQAV5ISFBfzLD1jGuwf1YUxNFJwCwwvTXz/pjdzzx+QqlxGYK+sfFOO5G9lLMf3v5MPZ6/8aH+rQwjNfVDCUncV8/PB3LJHLhbR1hHMxHP3XDeb0FJXR+PmEjYqxJX12fpmByh/fhvj2HlFHiHrmOzht8c7n292RVXhVRV9Dz91Ffv73F2DX1b95K8s4bRUoLVZ7M2MIv+/qNsoJv5nJDope0lO+1j1u88Bs00y2obDtHDjcYs4IiCplvS2UGOkiSHN99iAjDi9/8ApJcVxRevcMoac9ec1LUUwfJPSHE7Z/vBP/Cigj9t0J0Z2zJHsvourr+k2zZBc7LHWXfatrvw5pseH8UGcXbw067TS4vv0yR/yHAXf6m9rLJFmZUcwjlfj6d6chLruprsrjq6/wDBxtzz2H3FepjbsbHFmnI9HHGktPjzUUrc1byKpbpX+U8BDKdsQoQrPYt7YBDkUNvFVLao56Zo5NyJXi333kX+LCKosFV0lqs1WfVGb6Y8ftnhbYM9bKvtWv7tbhyG0c90E95C3iYo0uUmsv8Ae22S+6c7s4y29F07W++b/wDbfdfSLj0/+QI1v381TpXu6EMpp+ZxrRxlLaf27ykgwdPfwikeBYX1e4tqrvsXExeVfSfKlPugVe8o7VYQDP6CGEQzy/7/AJrvNiIF82cUmmyR+kH/AHrJcTtriN5nOHImbEv73rqoXj9rLjibx+R+ONtirNL4YhvBQHaJGPTbDRVUSrPt9Ft599Z5RtVysMvX3LbafkNDdlv8vR1dzwGRmVzDT/197Bq89VvN/wBwnlF5n8gT04/3n7CriQUV33aXPvcRtnLAPL7xw6ZvzLJ7797+bihswmQ8w65Bw464RRNt9XfYSXV4MLxbzy8fd/3SvGLxQ/2V/lP/APE4FWHFf/vu++NBT6u3FFbWPpFyDOvMZFd/X9tu3lhetG31kGXD1fOvtXycovE2Bge2M/fnH9v4+3gn2kVX9VMdcXD2fHRv2AkyQ/FxW0uVYzRX1FsVWbMk9PsOsmo4wDo2p64Duued6GM3kpUpOPwedb8s3xVsp2M12b372WUWkAf7jt6XLMADJmoPMG8GqtfH3nGk+xHJLqDrpWxkTokQz2JU1uM5vFfuD/8A/U48mQkfDmE6HjVdFlXAbGebGKeLzQwB5FB3MxPNRPNppdVPsDve878Gi1nwjtsLT+G5/Avzm/8A1IaBHJ/BHOo7ueWaSVuSTprXX76CWW3I9aE4Od6d9fybRAlqO2g3gr5QKucNYVfTy9XQcSsqt03zB/NuGWqh4eOnhVsyehsIphK2IqHcLuMOzDewe+h6T7fueNWb92j2BOHGUcT5blf71UxA/wCkk9Vbz/lIwqAJHMHRic0kp1gEXhdYO/Iets6Qfytk9XKnhqCCl8q36si5d69Oxx/aDzl+31oIqPf+dY0/YmomjywkTrIZKX7Wbld/8/nmOvEh+dwR8hfENLfazQ7SXn4+0GYpEnAqsoN72RNdu4LLe+IW+5snMxFtin9P139b2bAu6ed2uu/ueN9N+jf20Y2u6OLO7cEkcg2T+KZ0y7aJYR9j1v8Ar+/+GOnnR1a/6LPHm5hTEd1TJvPaWxv5htpl1UYWPWYQhnPjbv7wCAteell5kJqmvzNpSJUs/wD3xqlv6XOecAjwasmu/wCVUETmQz/fqKJd0lkk2kka0P8ADYh1Ttffa8xLt+GP7zajyUC4J8gB5EqC+Abb55XxTn2IIgiujHfJFxbDeOlVVAV1HJ621lxZyv2iOMdgtzd/E09qJpD+yMGDRhbaB5hvpjHjbSAwiXtUU+0QgLm/dGYVtzqH0DlZK9pt5m+uVJlDroidCF6vIQMLydSpyOPnJzjXBGkfbK2aT3jaTfnwtVWqoI8w3XrUf3VXzTmQLbhjtlfZ3Ld9zPF1h/rd86m5NzqP4hckSXBYHA294VSrPdd1dJJ5122uv7u8Ycsb3XkDbFDKBaeerwHv35N5VfzjzbnrLeGN+i7R2txIYwArRNP3tb/WRkrfHdPvf3xvKGTz+K2y0o9j/wD/AH/2P7yB2OOL0OP30P2F3+EP54IAL77z7zz4Lx7yD7yEL0OOH4ACH+P70EN9/wCe+ieD+jD+g//EACERAAMAAgMBAQEBAQEAAAAAAAABERAgITAxQUBRYXFQ/9oACAEDAQE/ENX1PDzNAxNrhav4/wA6U9Z6njueH1Loe7ykIILMYZYaxdKXKVpYVu2e79Gr4L9C0hMMYx6XRIpmFkPKkg+lKqGrieFrwb8HELDF+94Y0PL1S6OJUQQOdTxroS2PWeELKx6ZL/vC74Qn4WNZeiEySU1+2kTXQsWRaweNoYF2QhCEJ2UurGhrLykKKLs8EFHibJzDRMrR4lL/AILshCEw0PL7nhjGPrSj0L6E5brCdJkX/YjaPrS2Yx4eqxSlKUujGMeUMMPtRxhh7wauw1ssoSvqI/6YfOsIJEFpcMfS8FKXL0Y9ExskndYcYnGH0cN4sueoqiNNOPomYTRvV6XRC0eWMeUNp4kKipaJsN9LhfXTCT/o9ORaLC2ZRsbxCavalLh6PEJhDTKLLeaN6whMvCpmi2QDWq8FzxlE3Y2XKWYMu9zdWPSlEEVkMstj0mZiDxY9JIQWlUZnIV1eaQgzahJxSPAkLoeYJE0bL0LVlG97sCl3WITC/IcnfAhTa9eHun8xCCQlhoRJnECWtKUbGyC0bKNl2mly2NlKX8iIJCRBcciELm+INEsISJqx6iQ0JRS5pS4SITFKNj6HrSlH+VYSIIWGJtOo8j1Z+iha0bOIJIy5pS4QsMZS5eYcoliEIQnbCEITpQkJEzYXD1SyrzDG4f8ABFKUpRsaQcCWKUb0QsMfQnkIJiEIQhBoazCbzExCE1WCLqshyuBo9r/gmXFLm1fwc3/zSaMfg36TiUfA2Xuy1kTLy0NZhCYhMzM0miEyiYtuCjYnK/4LfjQ1N70cEoJYmGiRntQ9KPyXY0QhCEIQhO9YuyCg8NulURwGsIQjyxEIQhCCMSOary3+SYeITrWFszhv+D126VRTaT5vTliFpCDRZ/oeWNER8/pnUtKUpSlH9Po3v+Hula/Ruu60T5yW6GJ5SPqywcuUPpn5l1NxGi5PC1RPmM4doIerkQuikbQmbiFpV+iWIQaE/wDQjTj3n/g8GhiSG536s3EJj1d2sSKCYtJlKOsFwkLVlldFmEGh9LzfxI5ocqmc6uViEIcEm6cYSF0QQvCbyjWmVhZhCEITMIMe6fapt1DKDRhtgsq+kIL0gUPeTMEJwJE/C8NCEk1ot4QeleWR/OnMWF0p6z3yNz4TtUn6yxx8iEFgXITgQvwvLSfDPcutjEqfQQ+ExBoQnHo+HD1WF0uuUc09BBwSpojy8QV0eubwuAsLofS9Gk1CybzX6iWGsIeP6Oc/uiwul21Q5TSEcg96gxhwRsdXo1TPfC5EoTK6KPC6p1FKU5sTjLwh+C9PBcHouxYOVPDx2ZLwvBTm/CL4IfpyX4YkbC8CQlhCfSE6V1s+LS7+hZeE8oeK6F1+xSti75MRi7kf0vuH4OX7ErEhImS46HlaMuzHzwPFKUpS4e5ygstDRYJ3HwhH9JmC6k4P4isneNR9xV8DqGxbI1zR6EhISIJHBdDysvoY8NjZSlzSiYhJs0NCUYseCITuqo2yZwRxUwhI5+RowKLASFl8CFu0Qmj6GJzGQg1+iVCGNQ2QvAWLq0fRYm9UzSlLlsomVSvwTLgcL5RfHKOXo3lhPL9ELW73qWpoaIVdy8rbosTEzNOOGzRiCEdaUpS5YxB7QzwO+RXiUSQSDJyQhcrsuW+lrmCd+EQ8MhCSEuhrLPUiPpBqjWl2h9YSPg5eBKpcp48Dyhd1G9mXNyhIsNZhRiXZCEmIW5WhlMGrDfBQjTkTrBM+ceAoqJj1QvyMejX3LzMJ2tDQ1HhjrUQovwhxkZI8CQs+MUdE+CD8KUpcFvS4Zc11j3XUtl50WdQhx8EtIJaJUJ/cExk4ZJVDZS49ixS7RlYKO14eq1WqLqv3Cy8OPB7XEmfUbxBnsG9EFrBIn44PKwtqPpfJNFlMrWwbtaNwiRwQkIJCYhBIhPwXRZawhfie1PEw/wAC/wCFL4UU/gnC+x5gmvzDjjEN1EiRCXRe56PRjXIkL8EwYggkkgmsJ+eE/G8IXev/AAXs9v/EACQRAAMAAgIDAQACAwEAAAAAAAABERAgITEwQVFhQHFQkbGB/9oACAECAQE/EFqhYQsQmrY2MPR0UExPCFshn+48L8X9n/cfivxj8qEJhLyoQhC3bHkrDz1irETELWCHjMSX++BIqT1wQP0WtP4PypCUQvA3uhCFs2NgnmHgWoAYTE9Vh6vwWJo9Oi7fQq0XZP8AkflQsFlTF5CYhhasbG0vn2O+iyyur8wmJiyscT9If4Ll6P8A9EC+ucMe71QmKceYg2rHuhDCejGxhshIasoi5nGHGGExatX92PS6UYKrfg343ilyUTE2mieBCExPLHgww4+UsofVELCy1X/Wjy2UofhMX3wPRjw2UpcLCTwpEIQgkIWEXD3chEJmmkQsLLd35u8WvoTd/aFKT3u8suXhCEPZuxIghCEEtVl5UEEGiCWUKJimCFm4SIfBqi6vLmv0y7N6xaUerZSlGUuUhCguPAILImFsnhjQgmSahCZ9zxILkQteaHTFLl5Sz3EFsWiTp6tjej0ghcgxSMKUbGEhLLJ4WNCaT1G6IyNi+9HkEhC25ggamPSk/a5Eyu9WMpS6ITHNhphTORZ0UbGLVofgYxrU8e/FEEIW1K+Dmly9XzwyR/0IWPspNP0MbGxsuLlCWNfbDaRcp+j4QsNjxdWvA8NDWgryFioIJCWFmlLiBL/YpRyGv6Kq2jPcLDKUbF0RxfoU/vGNjZdYJYlJhx0VG8IQuBsYxbQhMwmjwxoejoIJCQllaUeGv1EQ0aGOvYLBSc9MY2NlGyiY3/mcqG9khLBPljVFBi4SEhIUuGLeYhCZeWQhNQgkJEIQmjY2UaSxjH/BZJOylKRGbGxsbG8IRQMYXH/CEIQSEKdCJKUHkSEEFwUuKXwQgkTLHiEIQhCEIQSITEy2UbHlqnoLq6YynYbr8GxsurkPp0SEIJCRQjpgYbwhLDFghSlGkbEyiZSlEy7snhhCasYbKXMwiTHrXayTh/2NDxCEEiiP4WbKCEhRsbG8ITFguruIYTKUpSiYmJiZcsf8FiDQ1sjip/6VJUJi/wCxjQ0QmUTX6Fof3CEi/C4Ynsz0sgwuRI+hMWvQPNKUohMTExMpSl1u1KLFKXDGhom39S+hIfj+wx6o5tBC+M0pSklSjrLilGNUK4+xC0XgxvFLlZpSlKUpSlLilzdKXVjRBrWOHc9j8H6PDyhDm6R+WWlLilnA8UuKWUaq6I4iHstqPyoXhgx5mENRumLBpCYaOPRv7y9HrgUbKUpSiOUdoWUJWWcdYpdaUTKUpd7sheJjIQhCHEXtCX9qHs2C6EiL5pCCcHAY8vKGJa09LKBT4YmLalKUpdZ/IWo/Ct8fDve1mYdrgI5fWIQgylFjKPMHntRqkxolWOOcEN0pSiY1uehk+v8AEUZCnX4IpOnrRCcv60byoWUeXl4cXIyE/Rvebm9KJ6Uu6xCE2fhY0dfh2QcY+GPFKMmClGN4Y9Y9Hilwng3fZd05yhCXV5TEylLhF1W78jkiTFJPfkWp/YtIWzfaKUb4Ze+BTSRlLlj8jzSl8dELCY1tp+GlKJiZRPH7Ar6dxydS9nq92HXjfQlvobEKD4IUP6SGW5hFDc4pSj8VzRPKZco6b78aYmNzkb0ht9lKUQc89CbytH44K6w3A5FOpHBoG8ETDp5o8n5Hh5o/KmJ5Zp1ElLm5pc09I2UonhMohx77WXh5u6XMVmKuC2hEhMaLtlvRwTQGxseGPFLqkMeywi4R1ePghudFl4dZZeHmlLi5bGAhifLCc1H9Bm++RidTg9kn2hquRsbwxi4pdVh+KiPe8fQfhWotXhj3ZV09wlwcOinBRi5HBF0G8DY2W8D7G9FosQfkJzlCJiEIQmJKMcD1lGpi8lKfrClKUfgoyyuKKXYz6jRkTEqZ7RdWdMGxso+VRjKUWixR5ngTE4GIhCEIQg0Ma7ITG6M9nGhMpcUo8XS5kaF2BTf0OgSP6etKjr5UEqfoo40UGoxlF1h5WaIpRvK8CH4iEUQui2NIE0PEx4mXrCq1N5hCb0OeyCoqpi1pB3DSfDJokISMTGPHQY8rS6QngWHiMTKTUwjrlyUGylKXNxcwSlQ0WNOMQSIQmig0QHtSHsEOqMpVgTPDnpJEJNUJlJhODHhFy9ZvMLHYT4o1TkoEJHBFKWY3l60uKdJ9Cn0JjRiYvAxkonWPVcD5RMSDaXYyb4E7CVGlFxo/4solmdlHXhhMuEEN4pSlKUpc0RYJiZPhi0hgl4R2JFcA17OCMWKJnK5JuqJYfQ2Nl3niuFo3rKEylHpRsfgpcJiY3BRMRKFhoijuRA1qxwPK6lODaOAx1wiPkJSEx0GPyVEbi2LNKMfjWjcFKKCKMfwhV2MUpSjaNxBJxs4vA1TqBzfIhomOg9FrUSSOii8aELL0TwzCy/oulKU7KUpR6UWJSC1TTGUYeKUpCH8lHIvEt0yiLijXe+FMTFllKNilzSj6EgYo2LDZIowxRpkpf4C0QxFE8UbKXF3pSlLhC2gSn6H6E/SMIGob+h9hEn948lQxKFjdjfg4/hvCEylGXxPai1a8kJmjf8m6rwPKy/O/EvK9n/B//8QAKRABAQABAwMEAwADAQEBAAAAAQARECExQVFhIHGBkaGxwTDR8OHxQP/aAAgBAQABPxA/wjQiCILEIxBBEEEQQQhBYh6QRrweg/Y40Cey9mj2T4aHxvbeyNJJ5nW65JJsWLEEmrzodBwLBw4P0ymozz11BMkzzMyWNcR0ZT3/ADwJ2B02njyxc0xjhzHsGM0AvsyT8JPPqOdC0HoefUEFixYsQRHMcQWXd4uYXBCPTt62eYjn1kaERzEREcwQQQQRBBBCIIekE8Wh47wXhvBHhHjHje29s+M18bwTXw0WJPM+jPMklixYsaJ6BYnZe1hFwpP+HTMt1z1GZnmZmedTmMZSWX8BueHebi6YVzWwccm8f7YbN/I6HnXEEHoBHqxYsWILEljQ5iOYkQWwwW6MNc/42eYjn1kc6EaCI5iNAQWI5ggghCCHpv8ANploeDQy3gjwjxvbe29s3wxWOx+jQSawksaGYsaMzoUxYg/2IIynAk+Bfy3LoG88zzozM8zo86BGyJIpky9sMfkJY0f0lSc55cXMv7rD+tDqQQQQhEejFixpiOfURBFWI+bl/wBQvujnTNmP8LLYI5j/AAHOhoSiOY1AixEG8RCENAx9UsZdY8d4pu17b2z4T4Xg0/FeC8F4/TmGMN5JJJN55saPM6FOhzdVwL9H+XcGcdWkSTM8yaHmfQLes4tuTLHo+Pzk/Bc2BHZA84D8aLE5jo8FyJYvXdZ5sWLEEEEEEEEcx/gI9IQQzEPmzl4hYoszGkUf4GVjcERZs65sxENmIfQAuiERoEERzCEIR9MZsFn6XBteG8MT0vFeOPDQ+N4Nd8OhyXdNMILH6KkknmZ5nRZWaU86BY48I/Ixbtn7VD+M9RmeZnQ+gjmyJZjm2pxcvv0PLGxBD0DAQzFhQsPY4fzmW7pbEGoaAQQQQWPWeg1xoFtjfmO/mwFkxoQegC3iz6mebATy6DDGubNmzZswwy39YBBBBBBCMIxtw0+HQ4NrwWwbXivHeOCHtB7XtvbD2j7XgvBeK8cPawepSjvCZ5llll1JZbMcxYDDJ9xj+rCPHzyr/Up1GeZnnQzzOhcrNnPBYTjAm5k+kH7zo8Oyh8A+VLJAJu6uVlMiaTZ5ucHLk4x1ggggsWIIIIILFj/CRqc6GgqwRyOZznDiW9Z8tJoHmPWy2sq9pb6jZs2fQWYYY0KUtQQQQQQQjHQdLJcdwXDeHS49tZ4bMgMviK3AeYOv0IwfwsHcz5I5QB4l6mnyXJJbNy24+jgRjjUUssspSzEcwmWmwl9r+WPHYHwH7zcpZ0POhnnQ+g5uRbXwM2fdbv0gmbiD7h/TL8RKnqEFixpiCCxBBYsf4MxHMaZsxzNw3gcLLKeXXdIYbmQ2jn1MsIYlnn051PQMMQylOdv0EcxoIQ0GGhwR3Na4tDjtiwy4O2AbA0lALFjHEdsw9yxh3Ojr3i0ufS3nQ3NQMNR5niWXfQ+gLYczC9hw/EQvKp906WeZnnQzzoZnQuc8ezeRG/C5W6WT2Fxl+7IurEcxHMWII0CxBpiTTE86NmzZhhhs2YcSpg2PE976YGHRyhgR6XQBZFdDL0GpzHoI5iOZS13ERzERxoEIw1jjuLT4bguK49oAyJPSMwQtk4FuhzAXcG3L6CDZf8ERAYw9A5SzqLaPje73A91/syyHtrLPM6HQ8zPM6DLeamHZiDcmW+NvwsF5CnjY/VyblqcxHMRHMR6DRn0M8zZhs2f8BjMMaDZGGCPSywSqhdIMu1hO/oOdTmNcaHMRGhznKUcxEahjqXBcEd7bLjuO2Sy7x4gg8RoAxJYhbYgIt8229Hi2tDliMxRuqMIcx9EUpTzLZjSoDKwe64i2YYf4nNxqM8zPMzPMzM86LeXHvGnOflAD8YlgZl/V2vhXJuWpzDERHMR6szZ1Z5mbMOhrXXEIeUOk8Q3P8AW6Um92WCxYseg59GPScxoHS82qONB6MdAxuJDe2i4rcI7FidQaxjUxizbzzZZxvDtCO8Obg6Or0BT0r0Bn0OyuT8FZ0H+4FyZSmeZnmZnmZnV72FM9bObxp4/2TqWGsDXlTD+VDCzqQwwxHMRzHobPo6TPMrNnQxrW++KQgz18iRwRz6VlJljLpDB/iCDQ5iIIIjmUvQfknLPoilvOUuNA4hxDaOUI4cR30kEETEkkkwFGOQuMMznzLmcpTnmfoDMzYjnSKRkT7C34/wB4v89MeZnmZmZ5n0MSWQ0xhndL+LRfKQn+/wDom6sN/QEREQRHoz6GzLqGbM6gdQaAinp2FhRxHPoWWTNiIF0n19YgsWNTmIILEERpeHfSc53ROUpS4lxp4F0XEjn3YQ4dQQgsSSTDjTZh7zls2RnLmfMpeg8dRmeZN9CESHR/fB/U3/xakNDzM8zPMzM8zzM86FyizOa56H+ksp/D5LfeE+Ybh1sUxYgsWI5giOY1WWz6VlrGbMspbzZsxHPpLACiI59DOh6Hn04ggsWLFjTFiCCCCCOY6f4BLlOW903TbAlxPiW2j7digYRhEaJYjtoe15ns2w/4AohyntoeZZmZjQJrGzPjL+T5z7O3J/CGFoZnmZmZnRnnQlhIkmUMdEuLRw7Ybn2MHzbQ2a990+tz4sLJYsWIII5iOdMyyy2bNmbMsRpLZsy6HmdSNAjYkiDEa5/wrLrixEIFixYsWLEEELEEaDciP8Y89Ol7k+J8WZebEPR9ECI50NMQ2k72Keqxc1y6PLv6kmUpaGeZllsy30E64FPkP3iwxFHuYuU5L4cXPQzMzMzPMzoSsI7WTGSB8b8zOG3bX2+qfzB+W2G3pLFmxhuKBnuisamg0zLMYtmzZs2ZaC3mZsyzM6hBHSzW8NCzpmbNmzZs6Zl0MWIIhCExYksWIN4IIINvQcylKcp+ob4nxoYsXHocMBdzZkghBBpjV0ZOPQWEsy63zXJcmpKXeUszoeZlsylIkwv/ABjZVeFiM6v+V1aGdGZmdGdVYWfAC5J7CdVfjNxyDMP/AB8MQ4RvZMMdyJT2HD8mG3pIyUQ8AIPZxnHfUjmLNmWWfSDM6Jy31HR9GIIW9cNlZeIYAg06We1mzZnUGjxpOUaBCExYsaNjTEEcQek5iUtaU9LlOUuNLguDRPFgcu7ZjcEckEEFj0MstvP0vdtq5rdbfdB8zlPQpSzMzMzzo5XXYP6NlLb8em5rl3+9RmZmZkmZ1NJuqybF3RPOVPDs+GFkwhkR4RuVwmA6f7vyLdzbWzZiIs2ZZZS6mXUdmgp5s2bNmX0BqXDMW21gAQaLopbpJDdh6TmxoFnTcugpCGgxJ59JzDtEeg5iOZTnP0Fbmhx3BYesfePa88GDQECb9X8h3lHozLLCu4bLMOY7efVaCnOcssssss8zPMc6UDPH8FgbcmL731UdDMzM8zPMzzPoLHbh2mXMzec3Dn8zpzETV7oSQAAYWMnD79HyR3nQ5jTMxZSs6M+gMWU8anpCGtLiOIsQasG9zb8lkDql+xK6oq8wzv07wSA2sssp0FIaCQhqdRhhjmNTnTpqOc5yuLR47juG4bg30/PcNuGGPB8X+8AKJwkNmzoY6EHK2yqh1632uVW5t9DLm5dLf9K0pSyzzoWWzM8xzLi3twI+wGROMs9hj+2AUS9mNzmdWeZnmZ5n0jcFiPAz285LlwZb8bfE2FWTowU/InzPlsGhZs2bMss+Zs2d7MtmzLMzoeghrK4jiPARo9YAy225n73uik3JBnYReLK6M5llkg3gsWLEwhJJJYsaEaDERzHpD4nP01XHcG92Lh30uDe89lebaN5nL+HRulk8rH4ueaj/AJ2689iiBPkX8smV7HQvNee597m3t7n1klKU8yyyyyzZllhlLPfFujlX7Bh/I22FgH48/I/S69LzOuJLEkzM+gnYESHCGOy/8GyIwyzt3OybI+LdqXB27T2HU+eG7EJ1ZlmZmWzpnVZ9BGg1FCAhDEGI0QG8eMKz5nQGSuDmcDaPN+wLN5iDlwb5sBjO9mdS6aswkmMSxJoc3SIiOYjnQcxpcpzx6LuOyWDFwah5LzXmvJB73u0PPeW8959FdDe9XQKUsssstmWWWWGViJ32s1Ofh7s/dwf+oH+aXLrjQx0Cbwn1DbUpREeVknXz4gybnw5Piz3+yj48x+eLFW+gL4vHR20QjTnDF5zOQgyL3Mj6mZ5lllll0zpmzZ1dSIa2oAysZZ5ddBcQBcqT97c1AiF4CzksPDpPPTsNAeIJiIYB3fi3XLGhEc+lkkmMSSx6CIjmI5iPQC9QQbFgbb5vNY8XmvPeW8ls8x53unyvN/meyGgFmKWWWzLMWzDobgne+Vl85H9F/wBskoYWc3WLJGej2W1YoTzo65sxMPhPpcquFu7dE7j0c9443JJy4Zn+ldTr7z/H8m/RJ1Xe8d1EFXl2PlYdSyyyyy2bNmWzZ9JENaUgZbvpcseI5s2A3tnCleuixivCDddgeYbJy7J+DsWYqqvVlnQz/wCCGWRKl0ILER6MWJjMSSSSSaEREcxHMahEoZTnOW2pcMl5Lz3nvPN30+7QXvpeXQ8n+BOoUpZZZZZbMstmWGGwbzqcZce6H9ZsFbl5G9DzjN1i2SxoJA+4RoDvyfp5jR1uN+AH9y4pw8T45SE7eHHwMN+o6R30Oi2bNm2W9YjDuQFJg2C83J5fCWAMQy7b8ufjNzwNPv8A9HqRE4uDvyurwwh9njKxB2RsexDQpSyy2bNmz6wg0skCA3YQBv1dc3PuXxdZwXJvpLZzBHN6iGXEx4DwXny92JaN2xut7lytthxocwQQakQRosSYkkJJLEEFjTERzENQQREpynpJ6EsXWTvJ3vNq2OrMun5/V8ClKWWZZZbMtmzZs6CZiyhS5Vt+Cw3Ab8IZEk6WXbJ1PJ9O3UhTNu6Djd2s3pcDl2H6DzzxFOb9lhDbD1J2PuAKlk9iUxv85gG121j8r2fjFgRb5/7A8nuWa4PYj+dY4dDLLZlsyxh1vJY3ZnAUTIOEe4zRXEMq7H9DchfbgwHZOpBiVwPvPtd0+TpoicpZZZbP+EINSzptbqm7cRc07zu2wnd82aWWfQEPqOdo+o9LgbDQ5gggsRoRzokSZJ5kkhJJYgsWLGghoBDUCEINBMRcRts9R3ry6iahvk9FWX0cKUu8sssu8sssstmWWWYzZYGE3QzmfK/y/I7SPT8AnJb5SNPifDr99dPAL2ibFOyDoXV6nR1gxujJ8Hrd3V6HnjO4NiPOwcNkXZMzwGx7N/c8wqjouoZ+jJ8ELlMyyyyyzoDGUbNjzPl+D/Oz9ZsorYhv0h5He3Rok4HQeEwxxmUpZbPoNMWLFiCDUMzxbId+0diFyguj951yubd1RdcQQhMsDK9CLMb0dky347aHMQRHMali0QyHiWeZknmSSxoEEEIIp6aAUhDxk1gzpB2ggiIUUOKU89LrXL6dBSyyyyylllllllmWXUVZu9JZEWwo3Ee+bHhEcXxB2fw5lYvbY8J3P/Jk64JA7o7/AJWOiDMpOFgyHYJZ8N2GH27geXxOwJQyr1V1ZGK9qRHJZjhNGVP4tlv9u+lSyyyy7yyy2ZSEljLOFxw5eWw9sD3hAghRkR6jcJXxdV2X3PpYQE30C8Zk/Nb0f6dRjvPPoxBFixYsWI1CQDLCc7v0sgbuI9u9lcrptYu+uLEIhMYM+ehEMY9foJFlcsRHMEcxBEOmYbMIhw9TMkmmLGgQg9YABqUy5jxsEMEIILFidrMbopTSfTVXQKUpZZZZ3mWZnV5l6Amb+9it6du7gbk/nZCAxmDqPVHRHZLc3sQqKxxwmUdzDZUeBMlcpxt2+vTKwJFhmN/wCcPzPmSXK67n04+NZSyy7S2ZbNmGW9ibKQXM+23u6dnbrYmiPwmJB3jxFB4SHFbn+f8AJ+LBblixYsQQQQaCENJgQfewgZ6mdK3AO1uTpFs6Ygg8RoPDMg/7GwY/s9YNAg8QQQQQWI9Jocww6JPMlixYsQQhCEIRoENYNANBhImNjPog9AMdQLLLKUsyzMzMyyyzocpSwySAk4yDN3r+Mfm/cMwgnROpbLTYzgN3zHYsyywyltMvgvsRt+cQYUJXvgf622UspZZbNnXMrcjEQHIOEfEwN8uD9GH5jFGAJuLlP2e1+sZtHyZPm2M4t+fRGIIIIINQRy7d1gY2tgeY6q1hiw6BBGWhkn8C4Ay923l3trYhvZekOPCIQNT0EakaMkljaxqQhCCGgNQ5jCNRzZmNXZ2fey1CGgxjFllllllMss8zMzzLLLInslOeh1YtLO5SZ3b9Q9+vDbMtUbLhTonJZHh+UdTwmE8N1zZhlIpg8+wYhWRcvDs5ylLLZn0dLEFztqPUm22Q/f8Ak/VnXGXUMP7mky698P8ASPCxh/G/b9W7oYsWLFiCCCCGXaLAHxZ4g7FsPoAC5nQIINAqPSM5s/toMMcRO5ct4TmCcGoTGjZ1z6hh0z6MWLEEdIQQQaghCOY0ZZZZ5ls2YbNmzZ1GOgWWWWWXeWZllnmZS1F0MyTSWLEcw4sDoYQWwy8n6n5NrH0JjnrHu/TPaOYTErYePCILuafKD+F0loeZ9OLGgIx4ssOP+hjhbDo5O51sGE97IjGX/A8R3hvJYsWLEEFi3aH9Q3F9vgiuA8TLlcspSzNiCDUMsXW8bI82xOyZZfT0lluZRxyP+rk4sdMf+Ys65s2Yg2bOoMMc6YhpCI5iPQHHFmzZmLLLLLZ0GhmzLMYxjGLLLLLLLLLPMvpAWMz5hj30IebtSHSWSRoYuOIwLMbiP8HI857zZkMxcc/9Dx7SE86crISdN4TuA/nO3LUedMWILEEQhpDhjk7ra2VPnfqxniy5Zw/5PytyZJLFixoJ12iAj0hy/wBTuGdp19+976OhTpixGWg+knaHNYEhiJtGU2dM2ZZYGgRtyHgeZipHKrlbE62bNmzmzZs6hqCGgIMegDDDDDBE3rZjXZegsWzZs2bNmWYx0GZsyyyyyyzLMrBoZpZdSUMQZuxB12sWhxJJLIYeQcj9zY2iXXrvvf2ZzCY9A4SwPFlPmLI8WfG+W8n8kd3UedAiEIU0gjCG9sHvEd29OwAf2SgEJ7DMrWffJL/Z7zNixEJhD7va2eHUfB7TlZSr1fQ+oCzyIMWQykAOLb0jxiYGODTGe88y2dMy2TQxwTplxmzOZc6DZs2ZbMtmzZs2bPmGGIQ0WxAiEIQ8ohqX3+vLNmWzZs2dCyyy2ZbMxZZZZbNmWWWl97ynnTFixHOg5iJGsMDe2x7GbNduDwZ5fEi/YQOEwL7PyW3ksmYYwdoAHf6poM51zKIQhCEJiCCNtZRxc8Acj7C3dYtgIH3Xiy5J7zxqQ2CRbjqWbD8Z193VcS6LOjEmDLxdUXY3k3b2BiDs3cYYySuQG3xFpLINgekGZIIBcToFLL6Gwx5JlxxLfR9Ky65s2bNmGGGIaDu6JCEzEKU8ryR6CzZhs2bOmbNmzZmZ5mWWWWWzLZmzLLPMM3agyWIILEEcRzDDZuGsw772HG+HuRQ5I258eY2z2d+t4qObZtn36J3lh3s7zYl8j/pbzSCb7YhA0xGhzHMbLLHaPRcVwBg7WfP62O2V/k957zZswhD7T27w28/K+DpKEK8rZs2dWWVeUG61fC4pe7u35WXaDHG0c6ActvkEF3HueZm4885W0ScxwGD9O8487RB2nQKWdMWNHiQ/lZh7b/yeZ5nb0ujz6yIYYYfQAQmfQDQFKOKQhCZs2bPpZZZZZZZZZZbNmWWWZkhZGfRMa5hs2ZZaGYbtx3s9vI9SYtnZ5wbjwm3kO0EQERwjsj2sswzslYHJ+yMwEITMaMWI9BqbE7DMrnK2e+Mw5FR7d/ytkZS2bONyUZRe6w2bMz6FkArwGWYuu+x2jiZauElYixk8yiI7m55H+of3oXHv2tmYss8yel50DsZQB0yZ0fQzPNnTMWfQa5sw6CiDZs2dGYhDQKUhDQzHMRzY1ZZSls2dHVllnmbNnVk0ZnC99jpx0sYs6EpCEwvX5+Tk9vMJuC527H/Tf3jMzb+HtG1eC+/+hDQkkn+IYAM575ZfwNg1CLu8D7wTjFHdU5X70Fl1zZs2YbNmWWJQ7T+tsQpoKtnQSQRsWSZjOvVYthAuI79/mIszz6XUGPZ/RpjR51dGXQsWLEaHoIZQww2bNmzDDDoMoYYgwxzEavMpaGWdXmWWzMzo8+lmdAkksW/rIt2I58HVs/6eT57Ti8odTh9zh8lv/ZhIqhge1zmZPWcxG3id53wnJbp7RsLLE9sfb8WRZTPOubNmzpmzZgRMAZWVzwHYuO0KzZ0zPOme/EpbMsNkbj4vs/dnDZ0fS6FzZQdMH0FjV5nVnQIILFixrixYsQRDDDZ0zqMaBBEQwylDFmWWWWWZ5nR5syy2ZZZnn0ujokniSSSSxY9RocQuzuOcezx8x+FEcomHxs/DbWPksL+A/tgyPI40Mzo64sRCG9hGb1x6B6ZUM2/RKZFlcqruu/LPvLx1gy/lS0s8zrmNc2brDuMrn2O1jBAxPNmXBZs6M9Z0bMK+XSdNynl8mzDD6nQ8M/IZX8zPNiSdUksQ0COo5caCENDFiCNc2bMcylEaDnTNmIQhoMYxZZZZbMsss6GbM6P+B5mxJJJq8zriDV4YM2up5/YfEHTmvkHZ+TD8wucvt4I/vNkwx+BUZnmZLGmNMQQjvZHJUoCEo4A5YEX2UdvxiWlmfSNmzZy26yurt9rZv17ybx2jhs6BswmYCZnU05l91udupHMauqy2kawhgd1uazBOgZixJPoCI6Pt/wADH2xpYnnTMMaBEeoGHEMaDFSyp0M2bMxZbOmdenrZnnVmSZ0xYsWIhc8xv1IuP7O583GymI4P7Db4LNTsAecDNkMYQPC5/tzk3mdMWLFiCCNuznNnnjI/mHDFZgCyjqo+huM2J7ynmZ9OI0cCdwdCNti94CQElcfExGiz62EcuRuAJzjs9SWfQyyt8HoHK7WZuBw8GhN4JJJ9QHUhtYsahDXEgiGhjqiToOgEJ0iLNmzZswxqFzokk8zqyz6+nqeZ1xqkk2LFixYsbQQQ3mvHg5A5H7IrjjTkOceQ/FwAN90Mn9XDwK98gfytIb6POmLFixBEywX5TiH0HBnK9JK0VDKbo+2D4sbuQZ7LD9XLUeZ1xYsWIJuVjNl5ltTlTKveyDLm2eT5kzvvixzY23nnb0M8+jFi5RxK0yC+APQWWWd7e2+cerHix3kx0vidcWLFixCERpiCDQx8bnBBBYnLUGY1It2oYbNmzZsw2bMOjzOiTPMzzPPqOZ0fXjRnmSZJLFixBYgguUsCWdwEXwD7B+ZMTPnQ/wBI+psx7WHLefl+FsvFik9IWN7Ed4ALicqeAmTj2YbYydcH7Y42QHqhsfLguQcV7u7p69DYsQScCROJfaH0JfVYrMJPC2PZ4uL23kBgxYznaGd3iyO11gnmZ59DqS6Xa8B97Q4Yiyyy5mgEsAdHeXLlnZxvmzD5nXbx/wAc3/SR7WRAeWYsaYsQRGpBEaJYgggsXCY6R7ZzpqOohpmzZsxLbY3RC5zo8zLLmZ51fU+hn1JMk2LFiCxBGpvZgx/fGP4vfEW5cp8mSJPgOADj6bqDFdfh9zh8mkOmNCOdC3icawDibHlXHseblZwBO75kewb+74spm5whYjKS8NlTaIwzyCazAzhiHxHJtsH67ZMnODF1nB03LYk3sWLEkjYdXQ5i5S8GNgE4TMNmXaN4I8BuvsQWSe3l+CTo7Ku6zDiFbHex5s6AjT6lhFOh0vv2g4eTvBBYsaGpoGz6iNMSTEhnTTERDoGmUpFlLZsoUKH130MWZnmf8jOmbOrzM640xY15R2sj/wDSrqROUNGMlz3Y69skG7Swm/8Aot/cid7ckmxY1Ljsh7MLPfcjvc8/hRzYSTMI3WRswSibTBo2CwzsnBjb3nD2LIwywc7QsWLEFyHmwSrHxJOpciDa3j2ZPc2s6MhxAcsZyyJvAOB2JTzOg4s9OYYYdp0O57h/5ZQbmycwLFixYsaENmzZs+gMRo8zJJDMMxNRs2YYhFmedDmGzZl0f8T/AI82fXjXENO9OD8rb+ycZGab3B+rZ28zMHjxztk7r/yfGIt8/wCA4+LchY1zocywYwgdk/AT8vuDDfR/1XOZ5nQTKWyZIhDOjwPMKqwHKws2GR3sQxDfl0GLEm0buCAfNz0hxNu6R2uWpc44hFML/wC5Zs2EOrP2OJZd51xOjoQdBuA9TonZsgWDl5P/ACLFixYsWPQNmzoIQg6LLLLLKeZ9Y2bOjzqeh0xYsWLGmNGdHV0efWevHodw8fqNxj/zeQPGL75y3Exzs7P7w/FzJWYOVu32cnyWxoM+gZYSRVSb3i+QyXloUgZLcTZH6wfy69DzoENyPBHBEuhgmzuHYDle04wDwcEi4Pm5QD2ir2LY2FZ9CG57aFxGc2U6zuln0CNrITFFZE6QbCfXp/owO47RoWdm+0ueObE+h9GNCZ3l9wmbqurHaNcaYk9TEOLb1sEZ8OgxjoFs2bOmdSPSFiNcWINGLFiSSxJo+h1ef85CFjzn6lzEfx9iZgI2ML7P9mVYGvsH+XMF2+RkHs4fiYQ6ac46nh5LASaHmWzDOxIsla874D8W5P8ANxf7GSxJBCYZQ5lsBckG9wP4IIXkZYyu2I9rl2I4IN5nullTorPBLvcDnRzZ9A2s2UjZbHJDIcmOjzKvWCwYnXMx6MaHM+jIF3nyDEep59OLGizMyMuWwb3zFs2bOjzHOhoegg0ObFiCCxYsWLFiSSSedXnV0ef8WPSagjYGDKrsB835krgDebV9g/27O5bs5z75xi2EWPpJ6nh2sxJcbIdg9X4e8EJYlswy2s8HNsHmU9hRx3Mf3DBjsaSrLOxeKH2mXeQfFiXSM5uzOshFODPyzFBgcBBBMrIi4OL6WcCu0srNj+7A87EBDiwWDbTNmWzGudM2bNhY4s72bNmzHpxobMkOFz7+LhFQh9T6TmzMtB0CeXQ6WbNmzoRHPoNDQixBBYsWLFiSSSSSZnnV9L6SOfUOnnFEjMijdGOXznHSxrho6IidcZyeSbqe2exNunL5R/MfyVLQMMs7KHDv195BTYXDp9Iz4uTuepu7t8eydo7baHQlCyZUnhMAfOdHhtkW1c5bvZMNkbJ96DfxAHFi6WAeLZOgydbJoTsEH7jwt7f5kZFcSWvxYjH3cp74Olk9p5V4kcWwMpuxxLKsyw6dY5j0s65gbPS4wek5g1N5sXZ3x4fEhC14273ERPozizLZlllOUznFPPUzozDDHMRHoLrY94iOYjXFiTaZJ0SSZJNH/M6Zjm5x58F/2gxt4OVPoWC5T4l4rwf/AFLU93NwcYjZen/GH3jtM3N6G6+wliJUdE2SO9ixBFvZATvgcfiD0CTqGT924szTHLc4cb4zxGlbkR7Sbj7TMCnnOZX/AHUYSSxLLT5M3CU+HMp5t+cLCGHMqB07TPNc7twsucFwerOxLvtLjFgx0U/4++ncsA2jLi9rM+kiNOUT7yg4TqZPqEvgH8Ro6ZlmOgsug6FZbNgvJHoAgyiOY9GbNSOqvH/qyq3yzt06O9xwnKbozp+dqERpiSSSSSSeZnmZ50Y1fSejOjzocwh9F32+nNg7b8A/luQ7L/qYltl7SAyA5DkejZOCTH02Py3+bYKB/wDXRNzQEQXPJ4CYjG44feE7mL4fVnm64x/pkhgG6PbdhHp2TMyAQTnaH8ZseTsee5P4iGAodwwn7fuxzAEBw6HVXadwrtGWwyIuxcPubMTDcLhPmUiHbue/+4ZuLtYeHmfYzLeIM9WU7m0gRwnSybg3kWVl5Z4S3x2umdHQ5/wMm52CwG7Ep0y6Hjb1DmONGNDuXROC8Jt6HRmzZ1xOcl6ShxIMWIxuusZhhh9GWYRHMaZsyVxdgPyZVylTlWDnO8jbE3AbDue0QCnJkR4hWF9r5HW2T5AfTY77RzGmJJJJJmeZnnU1fSf4A05A4++BAADBsLb/ANu25lne3j6X7T+X0NrMvAYV4LYe+D8XMs0x0f6H2tyMGEIx1Sbj3HfoevWWvIt5GQzl03zsfcMjwEME02Mg2HucAG/0TJxC6rl567C3B3F9C24G34XCeSg/CDLvPK9bKzZwO/aXG/bjKSsDWzhidVwyIQ7zrY5e8HoON2yKrJPMeSguNsztllti+ssy3gXeXznebqYnn0HPrYQ4DtE4G3jU9GZc6mhzM62DiTaxLeOLLCU9kxQve5PjvqzPMzoWIILGmPFioHNiCCCDMQbokCC2UgMq8BYGBHy/Fl5EHaYbBdmLhDtbsFwwT74sW4l6P3FjlhbYwh4ijMflP9ygOo+n/l+L4PQkzM8zozzOj6M6nqxoaCJPD+nLu9297/mK5RzIU9X+wsz7fjWaGiR8sTgfSxYmvdbL7MnzNKKbBs5sXz2udjYOue0vAAxsYlLw9sdCxgAuoMnDMOzCyC1y4HLhyHNgyOdk6mWLaXqj7p5Hg/GTLNJiNl/iRA3fekm+d7cbzgJ0y2N7nQAPOJHZuV5XB3mXDZNoHhAcHaHEWXwz3MwLI/4yD6CalWf8pzFmMPNgsWIYcTIUDcR3LIL9x3+bOjPMzzocxGvWJmWcOkQUU8bN0s3S3dLB0vZdhQA5XxG8Ec4zl90NmGWJM+3M6M7J1tp0cyYRuFypECJ1Mz+wFk5ydbETU5VlZTURl3EsEFZRkdGdDPMzMzdZ5l/xGoQaMO7/AIVH+RkhwOR6o6Jwkjg7DH3T+aQ7xBn/ANZsR44Y8e+5WSPniyP3f1ybt73IlcPvA+IEkKFy4GDeH+J3nqsZ2A4z3jDh3PbPbj8RZzkMnR3Rwg5PD2mAwTbOb132kvJCzzkfyn4GD8N8EH2v9QmcffpO4h0O3Yic2OfOJhsM8PEPgzeJDwBFc3+pbDc53TI5bGMW1txLmXe5Lhu2PY2I2wssszvflqc+o32I3by3xP8A+AFuN7BeZI43iKll7d4mcyWR0Z5nU9JBm75eCF2jGPCzdLHYTiwktZV4kz2cY7Y5/OZ51OYDeHGU57Tmrv2YIomE6QOQ5OlvWYN83YsW2NrbYwC56EOqu8zfI5/lgn67ydH+aPMzPOhJ5nR0eZ9Z6CNDQ8E+cOC7Jt4Oz4TtOjhMHfB+xP0XOOsqu03IOzvyk/pZ0nL9k7O9uDtuiAZuMewBZmRzvct0rCqe6llGK3rtICAoweYj0xd9+x325miSCDBlJwfMMr/jeZJ0EJ2sViIFDjPfpbWcvytt0OhNMObMcjLXZ6HsWXzGMG3G94287JYygOWw+4nDzLMstmWedDnQ19ow7ztlndmfS/4g7zwl7hYwpFwxEyLOw9nV5medDQ5iI0gMHPEeEZ2W4Nrxx2zlyQJts2Pl7vBO2qKr1WUVbFkQhwWAx9wWJsg/MJcgeLBOtsOzAh3ic+pO+CeLCMAqMMMB3sjnEyqXsd1/2Zxybnc0Z5mZnmZ5mdH/ABZiIjQXR5mpzhepZ/IRl4wBN3V9nk95VuVQAdTyY6P4uKC1iLk2dzni6zQdRw3vcBEI5Mx8EkvDRuflkNCc5h9hCUfhtfGFgcyO4jI+zZTsgykj3OX1/wDc7MOF28ZjZ6lrl22nBwSBhuX5RDwDF3WZdrKM8CyEF9r5JbiXvDMzrvLLdfsWcq3MzzK2fSc+jeehLa5TzBni2Opo6vpxoI5lknuxZuSW0ri9E/uOZ51Z5166EcyhhlowRRQbG5A9h37F2/g6DoHieLqOLY2IWZu8pBEskEsDo+TuSMI9htzHa3F22Mk2z9NxjQ4i4I48WJfZ/wBT41Z0PMzOjP8AixBBBYiI5sy8ukPYf2rryAweUwivKdd98Wxsybd1jb3IloxNtuB2z0328SG6fsGE5G8MdHyvI77O/ZuTl/rhbfiKn25oev5Q7e8nYe+7PGQfBYy5wuB7AXeU2YfeX02+NvWDzFHlbX/MQYWBjkuEYcZfVme6J+V7xf6/9y5NPgonmW1nrs7WfxYpdmXL+pJTYN57E73K97DKy7TNzwb2WOrDllhe1kzZszP+FtvuntDnZgzxoDz6M6ljU5ggjm6Q20lyXCXRs4ZZsPiwa41xYsaBYiGGGGIaBO8OC6niegLiXYnIFjBg0JPfS8e087LcLiZEOp7XWG+IzBLIY6XBcNsRE6KJD8zy6CSSSSSZ5mbEmjpnQ0IgsRoQTxGx0875H/ZbAGR+M/6vicPrazs7AfZcf2ToZ3wZT5SRN/zJH3fZc5H9EwfkV33wg2wFkDHRf5Fk+u7PBF03icvMD9NvmfPPT/UnG+bC2cnRPxZ3PCQcfAvyns9P4J7veW8xOmP23nDk2hzoYGztF0M4trXKxYvCxtjZZkOujO88MMtmWz/i2TMmWGLJDE865h1NSPRme9yXCHDJmG28HUEF7PRg9WMwWLEFixY0ERGhbRHwA/DdEOWdjQ5iW0dmiJKMjLKG42Qoxwx32uJVhYeWdIHmEj1S/M8vexJJJCSZsSSWJJPEzzqI5iOYiIIIJLKxzD4fs/KYFkDjpnD8N5RYdnqT80F8YR/kGwC88Cgw3xE57T6HfHVZzMLsvF9ZugPOBw3HzxcsCwpxg/8AsHVt0D4ZcbywCHNYeUcfqyuOZ3MnzjNye0Fv+D8Lk213tx8O8uGR3cwC9748Q4JmzrO6eYeD+YRY4baLLo6w7Q73WWWHQ59JoM+gv3OHQ8+g5iRtjd9Axxq8yw3JPE8W/ab3t/Eg28h6nR9OLFixBYsWLEEEQQQQ2QmgBin2lyqbC7XDUjQADzBjYtw3QWqdzDYwz37RPMTeojvu28XTOPG/7G9jeMp8dFgkkksSWLEkkkljQjmIsWIIRlJK9Lmp+PHf8ZjOZPnCm36xFsJMjQTZCfm99Rt4x9DZiOsN2gMmNdiHH7lAjwdkR/tgIhsw2ftHB5IHADqOji3XkAznmyMMbgOtlJq+XHKV42e3U23tw836h7U7vV1MAum8Q7w3482QrPUlzZ2hzzxBw5Fkkwt9pFrbly0LMOj6GPRiLENo1RuFznn0nW1hYhwsegYnThusTLhcpciW8LwHc6yGGQyPiCxYsWLFixYsWLFixBBG0MBQWVehIcJeiz8WYw67c+9hbiNCLYwJlbfaHDb+3TeOYdusrBzb9xkj2dRGTY/9bJHqUhiaGJJYmSSxBoRCCIapD2g7QGLqjPX/AOGdkDL8WYxtN+rfQFVd2wnePznv+DY8xnLt5nZOTgdD/hc0EE8Jk/cxhveRxOlYbdmZ2I4GMtish6RZFoEB972fEcQ7bEWHuEfYfspYii7bA8O8xw7rgnZZJZkZnIM4jIAdie63fpYu8EhuHm5M6dbMTqps+k5cWOmgaYhNiXLn0jLtHmeYlzZy6ddSOdWeLO8bksCzGSwxLkxdzRfiILEFixBBY1MWDpBYg02BUAbq9J1Y2vf3lzHLvPE3XQ5iJYSzANmZYic5wwL/APTYkMDm2PMOESZMZkjfQB5YeGAL3er92zUY3a11jE5mTR5nXFiCFls/SPGy7TdrHoCNu14we+Mv5IuEg+Gy2xvPzKfSz9vMebEoEXrk2/1YmhXxP4n5xbN9QcuOvzYXIh3gx/I0XJ/Z3AQd7uhgxGz2xKIMe7lZeeNjKmvHJhtk6I4e5IMHhWFbIdHf5t8c/kE/s9+bNnL2MpJnxMYUwEWWze90cWJY4dCbQy78WdD0HMRzHPoXNnfRmwObb827nTOob2cLxdIlXmHqHV5niZ73KwE85WF5JFnQRxY1OYsTzLDbkOYO1ixYc+wotHhshvOmLlZ0VjiMZICYg5HGZwgwuLHDvHkmmDDulgYsWbarIp+N/wCQDOghIQLextiSE9BZZZdTmDUvFrIe1hYoRoBNj5amT8lh3YB49fr9WFTG1vQQw+PINiB2McvdtzZ0TDJ8x73ltoWfD27rwRMkmIOuHGYTsHToZjttiVIQMW05xgsSaL5ng8xaSg53FnGe45+o8UAcFeOwdI52WZ1LI4fuzA5Q9jqxMFsTs0Mw2bN0swpzmaB5SyMRAhoHoedD1NWUPizvbCcva6T3s2M8WMdbEMoXCOXUejGgxxo86PMbTlcG4wR+eL8caSNHmdDQSnUoLDvO7hvoTI7pXuz4s2bMOI345vEd20bOHmOYUlLe5pzMDbHJLtFx2cuGZO3ePEFi4rZiqzV+3cH7uUzM8+klYbPLMs82LEQ0eXpM4yWHpqpoALEaE7Q5x4bASMf6/wBsLbYAA3RwDuvQkOBAMXvo7HWwQN8Ns43x+/mwQAAvc9x5fibDhTydR4+JuUPIm13UV74dzxMq8HC7ljcfw1/LOi06n8JcEo24xDX7BjLunuZyRoVIRB1XUZcekUMGRH2PxCy04jbcDYeE90t7O1ghhs2bcIYfmLN6Tyb5DO45uscxqxzHGhqxwZnvZ4l1dDYwaBZDIzgsQb2ywcXWINGMMJuk8zpwuMXPtPJ9j+rlEMNmWzb77y4u4PYtwE8liQ8HwpZgXRF5s7wwobMqfKGBmxdxL1ZkziMOkM945wljZlYnJGTZOIhh6zuyDxYYWeyuJOzswMMJsMkychOceZsvRFYMZeoyoeeJd5jFmLaU4jTzy2bFixoJlstkuDbXMPSNJ59BzEeeAQer5PhgUxEcygK7b5nbnBzp4/ZxHFDAAAB2A2CO8FvHObD2U/E7pvyZTiguhwYfggyACGEepJ1pbyHlezBtYkncvG2RvY8ZTHHJ+mzdBqqq8uM7n1ZTDG11McPkd55U9yeZd4YbNmGSOV5jv97CzvPFiD0DeYjhYixoy4wljm4Z0JfjXEWy5bELw06kcQkmG0tmWdOkNmdj8UisxCYd5IKuA5XpPl2u7y+0oV3HeINjkg69pwAydnMdtfxLsb2ywOB/5PmXayF64/aWMr8Eu+JbC2DGQjGxvbryT2XfFg5HNsDzbMOMNiO8HXOTaXOzDZNyXae4Tll2s43s52eXi/Czifa7A6MLvI7HBPudF9FY7I2SWWxmxY0ENEO9jcUCDGjF75ZYbMaM9m1h36j6mQjvBgxjnPTbD8XDwCpu584h2gzjH6ethfw9sybh5z+50zr4Tk6n8+ZECA34DoadJ94e8MTF3YcrLX9DHhltYsdP0Uzg6u/HbMm9Qn1X/bc+boWsq7AszJFV4juIRo8x0lV00eLGrciILaR0sWJJ4lzpuZ2E7WdcaBCDJBCONDDtO89JdoTmIZ4nmzoaENrYy85UrNmz5m3MmxzP1ZyaDDO3SRmAGetmX4Abon9ZuzBFMdsSw2Dck44hsSHrzY2YDHN0nMu7zNWJdAZuGeFsZM482VHbf9yGSz4Xk3nqsCb2c2cjb33YRnon+yy73uvdeSAZwEjpl0BZi6YsQRClNFtJ2OM5lE0nPNnZ0sxzEMzbXkY6k4fGQT2GbXmpdw8v/t5JvjLZ1GD9tul1n4B4DyuDuuZ4shvHwvzu/OjMCOADfPFlH43Nn7HeDHhuuPE3uxnHZ6kG9DvKuIQ5wRynZxKeu0CM8h/lxiZnxl/f7HAMClI+2IOcdYzwYg3p3v8AcRzoczx7UuXR5sTox3zZssPodcXIs+gGgWbEOImI5lF0hjGCNlLxDc2QyToaF0W332ZuFl87RDGma+o2bJlXLGpzp4kcwYumLDDZgTHRj5tkssxonN3ZCkM0d5Ycb5jE4lCsZ1HWXcnHUjJzwzzu8wmcNu8i3GYYc7ciYxOBwP3PJe+VKNnefkqzgZZXJs+LJC38Pns2IMxDWpTx0kIWHLMWej3xBjmObASAbquALMGzhD+W/wACFpB4deMpiK5yUy2CeyG49pprirOcTsfGF8vi/AuxGXBh5ylm18zAGx/7OcZx5FBHbKnAWAZN4J/qDgLADYjcuAZ2JjZ+IowjPzenknzFzk/R4khHCZXZsLO1uG8yHPLmVhzwY0GyY/uM4G1lnOd7EkgUi4pAyc3Dvpxhs3savNieddhZiOfQ8zYsaO08wbwmK8Ub9IsWO0MI4zAOxDi2zbGGMD5gS/URDDNDnQ0Db7WA+QfzLP7jmGN7MjJYByHeHGnFiDe5ywebMO2iwq9P3ZK8ndn0cafrRdr9w7rrHMMc6dsRtDZsot9r3JAPCbXQs7yyT6acD2bchXs7nUmAyWR8SwWZWVxNwz3zZEsGN7Y1Hw6JPZJYsQRCHMRBDUICBTMdDHXNhqXNnzu8fjxbovUeDBcspnybfM4agHIftOp9raIg4TZssKwwbru/9vL0cOXsbxir174z7nDZ4Gyct7GCAAAGAOCFiJ/8YsZsZNvw0bE8WI8zBmSOS334YSMEzvvZmDozKPXe3O0jyhzO/N4huU4724WRDtrzJDTGmIg9Dz6SxD1gQWJIWLEbih5Qz7aBFjODKxMO20MOPez79dOUvGSIuc6rdnk5hsEUA3V6SZTwd38J0hOVd3R45l3j8ydY4bO1niGztLY0Oxu+8sZZ5ZksYs6cxtmxoRzL7tmPiHezZ93ew8QIAO562Cg5IdGcRZYVvRbuGQ3f/EbRT24fqyNtaXg2jv4gn5YZvFbuqml7Z1gabRBBBCDEQ73TQgHBlc5742tg+RnghbZzO0Ttt2MFZf8AgUHv0cJxDRNtmQeo6jjPDz1sYCG3JO9nWIFO5sfRYxYlxzMeoSsS8w5kjK5XuysK+wH9YO5jI90Yfwsm2T7kZD3MN+NLdLZLk9rMHW3s2CuVsYm2O87WTrRwGWdRPMzYsaFjb0pY0xBC4xsRzEm8RzBbIIYNowLMcxEMruWxvDvDxLV0uFt5NUdy3vyh8QzvPs5HV9JS6RHNnBpKZRMSkXK5h2sZbdPExq6ESltrmWxA7GXL3hs6OWdnNkwe1gIGd8QGAS3pxuCS5du0P7Jlk6rkltrl5E5ggycJ6ACE9ulrAArsHK3Oo/K8lCrlxyJhPiI5iIyzk5mOJUw4MNkHrKOV3iJlycDkjZUdzZ8yP6SfmScOmEphP9ey8b/vaYlwSph2OVOwY4sWJ3TAg+M5jaRZxMnqtubDLH6bH6gsadR+4nw/isRPF1ebbgnhqZJ4d4E2QjYbN6zwp2vlPobH+BixYsWIIIQ0I1OYGFylvDZ7WHmHqcW4nZSGW0AQ3ST0ZQ9rPYm0hvFlLizZwfkkGTC8jt6SOdC0cmJWGMSTFnZxHaUbtTv6XQ0OIdHizDKEHgyIYs7YZcMOIfgc2B2nRf8AoEdGUs825BXFjRl5Xb/1Kxt5PHjQCCCxISSIxsq9JNkF26ny27iahLhP/dJoGAf+p4jmzICgAyr0j3McIxt3WwwyZPB3HZIMCDIerEIR8YdzswHAPYnWW51foLotrKXOcfIZJXJhjQ7/AFDwkXDhg9hyfemdeEHg7n2H3FdEGQ7JDBjzckNliCLlDIbHcomPvLYTzoejHo4ejFiSxBBBBFiOY0IQzICWWIbo3sEG2uLhe70MQWJw4l2l5Us3ZxZIfQRzHiHzEXNmzYnpiOYAYndnmdM2Z0IiGXTNmzYWExN0nEsEMZxjJCd2ZhjEKb3wG572VndJ3S94TByynOTwbAUkOo2fRxXh5/OjdEaPNjLD3lh/xtM5QtGe88/+QW6Z8f8AmYgTs5EfHaBGgYcw+B4mYNniHJeJFXvoc2YZeZ7249zrMjrxHVpGe2QWUwDnrfaZOS79bjaOPseH90YSrjG+ZfXA57hnzbGHVuSTI0YsQRz4WfDtJjZuJ7yyzzoenGgasaBBqENAhMWLFiCEBINwXJ/ffjWxPuObEGLGm7ERz6PGhzAQYYcNuDFxx2jXERpmzZs2beYgnTM6uq6HMRE2cFmztLDiwSmWeNHnbvPRY2ekLizt7LQXazIO5Mq34uRdurLUHhJQeL+z7nT4jCwjuJwwVxY8wXIT4JTA9za/U+D8CJG3o4dvEpbMcbjcJZbOrmKxoaEcz3zfI6cLG8Yq3C/NVTKxAcyOOMH9yPfH/Jy2bn/7Le8gjhw3jJeSBD2YGbe5hocNBNhG901x+Zd559eNAg0CCCxYsQRAggsWJ2x8G5udQ8KY/cvgeQl3IX+TiOGkasTvvYs/m5IPkW3p8EcyxDr27Gj0nM6r3hznic0cQRBBBqmmdBlJMTtzddX0Z0x9xFjneG6WFl2c3cZnTMNwzc5jmQe02MA4Yith74bws9uYZYE6fVuLJjfN5pjaNueBgjHeJnJfNh7K/EEZWhbO9mGzOcTrxLKzFixYhcidAOEKAZ+0sj/nJst6y/BH1icO2EzjfD5hM3zIIyiYd95V20M5mGH06Dm/M8BuLFc8D8jLOXB3JN4xqCHErk3uJ45sSWPRixYgiGoIegAgggsRjcdsP7FYS8+D3etl+NDdtmecTv4/6zt1M4AB8uWWPzZzs442lsz2Bg+rE34eWzaMHd8BvoQw2YjiGW9xh2lnTMcgls0AiOYINGJJPQM3nlMzz6sw8Fmz3ghPbmHTpG/UjNy1GNgIO9WBhN5ynlYbvUuGIlsd5uYlO9A6+bOJZbTzCkYALHG8FupY40sHzLaX0FiSebM9pnmCxBBBbS9t5cLNLYKYz9vmUvd4Y+0I6TjJkPdsE8AyGDEG7j2siupbm+PkgDCcB36MGeEfZMP7jc0vfWLc49EHSDEbWb6CCG9ixYsWLFiDQJiCCMWSW3B7shj2VPvF5wJ+FXNzQU9/6JyBvCNbROQL+7EcwZRhjth/uN7MrBGbxnaBYR8Z3PYTSI7Y5f8AyEe4r+hZ1VvV62GN3Nn5Zz8JufiTee0/pY+Sef8AzqRZlvbyDfQ7I9LuYhlKNDQRxHOgmZ5huvie876YsNixMzzMNgncQdUdIYMw7Zi5lhMEiYHHpQ2HFmAwEORLHzE7MReJGx3DtZcTzLM6e0w4s2dA5dnOuLrq6HbQ2II0MQXUPCYsv9jJESquDhEeTc3g2QBLHBgNNlMYlTHTsWxNBBdz/iDcsvdGH3j49j+/+wbE6rw1MTLvbjBpYxYsWN4IhosEmLA5cWC9mP8AlDwPrtP0fqxpbz+rCuSdfxYhdKbrmfaLEI7yX8ESvuSxL7D2F10O7MHGeyM5lbkNiHYkdv7MYZHeKh9zvt2zEZc7KB/N8T6X2sWATyifvAfmTyr7mf7gX8nf0gefbr/uT6fBakc65+529o5nDriTbaxHiOgjQQRoJLFiGzHTESwcneU5tjPM8zGm+PiUsNnnbi70JjmQ5gO8owc4NoMgwwaPDZTtzA3+N7qnnRLIlySwQ+R9z0c/jG6X5JDqkeSvOkt1WInJ3gDACwyUJsw7Nr3j8aY1ZJkk0BBYsTPDHsz/AITy/CCkP+EsoxNBweLFkFOTewbyT2d0xTyM9hk/I3iIwjbOyYxlLboWPSgLEYzJ9gsIuf8A9hiAQ5eb7f8AUMON/wDtMTjI4cDxH5i7pfYkYB5Qwb3EJKkoF7sBFMIu0KLjoqv4t2I9r9xtw/CZX6j23JYLtr0aFjA7mP3AK19xG2+UG3O3uSHIPmD1/eB5zjxpixoWLG8QZI2ZS0NcZbaNwuEF72+OYLEkljQk4bo2J0eZyFkzuEMRnmY05XBeSN23ErkurlpzPPO91kyXEMbLFiG4y4xxOjLqc7WbeBbWSDOZ90ZxtHvC95M+8Lwtkb8lkPOgx4kAl09CSWLFiIGrDe2N5I5X/WMf+Ho0Ek0FZ0GMv2ocn4ZCOc/UMQDjMzEkMWEg4nvKILEpKdJ4Ty7G4vwQ52ymweNmfiy/vhGfuwA/dn7YJL5w/wAAjmAOAPzMfgun+qd87jetkY9s+2ynvXV9h/bNM63ysfLGHmO/8D/c2+HzgCGI+APtb6SOpgslgnYz+Y1AO+R9F1/emL+5ifdtU/OPYM77sDxgPMA87WXUyuALkF9BriCxYsQWYz2jnQQQWNApoWS3QbnSEGjE6DoZjEJNCZ3k8mJ2D0k52+4CYZOdJLGqum2dtoE/s5rbLGXNsclvYLGhxY0xYk7WAnVsRjNzsycss2yYsruwWO3oBEzC74ncG9jN3w+jEEF7dBD0g3eLdkJ0QfD/AHm3OQSbSaJHr1sUPPxzkf5Y56L8XkPvfBmG9iSxW67wm6D3ZbgfZgdyxdbpYbNPwQ52k6/IwYiOXD8n8Ls9k0fn9Fuu284AsB77y7xohMbCp88TJAzh4+y7HxbWr6sXwYIzHcCCGJBybr6xcwJ1L+VJKGNhD8EWgh3LPSPRcyBkHusQLHjtnfwhOGb5/k6IzF9Zcewnco56dLMg9IHjaQ6ZkTk1BeDMJx9V59/wZLmcoYsOPzC/+TUgsWLEH3BtvJhjnQEFiCzOxhi2w6yZ8p7b6A2ksSTzYp5hJY2ukPaz6yHYNpuSEmD1sHGqwyyaJxbN07rMu0m9iCxYsa9LEwwWMmWzZjZ2WaeJFVY1Tu3LIkDBbWJz3NmNxGWRHk0dC3aGYgg0MLymds7/AFZD7xgPtlR24aZF3582UluPEcPB7XMyDd7nY/E/bHXC9sB+bND3INvsuSMOAH2bZF/6IczEZkPg83Pfdwwsc9EwxM5+BX+RvhGMgfcwy8fIzgA94BPufst+1kQ6IEfBz8QdFnCD8sxls6E9gALwoA5fKx9M28/02nuCFhaJsq+r8svllc5f8ri800mvofc0wNyEV/J7tkfcXJ+Z/J0B+DO7X/RbVh9kE5Jh5Tm6aXmD+ZAALhOUmGXumx9sX+gJugf9jdvZsB1WZEmwCwAdD6vY8W9nLmO9D6hCdg37R3A78XBb9wX6wxHKzg4Z/Fs7YxYuC+0t5JHVJzYzllBGCxIBY2LFixoEZEwLI2zSEEERN5biCCxbPFyaMDmWdTo5zM8zr72bGhibSQsWNo5li/DRlNtCw9Jy1MWLFiCCId5uMRzygMW7aIDUN2xHAOZ3NxJnsbtkkB62H+7b/wCT6ln9M/lk5N0Lf9495UyIeLd0+0x4/wB+H/OA9phcMm2zb8QuVHhvksDn7J4r9xOXHYyMNtDuiI7ftiSds7yQcqCW+X8xFEDOMWG7eFufy2LMehfpDnhSOLoX9wwY4ONuIrPiMZn84+zgtviX+4eBBkOQkeG2wbGV8TZMh2zzDhhOrvsFnRWEyAY8BiAfMAcfOLF9kbH4hTOfXOt14fP/AJKg66qvwEOA3ul/OCN9TuK+HMAOVOvL7Wcx24gfAWFnzAx/Udzj9n+sni3yv5IOPZX/AKkcIPmNnhnb8GY2ZH7VA5Y7YbzeE7tzdji37qzgH0BHof8AH3nNy/77w0N4bvJO3N2BFJungyuQo78Qchx5bl+7DeFyPd2srZ/mTz+Msb/hc2We4/cDwpvkzFZd4jiLct5aGuINWLEmbggsQ6WxY2bFQgsGkjtPJjR5l6S3KZ0ZnmxBBtYzMS7Gib2IINHU0bmcOZmLHaxbWQzlcbAeV2JLBl64H6SVyXYInys9C+w/pt0X7o/sCjnbnfCToA9Fx9yztnegVYHJbrvfRC8j7L/ch/0/d0WL/neQznvQUH7l8bnb/e3jX2dl74UkgMHZzh/2RzwPj/Y7rdf/ALmsjxlz5LzlJ/2rf62myMZ3w/8AdkBB0PP5mbt7og++GZb/ANkH7SLPY56bVhRrtImXasu5j7jBr4n8v6eMrhTkkfDEiGGOUfxbr3ZVUDbLggjJXgf2H4y9v98FuP7J/bd3D3f9oTY+T/ZYnIe535bnF9chPjJsI9TJflH6h2cPuf4jP5lJ53j6WQ4X/vkkYp3hLqT9dzdu1IYLaiedkcih2SO6T7v/AHDv/af7ti+3vA/KNsI8f7L/ALr+3XN/x3v/AL2AAEcOebpV+T9zhwcAMJ5cSNj/AISb5C7IzCjLZ032V+RhK8F8rZIcZi8AaQCnV92V5V+dMej2LqJjQN0xd1IwBIu7YuY3iyIggsQQQmxYsRAkjshtP7sp7WIIjxBvciSe66aHUElixJYgiOY0SZ1yTexBYsWJlDtH0tnBOFmxI1ZccCW89I8/Ev8Ad0H2v9wuX7ggnC75n8xmfZdn3OX35/tblRzhLAvxSQB1e+U0PKZX8y945XMHx/hRD7iy8EBsMWfmV2xe2zM+yxxOWPo43Bz/APe89l+9hA/fmMh3zgy3svfJ4nWH2myYfnoiXyqe9ljf9wu8G7M+bgPujuH3IE3xeYn8Ck0EOq2W1Ed4P3YGR/tH7sHOXthcmvkB+qZP/AXGJ2wP+XMMPhDB/IWQZ3bOU2+zYl6yvlCw3OcEfYzAdYQmFezwRu0Z9v8Afmy616vBbfPzskDO+BvKs31SIvEscW8N3qM78WinNOmM3vvdkm7m8Ylo6Drwz7wHAbD7p4+ZRnF7pH2NhZ+W/wDc5NvnU/ieyf7B1fj/ANSb+P8A3flIS38YXzH2eEuCQPtjfziwbwK/vQ0eYXsg7EvCQ9WB6WLokOxbDiUvC4U+bZ5xYOLFglV30zMcRnoc6Ecx6pHDPS4tDlrHGhHOjoumg6zzNy06aPM6nMRrwuURp3nnQTPa7e9+dckLJu3VX3C5N7mTxJxy3CCdBhOAN+hr6Rz6Mc3eedXmOY1AddC66HMXCdipPLcH3t+TfbrdXvc1+Bpz+db0TdrkaefO6IkwbtyYuk4sBHsY0WZiOdO09ZTqF/zt+b5YQbmni6rh8zxf1cZSEOyZjsDsMat3uWk6avTRy0HWOunNu086HN0v/9k=	2026-02-21 17:53:21.757	2026-03-02 08:21:07.004	f
99YneHrHAILof7dvLAUZk2hbzR6U88N9	Ibtihal	ibtihal@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-03-02 08:24:12.174	2026-03-02 08:24:12.174	f
Ihd7eh2NawDaJL2Kgncw6pDlfrsFLWcL	Ayoub	ayoub@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-03-08 16:00:52.882	2026-03-08 16:00:52.882	f
mBA4Xkqq9JEuK2myGtaYqFqRsjpP93ey	Anas	anas@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-03-08 16:01:29.826	2026-03-08 16:01:29.826	f
54U9K5nz949C47LxepSOHVJqigCoAy2e	Amine	amine@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-03-08 16:05:20.218	2026-03-08 16:05:20.218	f
6zuuUAYiMaL0DNTuh37xy6W08xWuMUEf	Malik	malik@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-03-16 14:49:58.988	2026-03-16 14:49:58.988	f
f0gzoeF9XYJ6ICFHAQ81clRuioCZc1XM	Marwan	marwan@gmail.com	\N	\N	\N	\N	\N	\N	\N	2026-03-16 14:50:51.905	2026-03-16 14:50:51.905	f
\.


--
-- Data for Name: verification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.verification (id, identifier, value, "expiresAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Name: Badge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Badge_id_seq"', 1, true);


--
-- Name: Equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Equipment_id_seq"', 1, false);


--
-- Name: Field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Field_id_seq"', 34, true);


--
-- Name: Location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Location_id_seq"', 12, true);


--
-- Name: MatchParticipant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."MatchParticipant_id_seq"', 218, true);


--
-- Name: Match_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Match_id_seq"', 1161, true);


--
-- Name: Message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Message_id_seq"', 35, true);


--
-- Name: Payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Payment_id_seq"', 130, true);


--
-- Name: Rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Rating_id_seq"', 41, true);


--
-- Name: Schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Schedule_id_seq"', 313, true);


--
-- Name: Sport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Sport_id_seq"', 4, true);


--
-- Name: UserSport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserSport_id_seq"', 1, true);


--
-- Name: Availability Availability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Availability"
    ADD CONSTRAINT "Availability_pkey" PRIMARY KEY (id);


--
-- Name: Badge Badge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Badge"
    ADD CONSTRAINT "Badge_pkey" PRIMARY KEY (id);


--
-- Name: Equipment Equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Equipment"
    ADD CONSTRAINT "Equipment_pkey" PRIMARY KEY (id);


--
-- Name: Field Field_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Field"
    ADD CONSTRAINT "Field_pkey" PRIMARY KEY (id);


--
-- Name: FriendRequest FriendRequest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FriendRequest"
    ADD CONSTRAINT "FriendRequest_pkey" PRIMARY KEY (id);


--
-- Name: Location Location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_pkey" PRIMARY KEY (id);


--
-- Name: MatchParticipant MatchParticipant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MatchParticipant"
    ADD CONSTRAINT "MatchParticipant_pkey" PRIMARY KEY (id);


--
-- Name: Match Match_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Match"
    ADD CONSTRAINT "Match_pkey" PRIMARY KEY (id);


--
-- Name: Message Message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_pkey" PRIMARY KEY (id);


--
-- Name: Payment Payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_pkey" PRIMARY KEY (id);


--
-- Name: Rating Rating_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rating"
    ADD CONSTRAINT "Rating_pkey" PRIMARY KEY (id);


--
-- Name: Schedule Schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_pkey" PRIMARY KEY (id);


--
-- Name: Sport Sport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sport"
    ADD CONSTRAINT "Sport_pkey" PRIMARY KEY (id);


--
-- Name: UserBadge UserBadge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserBadge"
    ADD CONSTRAINT "UserBadge_pkey" PRIMARY KEY ("userId", "badgeId");


--
-- Name: UserEquipment UserEquipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserEquipment"
    ADD CONSTRAINT "UserEquipment_pkey" PRIMARY KEY ("userId", "equipmentId");


--
-- Name: UserSport UserSport_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSport"
    ADD CONSTRAINT "UserSport_pkey" PRIMARY KEY (id);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: verification verification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification
    ADD CONSTRAINT verification_pkey PRIMARY KEY (id);


--
-- Name: Badge_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Badge_name_key" ON public."Badge" USING btree (name);


--
-- Name: Equipment_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Equipment_name_key" ON public."Equipment" USING btree (name);


--
-- Name: FriendRequest_senderId_receiverId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "FriendRequest_senderId_receiverId_key" ON public."FriendRequest" USING btree ("senderId", "receiverId");


--
-- Name: MatchParticipant_matchId_userId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "MatchParticipant_matchId_userId_key" ON public."MatchParticipant" USING btree ("matchId", "userId");


--
-- Name: Match_scheduleId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Match_scheduleId_key" ON public."Match" USING btree ("scheduleId");


--
-- Name: Sport_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Sport_name_key" ON public."Sport" USING btree (name);


--
-- Name: UserSport_userId_sportId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "UserSport_userId_sportId_key" ON public."UserSport" USING btree ("userId", "sportId");


--
-- Name: account_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "account_userId_idx" ON public.account USING btree ("userId");


--
-- Name: session_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX session_token_key ON public.session USING btree (token);


--
-- Name: session_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "session_userId_idx" ON public.session USING btree ("userId");


--
-- Name: user_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_email_key ON public."user" USING btree (email);


--
-- Name: verification_identifier_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX verification_identifier_idx ON public.verification USING btree (identifier);


--
-- Name: Availability Availability_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Availability"
    ADD CONSTRAINT "Availability_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Field Field_locationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Field"
    ADD CONSTRAINT "Field_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: FriendRequest FriendRequest_receiverId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FriendRequest"
    ADD CONSTRAINT "FriendRequest_receiverId_fkey" FOREIGN KEY ("receiverId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FriendRequest FriendRequest_senderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FriendRequest"
    ADD CONSTRAINT "FriendRequest_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Location Location_sportId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Location"
    ADD CONSTRAINT "Location_sportId_fkey" FOREIGN KEY ("sportId") REFERENCES public."Sport"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MatchParticipant MatchParticipant_matchId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MatchParticipant"
    ADD CONSTRAINT "MatchParticipant_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES public."Match"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: MatchParticipant MatchParticipant_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MatchParticipant"
    ADD CONSTRAINT "MatchParticipant_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Match Match_creatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Match"
    ADD CONSTRAINT "Match_creatorId_fkey" FOREIGN KEY ("creatorId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Match Match_locationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Match"
    ADD CONSTRAINT "Match_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES public."Location"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Match Match_scheduleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Match"
    ADD CONSTRAINT "Match_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES public."Schedule"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Match Match_sportId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Match"
    ADD CONSTRAINT "Match_sportId_fkey" FOREIGN KEY ("sportId") REFERENCES public."Sport"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Message Message_matchId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES public."Match"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Message Message_senderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Payment Payment_matchId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES public."Match"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Payment Payment_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Payment"
    ADD CONSTRAINT "Payment_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Rating Rating_matchId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rating"
    ADD CONSTRAINT "Rating_matchId_fkey" FOREIGN KEY ("matchId") REFERENCES public."Match"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Rating Rating_ratedUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rating"
    ADD CONSTRAINT "Rating_ratedUserId_fkey" FOREIGN KEY ("ratedUserId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Rating Rating_raterId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rating"
    ADD CONSTRAINT "Rating_raterId_fkey" FOREIGN KEY ("raterId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Schedule Schedule_fieldId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Schedule"
    ADD CONSTRAINT "Schedule_fieldId_fkey" FOREIGN KEY ("fieldId") REFERENCES public."Field"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserBadge UserBadge_badgeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserBadge"
    ADD CONSTRAINT "UserBadge_badgeId_fkey" FOREIGN KEY ("badgeId") REFERENCES public."Badge"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserBadge UserBadge_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserBadge"
    ADD CONSTRAINT "UserBadge_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserEquipment UserEquipment_equipmentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserEquipment"
    ADD CONSTRAINT "UserEquipment_equipmentId_fkey" FOREIGN KEY ("equipmentId") REFERENCES public."Equipment"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserEquipment UserEquipment_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserEquipment"
    ADD CONSTRAINT "UserEquipment_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserSport UserSport_sportId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSport"
    ADD CONSTRAINT "UserSport_sportId_fkey" FOREIGN KEY ("sportId") REFERENCES public."Sport"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: UserSport UserSport_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserSport"
    ADD CONSTRAINT "UserSport_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: account account_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT "account_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: session session_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT "session_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict rgqNnK9JaMKOxl6E38d7s8C3JY2NsyW0k8rJRebXgXlFoj2M1UVHhkcbgJErsjr

