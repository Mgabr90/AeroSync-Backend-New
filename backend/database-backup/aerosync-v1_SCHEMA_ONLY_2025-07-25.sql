--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 16.2

-- Started on 2025-07-25 11:36:32

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

DROP DATABASE IF EXISTS postgres;
--
-- TOC entry 4766 (class 1262 OID 17041)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';


\connect postgres

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

--
-- TOC entry 22 (class 2615 OID 17042)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA auth;


--
-- TOC entry 13 (class 2615 OID 17043)
-- Name: backup; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA backup;


--
-- TOC entry 11 (class 2615 OID 17044)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA extensions;


--
-- TOC entry 19 (class 2615 OID 17045)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql;


--
-- TOC entry 18 (class 2615 OID 17046)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql_public;


--
-- TOC entry 14 (class 2615 OID 17047)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA pgbouncer;


--
-- TOC entry 4770 (class 0 OID 0)
-- Dependencies: 20
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'Schema consolidated: documents and manuals tables relationship with organizations has been unified. The documents table now serves as the single source of truth for all document types with required organization relationships. The manuals table is deprecated and replaced by documents with document_type=''manual''. All 27 documents are properly associated with organizations.';


--
-- TOC entry 16 (class 2615 OID 17048)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA realtime;


--
-- TOC entry 21 (class 2615 OID 17049)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA storage;


--
-- TOC entry 15 (class 2615 OID 17050)
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA supabase_migrations;


--
-- TOC entry 17 (class 2615 OID 17051)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA vault;


--
-- TOC entry 7 (class 3079 OID 18890)
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- TOC entry 4775 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- TOC entry 5 (class 3079 OID 17062)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 4776 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 4 (class 3079 OID 17093)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 4777 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 3 (class 3079 OID 17130)
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- TOC entry 4778 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- TOC entry 6 (class 3079 OID 17137)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 4779 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 2 (class 3079 OID 17160)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 4780 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 8 (class 3079 OID 17171)
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- TOC entry 4781 (class 0 OID 0)
-- Dependencies: 8
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


--
-- TOC entry 1185 (class 1247 OID 17500)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


--
-- TOC entry 1188 (class 1247 OID 17508)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


--
-- TOC entry 1191 (class 1247 OID 17514)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


--
-- TOC entry 1194 (class 1247 OID 17520)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


--
-- TOC entry 1197 (class 1247 OID 17528)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


--
-- TOC entry 1200 (class 1247 OID 17542)
-- Name: action; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


--
-- TOC entry 1203 (class 1247 OID 17554)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


--
-- TOC entry 1206 (class 1247 OID 17571)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


--
-- TOC entry 1209 (class 1247 OID 17574)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


--
-- TOC entry 1212 (class 1247 OID 17577)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


--
-- TOC entry 499 (class 1255 OID 17578)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


--
-- TOC entry 4820 (class 0 OID 0)
-- Dependencies: 499
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 500 (class 1255 OID 17579)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


--
-- TOC entry 501 (class 1255 OID 17580)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


--
-- TOC entry 4823 (class 0 OID 0)
-- Dependencies: 501
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 502 (class 1255 OID 17581)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


--
-- TOC entry 4825 (class 0 OID 0)
-- Dependencies: 502
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 503 (class 1255 OID 17582)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


--
-- TOC entry 4842 (class 0 OID 0)
-- Dependencies: 503
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 504 (class 1255 OID 17583)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


--
-- TOC entry 4844 (class 0 OID 0)
-- Dependencies: 504
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 505 (class 1255 OID 17584)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


--
-- TOC entry 4846 (class 0 OID 0)
-- Dependencies: 505
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 506 (class 1255 OID 17585)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- TOC entry 507 (class 1255 OID 17586)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- TOC entry 508 (class 1255 OID 17587)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


--
-- TOC entry 4875 (class 0 OID 0)
-- Dependencies: 508
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 509 (class 1255 OID 17588)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: -
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


