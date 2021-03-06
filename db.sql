PGDMP     -    
                y         	   SkyStarDB    13.2    13.2     ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    16394 	   SkyStarDB    DATABASE     p   CREATE DATABASE "SkyStarDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United Kingdom.1252';
    DROP DATABASE "SkyStarDB";
                postgres    false            ?            1255    16443     afficherclientreservplust700dh()    FUNCTION     ~  CREATE FUNCTION public.afficherclientreservplust700dh() RETURNS TABLE(numpass character varying, nom character varying, ville character varying)
    LANGUAGE plpgsql
    AS $$

BEGIN
    RETURN QUERY SELECT
     cl.*
    FROM
     chambres AS ch,reservations AS r,"clients" AS cl
     WHERE ch.numc=r.numC AND r.numpass = cl.numpass AND ch.prix>700
	 GROUP BY cl.numpass;
END; 
$$;
 7   DROP FUNCTION public.afficherclientreservplust700dh();
       public          postgres    false            ?            1255    16449    ajouté100dhpourlits() 	   PROCEDURE     ?   CREATE PROCEDURE public."ajouté100dhpourlits"()
    LANGUAGE plpgsql
    AS $$
begin
    update chambres 
    set prix = prix + 100
    where lits > 1;
end;$$;
 0   DROP PROCEDURE public."ajouté100dhpourlits"();
       public          postgres    false            ?            1255    16444    chambresnomcommencepara()    FUNCTION     U  CREATE FUNCTION public.chambresnomcommencepara() RETURNS TABLE(numc numeric, lits numeric, prix numeric)
    LANGUAGE plpgsql
    AS $$

BEGIN
    RETURN QUERY SELECT
     ch.*
    FROM
     chambres AS ch,reservations AS r,clients AS cl
     WHERE ch.numc=r.numc AND r.numPass = cl.numpass AND cl.nom Like'A%'
	 GROUP BY ch.numC;
END; 
$$;
 0   DROP FUNCTION public.chambresnomcommencepara();
       public          postgres    false            ?            1255    16442    chambresreservelemois8()    FUNCTION     B  CREATE FUNCTION public.chambresreservelemois8() RETURNS TABLE(numc numeric, lits numeric, prix numeric)
    LANGUAGE plpgsql
    AS $$

BEGIN
    RETURN QUERY SELECT
     ch.*
    FROM
     chambres AS ch,reservations AS r
     WHERE ch.numC=r.numC AND EXTRACT(MONTH FROM r.date_arrivée)=08
	 GROUP BY ch.numC;
END; 
$$;
 /   DROP FUNCTION public.chambresreservelemois8();
       public          postgres    false            ?            1255    16446    clienthabitcasablanca()    FUNCTION     ?  CREATE FUNCTION public.clienthabitcasablanca() RETURNS TABLE(numpass character varying, nom character varying, ville character varying)
    LANGUAGE plpgsql
    AS $$

BEGIN
    RETURN QUERY SELECT 
     cl.*
    FROM
     chambres AS ch, reservations AS r,clients AS cl
     WHERE ch.numc= r.numc AND r.numpass = cl.numpass AND cl.ville='Casablanca' 
	 GROUP BY cl.numPass
	having count(ch.numc)>2 AND count(r.numpass)>2 ;
END; 
$$;
 .   DROP FUNCTION public.clienthabitcasablanca();
       public          postgres    false            ?            1255    16445    clientsreservéplus2chambres()    FUNCTION     ?  CREATE FUNCTION public."clientsreservéplus2chambres"() RETURNS TABLE(numpass character varying, nom character varying, ville character varying)
    LANGUAGE plpgsql
    AS $$

BEGIN
    RETURN QUERY SELECT 
     cl.*
    FROM
     chambres AS ch, reservations AS r,clients AS cl
     WHERE ch.numc= r.numc AND r.numpass = cl.numpass 
	 GROUP BY cl.numpass
	having count(ch.numc)>2;
END; 
$$;
 7   DROP FUNCTION public."clientsreservéplus2chambres"();
       public          postgres    false            ?            1255    16448    supprimerclientplusdeuxreserv() 	   PROCEDURE     ?   CREATE PROCEDURE public.supprimerclientplusdeuxreserv()
    LANGUAGE plpgsql
    AS $$
