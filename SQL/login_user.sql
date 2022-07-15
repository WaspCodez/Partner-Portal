create table if not exists login_user
(
    id            serial    not null,
    username      text      not null,
    display_name  text      not null,
    email         text      not null,
    password      text      not null,
    time_of_login timestamp not null,
    partner_id    integer   not null
        constraint login_user_partner_id_fk
            references partner,
    constraint login_user_pk
        primary key (id, partner_id)
);

comment on table login_user is 'User Login Details';

alter table login_user
    owner to postgres;
drop view if exists view_login_user;
create or replace view view_login_user as
select *
from login_user;

drop function if exists
    func_get_login_user(p_partner_id int);

create or replace function
    func_get_login_user(p_partner_id int)
    returns setof view_login_user
as
$BODY$
begin
    RETURN QUERY
        SELECT *
        FROM view_login_user
         WHERE partner_id = p_partner_id
    ORDER BY id;
end;
$BODY$
    language plpgsql;

drop function if exists
    func_add_login_user(p_username Text,p_display_name Text, p_email Text, p_password Text, p_time_of_login timestamp,  p_partnerid int);

create or replace function
    func_add_login_user(p_username Text, p_display_name Text, p_email Text, p_password Text, p_time_of_login timestamp, p_partnerid int)
    returns VOID
as
$BODY$
begin
 INSERT INTO login_user(username, display_name, email, password, time_of_login, partner_id)
 VALUES(p_username,p_display_name,p_email,p_password,p_time_of_login,p_partnerid);
end;
$BODY$
    language plpgsql;

drop function if exists
    func_edit_login_user(p_id int,p_username Text,p_display_name Text, p_email Text, p_password Text, p_time_of_login timestamp,  p_partnerid int);

create or replace function
    func_edit_login_user(p_id int,p_username Text, p_display_name Text, p_email Text, p_password Text, p_time_of_login timestamp, p_partnerid int)
    returns VOID
as
$BODY$
begin
    update login_user
        set username = p_username, display_name = p_display_name, email=p_email, password=p_password, time_of_login = p_time_of_login
    where id = p_id
    AND partner_id= p_partnerid;

end;
$BODY$
    language plpgsql;


drop function if exists
    func_delete_login_user(p_id int, p_partner_id int);

create or replace function
    func_delete_login_user(p_id int,  p_partner_id int)
    returns VOID
as
$BODY$
begin
  DELETE FROM login_user
    WHERE id = p_id
    AND partner_id= p_partner_id;

end;
$BODY$
    language plpgsql;


drop function if exists
    func_get_login_user_by_username(p_username Text,p_password Text);

create or replace function
    func_get_login_user_by_username(p_username Text,p_password Text)
    returns setof view_login_user
as
$BODY$
begin
RETURN QUERY
  SELECT *
  FROM view_login_user
    WHERE username = p_username
    AND password = p_password;

end;
$BODY$
    language plpgsql;

Select * from func_get_login_user_by_username('Test1','Phinity@122#');

drop function if exists
    func_search_login_user(p_partner_id int, p_username text);

create or replace function
    func_search_login_user(p_partner_id int, p_username text)
    returns setof view_login_user
as
$BODY$
begin
    RETURN QUERY
        SELECT *
        FROM view_login_user
         WHERE username = p_username
               AND partner_id = p_partner_id
    ORDER BY id;
end;
$BODY$
    language plpgsql;