--
-- TOC entry 510 (class 1255 OID 17589)
-- Name: auto_fix_regulation_id(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.auto_fix_regulation_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- If regulation_id is null but filename suggests it's a regulation job
    IF NEW.regulation_id IS NULL AND (
        NEW.filename ILIKE '%regulation%' OR 
        NEW.filename ILIKE '%IOSA%' OR
        NEW.filename ILIKE '%test%regulation%'
    ) THEN
        -- Set to our test regulation ID for IOSA-related jobs
        IF NEW.filename ILIKE '%IOSA%' OR NEW.filename ILIKE '%test%regulation%' THEN
            NEW.regulation_id = '56ba0502-0bf6-4cda-a6bc-dfeab6d50609';
            RAISE NOTICE 'AUTO-FIX: Set regulation_id to test regulation for filename: %', NEW.filename;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


--
-- TOC entry 511 (class 1255 OID 17590)
-- Name: bulk_delete_manuals(uuid[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.bulk_delete_manuals(manual_ids uuid[]) RETURNS TABLE(deleted_count integer, affected_rows uuid[])
    LANGUAGE plpgsql
    AS $$
DECLARE
    _deleted_count INTEGER;
    _affected_rows UUID[];
BEGIN
    -- Update multiple documents in a single transaction and collect all returned IDs
    WITH updated_docs AS (
        UPDATE documents 
        SET 
            is_deleted = true,
            deleted_at = NOW()
        WHERE 
            id = ANY(manual_ids)
            AND document_type = 'manual'
            AND is_deleted = false
        RETURNING id
    )
    SELECT array_agg(id), count(*)::INTEGER 
    INTO _affected_rows, _deleted_count
    FROM updated_docs;
    
    -- Handle case where no rows were affected
    IF _deleted_count IS NULL THEN
        _deleted_count := 0;
        _affected_rows := ARRAY[]::UUID[];
    END IF;
    
    -- Return the results
    RETURN QUERY SELECT _deleted_count, _affected_rows;
END;
$$;


--
-- TOC entry 512 (class 1255 OID 17591)
-- Name: comprehensive_regulation_id_fix(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.comprehensive_regulation_id_fix() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Log every job creation attempt
    RAISE NOTICE 'JOB_INSERT: filename=%, regulation_id=%, document_id=%', 
                 NEW.filename, NEW.regulation_id, NEW.document_id;
    
    -- If regulation_id is null, set it to our test regulation for any test-related job
    IF NEW.regulation_id IS NULL AND (
        NEW.filename ILIKE '%test%' OR 
        NEW.filename ILIKE '%debug%' OR
        NEW.filename ILIKE '%IOSA%' OR
        NEW.filename ILIKE '%regulation%' OR
        NEW.filename = 'Quick Debug Test'
    ) THEN
        NEW.regulation_id = '56ba0502-0bf6-4cda-a6bc-dfeab6d50609';
        RAISE NOTICE 'AUTO_FIX: Applied regulation_id for test job: %', NEW.filename;
    END IF;
    
    RETURN NEW;
END;
$$;


--
-- TOC entry 513 (class 1255 OID 17592)
-- Name: debug_job_creation(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.debug_job_creation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Log the regulation_id value being inserted
    RAISE NOTICE 'JOB_CREATE_DEBUG: ID=%, filename=%, regulation_id=%, document_id=%', 
                 NEW.id, NEW.filename, NEW.regulation_id, NEW.document_id;
    
    -- If regulation_id is provided, validate it exists
    IF NEW.regulation_id IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM regulations WHERE id = NEW.regulation_id::uuid) THEN
            RAISE EXCEPTION 'Invalid regulation_id: % (regulation does not exist)', NEW.regulation_id;
        END IF;
        RAISE NOTICE 'JOB_CREATE_DEBUG: Valid regulation_id found: %', NEW.regulation_id;
    END IF;
    
    -- If document_id is provided, validate it exists  
    IF NEW.document_id IS NOT NULL THEN
        IF NOT EXISTS (SELECT 1 FROM documents WHERE id = NEW.document_id) THEN
            RAISE EXCEPTION 'Invalid document_id: % (document does not exist)', NEW.document_id;
        END IF;
        RAISE NOTICE 'JOB_CREATE_DEBUG: Valid document_id found: %', NEW.document_id;
    END IF;
    
    RETURN NEW;
END;
$$;


--
-- TOC entry 514 (class 1255 OID 17593)
-- Name: generate_embeddings(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.generate_embeddings() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- In a real implementation, you would call an API to generate embeddings
    -- This is just a placeholder
    NEW.vector_embedding = NULL;
    RETURN NEW;
END;
$$;


--
-- TOC entry 515 (class 1255 OID 17594)
-- Name: get_user_role(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_user_role() RETURNS text
    LANGUAGE sql STABLE SECURITY DEFINER
    AS $$
  SELECT COALESCE(
    (SELECT role FROM public.users WHERE id = auth.uid() AND is_active = true AND is_deleted = false),
    'anonymous'
  );
$$;


--
-- TOC entry 516 (class 1255 OID 17595)
-- Name: is_admin(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.is_admin() RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.users 
    WHERE id = auth.uid() AND role = 'admin' AND is_active = true AND is_deleted = false
  );
$$;


--
-- TOC entry 517 (class 1255 OID 17596)
-- Name: log_pdf_activity(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.log_pdf_activity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Only log if we have a valid user_id (either from auth or from the record)
  IF auth.uid() IS NOT NULL OR COALESCE(NEW.created_by, OLD.created_by) IS NOT NULL THEN
    INSERT INTO activity_logs (user_id, action, entity_type, entity_id, details)
    VALUES (
      COALESCE(auth.uid(), NEW.created_by, OLD.created_by),
      TG_OP,
      'pdf_job',
      COALESCE(NEW.id, OLD.id),
      jsonb_build_object(
        'filename', COALESCE(NEW.filename, OLD.filename),
        'status', COALESCE(NEW.status, OLD.status),
        'timestamp', NOW()
      )
    );
  END IF;
  
  RETURN COALESCE(NEW, OLD);
END;
$$;


--
-- TOC entry 518 (class 1255 OID 17597)
-- Name: set_created_by(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_created_by() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    NEW.created_by = auth.uid();
    RETURN NEW;
END;
$$;


--
-- TOC entry 519 (class 1255 OID 17598)
-- Name: set_pdf_job_user_id(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_pdf_job_user_id() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  NEW.created_by = auth.uid();
  RETURN NEW;
END;
$$;


--
-- TOC entry 520 (class 1255 OID 17599)
-- Name: soft_delete(text, uuid); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.soft_delete(p_table_name text, p_id uuid) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
DECLARE
    v_query TEXT;
    v_result BOOLEAN;
BEGIN
    v_query := format(
        'UPDATE public.%I SET is_deleted = true, deleted_at = NOW() WHERE id = $1 RETURNING true',
        p_table_name
    );
    
    EXECUTE v_query INTO v_result USING p_id;
    
    IF v_result THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END;
$_$;


--
-- TOC entry 521 (class 1255 OID 17600)
-- Name: update_timestamp(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


--
-- TOC entry 522 (class 1255 OID 17601)
-- Name: update_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$;


--
-- TOC entry 523 (class 1255 OID 17602)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


--
-- TOC entry 524 (class 1255 OID 17603)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


--
-- TOC entry 525 (class 1255 OID 17605)
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


--
-- TOC entry 526 (class 1255 OID 17606)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


--
-- TOC entry 527 (class 1255 OID 17607)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


--
-- TOC entry 528 (class 1255 OID 17608)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


--
-- TOC entry 529 (class 1255 OID 17609)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


--
-- TOC entry 530 (class 1255 OID 17610)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


--
-- TOC entry 531 (class 1255 OID 17611)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


--
-- TOC entry 532 (class 1255 OID 17612)
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


--
-- TOC entry 533 (class 1255 OID 17613)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


--
-- TOC entry 534 (class 1255 OID 17614)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


--
-- TOC entry 535 (class 1255 OID 17615)
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


--
-- TOC entry 536 (class 1255 OID 17616)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


--
-- TOC entry 537 (class 1255 OID 17617)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


--
-- TOC entry 538 (class 1255 OID 17618)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


--
-- TOC entry 539 (class 1255 OID 17619)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


--
-- TOC entry 540 (class 1255 OID 17620)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


--
-- TOC entry 541 (class 1255 OID 17621)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


--
-- TOC entry 542 (class 1255 OID 17622)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


--
-- TOC entry 543 (class 1255 OID 17623)
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


--
-- TOC entry 544 (class 1255 OID 17624)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- TOC entry 545 (class 1255 OID 17625)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 238 (class 1259 OID 17626)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 239 (class 1259 OID 17632)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- TOC entry 240 (class 1259 OID 17637)
-- Name: identities; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 241 (class 1259 OID 17644)
-- Name: instances; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 242 (class 1259 OID 17649)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 243 (class 1259 OID 17654)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 244 (class 1259 OID 17659)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 245 (class 1259 OID 17664)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


--
-- TOC entry 246 (class 1259 OID 17672)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


--
-- TOC entry 5029 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 247 (class 1259 OID 17677)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: -
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5031 (class 0 OID 0)
-- Dependencies: 247
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: -
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 248 (class 1259 OID 17678)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


--
-- TOC entry 5033 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 249 (class 1259 OID 17686)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 250 (class 1259 OID 17692)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 251 (class 1259 OID 17695)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 251
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 252 (class 1259 OID 17700)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 252
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 253 (class 1259 OID 17706)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 253
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 254 (class 1259 OID 17712)
-- Name: users; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 254
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 255 (class 1259 OID 17727)
-- Name: activity_logs; Type: TABLE; Schema: backup; Owner: -
--

CREATE TABLE backup.activity_logs (
    id uuid,
    user_id uuid,
    action text,
    entity_type text,
    entity_id uuid,
    details jsonb,
    created_at timestamp with time zone
);


--
-- TOC entry 256 (class 1259 OID 17732)
-- Name: audits; Type: TABLE; Schema: backup; Owner: -
--

CREATE TABLE backup.audits (
    id uuid,
    title text,
    description text,
    company_id uuid,
    auditor_id uuid,
    document_id uuid,
    regulation_id uuid,
    scheduled_date timestamp with time zone,
    status text,
    readiness integer,
    findings jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    legacy_id integer,
    audit_name text,
    legacy_regulation_id integer,
    legacy_manual_id integer
);


--
-- TOC entry 257 (class 1259 OID 17737)
-- Name: authority_profiles; Type: TABLE; Schema: backup; Owner: -
--

CREATE TABLE backup.authority_profiles (
    id uuid,
    company_id uuid,
    name text,
    permissions jsonb,
    is_default boolean,
    created_at timestamp with time zone
);


--
-- TOC entry 258 (class 1259 OID 17742)
-- Name: billing_records; Type: TABLE; Schema: backup; Owner: -
--

CREATE TABLE backup.billing_records (
    id uuid,
    company_id uuid,
    period_start timestamp with time zone,
    period_end timestamp with time zone,
    total_tokens integer,
    total_cost numeric(10,2),
    status text,
    invoice_number text,
    paid_at timestamp with time zone,
    created_at timestamp with time zone
);


--
-- TOC entry 259 (class 1259 OID 17747)
-- Name: companies; Type: TABLE; Schema: backup; Owner: -
--

CREATE TABLE backup.companies (
    id uuid,
    name text,
    iata_code text,
    icao_code text,
    country text,
    registration_state text,
    operations_states text[],
    company_type text,
    fleet_size integer,
    logo_url text,
    settings jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- TOC entry 260 (class 1259 OID 17752)
-- Name: documents; Type: TABLE; Schema: backup; Owner: -
--

CREATE TABLE backup.documents (
    id uuid,
    title text,
    description text,
    document_type text,
    status text,
    company_id uuid,
    category_id uuid,
    file_url text,
    file_type text,
    parsed_content text,
    metadata jsonb,
    created_by uuid,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- TOC entry 261 (class 1259 OID 17757)
-- Name: regulation_categories; Type: TABLE; Schema: backup; Owner: -
--

CREATE TABLE backup.regulation_categories (
    id uuid,
    name text,
    description text,
    created_at timestamp with time zone
);


--
-- TOC entry 262 (class 1259 OID 17762)
-- Name: regulations; Type: TABLE; Schema: backup; Owner: -
--

CREATE TABLE backup.regulations (
    id uuid,
    title text,
    description text,
    category_id uuid,
    content text,
    issuer text,
    effective_date timestamp without time zone,
    metadata jsonb,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- TOC entry 263 (class 1259 OID 17767)
-- Name: token_usage; Type: TABLE; Schema: backup; Owner: -
--

CREATE TABLE backup.token_usage (
    id uuid,
    company_id uuid,
    audit_id uuid,
    model_used text,
    prompt_tokens integer,
    completion_tokens integer,
    total_tokens integer,
    cost numeric(10,4),
    request_type text,
    created_at timestamp with time zone
);


--
-- TOC entry 264 (class 1259 OID 17772)
-- Name: users; Type: TABLE; Schema: backup; Owner: -
--

CREATE TABLE backup.users (
    id uuid,
    email text,
    full_name text,
    role text,
    company_id uuid,
    job_title text,
    created_at timestamp with time zone,
    last_login timestamp with time zone,
    legacy_role_id integer,
    legacy_airline_profile_id uuid,
    legacy_name text
);


--
-- TOC entry 265 (class 1259 OID 17777)
-- Name: users_before_changes; Type: TABLE; Schema: backup; Owner: -
--

CREATE TABLE backup.users_before_changes (
    id uuid,
    email text,
    full_name text,
    role text,
    company_id uuid,
    job_title text,
    created_at timestamp with time zone,
    last_login timestamp with time zone,
    legacy_role_id integer,
    legacy_airline_profile_id uuid,
    legacy_name text
);


--
-- TOC entry 266 (class 1259 OID 17782)
-- Name: activity_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.activity_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    action text NOT NULL,
    entity_type text NOT NULL,
    details jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    entity_id text
);


--
-- TOC entry 267 (class 1259 OID 17790)
-- Name: audit_findings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_findings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    audit_id uuid NOT NULL,
    finding_type character varying(50) NOT NULL,
    severity character varying(20),
    title text NOT NULL,
    description text,
    recommendation text,
    evidence text,
    status character varying(20) DEFAULT 'open'::character varying,
    assigned_to uuid,
    due_date timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    created_by uuid,
    metadata jsonb DEFAULT '{}'::jsonb,
    is_deleted boolean DEFAULT false,
    deleted_at timestamp with time zone,
    CONSTRAINT audit_findings_severity_check CHECK (((severity)::text = ANY (ARRAY[('low'::character varying)::text, ('medium'::character varying)::text, ('high'::character varying)::text, ('critical'::character varying)::text]))),
    CONSTRAINT audit_findings_status_check CHECK (((status)::text = ANY (ARRAY[('open'::character varying)::text, ('in_progress'::character varying)::text, ('resolved'::character varying)::text, ('closed'::character varying)::text])))
);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 267
-- Name: TABLE audit_findings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.audit_findings IS 'Audit findings table for tracking compliance issues and recommendations';


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN audit_findings.finding_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.audit_findings.finding_type IS 'Type/category of the finding (e.g., compliance_gap, best_practice, observation)';


--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN audit_findings.severity; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.audit_findings.severity IS 'Severity level of the finding';


--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN audit_findings.recommendation; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.audit_findings.recommendation IS 'Recommended actions to address the finding';


--
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN audit_findings.evidence; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.audit_findings.evidence IS 'Supporting evidence or documentation for the finding';


--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN audit_findings.status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.audit_findings.status IS 'Current status of the finding';


--
-- TOC entry 268 (class 1259 OID 17803)
-- Name: audits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audits (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    description text,
    organization_id uuid NOT NULL,
    auditor_id uuid NOT NULL,
    document_id uuid,
    regulation_id uuid,
    scheduled_date timestamp with time zone NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    readiness integer,
    findings jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    audit_name text,
    is_deleted boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    created_by uuid,
    CONSTRAINT audits_readiness_check CHECK (((readiness >= 0) AND (readiness <= 100))),
    CONSTRAINT audits_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'in_progress'::text, 'completed'::text, 'cancelled'::text])))
);


--
-- TOC entry 269 (class 1259 OID 17815)
-- Name: authorities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authorities (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code character varying(10) NOT NULL,
    name text NOT NULL,
    full_name text NOT NULL,
    description text,
    country character varying(2),
    region text,
    jurisdiction text[],
    website_url text,
    contact_email text,
    document_patterns jsonb DEFAULT '{}'::jsonb,
    parsing_config jsonb DEFAULT '{}'::jsonb,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- TOC entry 270 (class 1259 OID 17826)
-- Name: authority_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authority_profiles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    name text NOT NULL,
    permissions jsonb DEFAULT '{"run_audits": true, "manage_users": false, "view_billing": false, "view_reports": true, "manage_billing": false, "manage_documents": true}'::jsonb NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 271 (class 1259 OID 17835)
-- Name: billing_periods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.billing_periods (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 272 (class 1259 OID 17842)
-- Name: billing_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.billing_records (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    period_start timestamp with time zone NOT NULL,
    period_end timestamp with time zone NOT NULL,
    total_tokens integer DEFAULT 0 NOT NULL,
    total_cost numeric(10,2) DEFAULT 0 NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    invoice_number text,
    paid_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT billing_records_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'paid'::text, 'overdue'::text])))
);


--
-- TOC entry 273 (class 1259 OID 17853)
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    iata_code text,
    icao_code text,
    country text NOT NULL,
    registration_state text NOT NULL,
    operations_states text[] NOT NULL,
    fleet_size integer,
    logo_url text,
    settings jsonb DEFAULT '{"ai_model": "gpt4", "audit_cap": 100, "token_cap": 1000000, "pause_on_cap": false, "notify_on_cap": true, "billing_period": "monthly"}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    organization_type text DEFAULT 'airline'::text NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone
);


--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN organizations.settings; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.organizations.settings IS 'Organization settings JSON object. Technical profiles are now managed at organization type level in organization_type_technical_profiles table.';


--
-- TOC entry 274 (class 1259 OID 17864)
-- Name: token_usage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.token_usage (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_id uuid NOT NULL,
    audit_id uuid,
    model_used text NOT NULL,
    prompt_tokens integer NOT NULL,
    completion_tokens integer NOT NULL,
    total_tokens integer NOT NULL,
    cost numeric(10,4) NOT NULL,
    request_type text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL
);


--
-- TOC entry 275 (class 1259 OID 17872)
-- Name: billing_summary; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.billing_summary AS
 SELECT bp.id AS billing_period_id,
    bp.start_date,
    bp.end_date,
    o.id AS organization_id,
    o.name AS organization_name,
    sum(tu.total_tokens) AS total_tokens,
    sum(tu.cost) AS total_cost,
    count(DISTINCT tu.audit_id) AS audits_count
   FROM ((public.billing_periods bp
     CROSS JOIN public.organizations o)
     LEFT JOIN public.token_usage tu ON (((bp.id = NULL::uuid) AND (o.id = tu.organization_id) AND (tu.is_deleted = false))))
  WHERE (o.is_deleted = false)
  GROUP BY bp.id, bp.start_date, bp.end_date, o.id, o.name;


--
-- TOC entry 276 (class 1259 OID 17877)
-- Name: document_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_categories (
    document_id uuid NOT NULL,
    category_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 277 (class 1259 OID 17881)
-- Name: document_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_sections (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    section_id integer,
    section_name text,
    section_number text,
    parent_section_id uuid,
    full_text text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    summary text,
    keywords text[],
    vector_embedding public.vector(1536),
    category text,
    subcategory text,
    original_title text,
    level integer,
    page_number integer,
    order_index integer,
    document_id uuid,
    confidence numeric,
    extraction_confidence numeric,
    quality_score numeric,
    extraction_method text,
    is_generated boolean DEFAULT false,
    generated_reason text,
    generated_from text,
    generated_at timestamp with time zone,
    hierarchy_level integer DEFAULT 1,
    CONSTRAINT document_sections_confidence_check CHECK (((confidence >= (0)::numeric) AND (confidence <= (1)::numeric))),
    CONSTRAINT document_sections_extraction_confidence_check CHECK (((extraction_confidence >= (0)::numeric) AND (extraction_confidence <= (1)::numeric))),
    CONSTRAINT document_sections_quality_score_check CHECK (((quality_score >= (0)::numeric) AND (quality_score <= (1)::numeric)))
);


--
-- TOC entry 5069 (class 0 OID 0)
-- Dependencies: 277
-- Name: TABLE document_sections; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.document_sections IS 'General document sections with flexible structure for various document types';


--
-- TOC entry 5070 (class 0 OID 0)
-- Dependencies: 277
-- Name: COLUMN document_sections.confidence; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.document_sections.confidence IS 'Overall confidence score for section extraction (0-1)';


--
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 277
-- Name: COLUMN document_sections.extraction_confidence; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.document_sections.extraction_confidence IS 'Confidence score for text extraction accuracy (0-1)';


--
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 277
-- Name: COLUMN document_sections.quality_score; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.document_sections.quality_score IS 'Quality assessment score for section content (0-1)';


--
-- TOC entry 5073 (class 0 OID 0)
-- Dependencies: 277
-- Name: COLUMN document_sections.extraction_method; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.document_sections.extraction_method IS 'Method used for extraction (unified, aerosync, ai, manual)';


--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 277
-- Name: COLUMN document_sections.is_generated; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.document_sections.is_generated IS 'Whether this section was algorithmically generated';


--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 277
-- Name: COLUMN document_sections.hierarchy_level; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.document_sections.hierarchy_level IS 'Hierarchy level for building parent-child relationships';


--
-- TOC entry 278 (class 1259 OID 17894)
-- Name: documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    description text,
    document_type text NOT NULL,
    status text DEFAULT 'draft'::text NOT NULL,
    category_id uuid,
    file_url text,
    file_type text,
    parsed_content text,
    metadata jsonb,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    organization_id uuid,
    authority_id uuid,
    user_id uuid,
    document_name text,
    version character varying(50) DEFAULT '1.0'::character varying,
    filename text,
    file_size bigint,
    manual_type character varying(100),
    effective_date timestamp with time zone,
    parser_type text DEFAULT 'unified'::text,
    volume_path text,
    CONSTRAINT check_organization_required_for_non_regulations CHECK (((document_type = 'regulation'::text) OR (organization_id IS NOT NULL))),
    CONSTRAINT documents_document_type_check CHECK ((document_type = ANY (ARRAY['manual'::text, 'regulation'::text, 'procedure'::text, 'policy'::text, 'guideline'::text, 'standard'::text]))),
    CONSTRAINT documents_parser_type_check CHECK ((parser_type = ANY (ARRAY['aerosync'::text, 'ai'::text, 'unified'::text]))),
    CONSTRAINT documents_status_check CHECK ((status = ANY (ARRAY['draft'::text, 'published'::text, 'archived'::text])))
);


--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE documents; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.documents IS 'Unified table for all document types (manuals, regulations, procedures, policies, etc.) with required organization relationship. Replaces the redundant manuals table completely.';


--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 278
-- Name: COLUMN documents.document_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.document_type IS 'Type of document: manual, regulation, procedure, policy, guideline, standard';


--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 278
-- Name: COLUMN documents.organization_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.organization_id IS 'Required organization ID - all documents must belong to an organization. This replaces the need for separate manual/document organization tracking.';


--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 278
-- Name: COLUMN documents.version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.version IS 'Document version (inherited from manuals table)';


--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 278
-- Name: COLUMN documents.manual_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.manual_type IS 'Specific manual type/category (for manual documents)';


--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 278
-- Name: COLUMN documents.effective_date; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.effective_date IS 'When the document becomes effective (for regulations)';


--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 278
-- Name: COLUMN documents.parser_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.parser_type IS 'Parser used for processing: aerosync, ai, unified';


--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 278
-- Name: COLUMN documents.volume_path; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.documents.volume_path IS 'Direct file system path on Railway volume for uploaded documents';


--
-- TOC entry 279 (class 1259 OID 17910)
-- Name: findings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.findings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    audit_id uuid NOT NULL,
    regulation_id uuid,
    document_id uuid,
    compliance_status text NOT NULL,
    details text,
    severity text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    created_by uuid,
    title text
);


--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 279
-- Name: COLUMN findings.title; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.findings.title IS 'Human-readable title describing the finding';


--
-- TOC entry 280 (class 1259 OID 17919)
-- Name: manuals_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.manuals_view AS
 SELECT documents.id AS manual_id,
    documents.title AS manual_name,
    documents.manual_type AS category,
    documents.metadata,
    documents.status,
    documents.user_id,
    documents.version,
    documents.id AS document_id,
    documents.created_at,
    documents.updated_at,
    documents.is_deleted,
    documents.deleted_at
   FROM public.documents
  WHERE (documents.document_type = 'manual'::text);


--
-- TOC entry 281 (class 1259 OID 17923)
-- Name: organization_documents_summary; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.organization_documents_summary AS
 SELECT o.id AS organization_id,
    o.name AS organization_name,
    o.iata_code,
    o.icao_code,
    o.country,
    count(d.id) AS total_documents,
    count(
        CASE
            WHEN (d.document_type = 'manual'::text) THEN 1
            ELSE NULL::integer
        END) AS manual_count,
    count(
        CASE
            WHEN (d.document_type = 'regulation'::text) THEN 1
            ELSE NULL::integer
        END) AS regulation_count,
    count(
        CASE
            WHEN (d.document_type = 'procedure'::text) THEN 1
            ELSE NULL::integer
        END) AS procedure_count,
    count(
        CASE
            WHEN (d.document_type = 'policy'::text) THEN 1
            ELSE NULL::integer
        END) AS policy_count,
    count(
        CASE
            WHEN (d.document_type = 'guideline'::text) THEN 1
            ELSE NULL::integer
        END) AS guideline_count,
    count(
        CASE
            WHEN (d.document_type = 'standard'::text) THEN 1
            ELSE NULL::integer
        END) AS standard_count,
    count(
        CASE
            WHEN (d.status = 'published'::text) THEN 1
            ELSE NULL::integer
        END) AS published_documents,
    count(
        CASE
            WHEN (d.status = 'draft'::text) THEN 1
            ELSE NULL::integer
        END) AS draft_documents,
    count(
        CASE
            WHEN (d.status = 'archived'::text) THEN 1
            ELSE NULL::integer
        END) AS archived_documents,
    max(d.updated_at) AS last_document_update
   FROM (public.organizations o
     LEFT JOIN public.documents d ON (((o.id = d.organization_id) AND (d.is_deleted = false))))
  GROUP BY o.id, o.name, o.iata_code, o.icao_code, o.country
  ORDER BY o.name;


--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 281
-- Name: VIEW organization_documents_summary; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON VIEW public.organization_documents_summary IS 'Comprehensive summary showing the relationship between organizations and their documents, with counts by type and status.';


--
-- TOC entry 282 (class 1259 OID 17928)
-- Name: organization_type_technical_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization_type_technical_profiles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    organization_type text NOT NULL,
    technical_profile jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- TOC entry 283 (class 1259 OID 17937)
-- Name: pdf_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pdf_jobs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    filename text NOT NULL,
    status text NOT NULL,
    progress numeric(5,2) DEFAULT 0,
    current_phase text,
    message text,
    regulation_id uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    created_by uuid,
    completed_at timestamp with time zone,
    failed_at timestamp with time zone,
    processing_time_ms integer,
    last_error text,
    retry_count integer DEFAULT 0,
    result_metadata jsonb,
    estimated_completion_ms bigint,
    processing_phase text,
    current_step text,
    sections_processed integer DEFAULT 0,
    total_sections integer,
    start_time timestamp with time zone,
    last_update timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    document_id uuid,
    auto_cleanup boolean DEFAULT true,
    cleaned_at timestamp with time zone,
    document_type text,
    file_size bigint,
    parser_type text DEFAULT 'unified'::text,
    pipeline_version text DEFAULT '2.0'::text,
    quality_score numeric,
    sections_quality_avg numeric,
    volume_path text,
    metadata jsonb DEFAULT '{}'::jsonb,
    processing_started timestamp with time zone,
    CONSTRAINT pdf_jobs_parser_type_check CHECK ((parser_type = ANY (ARRAY['aerosync'::text, 'ai'::text, 'unified'::text]))),
    CONSTRAINT pdf_jobs_progress_check CHECK (((progress >= (0)::numeric) AND (progress <= (100)::numeric))),
    CONSTRAINT pdf_jobs_quality_score_check CHECK (((quality_score >= (0)::numeric) AND (quality_score <= (1)::numeric))),
    CONSTRAINT pdf_jobs_sections_quality_avg_check CHECK (((sections_quality_avg >= (0)::numeric) AND (sections_quality_avg <= (1)::numeric))),
    CONSTRAINT pdf_jobs_status_check CHECK ((status = ANY (ARRAY['queued'::text, 'processing'::text, 'pending'::text, 'running'::text, 'completed'::text, 'error'::text, 'not_found'::text, 'uploaded'::text])))
);


--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.completed_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.completed_at IS 'Timestamp when job was successfully completed';


--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.failed_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.failed_at IS 'Timestamp when job failed (latest failure)';


--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.processing_time_ms; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.processing_time_ms IS 'Total processing time in milliseconds';


--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.last_error; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.last_error IS 'Last error message if job failed';


--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.retry_count; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.retry_count IS 'Number of retry attempts (0 = first attempt)';


--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.result_metadata; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.result_metadata IS 'JSON metadata about processing results (sections found, quality scores, etc)';


--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.estimated_completion_ms; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.estimated_completion_ms IS 'Estimated completion time in milliseconds from epoch';


--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.processing_phase; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.processing_phase IS 'Current processing phase (upload, document_validation, section_parsing, hierarchy_building, database_storage)';


--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.current_step; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.current_step IS 'Current processing step description';


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.sections_processed; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.sections_processed IS 'Number of sections processed so far';


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.total_sections; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.total_sections IS 'Total number of sections expected to be processed';


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.start_time; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.start_time IS 'Processing start time';


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.last_update; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.last_update IS 'Last progress update timestamp';


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.auto_cleanup; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.auto_cleanup IS 'Whether to automatically cleanup files after processing';


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.cleaned_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.cleaned_at IS 'Timestamp when job files were cleaned up';


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.document_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.document_type IS 'Type of document being processed (regulation, manual, etc.)';


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.file_size; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.file_size IS 'Size of the processed file in bytes';


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.parser_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.parser_type IS 'Parser used for processing (aerosync, ai, unified)';


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.pipeline_version; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.pipeline_version IS 'Version of processing pipeline used';


--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.quality_score; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.quality_score IS 'Overall quality score for the processing job';


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.sections_quality_avg; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.sections_quality_avg IS 'Average quality score of extracted sections';


--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.volume_path; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.volume_path IS 'Direct file system path on Railway volume for job processing';


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 283
-- Name: COLUMN pdf_jobs.metadata; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pdf_jobs.metadata IS 'JSON metadata for job processing context and configuration';


--
-- TOC entry 284 (class 1259 OID 17958)
-- Name: pdf_results; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pdf_results (
    id integer NOT NULL,
    job_id uuid NOT NULL,
    document_title text,
    sections jsonb,
    sections_extracted integer DEFAULT 0,
    total_pages integer,
    processing_time integer,
    error_message text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now(),
    user_id uuid
);


--
-- TOC entry 285 (class 1259 OID 17965)
-- Name: pdf_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pdf_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 285
-- Name: pdf_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pdf_results_id_seq OWNED BY public.pdf_results.id;


--
-- TOC entry 286 (class 1259 OID 17966)
-- Name: pdf_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pdf_sections (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    job_id uuid NOT NULL,
    regulation_section_id uuid,
    section_title text NOT NULL,
    section_content text,
    section_number text,
    page_number integer,
    section_order integer,
    confidence_score numeric(3,2),
    level integer DEFAULT 1,
    parent_section_id uuid,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now(),
    user_id uuid
);


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE pdf_sections; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.pdf_sections IS 'Sections extracted from PDF processing jobs - primary table for PDF workflow results';


--
-- TOC entry 287 (class 1259 OID 17974)
-- Name: pipeline_execution_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pipeline_execution_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    job_id uuid NOT NULL,
    pipeline_step text NOT NULL,
    step_order integer NOT NULL,
    status text NOT NULL,
    step_metadata jsonb DEFAULT '{}'::jsonb,
    started_at timestamp with time zone DEFAULT now(),
    completed_at timestamp with time zone,
    error_message text,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT pipeline_execution_logs_status_check CHECK ((status = ANY (ARRAY['started'::text, 'completed'::text, 'failed'::text])))
);


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 287
-- Name: TABLE pipeline_execution_logs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.pipeline_execution_logs IS 'Tracks execution of individual pipeline steps for each job';


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 287
-- Name: COLUMN pipeline_execution_logs.job_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pipeline_execution_logs.job_id IS 'Reference to the PDF job being processed';


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 287
-- Name: COLUMN pipeline_execution_logs.pipeline_step; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pipeline_execution_logs.pipeline_step IS 'Name of the pipeline step (validation, extraction, analysis, etc.)';


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 287
-- Name: COLUMN pipeline_execution_logs.step_order; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pipeline_execution_logs.step_order IS 'Order of execution within the pipeline';


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 287
-- Name: COLUMN pipeline_execution_logs.status; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pipeline_execution_logs.status IS 'Current status of the step execution';


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 287
-- Name: COLUMN pipeline_execution_logs.step_metadata; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.pipeline_execution_logs.step_metadata IS 'Additional metadata about the step execution';


--
-- TOC entry 288 (class 1259 OID 17984)
-- Name: regulation_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.regulation_categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 289 (class 1259 OID 17991)
-- Name: regulation_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.regulation_sections (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    section_name text,
    section_number text,
    parent_section_id uuid,
    full_text text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    summary text,
    keywords text[],
    vector_embedding public.vector(1536),
    category text,
    subcategory text,
    original_title text,
    level integer,
    page_number integer,
    order_index integer,
    regulation_id uuid,
    metadata jsonb,
    title text,
    content text,
    subpart_id text,
    user_id uuid,
    hierarchy_level integer DEFAULT 1,
    confidence numeric,
    extraction_confidence numeric,
    quality_score numeric,
    extraction_method text,
    is_generated boolean DEFAULT false,
    generated_reason text,
    generated_from text,
    generated_at timestamp with time zone,
    section_title text,
    config_based_extraction boolean DEFAULT false,
    original_outline_title text,
    CONSTRAINT regulation_sections_confidence_check CHECK (((confidence >= (0)::numeric) AND (confidence <= (1)::numeric))),
    CONSTRAINT regulation_sections_extraction_confidence_check CHECK (((extraction_confidence >= (0)::numeric) AND (extraction_confidence <= (1)::numeric))),
    CONSTRAINT regulation_sections_quality_score_check CHECK (((quality_score >= (0)::numeric) AND (quality_score <= (1)::numeric)))
);


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE regulation_sections; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.regulation_sections IS 'Sections from regulation documents with regulatory-specific metadata and compliance tracking';


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.section_number; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.section_number IS 'Section numbering (e.g., 1.1.1)';


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.parent_section_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.parent_section_id IS 'Reference to parent section for hierarchy';


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.level; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.level IS 'Hierarchy level (1=top level, 2=subsection, etc.)';


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.order_index; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.order_index IS 'Order of appearance within document';


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.content; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.content IS 'Full text content of the section';


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.hierarchy_level; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.hierarchy_level IS 'Hierarchy level for building parent-child relationships';


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.confidence; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.confidence IS 'Overall confidence score for section extraction (0-1)';


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.extraction_confidence; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.extraction_confidence IS 'Confidence score for text extraction accuracy (0-1)';


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.quality_score; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.quality_score IS 'Quality assessment score for section content (0-1)';


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.extraction_method; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.extraction_method IS 'Method used for extraction (unified, aerosync, ai, manual)';


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.is_generated; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.is_generated IS 'Whether this section was algorithmically generated';


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.generated_reason; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.generated_reason IS 'Reason for section generation (e.g., hierarchy_completion, toc_reconstruction)';


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.generated_from; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.generated_from IS 'Source data used for generation';


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.generated_at; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.generated_at IS 'Timestamp when section was generated';


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN regulation_sections.section_title; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulation_sections.section_title IS 'Title/heading of the regulation section';


--
-- TOC entry 290 (class 1259 OID 18005)
-- Name: regulations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.regulations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title text NOT NULL,
    description text,
    category_id uuid,
    effective_date timestamp without time zone,
    metadata jsonb,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    authority_id uuid,
    parser_type text DEFAULT 'aerosync'::text,
    file_url text,
    file_size bigint,
    filename text,
    parsed_content text,
    volume_path text,
    file_type text DEFAULT 'application/pdf'::text,
    created_by uuid,
    regulation_type text,
    status text DEFAULT 'draft'::text,
    CONSTRAINT regulations_parser_type_check CHECK ((parser_type = ANY (ARRAY['aerosync'::text, 'ai'::text, 'unified'::text])))
);


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN regulations.authority_id; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulations.authority_id IS 'References the regulatory authority that issued this regulation';


