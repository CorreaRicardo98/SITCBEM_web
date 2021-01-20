delimiter $$ 
drop procedure if exists agregarAfiliado; 
create procedure agregarAfiliado( 
    in _nombre varchar(45), 
    in _ap_paterno varchar(45), 
    in _ap_materno varchar(45), 
    in _rfc varchar(45), 
    in _curp varchar(45), 
    in _email varchar(45), 
    in _foto text, 
    in _telefono varchar(12), 
    in _fecha_ingreso varchar(45), 
    in _fecha_nacimiento varchar(45), 
    in _id_centro_trabajo int, 
    in _id_status int, 
    in _id_civil int, 
    in _id_plaza int, 
 
    in _cod_postal int, 
    in _colonia varchar(45), 
    in _municipio varchar(45), 
    in _estado varchar(45), 
    in _tipo_asenta varchar(45), 
    in _calle varchar(45), 
    in _no_int int, 
    in _no_ext int 
) 
begin 
declare _id_direccion int; 
INSERT INTO direccion VALUES (null, _cod_postal, _colonia, _municipio, 
                            _estado,_tipo_asenta,_calle,_no_int,_no_ext); 
SELECT MAX(id_direccion) into _id_direccion from direccion; 
 
 
 
INSERT INTO afiliado VALUES (null,_nombre,_ap_paterno,_ap_materno,_rfc,_curp,_email,_foto,_telefono, 
                             _fecha_ingreso,_fecha_nacimiento,_id_direccion,_id_centro_trabajo, 
                             _id_status,_id_civil,_id_plaza); 
SELECT 200 as code, 'Usuario insertado' as response; 
end $$ 
delimiter ; 

 

 


delimiter $$
drop procedure if exists login;
create procedure login(

    in _email varchar(45),
    in _passw varchar(45),
    in _fecha varchar(45),
    in _hora varchar(45),
    in _idRol int

)
begin
    declare id int;
    declare nom varchar(45);
    declare _rol varchar(45);
    declare _email_log varchar(45);

    SELECT id_usuarios into id from Usuario where email_usuario = _email and pass_usuario = _passw and Roles_idRoles = _idRol;

    if id != '' then

        SELECT email into _email_log from log_acceso where id_usuarios = id and status = 1;

        if _email_log != '' then
            SELECT 200 as code, 'Esta usuario ya fue registrado' as response,_idRol as id limit 1;
        else
            SELECT concat(nombre_usuario,' ',ap_pat_usuario,' ',ap_mat_usuario) into nom from Usuario WHERE id_usuarios = id;
            SELECT nombre_rol into _rol from Roles R JOIN Usuario U on R.idRoles = U.Roles_idRoles where U.id_usuarios = id;
            INSERT INTO log_acceso values (null,_email,nom,_rol,_fecha,_hora,null,1,id);
            select 200 as code,'Usuario ingresado' as response,_idRol as id, nom as nombre,id as id_usu;
        end if;
    else
        SELECT 404 as code, 'Usuario no encontrado' as response,0 as id;
    end if;
end $$
delimiter ; 



delimiter $$
drop procedure if exists verAllAfiliados;
create procedure verAllAfiliados(

)
begin
    SELECT id_afiliado,foto,CONCAT(nombre,' ',ap_paterno,' ',ap_materno) as nombreC FROM afiliado;
end $$
delimiter ;



delimiter $$
drop procedure if exists getAfiliadoData;
create procedure getAfiliadoData(
in _id int
)
begin
    select * from afiliado A join direccion d on d.id_direccion = A.direccion_id_direccion join plaza p on p.id_plaza = A.plaza_id_plaza join centro_trabajo ct on ct.id_centro_trabajo = A.centro_trabajo_id_centro_trabajo join estado_civil ec on ec.id_estado_civil = A.estado_civil_id_estado_civil join status s on s.id_status = A.status_id_status where id_afiliado = _id;
end $$
delimiter ;


delimiter $$
drop procedure if exists getRoles;
create procedure getRoles()
begin
    select * from Roles;
end $$
delimiter ;


delimiter $$
drop procedure if exists logOut
create procedure logOut(
in _hora varchar(45),
in _id_usuario int
)
begin
    declare _id_log int;
    select id_registro into _id_log from log_acceso where id_usuarios = _id_usuario and status = 1 limit 1;
    update log_acceso set status = 0, salida_log = _hora where id_registro = _id_log;
    select 200 as code, 'success' as response;
end $$
delimiter ;


delimiter $$
drop procedure if exists getJobs;
create procedure getJobs(

)
begin
    select * from centro_trabajo;
end $$
delimiter ;


delimiter $$
drop procedure if exists getCivil;
create procedure getCivil(

)
begin
    select * from estado_civil;
end $$
delimiter ;

delimiter $$
drop procedure if exists getPlaza;
create procedure getPlaza(

)
begin
    select * from plaza;
end $$
delimiter ;