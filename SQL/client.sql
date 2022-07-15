create table if not exists client
(
    id        SERIAL PRIMARY KEY not null,
    name       text    not null,
    partner_id integer not null,
        CONSTRAINT fk_partner_id FOREIGN KEY(partner_id) REFERENCES partner(id)

);

drop view if exists view_client;
create or replace view view_client as
select *
from client;

drop function if exists
    func_get_client(p_partner_id int);
create or replace function func_get_client(p_partner_id int)
 returns setof view_client
as
$BODY$
begin
  RETURN QUERY
    SELECT *
    FROM view_client
  WHERE partner_id = p_partner_id
  ORDER BY id;
end;
$BODY$
language plpgsql;

drop function if exists
    func_search_client(p_partner_id int, p_name text);
create or replace function func_search_client(p_partner_id int, p_name text)
 returns setof view_client
as
$BODY$
begin
  RETURN QUERY
    SELECT *
    FROM view_client
  WHERE name = p_name
        AND partner_id = p_partner_id
  ORDER BY id;
end;
$BODY$
language plpgsql;

drop function if exists
    func_add_client(p_name Text, p_partner_id int);
create or replace function func_add_client(p_name Text, p_partner_id int)
 returns VOID
as
$BODY$
begin
  INSERT INTO Client(name,partner_id)
    Values(p_name,p_partner_id);
end;
$BODY$
language plpgsql;

drop function if exists
    func_edit_client(p_id int,p_name Text, p_partner_id int);
create or replace function func_edit_client(p_id int,p_name Text, p_partner_id int)
 returns VOID
as
$BODY$
begin

  Update client
  set name = p_name, partner_id= p_partner_id
    where id= p_id
     AND partner_id = p_partner_id;

end;
$BODY$
language plpgsql;

drop function if exists
    func_delete_client(p_id int,p_partner_id int);
create or replace function func_delete_client(p_id int, p_partner_id int)
 returns VOID
as
$BODY$
begin

 DELETE FROM Client
    WHERE id=p_id
    AND partner_id = p_partner_id;

end;
$BODY$
language plpgsql;

drop function if exists
   func_get_client_by_username(p_name text);
create or replace function func_get_client_by_username(p_name text)
 returns setof view_client
as
$BODY$
begin
  RETURN QUERY
    SELECT *
    FROM view_client
  WHERE name= p_name;
end;
$BODY$
language plpgsql;