--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN regulations.parser_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulations.parser_type IS 'Tracks which parser was used for the entire regulation: aerosync (original AeroSync parser), ai (AI/GPT parser), unified (Unified Document Parser)';


--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN regulations.file_url; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulations.file_url IS 'URL/path to the regulation PDF file in Railway storage';


--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN regulations.file_size; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulations.file_size IS 'Size of the regulation PDF file in bytes';


--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN regulations.filename; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulations.filename IS 'Original filename of the uploaded regulation PDF';


--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN regulations.parsed_content; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulations.parsed_content IS 'Extracted text content from the regulation PDF';


--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN regulations.volume_path; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulations.volume_path IS 'Direct file system path on Railway volume (e.g., /temp/aerosync-storage/pdfs/filename.pdf)';


--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 290
-- Name: COLUMN regulations.file_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.regulations.file_type IS 'MIME type of the uploaded file (e.g., application/pdf)';


--
-- TOC entry 291 (class 1259 OID 18017)
-- Name: regulations_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.regulations_view AS
 SELECT documents.id,
    documents.title,
    documents.description,
    documents.category_id,
    documents.effective_date,
    documents.metadata,
    documents.created_at,
    documents.updated_at,
    documents.authority_id,
    documents.parser_type
   FROM public.documents
  WHERE (documents.document_type = 'regulation'::text);


--
-- TOC entry 292 (class 1259 OID 18021)
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    permissions jsonb DEFAULT '{}'::jsonb NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 293 (class 1259 OID 18030)
-- Name: schema_change_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_change_log (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    change_type text NOT NULL,
    description text NOT NULL,
    tables_affected text[],
    migration_name text,
    created_at timestamp with time zone DEFAULT now()
);


--
-- TOC entry 294 (class 1259 OID 18037)
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_profiles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    job_title text,
    phone_number text,
    preferences jsonb DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 295 (class 1259 OID 18046)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email text NOT NULL,
    full_name text NOT NULL,
    role text NOT NULL,
    job_title text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    last_login timestamp with time zone,
    role_id uuid,
    organization_id uuid,
    is_deleted boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_active boolean,
    CONSTRAINT users_role_check CHECK ((role = ANY (ARRAY['admin'::text, 'auditor'::text])))
);


--
-- TOC entry 296 (class 1259 OID 18055)
-- Name: messages; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


--
-- TOC entry 297 (class 1259 OID 18062)
-- Name: messages_2025_06_28; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_06_28 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- TOC entry 298 (class 1259 OID 18071)
-- Name: messages_2025_06_29; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_06_29 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- TOC entry 299 (class 1259 OID 18080)
-- Name: messages_2025_06_30; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_06_30 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- TOC entry 300 (class 1259 OID 18089)
-- Name: messages_2025_07_01; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_07_01 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- TOC entry 301 (class 1259 OID 18098)
-- Name: messages_2025_07_02; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_07_02 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- TOC entry 302 (class 1259 OID 18107)
-- Name: messages_2025_07_03; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_07_03 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- TOC entry 303 (class 1259 OID 18116)
-- Name: messages_2025_07_04; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages_2025_07_04 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- TOC entry 304 (class 1259 OID 18125)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- TOC entry 305 (class 1259 OID 18128)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


--
-- TOC entry 306 (class 1259 OID 18136)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: -
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 307 (class 1259 OID 18137)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


--
-- TOC entry 5171 (class 0 OID 0)
-- Dependencies: 307
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 308 (class 1259 OID 18146)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 309 (class 1259 OID 18150)
-- Name: objects; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


--
-- TOC entry 5173 (class 0 OID 0)
-- Dependencies: 309
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 310 (class 1259 OID 18160)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


--
-- TOC entry 311 (class 1259 OID 18167)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- TOC entry 312 (class 1259 OID 18175)
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: -
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text,
    created_by text,
    idempotency_key text
);


--
-- TOC entry 3938 (class 0 OID 0)
-- Name: messages_2025_06_28; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_06_28 FOR VALUES FROM ('2025-06-28 00:00:00') TO ('2025-06-29 00:00:00');


--
-- TOC entry 3939 (class 0 OID 0)
-- Name: messages_2025_06_29; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_06_29 FOR VALUES FROM ('2025-06-29 00:00:00') TO ('2025-06-30 00:00:00');


--
-- TOC entry 3940 (class 0 OID 0)
-- Name: messages_2025_06_30; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_06_30 FOR VALUES FROM ('2025-06-30 00:00:00') TO ('2025-07-01 00:00:00');


--
-- TOC entry 3941 (class 0 OID 0)
-- Name: messages_2025_07_01; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_01 FOR VALUES FROM ('2025-07-01 00:00:00') TO ('2025-07-02 00:00:00');


--
-- TOC entry 3942 (class 0 OID 0)
-- Name: messages_2025_07_02; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_02 FOR VALUES FROM ('2025-07-02 00:00:00') TO ('2025-07-03 00:00:00');


--
-- TOC entry 3943 (class 0 OID 0)
-- Name: messages_2025_07_03; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_03 FOR VALUES FROM ('2025-07-03 00:00:00') TO ('2025-07-04 00:00:00');


--
-- TOC entry 3944 (class 0 OID 0)
-- Name: messages_2025_07_04; Type: TABLE ATTACH; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_04 FOR VALUES FROM ('2025-07-04 00:00:00') TO ('2025-07-05 00:00:00');


--
-- TOC entry 3955 (class 2604 OID 18180)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 4039 (class 2604 OID 18181)
-- Name: pdf_results id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_results ALTER COLUMN id SET DEFAULT nextval('public.pdf_results_id_seq'::regclass);


--
-- TOC entry 4177 (class 2606 OID 18183)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 4161 (class 2606 OID 18185)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 4165 (class 2606 OID 18187)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 4170 (class 2606 OID 18189)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 4172 (class 2606 OID 18191)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 4175 (class 2606 OID 18193)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 4179 (class 2606 OID 18195)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 4182 (class 2606 OID 18197)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 4185 (class 2606 OID 18199)
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- TOC entry 4187 (class 2606 OID 18201)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 4192 (class 2606 OID 18203)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4200 (class 2606 OID 18205)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4203 (class 2606 OID 18207)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 4206 (class 2606 OID 18209)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 4208 (class 2606 OID 18211)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4213 (class 2606 OID 18213)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 4216 (class 2606 OID 18215)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 4219 (class 2606 OID 18217)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4224 (class 2606 OID 18219)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 4227 (class 2606 OID 18221)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4239 (class 2606 OID 18223)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 4241 (class 2606 OID 18225)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4243 (class 2606 OID 18227)
-- Name: activity_logs activity_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4248 (class 2606 OID 18229)
-- Name: audit_findings audit_findings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_findings
    ADD CONSTRAINT audit_findings_pkey PRIMARY KEY (id);


--
-- TOC entry 4254 (class 2606 OID 18231)
-- Name: audits audits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audits
    ADD CONSTRAINT audits_pkey PRIMARY KEY (id);


--
-- TOC entry 4260 (class 2606 OID 18233)
-- Name: authorities authorities_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorities
    ADD CONSTRAINT authorities_code_key UNIQUE (code);


--
-- TOC entry 4262 (class 2606 OID 18235)
-- Name: authorities authorities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorities
    ADD CONSTRAINT authorities_pkey PRIMARY KEY (id);


--
-- TOC entry 4266 (class 2606 OID 18237)
-- Name: authority_profiles authority_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authority_profiles
    ADD CONSTRAINT authority_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4268 (class 2606 OID 18239)
-- Name: billing_periods billing_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_periods
    ADD CONSTRAINT billing_periods_pkey PRIMARY KEY (id);


--
-- TOC entry 4270 (class 2606 OID 18241)
-- Name: billing_records billing_records_invoice_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_records
    ADD CONSTRAINT billing_records_invoice_number_key UNIQUE (invoice_number);


--
-- TOC entry 4272 (class 2606 OID 18243)
-- Name: billing_records billing_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_records
    ADD CONSTRAINT billing_records_pkey PRIMARY KEY (id);


--
-- TOC entry 4275 (class 2606 OID 18245)
-- Name: organizations companies_iata_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT companies_iata_code_key UNIQUE (iata_code);


--
-- TOC entry 4277 (class 2606 OID 18247)
-- Name: organizations companies_icao_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT companies_icao_code_key UNIQUE (icao_code);


--
-- TOC entry 4279 (class 2606 OID 18249)
-- Name: organizations companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- TOC entry 4286 (class 2606 OID 18251)
-- Name: document_categories document_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_categories
    ADD CONSTRAINT document_categories_pkey PRIMARY KEY (document_id, category_id);


--
-- TOC entry 4298 (class 2606 OID 18253)
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- TOC entry 4308 (class 2606 OID 18255)
-- Name: findings findings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT findings_pkey PRIMARY KEY (id);


--
-- TOC entry 4296 (class 2606 OID 18257)
-- Name: document_sections manual_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_sections
    ADD CONSTRAINT manual_sections_pkey PRIMARY KEY (id);


--
-- TOC entry 4310 (class 2606 OID 18259)
-- Name: organization_type_technical_profiles organization_type_technical_profiles_organization_type_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_type_technical_profiles
    ADD CONSTRAINT organization_type_technical_profiles_organization_type_key UNIQUE (organization_type);


--
-- TOC entry 4312 (class 2606 OID 18261)
-- Name: organization_type_technical_profiles organization_type_technical_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_type_technical_profiles
    ADD CONSTRAINT organization_type_technical_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4336 (class 2606 OID 18263)
-- Name: pdf_jobs pdf_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_jobs
    ADD CONSTRAINT pdf_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4340 (class 2606 OID 18265)
-- Name: pdf_results pdf_results_job_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_results
    ADD CONSTRAINT pdf_results_job_id_key UNIQUE (job_id);


--
-- TOC entry 4342 (class 2606 OID 18267)
-- Name: pdf_results pdf_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_results
    ADD CONSTRAINT pdf_results_pkey PRIMARY KEY (id);


--
-- TOC entry 4348 (class 2606 OID 18269)
-- Name: pdf_sections pdf_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_sections
    ADD CONSTRAINT pdf_sections_pkey PRIMARY KEY (id);


--
-- TOC entry 4354 (class 2606 OID 18271)
-- Name: pipeline_execution_logs pipeline_execution_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pipeline_execution_logs
    ADD CONSTRAINT pipeline_execution_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4356 (class 2606 OID 18273)
-- Name: regulation_categories regulation_categories_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regulation_categories
    ADD CONSTRAINT regulation_categories_name_key UNIQUE (name);


--
-- TOC entry 4358 (class 2606 OID 18275)
-- Name: regulation_categories regulation_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regulation_categories
    ADD CONSTRAINT regulation_categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4369 (class 2606 OID 18277)
-- Name: regulation_sections regulation_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regulation_sections
    ADD CONSTRAINT regulation_sections_pkey PRIMARY KEY (id);


--
-- TOC entry 4377 (class 2606 OID 18279)
-- Name: regulations regulations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regulations
    ADD CONSTRAINT regulations_pkey PRIMARY KEY (id);


--
-- TOC entry 4379 (class 2606 OID 18281)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 4381 (class 2606 OID 18283)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4383 (class 2606 OID 18285)
-- Name: schema_change_log schema_change_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_change_log
    ADD CONSTRAINT schema_change_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4284 (class 2606 OID 18287)
-- Name: token_usage token_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_usage
    ADD CONSTRAINT token_usage_pkey PRIMARY KEY (id);


--
-- TOC entry 4385 (class 2606 OID 18289)
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4387 (class 2606 OID 18291)
-- Name: user_profiles user_profiles_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_user_id_key UNIQUE (user_id);


--
-- TOC entry 4391 (class 2606 OID 18293)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4393 (class 2606 OID 18295)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4395 (class 2606 OID 18297)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4397 (class 2606 OID 18299)
-- Name: messages_2025_06_28 messages_2025_06_28_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_06_28
    ADD CONSTRAINT messages_2025_06_28_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4399 (class 2606 OID 18301)
-- Name: messages_2025_06_29 messages_2025_06_29_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_06_29
    ADD CONSTRAINT messages_2025_06_29_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4401 (class 2606 OID 18303)
-- Name: messages_2025_06_30 messages_2025_06_30_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_06_30
    ADD CONSTRAINT messages_2025_06_30_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4403 (class 2606 OID 18305)
-- Name: messages_2025_07_01 messages_2025_07_01_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_07_01
    ADD CONSTRAINT messages_2025_07_01_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4405 (class 2606 OID 18307)
-- Name: messages_2025_07_02 messages_2025_07_02_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_07_02
    ADD CONSTRAINT messages_2025_07_02_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4407 (class 2606 OID 18309)
-- Name: messages_2025_07_03 messages_2025_07_03_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_07_03
    ADD CONSTRAINT messages_2025_07_03_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4409 (class 2606 OID 18311)
-- Name: messages_2025_07_04 messages_2025_07_04_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages_2025_07_04
    ADD CONSTRAINT messages_2025_07_04_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4414 (class 2606 OID 18313)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 4411 (class 2606 OID 18315)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 4418 (class 2606 OID 18317)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 4420 (class 2606 OID 18319)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 4422 (class 2606 OID 18321)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4427 (class 2606 OID 18323)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 4432 (class 2606 OID 18325)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 4430 (class 2606 OID 18327)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 4434 (class 2606 OID 18329)
-- Name: schema_migrations schema_migrations_idempotency_key_key; Type: CONSTRAINT; Schema: supabase_migrations; Owner: -
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_idempotency_key_key UNIQUE (idempotency_key);


--
-- TOC entry 4436 (class 2606 OID 18331)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: -
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 4162 (class 1259 OID 18332)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 4229 (class 1259 OID 18333)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4230 (class 1259 OID 18334)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4231 (class 1259 OID 18335)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4183 (class 1259 OID 18336)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 4163 (class 1259 OID 18337)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 4168 (class 1259 OID 18338)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 5179 (class 0 OID 0)
-- Dependencies: 4168
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 4173 (class 1259 OID 18339)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 4166 (class 1259 OID 18340)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 4167 (class 1259 OID 18341)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 4180 (class 1259 OID 18342)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 4188 (class 1259 OID 18343)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 4189 (class 1259 OID 18344)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 4193 (class 1259 OID 18345)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 4194 (class 1259 OID 18346)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 4195 (class 1259 OID 18347)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 4232 (class 1259 OID 18348)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4233 (class 1259 OID 18349)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4196 (class 1259 OID 18350)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 4197 (class 1259 OID 18351)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 4198 (class 1259 OID 18352)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 4201 (class 1259 OID 18353)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 4204 (class 1259 OID 18354)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 4209 (class 1259 OID 18355)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 4210 (class 1259 OID 18356)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 4211 (class 1259 OID 18357)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 4214 (class 1259 OID 18358)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 4217 (class 1259 OID 18359)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 4220 (class 1259 OID 18360)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 4222 (class 1259 OID 18361)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 4225 (class 1259 OID 18362)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 4228 (class 1259 OID 18363)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 4190 (class 1259 OID 18364)
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- TOC entry 4221 (class 1259 OID 18365)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 4234 (class 1259 OID 18366)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 5180 (class 0 OID 0)
-- Dependencies: 4234
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 4235 (class 1259 OID 18367)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 4236 (class 1259 OID 18368)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 4237 (class 1259 OID 18369)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 4244 (class 1259 OID 18370)
-- Name: idx_activity_logs_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_activity_logs_created_at ON public.activity_logs USING btree (created_at);


