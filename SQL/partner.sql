create table if not exists partner
(
    id           serial not null
        constraint partner_pk
            primary key,
    partner_name text not null
);

drop view if exists view_partner;
create or replace view view_partner as
select *
from partner;

drop function if exists
    func_get_partner();
create or replace function func_get_partner()
 returns setof view_partner
as
$BODY$
begin
  RETURN QUERY
    SELECT *
    FROM view_partner;
end;
$BODY$
language plpgsql
