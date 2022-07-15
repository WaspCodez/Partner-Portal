create table if not exists vendor
(
    id          serial Primary key  not null,
    vendor_name text    not null,
    category    text    not null,
    description text    not null,
    email       text    not null,
    client_id   integer not null
        constraint vendor_client_id_fk
            references client,
CONSTRAINT fk_customer FOREIGN KEY(client_id) REFERENCES partner(id)
);

drop view if exists view_vendor;
create or replace view view_vendor as
select v.id, v.vendor_name ,v.category, v.description, v.email, v.client_id, c.partner_id
from vendor v
join client c on v.client_id = c.id;

drop function if exists
    func_get_vendor(p_client_id int, p_partner_id int);
create or replace function func_get_vendor(p_client_id int, p_partner_id int)
 returns setof view_vendor
as
$BODY$
begin
  RETURN QUERY
    SELECT *
    FROM view_vendor
    WHERE partner_id = p_partner_id
    AND client_id = p_client_id;
end;
$BODY$
language plpgsql;