--
-- TOC entry 4245 (class 1259 OID 18371)
-- Name: idx_activity_logs_entity_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_activity_logs_entity_type ON public.activity_logs USING btree (entity_type);


--
-- TOC entry 4246 (class 1259 OID 18372)
-- Name: idx_activity_logs_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_activity_logs_user ON public.activity_logs USING btree (user_id);


--
-- TOC entry 4249 (class 1259 OID 18373)
-- Name: idx_audit_findings_audit_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_findings_audit_id ON public.audit_findings USING btree (audit_id);


--
-- TOC entry 4250 (class 1259 OID 18374)
-- Name: idx_audit_findings_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_findings_created_at ON public.audit_findings USING btree (created_at);


--
-- TOC entry 4251 (class 1259 OID 18375)
-- Name: idx_audit_findings_severity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_findings_severity ON public.audit_findings USING btree (severity);


--
-- TOC entry 4252 (class 1259 OID 18376)
-- Name: idx_audit_findings_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_findings_status ON public.audit_findings USING btree (status);


--
-- TOC entry 4255 (class 1259 OID 18377)
-- Name: idx_audits_company; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audits_company ON public.audits USING btree (organization_id);


--
-- TOC entry 4256 (class 1259 OID 18378)
-- Name: idx_audits_organization; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audits_organization ON public.audits USING btree (organization_id);


--
-- TOC entry 4257 (class 1259 OID 18379)
-- Name: idx_audits_scheduled_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audits_scheduled_date ON public.audits USING btree (scheduled_date);


--
-- TOC entry 4258 (class 1259 OID 18380)
-- Name: idx_audits_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audits_status ON public.audits USING btree (status);


--
-- TOC entry 4263 (class 1259 OID 18381)
-- Name: idx_authorities_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_authorities_code ON public.authorities USING btree (code);


--
-- TOC entry 4264 (class 1259 OID 18382)
-- Name: idx_authorities_country; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_authorities_country ON public.authorities USING btree (country);


--
-- TOC entry 4273 (class 1259 OID 18383)
-- Name: idx_billing_records_company; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_billing_records_company ON public.billing_records USING btree (organization_id);


--
-- TOC entry 4287 (class 1259 OID 18384)
-- Name: idx_document_sections_confidence; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_document_sections_confidence ON public.document_sections USING btree (confidence) WHERE (confidence IS NOT NULL);


--
-- TOC entry 4288 (class 1259 OID 18385)
-- Name: idx_document_sections_extraction_method; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_document_sections_extraction_method ON public.document_sections USING btree (extraction_method) WHERE (extraction_method IS NOT NULL);


--
-- TOC entry 4289 (class 1259 OID 18386)
-- Name: idx_document_sections_generated; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_document_sections_generated ON public.document_sections USING btree (is_generated) WHERE (is_generated = true);


--
-- TOC entry 4290 (class 1259 OID 18387)
-- Name: idx_document_sections_hierarchy_level; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_document_sections_hierarchy_level ON public.document_sections USING btree (hierarchy_level);


--
-- TOC entry 4291 (class 1259 OID 18388)
-- Name: idx_document_sections_quality; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_document_sections_quality ON public.document_sections USING btree (quality_score) WHERE (quality_score IS NOT NULL);


--
-- TOC entry 4299 (class 1259 OID 18389)
-- Name: idx_documents_authority_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_authority_id ON public.documents USING btree (authority_id);


--
-- TOC entry 4300 (class 1259 OID 18390)
-- Name: idx_documents_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_category ON public.documents USING btree (category_id);


--
-- TOC entry 4301 (class 1259 OID 18391)
-- Name: idx_documents_manual_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_manual_active ON public.documents USING btree (document_type, is_deleted, organization_id, created_at DESC) WHERE ((document_type = 'manual'::text) AND (is_deleted = false));


--
-- TOC entry 4302 (class 1259 OID 18392)
-- Name: idx_documents_org_type_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_org_type_status ON public.documents USING btree (organization_id, document_type, status) WHERE (is_deleted = false);


--
-- TOC entry 4303 (class 1259 OID 18393)
-- Name: idx_documents_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_organization_id ON public.documents USING btree (organization_id);


--
-- TOC entry 4304 (class 1259 OID 18394)
-- Name: idx_documents_organization_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_organization_type ON public.documents USING btree (organization_id, document_type);


--
-- TOC entry 4305 (class 1259 OID 18395)
-- Name: idx_documents_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_user_id ON public.documents USING btree (user_id);


--
-- TOC entry 4306 (class 1259 OID 18396)
-- Name: idx_documents_volume_path; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_volume_path ON public.documents USING btree (volume_path);


--
-- TOC entry 4292 (class 1259 OID 18397)
-- Name: idx_manual_sections_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_manual_sections_document_id ON public.document_sections USING btree (document_id);


--
-- TOC entry 4293 (class 1259 OID 18398)
-- Name: idx_manual_sections_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_manual_sections_parent_id ON public.document_sections USING btree (parent_section_id);


--
-- TOC entry 4294 (class 1259 OID 18399)
-- Name: idx_manual_sections_vector; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_manual_sections_vector ON public.document_sections USING ivfflat (vector_embedding) WITH (lists='100');


--
-- TOC entry 4280 (class 1259 OID 18400)
-- Name: idx_organizations_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_organizations_type ON public.organizations USING btree (organization_type);


--
-- TOC entry 4313 (class 1259 OID 18401)
-- Name: idx_pdf_jobs_active_monitoring; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_active_monitoring ON public.pdf_jobs USING btree (status, current_phase, updated_at) WHERE (status = ANY (ARRAY['processing'::text, 'pending'::text, 'running'::text, 'queued'::text]));


--
-- TOC entry 4314 (class 1259 OID 18402)
-- Name: idx_pdf_jobs_auto_cleanup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_auto_cleanup ON public.pdf_jobs USING btree (auto_cleanup, cleaned_at) WHERE ((auto_cleanup = true) AND (cleaned_at IS NULL));


--
-- TOC entry 4315 (class 1259 OID 18403)
-- Name: idx_pdf_jobs_completed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_completed_at ON public.pdf_jobs USING btree (completed_at);


--
-- TOC entry 4316 (class 1259 OID 18404)
-- Name: idx_pdf_jobs_completed_for_cleanup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_completed_for_cleanup ON public.pdf_jobs USING btree (status, completed_at) WHERE ((status = 'completed'::text) AND (completed_at IS NOT NULL));


--
-- TOC entry 4317 (class 1259 OID 18405)
-- Name: idx_pdf_jobs_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_created_at ON public.pdf_jobs USING btree (created_at DESC);


--
-- TOC entry 4318 (class 1259 OID 18406)
-- Name: idx_pdf_jobs_created_by; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_created_by ON public.pdf_jobs USING btree (created_by);


--
-- TOC entry 4319 (class 1259 OID 18407)
-- Name: idx_pdf_jobs_current_phase; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_current_phase ON public.pdf_jobs USING btree (current_phase) WHERE (current_phase IS NOT NULL);


--
-- TOC entry 4320 (class 1259 OID 18408)
-- Name: idx_pdf_jobs_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_document_id ON public.pdf_jobs USING btree (document_id) WHERE (document_id IS NOT NULL);


--
-- TOC entry 4321 (class 1259 OID 18409)
-- Name: idx_pdf_jobs_document_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_document_type ON public.pdf_jobs USING btree (document_type) WHERE (document_type IS NOT NULL);


--
-- TOC entry 4322 (class 1259 OID 18410)
-- Name: idx_pdf_jobs_estimated_completion; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_estimated_completion ON public.pdf_jobs USING btree (estimated_completion_ms) WHERE (estimated_completion_ms IS NOT NULL);


--
-- TOC entry 4323 (class 1259 OID 18411)
-- Name: idx_pdf_jobs_failed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_failed ON public.pdf_jobs USING btree (status, failed_at, retry_count) WHERE (status = 'error'::text);


--
-- TOC entry 4324 (class 1259 OID 18412)
-- Name: idx_pdf_jobs_failed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_failed_at ON public.pdf_jobs USING btree (failed_at);


--
-- TOC entry 4325 (class 1259 OID 18413)
-- Name: idx_pdf_jobs_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_id ON public.pdf_jobs USING btree (id);


--
-- TOC entry 4326 (class 1259 OID 18414)
-- Name: idx_pdf_jobs_parser_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_parser_type ON public.pdf_jobs USING btree (parser_type);


--
-- TOC entry 4327 (class 1259 OID 18415)
-- Name: idx_pdf_jobs_processing_phase; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_processing_phase ON public.pdf_jobs USING btree (processing_phase);


--
-- TOC entry 4328 (class 1259 OID 18416)
-- Name: idx_pdf_jobs_processing_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_processing_time ON public.pdf_jobs USING btree (processing_time_ms) WHERE (processing_time_ms IS NOT NULL);


--
-- TOC entry 4329 (class 1259 OID 18417)
-- Name: idx_pdf_jobs_progress; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_progress ON public.pdf_jobs USING btree (progress) WHERE (progress < (100)::numeric);


--
-- TOC entry 4330 (class 1259 OID 18418)
-- Name: idx_pdf_jobs_recent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_recent ON public.pdf_jobs USING btree (created_at DESC);


--
-- TOC entry 4331 (class 1259 OID 18419)
-- Name: idx_pdf_jobs_regulation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_regulation_id ON public.pdf_jobs USING btree (regulation_id);


--
-- TOC entry 4332 (class 1259 OID 18420)
-- Name: idx_pdf_jobs_retry_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_retry_count ON public.pdf_jobs USING btree (retry_count);


--
-- TOC entry 4333 (class 1259 OID 18421)
-- Name: idx_pdf_jobs_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_status ON public.pdf_jobs USING btree (status);


--
-- TOC entry 4334 (class 1259 OID 18422)
-- Name: idx_pdf_jobs_volume_path; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_jobs_volume_path ON public.pdf_jobs USING btree (volume_path);


--
-- TOC entry 4337 (class 1259 OID 18423)
-- Name: idx_pdf_results_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_results_job_id ON public.pdf_results USING btree (job_id);


--
-- TOC entry 4338 (class 1259 OID 18424)
-- Name: idx_pdf_results_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_results_user_id ON public.pdf_results USING btree (user_id);


--
-- TOC entry 4343 (class 1259 OID 18425)
-- Name: idx_pdf_sections_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_sections_job_id ON public.pdf_sections USING btree (job_id);


--
-- TOC entry 4344 (class 1259 OID 18426)
-- Name: idx_pdf_sections_parent_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_sections_parent_section_id ON public.pdf_sections USING btree (parent_section_id);


--
-- TOC entry 4345 (class 1259 OID 18427)
-- Name: idx_pdf_sections_regulation_section_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_sections_regulation_section_id ON public.pdf_sections USING btree (regulation_section_id);


--
-- TOC entry 4346 (class 1259 OID 18428)
-- Name: idx_pdf_sections_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pdf_sections_user_id ON public.pdf_sections USING btree (user_id);


--
-- TOC entry 4349 (class 1259 OID 18429)
-- Name: idx_pipeline_logs_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pipeline_logs_job_id ON public.pipeline_execution_logs USING btree (job_id);


--
-- TOC entry 4350 (class 1259 OID 18430)
-- Name: idx_pipeline_logs_started_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pipeline_logs_started_at ON public.pipeline_execution_logs USING btree (started_at);


--
-- TOC entry 4351 (class 1259 OID 18431)
-- Name: idx_pipeline_logs_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pipeline_logs_status ON public.pipeline_execution_logs USING btree (status);


--
-- TOC entry 4352 (class 1259 OID 18432)
-- Name: idx_pipeline_logs_step; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_pipeline_logs_step ON public.pipeline_execution_logs USING btree (pipeline_step);


--
-- TOC entry 4359 (class 1259 OID 18433)
-- Name: idx_regulation_sections_confidence; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulation_sections_confidence ON public.regulation_sections USING btree (confidence) WHERE (confidence IS NOT NULL);


--
-- TOC entry 4360 (class 1259 OID 18434)
-- Name: idx_regulation_sections_extraction_method; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulation_sections_extraction_method ON public.regulation_sections USING btree (extraction_method) WHERE (extraction_method IS NOT NULL);


--
-- TOC entry 4361 (class 1259 OID 18435)
-- Name: idx_regulation_sections_generated; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulation_sections_generated ON public.regulation_sections USING btree (is_generated) WHERE (is_generated = true);


--
-- TOC entry 4362 (class 1259 OID 18436)
-- Name: idx_regulation_sections_hierarchy_level; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulation_sections_hierarchy_level ON public.regulation_sections USING btree (hierarchy_level);


--
-- TOC entry 4363 (class 1259 OID 18437)
-- Name: idx_regulation_sections_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulation_sections_parent_id ON public.regulation_sections USING btree (parent_section_id);


--
-- TOC entry 4364 (class 1259 OID 18438)
-- Name: idx_regulation_sections_quality; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulation_sections_quality ON public.regulation_sections USING btree (quality_score) WHERE (quality_score IS NOT NULL);


--
-- TOC entry 4365 (class 1259 OID 18439)
-- Name: idx_regulation_sections_regulation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulation_sections_regulation_id ON public.regulation_sections USING btree (regulation_id);


--
-- TOC entry 4366 (class 1259 OID 18440)
-- Name: idx_regulation_sections_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulation_sections_user_id ON public.regulation_sections USING btree (user_id);


--
-- TOC entry 4367 (class 1259 OID 18441)
-- Name: idx_regulation_sections_vector; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulation_sections_vector ON public.regulation_sections USING ivfflat (vector_embedding) WITH (lists='100');


--
-- TOC entry 4370 (class 1259 OID 18442)
-- Name: idx_regulations_authority_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulations_authority_id ON public.regulations USING btree (authority_id);


--
-- TOC entry 4371 (class 1259 OID 18443)
-- Name: idx_regulations_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulations_category_id ON public.regulations USING btree (category_id);


--
-- TOC entry 4372 (class 1259 OID 18444)
-- Name: idx_regulations_file_url; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulations_file_url ON public.regulations USING btree (file_url);


--
-- TOC entry 4373 (class 1259 OID 18445)
-- Name: idx_regulations_filename; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulations_filename ON public.regulations USING btree (filename);


--
-- TOC entry 4374 (class 1259 OID 18446)
-- Name: idx_regulations_parser_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulations_parser_type ON public.regulations USING btree (parser_type);


--
-- TOC entry 4375 (class 1259 OID 18447)
-- Name: idx_regulations_volume_path; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_regulations_volume_path ON public.regulations USING btree (volume_path);


--
-- TOC entry 4281 (class 1259 OID 18448)
-- Name: idx_token_usage_company; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_token_usage_company ON public.token_usage USING btree (organization_id);


--
-- TOC entry 4282 (class 1259 OID 18449)
-- Name: idx_token_usage_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_token_usage_created_at ON public.token_usage USING btree (created_at);


--
-- TOC entry 4388 (class 1259 OID 18450)
-- Name: idx_users_organization; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_organization ON public.users USING btree (organization_id);


--
-- TOC entry 4389 (class 1259 OID 18451)
-- Name: idx_users_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_role ON public.users USING btree (role_id);


--
-- TOC entry 4412 (class 1259 OID 18452)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- TOC entry 4415 (class 1259 OID 18453)
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: -
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- TOC entry 4416 (class 1259 OID 18454)
-- Name: bname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 4423 (class 1259 OID 18455)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 4428 (class 1259 OID 18456)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 4424 (class 1259 OID 18457)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 4425 (class 1259 OID 18458)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 4437 (class 0 OID 0)
-- Name: messages_2025_06_28_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_06_28_pkey;


--
-- TOC entry 4438 (class 0 OID 0)
-- Name: messages_2025_06_29_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_06_29_pkey;


--
-- TOC entry 4439 (class 0 OID 0)
-- Name: messages_2025_06_30_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_06_30_pkey;


--
-- TOC entry 4440 (class 0 OID 0)
-- Name: messages_2025_07_01_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_01_pkey;


--
-- TOC entry 4441 (class 0 OID 0)
-- Name: messages_2025_07_02_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_02_pkey;


--
-- TOC entry 4442 (class 0 OID 0)
-- Name: messages_2025_07_03_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_03_pkey;


--
-- TOC entry 4443 (class 0 OID 0)
-- Name: messages_2025_07_04_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: -
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_04_pkey;


--
-- TOC entry 4506 (class 2620 OID 18459)
-- Name: pdf_jobs comprehensive_regulation_id_fix_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER comprehensive_regulation_id_fix_trigger BEFORE INSERT ON public.pdf_jobs FOR EACH ROW EXECUTE FUNCTION public.comprehensive_regulation_id_fix();


--
-- TOC entry 4507 (class 2620 OID 18460)
-- Name: pdf_jobs pdf_jobs_audit_log; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER pdf_jobs_audit_log AFTER INSERT OR DELETE OR UPDATE ON public.pdf_jobs FOR EACH ROW EXECUTE FUNCTION public.log_pdf_activity();


--
-- TOC entry 4508 (class 2620 OID 18461)
-- Name: pdf_jobs pdf_jobs_set_user_id; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER pdf_jobs_set_user_id BEFORE INSERT ON public.pdf_jobs FOR EACH ROW EXECUTE FUNCTION public.set_pdf_job_user_id();


--
-- TOC entry 4511 (class 2620 OID 18462)
-- Name: regulation_sections trg_regulation_sections_embeddings_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_regulation_sections_embeddings_insert BEFORE INSERT ON public.regulation_sections FOR EACH ROW EXECUTE FUNCTION public.generate_embeddings();


--
-- TOC entry 4502 (class 2620 OID 18463)
-- Name: audits trigger_set_created_by_audits; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_set_created_by_audits BEFORE INSERT ON public.audits FOR EACH ROW EXECUTE FUNCTION public.set_created_by();


--
-- TOC entry 4503 (class 2620 OID 18464)
-- Name: documents trigger_set_created_by_documents; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_set_created_by_documents BEFORE INSERT ON public.documents FOR EACH ROW EXECUTE FUNCTION public.set_created_by();


--
-- TOC entry 4504 (class 2620 OID 18465)
-- Name: findings trigger_set_created_by_findings; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_set_created_by_findings BEFORE INSERT ON public.findings FOR EACH ROW EXECUTE FUNCTION public.set_created_by();