begin
    delete from "clients" WHERE clients.numPass Not in(select numPass FROM reservations );
end;
$$;
 7   DROP PROCEDURE public.supprimerclientplusdeuxreserv();
       public          postgres    false            ?            1255    16447    updateprix() 	   PROCEDURE     v   CREATE PROCEDURE public.updateprix()
    LANGUAGE sql
    AS $$
UPDATE chambres SET prix  = '1000' WHERE prix>700
$$;
 $   DROP PROCEDURE public.updateprix();
       public          postgres    false            ?            1259    16405    chambres    TABLE     ?   CREATE TABLE public.chambres (
    numc numeric(11,0) NOT NULL,
    lits numeric(11,0) DEFAULT 2 NOT NULL,
    prix numeric(11,0) NOT NULL
);
    DROP TABLE public.chambres;
       public         heap    postgres    false            ?            1259    16395    clients    TABLE     ?   CREATE TABLE public.clients (
    numpass character varying(9) NOT NULL,
    nom character varying(255) NOT NULL,
    ville character varying(255) NOT NULL
);
    DROP TABLE public.clients;
       public         heap    postgres    false            ?            1259    16426    reservations    TABLE     ?   CREATE TABLE public.reservations (
    numr numeric(11,0) NOT NULL,
    "date_arrivée" date NOT NULL,
    "date_départ" date,
    numpass character varying(9),
    numc numeric(11,0)
);
     DROP TABLE public.reservations;
       public         heap    postgres    false            ?          0    16405    chambres 
   TABLE DATA           4   COPY public.chambres (numc, lits, prix) FROM stdin;
    public          postgres    false    201   ?        ?          0    16395    clients 
   TABLE DATA           6   COPY public.clients (numpass, nom, ville) FROM stdin;
    public          postgres    false    200   4!       ?          0    16426    reservations 
   TABLE DATA           \   COPY public.reservations (numr, "date_arrivée", "date_départ", numpass, numc) FROM stdin;
    public          postgres    false    202   ?!       7           2606    16410    chambres chambres_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.chambres
    ADD CONSTRAINT chambres_pkey PRIMARY KEY (numc);
 @   ALTER TABLE ONLY public.chambres DROP CONSTRAINT chambres_pkey;
       public            postgres    false    201            3           2606    16404    clients clients_nom_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_nom_key UNIQUE (nom);
 A   ALTER TABLE ONLY public.clients DROP CONSTRAINT clients_nom_key;
       public            postgres    false    200            5           2606    16402    clients clients_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (numpass);
 >   ALTER TABLE ONLY public.clients DROP CONSTRAINT clients_pkey;
       public            postgres    false    200            9           2606    16430    reservations reservations_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (numr);
 H   ALTER TABLE ONLY public.reservations DROP CONSTRAINT reservations_pkey;
       public            postgres    false    202            ;           2606    16436    reservations fk_chambres    FK CONSTRAINT     ?   ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT fk_chambres FOREIGN KEY (numc) REFERENCES public.chambres(numc) ON UPDATE CASCADE ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.reservations DROP CONSTRAINT fk_chambres;
       public          postgres    false    2871    202    201            :           2606    16431    reservations fk_reservation    FK CONSTRAINT     ?   ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT fk_reservation FOREIGN KEY (numpass) REFERENCES public.clients(numpass) ON UPDATE CASCADE ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.reservations DROP CONSTRAINT fk_reservation;
       public          postgres    false    2869    200    202            ?   9   x?-??  B?3c]???b??G2'??rY0?p???????H>bA	?      ?   ?   x?M???0 ?ۯ?+h??	X?	?A?e?5??
?^?y?df0????4?2?j?<???? ???A??me6.5M?2?b???? q=q'5ÐSM?????S????H?t=(ذ??ka??t?;9ǃ?ac??ƅ!$GuGÓ?o??kV??????T?:      ?   l   x?M?K
?@?u?]F??[?$??H??(D?U?
?.?V?R?R5)Ƈ?Ax?Q?'?w??(?J5??q??Ƴ֎ڍ????????x????j?`?e?????kG?dL#?     