--
-- TOC entry 4509 (class 2620 OID 18466)
-- Name: pdf_jobs trigger_set_created_by_pdf_jobs; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_set_created_by_pdf_jobs BEFORE INSERT ON public.pdf_jobs FOR EACH ROW EXECUTE FUNCTION public.set_created_by();


--
-- TOC entry 4505 (class 2620 OID 18467)
-- Name: organization_type_technical_profiles update_organization_type_technical_profiles_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_organization_type_technical_profiles_updated_at BEFORE UPDATE ON public.organization_type_technical_profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4510 (class 2620 OID 18468)
-- Name: pdf_jobs update_pdf_jobs_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_pdf_jobs_updated_at BEFORE UPDATE ON public.pdf_jobs FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4512 (class 2620 OID 18469)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: -
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 4513 (class 2620 OID 18470)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 4444 (class 2606 OID 18471)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4445 (class 2606 OID 18476)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4446 (class 2606 OID 18481)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 4447 (class 2606 OID 18486)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4448 (class 2606 OID 18491)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4449 (class 2606 OID 18496)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4450 (class 2606 OID 18501)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4451 (class 2606 OID 18506)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 4452 (class 2606 OID 18511)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4453 (class 2606 OID 18516)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4454 (class 2606 OID 18521)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4455 (class 2606 OID 18526)
-- Name: activity_logs activity_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4456 (class 2606 OID 18531)
-- Name: audit_findings audit_findings_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_findings
    ADD CONSTRAINT audit_findings_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.users(id);


--
-- TOC entry 4457 (class 2606 OID 18536)
-- Name: audit_findings audit_findings_audit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_findings
    ADD CONSTRAINT audit_findings_audit_id_fkey FOREIGN KEY (audit_id) REFERENCES public.audits(id) ON DELETE CASCADE;


--
-- TOC entry 4458 (class 2606 OID 18541)
-- Name: audit_findings audit_findings_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_findings
    ADD CONSTRAINT audit_findings_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- TOC entry 4459 (class 2606 OID 18546)
-- Name: audits audits_auditor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audits
    ADD CONSTRAINT audits_auditor_id_fkey FOREIGN KEY (auditor_id) REFERENCES public.users(id);


--
-- TOC entry 4460 (class 2606 OID 18551)
-- Name: audits audits_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audits
    ADD CONSTRAINT audits_company_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- TOC entry 4461 (class 2606 OID 18556)
-- Name: audits audits_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audits
    ADD CONSTRAINT audits_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id);


--
-- TOC entry 4462 (class 2606 OID 18561)
-- Name: audits audits_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audits
    ADD CONSTRAINT audits_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.documents(id);


--
-- TOC entry 4463 (class 2606 OID 18566)
-- Name: audits audits_regulation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audits
    ADD CONSTRAINT audits_regulation_id_fkey FOREIGN KEY (regulation_id) REFERENCES public.documents(id);


--
-- TOC entry 4464 (class 2606 OID 18571)
-- Name: authority_profiles authority_profiles_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authority_profiles
    ADD CONSTRAINT authority_profiles_company_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- TOC entry 4465 (class 2606 OID 18576)
-- Name: billing_records billing_records_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_records
    ADD CONSTRAINT billing_records_company_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- TOC entry 4472 (class 2606 OID 18581)
-- Name: documents documents_authority_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_authority_id_fkey FOREIGN KEY (authority_id) REFERENCES public.authorities(id);


--
-- TOC entry 4473 (class 2606 OID 18586)
-- Name: documents documents_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.regulation_categories(id);


--
-- TOC entry 4474 (class 2606 OID 18591)
-- Name: documents documents_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- TOC entry 4475 (class 2606 OID 18596)
-- Name: documents documents_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- TOC entry 4477 (class 2606 OID 18601)
-- Name: findings findings_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT findings_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id);


--
-- TOC entry 4468 (class 2606 OID 18606)
-- Name: document_categories fk_document_categories_category; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_categories
    ADD CONSTRAINT fk_document_categories_category FOREIGN KEY (category_id) REFERENCES public.regulation_categories(id) ON DELETE CASCADE;


--
-- TOC entry 4469 (class 2606 OID 18611)
-- Name: document_categories fk_document_categories_document; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_categories
    ADD CONSTRAINT fk_document_categories_document FOREIGN KEY (document_id) REFERENCES public.documents(id) ON DELETE CASCADE;


--
-- TOC entry 4476 (class 2606 OID 18616)
-- Name: documents fk_documents_organization; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_documents_organization FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- TOC entry 4478 (class 2606 OID 18621)
-- Name: findings fk_findings_audit; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT fk_findings_audit FOREIGN KEY (audit_id) REFERENCES public.audits(id) ON DELETE CASCADE;


--
-- TOC entry 4479 (class 2606 OID 18626)
-- Name: findings fk_findings_document; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT fk_findings_document FOREIGN KEY (document_id) REFERENCES public.documents(id) ON DELETE SET NULL;


--
-- TOC entry 4480 (class 2606 OID 18631)
-- Name: findings fk_findings_regulation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.findings
    ADD CONSTRAINT fk_findings_regulation FOREIGN KEY (regulation_id) REFERENCES public.regulations(id) ON DELETE SET NULL;


--
-- TOC entry 4495 (class 2606 OID 18636)
-- Name: user_profiles fk_user_profiles_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT fk_user_profiles_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4496 (class 2606 OID 18641)
-- Name: users fk_users_organization; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_organization FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- TOC entry 4497 (class 2606 OID 18646)
-- Name: users fk_users_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- TOC entry 4470 (class 2606 OID 18651)
-- Name: document_sections manual_sections_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_sections
    ADD CONSTRAINT manual_sections_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.documents(id) ON DELETE CASCADE;


--
-- TOC entry 4471 (class 2606 OID 18656)
-- Name: document_sections manual_sections_parent_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_sections
    ADD CONSTRAINT manual_sections_parent_section_id_fkey FOREIGN KEY (parent_section_id) REFERENCES public.document_sections(id);


--
-- TOC entry 4481 (class 2606 OID 18661)
-- Name: pdf_jobs pdf_jobs_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_jobs
    ADD CONSTRAINT pdf_jobs_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id);


--
-- TOC entry 4482 (class 2606 OID 18666)
-- Name: pdf_jobs pdf_jobs_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_jobs
    ADD CONSTRAINT pdf_jobs_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.documents(id);


--
-- TOC entry 4483 (class 2606 OID 18671)
-- Name: pdf_jobs pdf_jobs_regulation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_jobs
    ADD CONSTRAINT pdf_jobs_regulation_id_fkey FOREIGN KEY (regulation_id) REFERENCES public.regulations(id);


--
-- TOC entry 4484 (class 2606 OID 18676)
-- Name: pdf_results pdf_results_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_results
    ADD CONSTRAINT pdf_results_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.pdf_jobs(id) ON DELETE CASCADE;


--
-- TOC entry 4485 (class 2606 OID 18681)
-- Name: pdf_results pdf_results_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_results
    ADD CONSTRAINT pdf_results_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- TOC entry 4486 (class 2606 OID 18686)
-- Name: pdf_sections pdf_sections_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_sections
    ADD CONSTRAINT pdf_sections_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.pdf_jobs(id) ON DELETE CASCADE;


--
-- TOC entry 4487 (class 2606 OID 18691)
-- Name: pdf_sections pdf_sections_parent_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_sections
    ADD CONSTRAINT pdf_sections_parent_section_id_fkey FOREIGN KEY (parent_section_id) REFERENCES public.pdf_sections(id);


--
-- TOC entry 4488 (class 2606 OID 18696)
-- Name: pdf_sections pdf_sections_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pdf_sections
    ADD CONSTRAINT pdf_sections_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- TOC entry 4489 (class 2606 OID 18701)
-- Name: pipeline_execution_logs pipeline_execution_logs_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pipeline_execution_logs
    ADD CONSTRAINT pipeline_execution_logs_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.pdf_jobs(id) ON DELETE CASCADE;


--
-- TOC entry 4490 (class 2606 OID 18706)
-- Name: regulation_sections regulation_sections_parent_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regulation_sections
    ADD CONSTRAINT regulation_sections_parent_section_id_fkey FOREIGN KEY (parent_section_id) REFERENCES public.regulation_sections(id) ON DELETE SET NULL;


--
-- TOC entry 4491 (class 2606 OID 18711)
-- Name: regulation_sections regulation_sections_regulation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regulation_sections
    ADD CONSTRAINT regulation_sections_regulation_id_fkey FOREIGN KEY (regulation_id) REFERENCES public.regulations(id) ON DELETE CASCADE;


--
-- TOC entry 4492 (class 2606 OID 18716)
-- Name: regulation_sections regulation_sections_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regulation_sections
    ADD CONSTRAINT regulation_sections_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- TOC entry 4493 (class 2606 OID 18721)
-- Name: regulations regulations_authority_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regulations
    ADD CONSTRAINT regulations_authority_id_fkey FOREIGN KEY (authority_id) REFERENCES public.authorities(id);


--
-- TOC entry 4494 (class 2606 OID 18726)
-- Name: regulations regulations_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.regulations
    ADD CONSTRAINT regulations_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.regulation_categories(id);


--
-- TOC entry 4466 (class 2606 OID 18731)
-- Name: token_usage token_usage_audit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_usage
    ADD CONSTRAINT token_usage_audit_id_fkey FOREIGN KEY (audit_id) REFERENCES public.audits(id) ON DELETE SET NULL;


--
-- TOC entry 4467 (class 2606 OID 18736)
-- Name: token_usage token_usage_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_usage
    ADD CONSTRAINT token_usage_company_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id) ON DELETE CASCADE;


--
-- TOC entry 4498 (class 2606 OID 18741)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4499 (class 2606 OID 18746)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4500 (class 2606 OID 18751)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4501 (class 2606 OID 18756)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 4663 (class 0 OID 17626)
-- Dependencies: 238
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4664 (class 0 OID 17632)
-- Dependencies: 239
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4665 (class 0 OID 17637)
-- Dependencies: 240
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4666 (class 0 OID 17644)
-- Dependencies: 241
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4667 (class 0 OID 17649)
-- Dependencies: 242
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4668 (class 0 OID 17654)
-- Dependencies: 243
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4669 (class 0 OID 17659)
-- Dependencies: 244
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4670 (class 0 OID 17664)
-- Dependencies: 245
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4671 (class 0 OID 17672)
-- Dependencies: 246
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4672 (class 0 OID 17678)
-- Dependencies: 248
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4673 (class 0 OID 17686)
-- Dependencies: 249
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4674 (class 0 OID 17692)
-- Dependencies: 250
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4675 (class 0 OID 17695)
-- Dependencies: 251
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4676 (class 0 OID 17700)
-- Dependencies: 252
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4677 (class 0 OID 17706)
-- Dependencies: 253
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4678 (class 0 OID 17712)
-- Dependencies: 254
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4703 (class 3256 OID 18761)
-- Name: pdf_jobs Allow all operations for authenticated users on pdf_jobs; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow all operations for authenticated users on pdf_jobs" ON public.pdf_jobs TO authenticated USING (true) WITH CHECK (true);


--
-- TOC entry 4704 (class 3256 OID 18762)
-- Name: pdf_results Allow all operations for authenticated users on pdf_results; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow all operations for authenticated users on pdf_results" ON public.pdf_results TO authenticated USING (true) WITH CHECK (true);


--
-- TOC entry 4705 (class 3256 OID 18763)
-- Name: pdf_sections Allow all operations for authenticated users on pdf_sections; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow all operations for authenticated users on pdf_sections" ON public.pdf_sections TO authenticated USING (true) WITH CHECK (true);


--
-- TOC entry 4706 (class 3256 OID 18764)
-- Name: pdf_jobs Allow read-only access for anonymous users on pdf_jobs; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow read-only access for anonymous users on pdf_jobs" ON public.pdf_jobs FOR SELECT TO anon USING (true);


--
-- TOC entry 4707 (class 3256 OID 18765)
-- Name: pdf_results Allow read-only access for anonymous users on pdf_results; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow read-only access for anonymous users on pdf_results" ON public.pdf_results FOR SELECT TO anon USING (true);


--
-- TOC entry 4708 (class 3256 OID 18766)
-- Name: pdf_sections Allow read-only access for anonymous users on pdf_sections; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Allow read-only access for anonymous users on pdf_sections" ON public.pdf_sections FOR SELECT TO anon USING (true);


--
-- TOC entry 4709 (class 3256 OID 18767)
-- Name: audits Authenticated users can insert audits; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Authenticated users can insert audits" ON public.audits FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4710 (class 3256 OID 18768)
-- Name: documents Authenticated users can insert documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Authenticated users can insert documents" ON public.documents FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4711 (class 3256 OID 18769)
-- Name: findings Authenticated users can insert findings; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Authenticated users can insert findings" ON public.findings FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4712 (class 3256 OID 18770)
-- Name: pdf_jobs Authenticated users can insert pdf jobs; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Authenticated users can insert pdf jobs" ON public.pdf_jobs FOR INSERT WITH CHECK ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4713 (class 3256 OID 18771)
-- Name: documents Authenticated users can view documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Authenticated users can view documents" ON public.documents FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4714 (class 3256 OID 18772)
-- Name: findings Authenticated users can view findings; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Authenticated users can view findings" ON public.findings FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4715 (class 3256 OID 18773)
-- Name: organizations Authenticated users can view organizations; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Authenticated users can view organizations" ON public.organizations FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4716 (class 3256 OID 18774)
-- Name: regulation_sections Authenticated users can view regulation sections; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Authenticated users can view regulation sections" ON public.regulation_sections FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4717 (class 3256 OID 18775)
-- Name: regulations Authenticated users can view regulations; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Authenticated users can view regulations" ON public.regulations FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4719 (class 3256 OID 18776)
-- Name: pdf_jobs Enhanced delete policy for pdf_jobs; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Enhanced delete policy for pdf_jobs" ON public.pdf_jobs FOR DELETE USING (((auth.role() = 'authenticated'::text) AND ((created_by = auth.uid()) OR public.is_admin() OR (created_by IS NULL))));


--
-- TOC entry 4720 (class 3256 OID 18777)
-- Name: regulations Enhanced delete policy for regulations; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Enhanced delete policy for regulations" ON public.regulations FOR DELETE USING (((auth.role() = 'authenticated'::text) AND public.is_admin()));


--
-- TOC entry 4721 (class 3256 OID 18778)
-- Name: regulations Only admins can insert regulations; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Only admins can insert regulations" ON public.regulations FOR INSERT WITH CHECK (((auth.role() = 'authenticated'::text) AND public.is_admin()));


--
-- TOC entry 4722 (class 3256 OID 18779)
-- Name: organizations Only admins can modify organizations; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Only admins can modify organizations" ON public.organizations USING (((auth.role() = 'authenticated'::text) AND public.is_admin()));


--
-- TOC entry 4723 (class 3256 OID 18780)
-- Name: regulation_sections Only admins can modify regulation sections; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Only admins can modify regulation sections" ON public.regulation_sections USING (((auth.role() = 'authenticated'::text) AND public.is_admin()));


--
-- TOC entry 4724 (class 3256 OID 18781)
-- Name: regulations Only admins can update regulations; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Only admins can update regulations" ON public.regulations FOR UPDATE USING (((auth.role() = 'authenticated'::text) AND public.is_admin())) WITH CHECK (((auth.role() = 'authenticated'::text) AND public.is_admin()));


--
-- TOC entry 4725 (class 3256 OID 18782)
-- Name: documents Service role can manage all documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Service role can manage all documents" ON public.documents TO service_role USING (true) WITH CHECK (true);


--
-- TOC entry 4726 (class 3256 OID 18783)
-- Name: audits Users can delete audits they created or admins can delete all; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can delete audits they created or admins can delete all" ON public.audits FOR DELETE USING (((auth.role() = 'authenticated'::text) AND ((created_by = auth.uid()) OR public.is_admin())));


--
-- TOC entry 4727 (class 3256 OID 18784)
-- Name: documents Users can delete documents they created or admins can delete al; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can delete documents they created or admins can delete al" ON public.documents FOR DELETE USING (((auth.role() = 'authenticated'::text) AND ((created_by = auth.uid()) OR public.is_admin())));


--
-- TOC entry 4728 (class 3256 OID 18785)
-- Name: findings Users can delete findings they created or admins can delete all; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can delete findings they created or admins can delete all" ON public.findings FOR DELETE USING (((auth.role() = 'authenticated'::text) AND ((created_by = auth.uid()) OR public.is_admin())));


--
-- TOC entry 4729 (class 3256 OID 18786)
-- Name: documents Users can delete their own documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can delete their own documents" ON public.documents FOR DELETE USING ((((auth.uid())::text = (created_by)::text) OR ((auth.uid())::text = (user_id)::text) OR ((created_by IS NULL) AND (user_id IS NULL))));


--
-- TOC entry 4730 (class 3256 OID 18787)
-- Name: documents Users can insert their own documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert their own documents" ON public.documents FOR INSERT WITH CHECK ((((auth.uid())::text = (created_by)::text) OR ((auth.uid())::text = (user_id)::text) OR ((created_by IS NULL) AND (user_id IS NULL))));


--
-- TOC entry 4731 (class 3256 OID 18788)
-- Name: user_profiles Users can insert their profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can insert their profile" ON public.user_profiles FOR INSERT WITH CHECK (((auth.role() = 'authenticated'::text) AND (user_id = auth.uid())));


--
-- TOC entry 4732 (class 3256 OID 18789)
-- Name: pdf_jobs Users can only access their own PDF jobs; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can only access their own PDF jobs" ON public.pdf_jobs USING ((auth.uid() = created_by));


--
-- TOC entry 4733 (class 3256 OID 18790)
-- Name: pdf_results Users can only access their own PDF results; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can only access their own PDF results" ON public.pdf_results USING ((auth.uid() = user_id));


--
-- TOC entry 4718 (class 3256 OID 18791)
-- Name: pdf_sections Users can only access their own PDF sections; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can only access their own PDF sections" ON public.pdf_sections USING ((auth.uid() = user_id));


--
-- TOC entry 4734 (class 3256 OID 18792)
-- Name: regulation_sections Users can only access their own regulation sections; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can only access their own regulation sections" ON public.regulation_sections USING (((user_id IS NULL) OR (auth.uid() = user_id)));


--
-- TOC entry 4735 (class 3256 OID 18793)
-- Name: audits Users can update audits they created or admins can update all; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update audits they created or admins can update all" ON public.audits FOR UPDATE USING (((auth.role() = 'authenticated'::text) AND ((created_by = auth.uid()) OR public.is_admin())));


--
-- TOC entry 4736 (class 3256 OID 18794)
-- Name: documents Users can update documents they created or admins can update al; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update documents they created or admins can update al" ON public.documents FOR UPDATE USING (((auth.role() = 'authenticated'::text) AND ((created_by = auth.uid()) OR public.is_admin())));


--
-- TOC entry 4737 (class 3256 OID 18795)
-- Name: findings Users can update findings they created or admins can update all; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update findings they created or admins can update all" ON public.findings FOR UPDATE USING (((auth.role() = 'authenticated'::text) AND ((created_by = auth.uid()) OR public.is_admin())));


--
-- TOC entry 4738 (class 3256 OID 18796)
-- Name: documents Users can update their own documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own documents" ON public.documents FOR UPDATE USING ((((auth.uid())::text = (created_by)::text) OR ((auth.uid())::text = (user_id)::text) OR ((created_by IS NULL) AND (user_id IS NULL))));


--
-- TOC entry 4739 (class 3256 OID 18797)
-- Name: pdf_jobs Users can update their own pdf jobs or admins can update all; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own pdf jobs or admins can update all" ON public.pdf_jobs FOR UPDATE USING (((auth.role() = 'authenticated'::text) AND ((created_by = auth.uid()) OR public.is_admin())));


--
-- TOC entry 4740 (class 3256 OID 18798)
-- Name: user_profiles Users can update their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own profile" ON public.user_profiles FOR UPDATE USING (((auth.role() = 'authenticated'::text) AND (user_id = auth.uid())));


--
-- TOC entry 4741 (class 3256 OID 18799)
-- Name: users Users can update their own profile; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can update their own profile" ON public.users FOR UPDATE USING (((auth.role() = 'authenticated'::text) AND (id = auth.uid()) AND (is_active = true) AND (is_deleted = false)));


--
-- TOC entry 4742 (class 3256 OID 18800)
-- Name: users Users can view active users they have access to; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view active users they have access to" ON public.users FOR SELECT USING (((auth.role() = 'authenticated'::text) AND (is_active = true) AND (is_deleted = false) AND ((id = auth.uid()) OR public.is_admin())));


--
-- TOC entry 4743 (class 3256 OID 18801)
-- Name: audits Users can view audits they created or admins can view all; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view audits they created or admins can view all" ON public.audits FOR SELECT USING (((auth.role() = 'authenticated'::text) AND ((created_by = auth.uid()) OR public.is_admin())));


--
-- TOC entry 4744 (class 3256 OID 18802)
-- Name: documents Users can view their own documents; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own documents" ON public.documents FOR SELECT USING ((((auth.uid())::text = (created_by)::text) OR ((auth.uid())::text = (user_id)::text) OR (created_by IS NULL) OR (user_id IS NULL)));


--
-- TOC entry 4745 (class 3256 OID 18803)
-- Name: pdf_jobs Users can view their own pdf jobs or admins can view all; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their own pdf jobs or admins can view all" ON public.pdf_jobs FOR SELECT USING (((auth.role() = 'authenticated'::text) AND ((created_by = auth.uid()) OR public.is_admin())));


--
-- TOC entry 4746 (class 3256 OID 18804)
-- Name: user_profiles Users can view their profile or admins can view all; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY "Users can view their profile or admins can view all" ON public.user_profiles FOR SELECT USING (((auth.role() = 'authenticated'::text) AND ((user_id = auth.uid()) OR public.is_admin())));


--
-- TOC entry 4679 (class 0 OID 17782)
-- Dependencies: 266
-- Name: activity_logs; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.activity_logs ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4680 (class 0 OID 17790)
-- Dependencies: 267
-- Name: audit_findings; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.audit_findings ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4681 (class 0 OID 17803)
-- Dependencies: 268
-- Name: audits; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.audits ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4682 (class 0 OID 17815)
-- Dependencies: 269
-- Name: authorities; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.authorities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4747 (class 3256 OID 18805)
-- Name: authorities authorities_authenticated_read; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY authorities_authenticated_read ON public.authorities FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4683 (class 0 OID 17842)
-- Dependencies: 272
-- Name: billing_records; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.billing_records ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4748 (class 3256 OID 18806)
-- Name: regulation_categories categories_authenticated_read; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY categories_authenticated_read ON public.regulation_categories FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 4686 (class 0 OID 17881)
-- Dependencies: 277
-- Name: document_sections; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.document_sections ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4749 (class 3256 OID 18807)
-- Name: document_sections document_sections_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY document_sections_policy ON public.document_sections USING ((EXISTS ( SELECT 1
   FROM (public.documents d
     LEFT JOIN public.users u ON (((d.organization_id = u.organization_id) AND (u.id = auth.uid()))))
  WHERE ((document_sections.document_id = d.id) AND ((u.id IS NOT NULL) OR (d.organization_id IS NULL))))));


--
-- TOC entry 4687 (class 0 OID 17894)
-- Dependencies: 278
-- Name: documents; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.documents ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4688 (class 0 OID 17910)
-- Dependencies: 279
-- Name: findings; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.findings ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4684 (class 0 OID 17853)
-- Dependencies: 273
-- Name: organizations; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.organizations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4689 (class 0 OID 17937)
-- Dependencies: 283
-- Name: pdf_jobs; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.pdf_jobs ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4690 (class 0 OID 17958)
-- Dependencies: 284
-- Name: pdf_results; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.pdf_results ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4691 (class 0 OID 17966)
-- Dependencies: 286
-- Name: pdf_sections; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.pdf_sections ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4692 (class 0 OID 17984)
-- Dependencies: 288
-- Name: regulation_categories; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.regulation_categories ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4693 (class 0 OID 17991)
-- Dependencies: 289
-- Name: regulation_sections; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.regulation_sections ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4750 (class 3256 OID 18809)
-- Name: regulation_sections regulation_sections_policy; Type: POLICY; Schema: public; Owner: -
--

CREATE POLICY regulation_sections_policy ON public.regulation_sections USING (((regulation_id IN ( SELECT r.id
   FROM public.regulations r
  WHERE (EXISTS ( SELECT 1
           FROM public.users
          WHERE (users.id = auth.uid()))))) OR (EXISTS ( SELECT 1
   FROM public.users
  WHERE ((users.id = auth.uid()) AND (users.role = 'admin'::text))))));


--
-- TOC entry 4694 (class 0 OID 18005)
-- Dependencies: 290
-- Name: regulations; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.regulations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4685 (class 0 OID 17864)
-- Dependencies: 274
-- Name: token_usage; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.token_usage ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4695 (class 0 OID 18037)
-- Dependencies: 294
-- Name: user_profiles; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4696 (class 0 OID 18046)
-- Dependencies: 295
-- Name: users; Type: ROW SECURITY; Schema: public; Owner: -
--

ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4751 (class 3256 OID 18810)
-- Name: messages Allow authenticated users to receive realtime events; Type: POLICY; Schema: realtime; Owner: -
--

CREATE POLICY "Allow authenticated users to receive realtime events" ON realtime.messages FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4697 (class 0 OID 18055)
-- Dependencies: 296
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: -
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4698 (class 0 OID 18137)
-- Dependencies: 307
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4699 (class 0 OID 18146)
-- Dependencies: 308
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4700 (class 0 OID 18150)
-- Dependencies: 309
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4701 (class 0 OID 18160)
-- Dependencies: 310
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4702 (class 0 OID 18167)
-- Dependencies: 311
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4752 (class 6104 OID 18811)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: -
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


--
-- TOC entry 4753 (class 6104 OID 18812)
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: -
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


--
-- TOC entry 4754 (class 6106 OID 18813)
-- Name: supabase_realtime audits; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.audits;


--
-- TOC entry 4755 (class 6106 OID 18814)
-- Name: supabase_realtime authority_profiles; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.authority_profiles;


--
-- TOC entry 4756 (class 6106 OID 18815)
-- Name: supabase_realtime billing_records; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.billing_records;


--
-- TOC entry 4757 (class 6106 OID 18816)
-- Name: supabase_realtime pdf_jobs; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.pdf_jobs;


--
-- TOC entry 4758 (class 6106 OID 18817)
-- Name: supabase_realtime regulations; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.regulations;


--
-- TOC entry 4759 (class 6106 OID 18818)
-- Name: supabase_realtime users; Type: PUBLICATION TABLE; Schema: public; Owner: -
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.users;


--
-- TOC entry 4760 (class 6106 OID 18819)
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: -
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- TOC entry 4767 (class 0 OID 0)
-- Dependencies: 4766
-- Name: DATABASE postgres; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON DATABASE postgres TO dashboard_user;


--
-- TOC entry 4768 (class 0 OID 0)
-- Dependencies: 22
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- TOC entry 4769 (class 0 OID 0)
-- Dependencies: 11
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 4771 (class 0 OID 0)
-- Dependencies: 20
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 4772 (class 0 OID 0)
-- Dependencies: 16
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 4773 (class 0 OID 0)
-- Dependencies: 21
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 4774 (class 0 OID 0)
-- Dependencies: 17
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- TOC entry 4782 (class 0 OID 0)
-- Dependencies: 429
-- Name: FUNCTION halfvec_in(cstring, oid, integer); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_in(cstring, oid, integer) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_in(cstring, oid, integer) TO anon;
GRANT ALL ON FUNCTION public.halfvec_in(cstring, oid, integer) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_in(cstring, oid, integer) TO service_role;


--
-- TOC entry 4783 (class 0 OID 0)
-- Dependencies: 430
-- Name: FUNCTION halfvec_out(public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_out(public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_out(public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_out(public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_out(public.halfvec) TO service_role;


--
-- TOC entry 4784 (class 0 OID 0)
-- Dependencies: 432
-- Name: FUNCTION halfvec_recv(internal, oid, integer); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_recv(internal, oid, integer) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_recv(internal, oid, integer) TO anon;
GRANT ALL ON FUNCTION public.halfvec_recv(internal, oid, integer) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_recv(internal, oid, integer) TO service_role;


--
-- TOC entry 4785 (class 0 OID 0)
-- Dependencies: 433
-- Name: FUNCTION halfvec_send(public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_send(public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_send(public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_send(public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_send(public.halfvec) TO service_role;


--
-- TOC entry 4786 (class 0 OID 0)
-- Dependencies: 431
-- Name: FUNCTION halfvec_typmod_in(cstring[]); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_typmod_in(cstring[]) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_typmod_in(cstring[]) TO anon;
GRANT ALL ON FUNCTION public.halfvec_typmod_in(cstring[]) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_typmod_in(cstring[]) TO service_role;


--
-- TOC entry 4787 (class 0 OID 0)
-- Dependencies: 470
-- Name: FUNCTION sparsevec_in(cstring, oid, integer); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_in(cstring, oid, integer) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_in(cstring, oid, integer) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_in(cstring, oid, integer) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_in(cstring, oid, integer) TO service_role;


--
-- TOC entry 4788 (class 0 OID 0)
-- Dependencies: 471
-- Name: FUNCTION sparsevec_out(public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_out(public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_out(public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_out(public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_out(public.sparsevec) TO service_role;


--
-- TOC entry 4789 (class 0 OID 0)
-- Dependencies: 473
-- Name: FUNCTION sparsevec_recv(internal, oid, integer); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_recv(internal, oid, integer) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_recv(internal, oid, integer) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_recv(internal, oid, integer) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_recv(internal, oid, integer) TO service_role;


--
-- TOC entry 4790 (class 0 OID 0)
-- Dependencies: 474
-- Name: FUNCTION sparsevec_send(public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_send(public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_send(public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_send(public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_send(public.sparsevec) TO service_role;


--
-- TOC entry 4791 (class 0 OID 0)
-- Dependencies: 472
-- Name: FUNCTION sparsevec_typmod_in(cstring[]); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_typmod_in(cstring[]) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_typmod_in(cstring[]) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_typmod_in(cstring[]) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_typmod_in(cstring[]) TO service_role;


--
-- TOC entry 4792 (class 0 OID 0)
-- Dependencies: 385
-- Name: FUNCTION vector_in(cstring, oid, integer); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_in(cstring, oid, integer) TO postgres;
GRANT ALL ON FUNCTION public.vector_in(cstring, oid, integer) TO anon;
GRANT ALL ON FUNCTION public.vector_in(cstring, oid, integer) TO authenticated;
GRANT ALL ON FUNCTION public.vector_in(cstring, oid, integer) TO service_role;


--
-- TOC entry 4793 (class 0 OID 0)
-- Dependencies: 386
-- Name: FUNCTION vector_out(public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_out(public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_out(public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_out(public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_out(public.vector) TO service_role;


--
-- TOC entry 4794 (class 0 OID 0)
-- Dependencies: 388
-- Name: FUNCTION vector_recv(internal, oid, integer); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_recv(internal, oid, integer) TO postgres;
GRANT ALL ON FUNCTION public.vector_recv(internal, oid, integer) TO anon;
GRANT ALL ON FUNCTION public.vector_recv(internal, oid, integer) TO authenticated;
GRANT ALL ON FUNCTION public.vector_recv(internal, oid, integer) TO service_role;


--
-- TOC entry 4795 (class 0 OID 0)
-- Dependencies: 389
-- Name: FUNCTION vector_send(public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_send(public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_send(public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_send(public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_send(public.vector) TO service_role;


--
-- TOC entry 4796 (class 0 OID 0)
-- Dependencies: 387
-- Name: FUNCTION vector_typmod_in(cstring[]); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_typmod_in(cstring[]) TO postgres;
GRANT ALL ON FUNCTION public.vector_typmod_in(cstring[]) TO anon;
GRANT ALL ON FUNCTION public.vector_typmod_in(cstring[]) TO authenticated;
GRANT ALL ON FUNCTION public.vector_typmod_in(cstring[]) TO service_role;


--
-- TOC entry 4797 (class 0 OID 0)
-- Dependencies: 464
-- Name: FUNCTION array_to_halfvec(real[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_halfvec(real[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_halfvec(real[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_halfvec(real[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_halfvec(real[], integer, boolean) TO service_role;


--
-- TOC entry 4798 (class 0 OID 0)
-- Dependencies: 496
-- Name: FUNCTION array_to_sparsevec(real[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_sparsevec(real[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_sparsevec(real[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_sparsevec(real[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_sparsevec(real[], integer, boolean) TO service_role;


--
-- TOC entry 4799 (class 0 OID 0)
-- Dependencies: 418
-- Name: FUNCTION array_to_vector(real[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_vector(real[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_vector(real[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_vector(real[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_vector(real[], integer, boolean) TO service_role;


--
-- TOC entry 4800 (class 0 OID 0)
-- Dependencies: 465
-- Name: FUNCTION array_to_halfvec(double precision[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_halfvec(double precision[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_halfvec(double precision[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_halfvec(double precision[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_halfvec(double precision[], integer, boolean) TO service_role;


--
-- TOC entry 4801 (class 0 OID 0)
-- Dependencies: 497
-- Name: FUNCTION array_to_sparsevec(double precision[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_sparsevec(double precision[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_sparsevec(double precision[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_sparsevec(double precision[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_sparsevec(double precision[], integer, boolean) TO service_role;


--
-- TOC entry 4802 (class 0 OID 0)
-- Dependencies: 419
-- Name: FUNCTION array_to_vector(double precision[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_vector(double precision[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_vector(double precision[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_vector(double precision[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_vector(double precision[], integer, boolean) TO service_role;


--
-- TOC entry 4803 (class 0 OID 0)
-- Dependencies: 463
-- Name: FUNCTION array_to_halfvec(integer[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_halfvec(integer[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_halfvec(integer[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_halfvec(integer[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_halfvec(integer[], integer, boolean) TO service_role;


--
-- TOC entry 4804 (class 0 OID 0)
-- Dependencies: 495
-- Name: FUNCTION array_to_sparsevec(integer[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_sparsevec(integer[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_sparsevec(integer[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_sparsevec(integer[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_sparsevec(integer[], integer, boolean) TO service_role;


--
-- TOC entry 4805 (class 0 OID 0)
-- Dependencies: 417
-- Name: FUNCTION array_to_vector(integer[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_vector(integer[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_vector(integer[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_vector(integer[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_vector(integer[], integer, boolean) TO service_role;


--
-- TOC entry 4806 (class 0 OID 0)
-- Dependencies: 466
-- Name: FUNCTION array_to_halfvec(numeric[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_halfvec(numeric[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_halfvec(numeric[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_halfvec(numeric[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_halfvec(numeric[], integer, boolean) TO service_role;


--
-- TOC entry 4807 (class 0 OID 0)
-- Dependencies: 498
-- Name: FUNCTION array_to_sparsevec(numeric[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_sparsevec(numeric[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_sparsevec(numeric[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_sparsevec(numeric[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_sparsevec(numeric[], integer, boolean) TO service_role;


--
-- TOC entry 4808 (class 0 OID 0)
-- Dependencies: 420
-- Name: FUNCTION array_to_vector(numeric[], integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.array_to_vector(numeric[], integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.array_to_vector(numeric[], integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.array_to_vector(numeric[], integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.array_to_vector(numeric[], integer, boolean) TO service_role;


--
-- TOC entry 4809 (class 0 OID 0)
-- Dependencies: 467
-- Name: FUNCTION halfvec_to_float4(public.halfvec, integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_to_float4(public.halfvec, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_to_float4(public.halfvec, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.halfvec_to_float4(public.halfvec, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_to_float4(public.halfvec, integer, boolean) TO service_role;


--
-- TOC entry 4810 (class 0 OID 0)
-- Dependencies: 460
-- Name: FUNCTION halfvec(public.halfvec, integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec(public.halfvec, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.halfvec(public.halfvec, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.halfvec(public.halfvec, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec(public.halfvec, integer, boolean) TO service_role;


--
-- TOC entry 4811 (class 0 OID 0)
-- Dependencies: 493
-- Name: FUNCTION halfvec_to_sparsevec(public.halfvec, integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_to_sparsevec(public.halfvec, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_to_sparsevec(public.halfvec, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.halfvec_to_sparsevec(public.halfvec, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_to_sparsevec(public.halfvec, integer, boolean) TO service_role;


--
-- TOC entry 4812 (class 0 OID 0)
-- Dependencies: 461
-- Name: FUNCTION halfvec_to_vector(public.halfvec, integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_to_vector(public.halfvec, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_to_vector(public.halfvec, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.halfvec_to_vector(public.halfvec, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_to_vector(public.halfvec, integer, boolean) TO service_role;


--
-- TOC entry 4813 (class 0 OID 0)
-- Dependencies: 494
-- Name: FUNCTION sparsevec_to_halfvec(public.sparsevec, integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_to_halfvec(public.sparsevec, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_to_halfvec(public.sparsevec, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_to_halfvec(public.sparsevec, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_to_halfvec(public.sparsevec, integer, boolean) TO service_role;


--
-- TOC entry 4814 (class 0 OID 0)
-- Dependencies: 490
-- Name: FUNCTION sparsevec(public.sparsevec, integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec(public.sparsevec, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec(public.sparsevec, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.sparsevec(public.sparsevec, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec(public.sparsevec, integer, boolean) TO service_role;


--
-- TOC entry 4815 (class 0 OID 0)
-- Dependencies: 492
-- Name: FUNCTION sparsevec_to_vector(public.sparsevec, integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_to_vector(public.sparsevec, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_to_vector(public.sparsevec, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_to_vector(public.sparsevec, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_to_vector(public.sparsevec, integer, boolean) TO service_role;


--
-- TOC entry 4816 (class 0 OID 0)
-- Dependencies: 421
-- Name: FUNCTION vector_to_float4(public.vector, integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_to_float4(public.vector, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.vector_to_float4(public.vector, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.vector_to_float4(public.vector, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.vector_to_float4(public.vector, integer, boolean) TO service_role;


--
-- TOC entry 4817 (class 0 OID 0)
-- Dependencies: 462
-- Name: FUNCTION vector_to_halfvec(public.vector, integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_to_halfvec(public.vector, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.vector_to_halfvec(public.vector, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.vector_to_halfvec(public.vector, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.vector_to_halfvec(public.vector, integer, boolean) TO service_role;


--
-- TOC entry 4818 (class 0 OID 0)
-- Dependencies: 491
-- Name: FUNCTION vector_to_sparsevec(public.vector, integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_to_sparsevec(public.vector, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.vector_to_sparsevec(public.vector, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.vector_to_sparsevec(public.vector, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.vector_to_sparsevec(public.vector, integer, boolean) TO service_role;


--
-- TOC entry 4819 (class 0 OID 0)
-- Dependencies: 416
-- Name: FUNCTION vector(public.vector, integer, boolean); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector(public.vector, integer, boolean) TO postgres;
GRANT ALL ON FUNCTION public.vector(public.vector, integer, boolean) TO anon;
GRANT ALL ON FUNCTION public.vector(public.vector, integer, boolean) TO authenticated;
GRANT ALL ON FUNCTION public.vector(public.vector, integer, boolean) TO service_role;


--
-- TOC entry 4821 (class 0 OID 0)
-- Dependencies: 499
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;
GRANT ALL ON FUNCTION auth.email() TO postgres;


--
-- TOC entry 4822 (class 0 OID 0)
-- Dependencies: 500
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 4824 (class 0 OID 0)
-- Dependencies: 501
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;
GRANT ALL ON FUNCTION auth.role() TO postgres;


--
-- TOC entry 4826 (class 0 OID 0)
-- Dependencies: 502
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;
GRANT ALL ON FUNCTION auth.uid() TO postgres;


--
-- TOC entry 4827 (class 0 OID 0)
-- Dependencies: 366
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 4828 (class 0 OID 0)
-- Dependencies: 360
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- TOC entry 4829 (class 0 OID 0)
-- Dependencies: 361
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- TOC entry 4830 (class 0 OID 0)
-- Dependencies: 332
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- TOC entry 4831 (class 0 OID 0)
-- Dependencies: 362
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- TOC entry 4832 (class 0 OID 0)
-- Dependencies: 336
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4833 (class 0 OID 0)
-- Dependencies: 338
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4834 (class 0 OID 0)
-- Dependencies: 329
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- TOC entry 4835 (class 0 OID 0)
-- Dependencies: 328
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- TOC entry 4836 (class 0 OID 0)
-- Dependencies: 335
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4837 (class 0 OID 0)
-- Dependencies: 337
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4838 (class 0 OID 0)
-- Dependencies: 339
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- TOC entry 4839 (class 0 OID 0)
-- Dependencies: 340
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- TOC entry 4840 (class 0 OID 0)
-- Dependencies: 333
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- TOC entry 4841 (class 0 OID 0)
-- Dependencies: 334
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- TOC entry 4843 (class 0 OID 0)
-- Dependencies: 503
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4845 (class 0 OID 0)
-- Dependencies: 504
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4847 (class 0 OID 0)
-- Dependencies: 505
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: -
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4848 (class 0 OID 0)
-- Dependencies: 331
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4849 (class 0 OID 0)
-- Dependencies: 330
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- TOC entry 4850 (class 0 OID 0)
-- Dependencies: 327
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- TOC entry 4851 (class 0 OID 0)
-- Dependencies: 326
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4852 (class 0 OID 0)
-- Dependencies: 325
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- TOC entry 4853 (class 0 OID 0)
-- Dependencies: 363
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- TOC entry 4854 (class 0 OID 0)
-- Dependencies: 359
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- TOC entry 4855 (class 0 OID 0)
-- Dependencies: 353
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4856 (class 0 OID 0)
-- Dependencies: 355
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4857 (class 0 OID 0)
-- Dependencies: 357
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4858 (class 0 OID 0)
-- Dependencies: 354
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4859 (class 0 OID 0)
-- Dependencies: 356
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4860 (class 0 OID 0)
-- Dependencies: 358
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4861 (class 0 OID 0)
-- Dependencies: 349
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- TOC entry 4862 (class 0 OID 0)
-- Dependencies: 351
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- TOC entry 4863 (class 0 OID 0)
-- Dependencies: 350
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4864 (class 0 OID 0)
-- Dependencies: 352
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4865 (class 0 OID 0)
-- Dependencies: 345
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- TOC entry 4866 (class 0 OID 0)
-- Dependencies: 347
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4867 (class 0 OID 0)
-- Dependencies: 346
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4868 (class 0 OID 0)
-- Dependencies: 348
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4869 (class 0 OID 0)
-- Dependencies: 341
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 343
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 342
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 344
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 506
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4874 (class 0 OID 0)
-- Dependencies: 507
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4876 (class 0 OID 0)
-- Dependencies: 508
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4877 (class 0 OID 0)
-- Dependencies: 367
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 4878 (class 0 OID 0)
-- Dependencies: 369
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 365
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 364
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 380
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 381
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 382
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 383
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 384
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 375
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 376
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 378
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 377
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 379
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 368
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 552
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: -
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 509
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: -
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 510
-- Name: FUNCTION auto_fix_regulation_id(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.auto_fix_regulation_id() TO anon;
GRANT ALL ON FUNCTION public.auto_fix_regulation_id() TO authenticated;
GRANT ALL ON FUNCTION public.auto_fix_regulation_id() TO service_role;


--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 441
-- Name: FUNCTION binary_quantize(public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.binary_quantize(public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.binary_quantize(public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.binary_quantize(public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.binary_quantize(public.halfvec) TO service_role;


--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 397
-- Name: FUNCTION binary_quantize(public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.binary_quantize(public.vector) TO postgres;
GRANT ALL ON FUNCTION public.binary_quantize(public.vector) TO anon;
GRANT ALL ON FUNCTION public.binary_quantize(public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.binary_quantize(public.vector) TO service_role;


--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 511
-- Name: FUNCTION bulk_delete_manuals(manual_ids uuid[]); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.bulk_delete_manuals(manual_ids uuid[]) TO anon;
GRANT ALL ON FUNCTION public.bulk_delete_manuals(manual_ids uuid[]) TO authenticated;
GRANT ALL ON FUNCTION public.bulk_delete_manuals(manual_ids uuid[]) TO service_role;


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 512
-- Name: FUNCTION comprehensive_regulation_id_fix(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.comprehensive_regulation_id_fix() TO anon;
GRANT ALL ON FUNCTION public.comprehensive_regulation_id_fix() TO authenticated;
GRANT ALL ON FUNCTION public.comprehensive_regulation_id_fix() TO service_role;


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 436
-- Name: FUNCTION cosine_distance(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.cosine_distance(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.cosine_distance(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.cosine_distance(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.cosine_distance(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 477
-- Name: FUNCTION cosine_distance(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.cosine_distance(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.cosine_distance(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.cosine_distance(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.cosine_distance(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 392
-- Name: FUNCTION cosine_distance(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.cosine_distance(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.cosine_distance(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.cosine_distance(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.cosine_distance(public.vector, public.vector) TO service_role;


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 513
-- Name: FUNCTION debug_job_creation(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.debug_job_creation() TO anon;
GRANT ALL ON FUNCTION public.debug_job_creation() TO authenticated;
GRANT ALL ON FUNCTION public.debug_job_creation() TO service_role;


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 514
-- Name: FUNCTION generate_embeddings(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.generate_embeddings() TO anon;
GRANT ALL ON FUNCTION public.generate_embeddings() TO authenticated;
GRANT ALL ON FUNCTION public.generate_embeddings() TO service_role;


--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 515
-- Name: FUNCTION get_user_role(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.get_user_role() TO anon;
GRANT ALL ON FUNCTION public.get_user_role() TO authenticated;
GRANT ALL ON FUNCTION public.get_user_role() TO service_role;


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 457
-- Name: FUNCTION halfvec_accum(double precision[], public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_accum(double precision[], public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_accum(double precision[], public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_accum(double precision[], public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_accum(double precision[], public.halfvec) TO service_role;


--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 443
-- Name: FUNCTION halfvec_add(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_add(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_add(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_add(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_add(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 458
-- Name: FUNCTION halfvec_avg(double precision[]); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_avg(double precision[]) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_avg(double precision[]) TO anon;
GRANT ALL ON FUNCTION public.halfvec_avg(double precision[]) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_avg(double precision[]) TO service_role;


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 453
-- Name: FUNCTION halfvec_cmp(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_cmp(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_cmp(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_cmp(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_cmp(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 459
-- Name: FUNCTION halfvec_combine(double precision[], double precision[]); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_combine(double precision[], double precision[]) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_combine(double precision[], double precision[]) TO anon;
GRANT ALL ON FUNCTION public.halfvec_combine(double precision[], double precision[]) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_combine(double precision[], double precision[]) TO service_role;


--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 446
-- Name: FUNCTION halfvec_concat(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_concat(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_concat(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_concat(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_concat(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 449
-- Name: FUNCTION halfvec_eq(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_eq(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_eq(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_eq(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_eq(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 451
-- Name: FUNCTION halfvec_ge(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_ge(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_ge(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_ge(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_ge(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 452
-- Name: FUNCTION halfvec_gt(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_gt(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_gt(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_gt(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_gt(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 454
-- Name: FUNCTION halfvec_l2_squared_distance(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_l2_squared_distance(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_l2_squared_distance(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_l2_squared_distance(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_l2_squared_distance(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 448
-- Name: FUNCTION halfvec_le(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_le(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_le(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_le(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_le(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 447
-- Name: FUNCTION halfvec_lt(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_lt(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_lt(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_lt(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_lt(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 445
-- Name: FUNCTION halfvec_mul(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_mul(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_mul(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_mul(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_mul(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 450
-- Name: FUNCTION halfvec_ne(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_ne(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_ne(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_ne(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_ne(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 455
-- Name: FUNCTION halfvec_negative_inner_product(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_negative_inner_product(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_negative_inner_product(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_negative_inner_product(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_negative_inner_product(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 456
-- Name: FUNCTION halfvec_spherical_distance(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_spherical_distance(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_spherical_distance(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_spherical_distance(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_spherical_distance(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 444
-- Name: FUNCTION halfvec_sub(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.halfvec_sub(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.halfvec_sub(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.halfvec_sub(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.halfvec_sub(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 468
-- Name: FUNCTION hamming_distance(bit, bit); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.hamming_distance(bit, bit) TO postgres;
GRANT ALL ON FUNCTION public.hamming_distance(bit, bit) TO anon;
GRANT ALL ON FUNCTION public.hamming_distance(bit, bit) TO authenticated;
GRANT ALL ON FUNCTION public.hamming_distance(bit, bit) TO service_role;


--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 427
-- Name: FUNCTION hnsw_bit_support(internal); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.hnsw_bit_support(internal) TO postgres;
GRANT ALL ON FUNCTION public.hnsw_bit_support(internal) TO anon;
GRANT ALL ON FUNCTION public.hnsw_bit_support(internal) TO authenticated;
GRANT ALL ON FUNCTION public.hnsw_bit_support(internal) TO service_role;


--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 426
-- Name: FUNCTION hnsw_halfvec_support(internal); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.hnsw_halfvec_support(internal) TO postgres;
GRANT ALL ON FUNCTION public.hnsw_halfvec_support(internal) TO anon;
GRANT ALL ON FUNCTION public.hnsw_halfvec_support(internal) TO authenticated;
GRANT ALL ON FUNCTION public.hnsw_halfvec_support(internal) TO service_role;


--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 428
-- Name: FUNCTION hnsw_sparsevec_support(internal); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.hnsw_sparsevec_support(internal) TO postgres;
GRANT ALL ON FUNCTION public.hnsw_sparsevec_support(internal) TO anon;
GRANT ALL ON FUNCTION public.hnsw_sparsevec_support(internal) TO authenticated;
GRANT ALL ON FUNCTION public.hnsw_sparsevec_support(internal) TO service_role;


--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 423
-- Name: FUNCTION hnswhandler(internal); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.hnswhandler(internal) TO postgres;
GRANT ALL ON FUNCTION public.hnswhandler(internal) TO anon;
GRANT ALL ON FUNCTION public.hnswhandler(internal) TO authenticated;
GRANT ALL ON FUNCTION public.hnswhandler(internal) TO service_role;


--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 435
-- Name: FUNCTION inner_product(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.inner_product(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.inner_product(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.inner_product(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.inner_product(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 476
-- Name: FUNCTION inner_product(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.inner_product(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.inner_product(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.inner_product(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.inner_product(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 391
-- Name: FUNCTION inner_product(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.inner_product(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.inner_product(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.inner_product(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.inner_product(public.vector, public.vector) TO service_role;


--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 516
-- Name: FUNCTION is_admin(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.is_admin() TO anon;
GRANT ALL ON FUNCTION public.is_admin() TO authenticated;
GRANT ALL ON FUNCTION public.is_admin() TO service_role;


--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 425
-- Name: FUNCTION ivfflat_bit_support(internal); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.ivfflat_bit_support(internal) TO postgres;
GRANT ALL ON FUNCTION public.ivfflat_bit_support(internal) TO anon;
GRANT ALL ON FUNCTION public.ivfflat_bit_support(internal) TO authenticated;
GRANT ALL ON FUNCTION public.ivfflat_bit_support(internal) TO service_role;


--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 424
-- Name: FUNCTION ivfflat_halfvec_support(internal); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.ivfflat_halfvec_support(internal) TO postgres;
GRANT ALL ON FUNCTION public.ivfflat_halfvec_support(internal) TO anon;
GRANT ALL ON FUNCTION public.ivfflat_halfvec_support(internal) TO authenticated;
GRANT ALL ON FUNCTION public.ivfflat_halfvec_support(internal) TO service_role;


--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 422
-- Name: FUNCTION ivfflathandler(internal); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.ivfflathandler(internal) TO postgres;
GRANT ALL ON FUNCTION public.ivfflathandler(internal) TO anon;
GRANT ALL ON FUNCTION public.ivfflathandler(internal) TO authenticated;
GRANT ALL ON FUNCTION public.ivfflathandler(internal) TO service_role;


--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 469
-- Name: FUNCTION jaccard_distance(bit, bit); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.jaccard_distance(bit, bit) TO postgres;
GRANT ALL ON FUNCTION public.jaccard_distance(bit, bit) TO anon;
GRANT ALL ON FUNCTION public.jaccard_distance(bit, bit) TO authenticated;
GRANT ALL ON FUNCTION public.jaccard_distance(bit, bit) TO service_role;


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 437
-- Name: FUNCTION l1_distance(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.l1_distance(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.l1_distance(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.l1_distance(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.l1_distance(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 478
-- Name: FUNCTION l1_distance(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.l1_distance(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.l1_distance(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.l1_distance(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.l1_distance(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 393
-- Name: FUNCTION l1_distance(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.l1_distance(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.l1_distance(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.l1_distance(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.l1_distance(public.vector, public.vector) TO service_role;


--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 434
-- Name: FUNCTION l2_distance(public.halfvec, public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.l2_distance(public.halfvec, public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.l2_distance(public.halfvec, public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.l2_distance(public.halfvec, public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.l2_distance(public.halfvec, public.halfvec) TO service_role;


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 475
-- Name: FUNCTION l2_distance(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.l2_distance(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.l2_distance(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.l2_distance(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.l2_distance(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 390
-- Name: FUNCTION l2_distance(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.l2_distance(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.l2_distance(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.l2_distance(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.l2_distance(public.vector, public.vector) TO service_role;


--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 439
-- Name: FUNCTION l2_norm(public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.l2_norm(public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.l2_norm(public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.l2_norm(public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.l2_norm(public.halfvec) TO service_role;


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 479
-- Name: FUNCTION l2_norm(public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.l2_norm(public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.l2_norm(public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.l2_norm(public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.l2_norm(public.sparsevec) TO service_role;


--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 440
-- Name: FUNCTION l2_normalize(public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.l2_normalize(public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.l2_normalize(public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.l2_normalize(public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.l2_normalize(public.halfvec) TO service_role;


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 480
-- Name: FUNCTION l2_normalize(public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.l2_normalize(public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.l2_normalize(public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.l2_normalize(public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.l2_normalize(public.sparsevec) TO service_role;


--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 396
-- Name: FUNCTION l2_normalize(public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.l2_normalize(public.vector) TO postgres;
GRANT ALL ON FUNCTION public.l2_normalize(public.vector) TO anon;
GRANT ALL ON FUNCTION public.l2_normalize(public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.l2_normalize(public.vector) TO service_role;


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 517
-- Name: FUNCTION log_pdf_activity(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.log_pdf_activity() TO anon;
GRANT ALL ON FUNCTION public.log_pdf_activity() TO authenticated;
GRANT ALL ON FUNCTION public.log_pdf_activity() TO service_role;


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 518
-- Name: FUNCTION set_created_by(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.set_created_by() TO anon;
GRANT ALL ON FUNCTION public.set_created_by() TO authenticated;
GRANT ALL ON FUNCTION public.set_created_by() TO service_role;


--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 519
-- Name: FUNCTION set_pdf_job_user_id(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.set_pdf_job_user_id() TO anon;
GRANT ALL ON FUNCTION public.set_pdf_job_user_id() TO authenticated;
GRANT ALL ON FUNCTION public.set_pdf_job_user_id() TO service_role;


--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 520
-- Name: FUNCTION soft_delete(p_table_name text, p_id uuid); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.soft_delete(p_table_name text, p_id uuid) TO anon;
GRANT ALL ON FUNCTION public.soft_delete(p_table_name text, p_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.soft_delete(p_table_name text, p_id uuid) TO service_role;


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 487
-- Name: FUNCTION sparsevec_cmp(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_cmp(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_cmp(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_cmp(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_cmp(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 483
-- Name: FUNCTION sparsevec_eq(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_eq(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_eq(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_eq(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_eq(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 485
-- Name: FUNCTION sparsevec_ge(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_ge(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_ge(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_ge(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_ge(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 486
-- Name: FUNCTION sparsevec_gt(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_gt(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_gt(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_gt(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_gt(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 488
-- Name: FUNCTION sparsevec_l2_squared_distance(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_l2_squared_distance(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_l2_squared_distance(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_l2_squared_distance(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_l2_squared_distance(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 482
-- Name: FUNCTION sparsevec_le(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_le(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_le(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_le(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_le(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 481
-- Name: FUNCTION sparsevec_lt(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_lt(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_lt(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_lt(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_lt(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 484
-- Name: FUNCTION sparsevec_ne(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_ne(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_ne(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_ne(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_ne(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 489
-- Name: FUNCTION sparsevec_negative_inner_product(public.sparsevec, public.sparsevec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sparsevec_negative_inner_product(public.sparsevec, public.sparsevec) TO postgres;
GRANT ALL ON FUNCTION public.sparsevec_negative_inner_product(public.sparsevec, public.sparsevec) TO anon;
GRANT ALL ON FUNCTION public.sparsevec_negative_inner_product(public.sparsevec, public.sparsevec) TO authenticated;
GRANT ALL ON FUNCTION public.sparsevec_negative_inner_product(public.sparsevec, public.sparsevec) TO service_role;


--
-- TOC entry 4959 (class 0 OID 0)
-- Dependencies: 442
-- Name: FUNCTION subvector(public.halfvec, integer, integer); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.subvector(public.halfvec, integer, integer) TO postgres;
GRANT ALL ON FUNCTION public.subvector(public.halfvec, integer, integer) TO anon;
GRANT ALL ON FUNCTION public.subvector(public.halfvec, integer, integer) TO authenticated;
GRANT ALL ON FUNCTION public.subvector(public.halfvec, integer, integer) TO service_role;


--
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 398
-- Name: FUNCTION subvector(public.vector, integer, integer); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.subvector(public.vector, integer, integer) TO postgres;
GRANT ALL ON FUNCTION public.subvector(public.vector, integer, integer) TO anon;
GRANT ALL ON FUNCTION public.subvector(public.vector, integer, integer) TO authenticated;
GRANT ALL ON FUNCTION public.subvector(public.vector, integer, integer) TO service_role;


--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 521
-- Name: FUNCTION update_timestamp(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.update_timestamp() TO anon;
GRANT ALL ON FUNCTION public.update_timestamp() TO authenticated;
GRANT ALL ON FUNCTION public.update_timestamp() TO service_role;


--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 522
-- Name: FUNCTION update_updated_at(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.update_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at() TO service_role;


--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 523
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.update_updated_at_column() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO service_role;


--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 413
-- Name: FUNCTION vector_accum(double precision[], public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_accum(double precision[], public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_accum(double precision[], public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_accum(double precision[], public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_accum(double precision[], public.vector) TO service_role;


--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 399
-- Name: FUNCTION vector_add(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_add(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_add(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_add(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_add(public.vector, public.vector) TO service_role;


--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 414
-- Name: FUNCTION vector_avg(double precision[]); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_avg(double precision[]) TO postgres;
GRANT ALL ON FUNCTION public.vector_avg(double precision[]) TO anon;
GRANT ALL ON FUNCTION public.vector_avg(double precision[]) TO authenticated;
GRANT ALL ON FUNCTION public.vector_avg(double precision[]) TO service_role;


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 409
-- Name: FUNCTION vector_cmp(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_cmp(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_cmp(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_cmp(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_cmp(public.vector, public.vector) TO service_role;


--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 415
-- Name: FUNCTION vector_combine(double precision[], double precision[]); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_combine(double precision[], double precision[]) TO postgres;
GRANT ALL ON FUNCTION public.vector_combine(double precision[], double precision[]) TO anon;
GRANT ALL ON FUNCTION public.vector_combine(double precision[], double precision[]) TO authenticated;
GRANT ALL ON FUNCTION public.vector_combine(double precision[], double precision[]) TO service_role;


--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 402
-- Name: FUNCTION vector_concat(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_concat(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_concat(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_concat(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_concat(public.vector, public.vector) TO service_role;


--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 438
-- Name: FUNCTION vector_dims(public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_dims(public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.vector_dims(public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.vector_dims(public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.vector_dims(public.halfvec) TO service_role;


--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 394
-- Name: FUNCTION vector_dims(public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_dims(public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_dims(public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_dims(public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_dims(public.vector) TO service_role;


--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 405
-- Name: FUNCTION vector_eq(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_eq(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_eq(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_eq(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_eq(public.vector, public.vector) TO service_role;


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 407
-- Name: FUNCTION vector_ge(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_ge(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_ge(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_ge(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_ge(public.vector, public.vector) TO service_role;


--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 408
-- Name: FUNCTION vector_gt(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_gt(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_gt(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_gt(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_gt(public.vector, public.vector) TO service_role;


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 410
-- Name: FUNCTION vector_l2_squared_distance(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_l2_squared_distance(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_l2_squared_distance(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_l2_squared_distance(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_l2_squared_distance(public.vector, public.vector) TO service_role;


--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 404
-- Name: FUNCTION vector_le(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_le(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_le(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_le(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_le(public.vector, public.vector) TO service_role;


--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 403
-- Name: FUNCTION vector_lt(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_lt(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_lt(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_lt(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_lt(public.vector, public.vector) TO service_role;


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 401
-- Name: FUNCTION vector_mul(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_mul(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_mul(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_mul(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_mul(public.vector, public.vector) TO service_role;


--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 406
-- Name: FUNCTION vector_ne(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_ne(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_ne(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_ne(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_ne(public.vector, public.vector) TO service_role;


--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 411
-- Name: FUNCTION vector_negative_inner_product(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_negative_inner_product(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_negative_inner_product(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_negative_inner_product(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_negative_inner_product(public.vector, public.vector) TO service_role;


--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 395
-- Name: FUNCTION vector_norm(public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_norm(public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_norm(public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_norm(public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_norm(public.vector) TO service_role;


--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 412
-- Name: FUNCTION vector_spherical_distance(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_spherical_distance(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_spherical_distance(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_spherical_distance(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_spherical_distance(public.vector, public.vector) TO service_role;


--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 400
-- Name: FUNCTION vector_sub(public.vector, public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.vector_sub(public.vector, public.vector) TO postgres;
GRANT ALL ON FUNCTION public.vector_sub(public.vector, public.vector) TO anon;
GRANT ALL ON FUNCTION public.vector_sub(public.vector, public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.vector_sub(public.vector, public.vector) TO service_role;


--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 524
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 525
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 526
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 527
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 528
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 529
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 530
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 531
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 532
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 533
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 534
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 535
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 536
-- Name: FUNCTION can_insert_object(bucketid text, name text, owner uuid, metadata jsonb); Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) TO postgres;


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 537
-- Name: FUNCTION extension(name text); Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON FUNCTION storage.extension(name text) TO postgres;


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 538
-- Name: FUNCTION filename(name text); Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON FUNCTION storage.filename(name text) TO postgres;


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 539
-- Name: FUNCTION foldername(name text); Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON FUNCTION storage.foldername(name text) TO postgres;


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 540
-- Name: FUNCTION get_size_by_bucket(); Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON FUNCTION storage.get_size_by_bucket() TO postgres;


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 541
-- Name: FUNCTION list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text); Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) TO postgres;


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 542
-- Name: FUNCTION list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text); Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) TO postgres;


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 543
-- Name: FUNCTION operation(); Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON FUNCTION storage.operation() TO postgres;


--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 544
-- Name: FUNCTION search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text); Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) TO postgres;


--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 545
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON FUNCTION storage.update_updated_at_column() TO postgres;


--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 371
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: -
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 373
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: -
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 374
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: -
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 1433
-- Name: FUNCTION avg(public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.avg(public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.avg(public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.avg(public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.avg(public.halfvec) TO service_role;


--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 1434
-- Name: FUNCTION avg(public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.avg(public.vector) TO postgres;
GRANT ALL ON FUNCTION public.avg(public.vector) TO anon;
GRANT ALL ON FUNCTION public.avg(public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.avg(public.vector) TO service_role;


--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 1432
-- Name: FUNCTION sum(public.halfvec); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sum(public.halfvec) TO postgres;
GRANT ALL ON FUNCTION public.sum(public.halfvec) TO anon;
GRANT ALL ON FUNCTION public.sum(public.halfvec) TO authenticated;
GRANT ALL ON FUNCTION public.sum(public.halfvec) TO service_role;


--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 1435
-- Name: FUNCTION sum(public.vector); Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON FUNCTION public.sum(public.vector) TO postgres;
GRANT ALL ON FUNCTION public.sum(public.vector) TO anon;
GRANT ALL ON FUNCTION public.sum(public.vector) TO authenticated;
GRANT ALL ON FUNCTION public.sum(public.vector) TO service_role;


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 5030 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- TOC entry 5032 (class 0 OID 0)
-- Dependencies: 247
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 5036 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 252
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: -
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: -
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: -
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 266
-- Name: TABLE activity_logs; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.activity_logs TO anon;
GRANT ALL ON TABLE public.activity_logs TO authenticated;
GRANT ALL ON TABLE public.activity_logs TO service_role;


--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 267
-- Name: TABLE audit_findings; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.audit_findings TO anon;
GRANT ALL ON TABLE public.audit_findings TO authenticated;
GRANT ALL ON TABLE public.audit_findings TO service_role;


--
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE audits; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.audits TO anon;
GRANT ALL ON TABLE public.audits TO authenticated;
GRANT ALL ON TABLE public.audits TO service_role;


--
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE authorities; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.authorities TO anon;
GRANT ALL ON TABLE public.authorities TO authenticated;
GRANT ALL ON TABLE public.authorities TO service_role;


--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE authority_profiles; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.authority_profiles TO anon;
GRANT ALL ON TABLE public.authority_profiles TO authenticated;
GRANT ALL ON TABLE public.authority_profiles TO service_role;


--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE billing_periods; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.billing_periods TO anon;
GRANT ALL ON TABLE public.billing_periods TO authenticated;
GRANT ALL ON TABLE public.billing_periods TO service_role;


--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE billing_records; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.billing_records TO anon;
GRANT ALL ON TABLE public.billing_records TO authenticated;
GRANT ALL ON TABLE public.billing_records TO service_role;


--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE organizations; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.organizations TO anon;
GRANT ALL ON TABLE public.organizations TO authenticated;
GRANT ALL ON TABLE public.organizations TO service_role;


--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE token_usage; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.token_usage TO anon;
GRANT ALL ON TABLE public.token_usage TO authenticated;
GRANT ALL ON TABLE public.token_usage TO service_role;


--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 275
-- Name: TABLE billing_summary; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.billing_summary TO anon;
GRANT ALL ON TABLE public.billing_summary TO authenticated;
GRANT ALL ON TABLE public.billing_summary TO service_role;


--
-- TOC entry 5068 (class 0 OID 0)
-- Dependencies: 276
-- Name: TABLE document_categories; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.document_categories TO anon;
GRANT ALL ON TABLE public.document_categories TO authenticated;
GRANT ALL ON TABLE public.document_categories TO service_role;


--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 277
-- Name: TABLE document_sections; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.document_sections TO anon;
GRANT ALL ON TABLE public.document_sections TO authenticated;
GRANT ALL ON TABLE public.document_sections TO service_role;


--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE documents; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.documents TO anon;
GRANT ALL ON TABLE public.documents TO authenticated;
GRANT ALL ON TABLE public.documents TO service_role;


--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 279
-- Name: TABLE findings; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.findings TO anon;
GRANT ALL ON TABLE public.findings TO authenticated;
GRANT ALL ON TABLE public.findings TO service_role;


--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 280
-- Name: TABLE manuals_view; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.manuals_view TO anon;
GRANT ALL ON TABLE public.manuals_view TO authenticated;
GRANT ALL ON TABLE public.manuals_view TO service_role;


--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE organization_documents_summary; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.organization_documents_summary TO anon;
GRANT ALL ON TABLE public.organization_documents_summary TO authenticated;
GRANT ALL ON TABLE public.organization_documents_summary TO service_role;


--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE organization_type_technical_profiles; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.organization_type_technical_profiles TO anon;
GRANT ALL ON TABLE public.organization_type_technical_profiles TO authenticated;
GRANT ALL ON TABLE public.organization_type_technical_profiles TO service_role;


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 283
-- Name: TABLE pdf_jobs; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.pdf_jobs TO anon;
GRANT ALL ON TABLE public.pdf_jobs TO authenticated;
GRANT ALL ON TABLE public.pdf_jobs TO service_role;


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 284
-- Name: TABLE pdf_results; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.pdf_results TO anon;
GRANT ALL ON TABLE public.pdf_results TO authenticated;
GRANT ALL ON TABLE public.pdf_results TO service_role;


--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 285
-- Name: SEQUENCE pdf_results_id_seq; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON SEQUENCE public.pdf_results_id_seq TO anon;
GRANT ALL ON SEQUENCE public.pdf_results_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.pdf_results_id_seq TO service_role;


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE pdf_sections; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.pdf_sections TO anon;
GRANT ALL ON TABLE public.pdf_sections TO authenticated;
GRANT ALL ON TABLE public.pdf_sections TO service_role;


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 287
-- Name: TABLE pipeline_execution_logs; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.pipeline_execution_logs TO anon;
GRANT ALL ON TABLE public.pipeline_execution_logs TO authenticated;
GRANT ALL ON TABLE public.pipeline_execution_logs TO service_role;


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE regulation_categories; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.regulation_categories TO anon;
GRANT ALL ON TABLE public.regulation_categories TO authenticated;
GRANT ALL ON TABLE public.regulation_categories TO service_role;


--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE regulation_sections; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.regulation_sections TO anon;
GRANT ALL ON TABLE public.regulation_sections TO authenticated;
GRANT ALL ON TABLE public.regulation_sections TO service_role;


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 290
-- Name: TABLE regulations; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.regulations TO anon;
GRANT ALL ON TABLE public.regulations TO authenticated;
GRANT ALL ON TABLE public.regulations TO service_role;


--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 291
-- Name: TABLE regulations_view; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.regulations_view TO anon;
GRANT ALL ON TABLE public.regulations_view TO authenticated;
GRANT ALL ON TABLE public.regulations_view TO service_role;


--
-- TOC entry 5156 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE roles; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.roles TO anon;
GRANT ALL ON TABLE public.roles TO authenticated;
GRANT ALL ON TABLE public.roles TO service_role;


--
-- TOC entry 5157 (class 0 OID 0)
-- Dependencies: 293
-- Name: TABLE schema_change_log; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.schema_change_log TO anon;
GRANT ALL ON TABLE public.schema_change_log TO authenticated;
GRANT ALL ON TABLE public.schema_change_log TO service_role;


--
-- TOC entry 5158 (class 0 OID 0)
-- Dependencies: 294
-- Name: TABLE user_profiles; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.user_profiles TO anon;
GRANT ALL ON TABLE public.user_profiles TO authenticated;
GRANT ALL ON TABLE public.user_profiles TO service_role;


--
-- TOC entry 5159 (class 0 OID 0)
-- Dependencies: 295
-- Name: TABLE users; Type: ACL; Schema: public; Owner: -
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- TOC entry 5160 (class 0 OID 0)
-- Dependencies: 296
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- TOC entry 5161 (class 0 OID 0)
-- Dependencies: 297
-- Name: TABLE messages_2025_06_28; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_06_28 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_06_28 TO dashboard_user;


--
-- TOC entry 5162 (class 0 OID 0)
-- Dependencies: 298
-- Name: TABLE messages_2025_06_29; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_06_29 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_06_29 TO dashboard_user;


--
-- TOC entry 5163 (class 0 OID 0)
-- Dependencies: 299
-- Name: TABLE messages_2025_06_30; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_06_30 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_06_30 TO dashboard_user;


--
-- TOC entry 5164 (class 0 OID 0)
-- Dependencies: 300
-- Name: TABLE messages_2025_07_01; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_07_01 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_01 TO dashboard_user;


--
-- TOC entry 5165 (class 0 OID 0)
-- Dependencies: 301
-- Name: TABLE messages_2025_07_02; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_07_02 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_02 TO dashboard_user;


--
-- TOC entry 5166 (class 0 OID 0)
-- Dependencies: 302
-- Name: TABLE messages_2025_07_03; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_07_03 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_03 TO dashboard_user;


--
-- TOC entry 5167 (class 0 OID 0)
-- Dependencies: 303
-- Name: TABLE messages_2025_07_04; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.messages_2025_07_04 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_04 TO dashboard_user;


--
-- TOC entry 5168 (class 0 OID 0)
-- Dependencies: 304
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 5169 (class 0 OID 0)
-- Dependencies: 305
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 306
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: -
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 5172 (class 0 OID 0)
-- Dependencies: 307
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 309
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- TOC entry 5175 (class 0 OID 0)
-- Dependencies: 310
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;
GRANT ALL ON TABLE storage.s3_multipart_uploads TO postgres;


--
-- TOC entry 5176 (class 0 OID 0)
-- Dependencies: 311
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: -
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;
GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO postgres;


--
-- TOC entry 5177 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: -
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- TOC entry 5178 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: -
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- TOC entry 2740 (class 826 OID 18826)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2741 (class 826 OID 18827)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2739 (class 826 OID 18828)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2726 (class 826 OID 18829)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2725 (class 826 OID 18830)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 2724 (class 826 OID 18831)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2731 (class 826 OID 18832)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2729 (class 826 OID 18833)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2728 (class 826 OID 18834)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2721 (class 826 OID 18835)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2723 (class 826 OID 18836)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2722 (class 826 OID 18837)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2727 (class 826 OID 18838)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2730 (class 826 OID 18839)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2732 (class 826 OID 18840)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2733 (class 826 OID 18841)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2734 (class 826 OID 18842)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2735 (class 826 OID 18843)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2719 (class 826 OID 18844)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2720 (class 826 OID 18845)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2742 (class 826 OID 18846)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2736 (class 826 OID 18847)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2737 (class 826 OID 18848)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2738 (class 826 OID 18849)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: -
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 3930 (class 3466 OID 18863)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


--
-- TOC entry 3935 (class 3466 OID 18901)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


--
-- TOC entry 3929 (class 3466 OID 18862)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


--
-- TOC entry 3936 (class 3466 OID 18902)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


--
-- TOC entry 3931 (class 3466 OID 18864)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


--
-- TOC entry 3932 (class 3466 OID 18865)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


-- Completed on 2025-07-25 11:38:05

--
-- PostgreSQL database dump complete
--

