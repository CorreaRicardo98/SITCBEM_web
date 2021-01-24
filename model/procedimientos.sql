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
drop procedure if exists agregarUsuario; 
create procedure agregarUsuario( 
    in _nombre_usuario varchar(45), 
    in _ap_mat_usuario varchar(45), 
    in _ap_pat_usuario varchar(45), 
    in _Roles_idRoles int(11),
    in _email_usuario varchar(45),
    in _pass_usuario varchar(45)   

) 
begin 

INSERT INTO usuario VALUES (null, _nombre_usuario, _ap_mat_usuario, _ap_pat_usuario, _Roles_idRoles, _email_usuario, _pass_usuario); 

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
drop procedure if exists logOut;
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

delimiter $$
drop procedure if exists getUsuarios;
create procedure getUsuarios(

)
begin
    SELECT id_usuarios, nombre_usuario, ap_pat_usuario, ap_mat_usuario, nombre_rol, email_usuario, pass_usuario FROM usuario LEFT JOIN roles on usuario.Roles_idRoles=roles.idRoles;
end $$
delimiter ;


delimiter $$
drop procedure if exists getUsuariosData;
create procedure getUsuariosData(
	in _id int
)
begin
    SELECT id_usuarios, nombre_usuario, ap_pat_usuario, ap_mat_usuario, nombre_rol, email_usuario, pass_usuario FROM usuario LEFT JOIN roles on usuario.Roles_idRoles=roles.idRoles WHERE id_usuarios = _id;
end $$
delimiter ;


delimiter $$ 
drop procedure if exists editarUsuario; 
create procedure editarUsuario(
	in _id_usuarios int,
    in _nombre_usuario varchar(45), 
    in _ap_mat_usuario varchar(45), 
    in _ap_pat_usuario varchar(45), 
    in _Roles_idRoles int(11),
    in _email_usuario varchar(45),
    in _pass_usuario varchar(45)   

) 
begin 

	UPDATE usuario SET Roles_idroles = _Roles_idRoles, nombre_usuario = _nombre_usuario, ap_mat_usuario = _ap_mat_usuario, ap_pat_usuario = _ap_pat_usuario, email_usuario = _email_usuario, pass_usuario = _pass_usuario WHERE usuario.id_usuarios =_id_usuarios;

end $$ 
delimiter ; 




delimiter $$
drop procedure if exists updateAgremiado;
create procedure updateAgremiado(
    in _id_afiliado int,
    in _nombre varchar(45),
    in _ap_paterno varchar(45),
    in _ap_materno varchar(45),
    in _rfc varchar(45),
    in _curp varchar(45),
    in _email varchar(45),
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
    in _no_ext int,
    in _id_direccion int
)
begin
    update direccion set no_ext = _no_ext,
                         no_int = _no_int,
                         calle = _calle,
                         cod_postal = _cod_postal,
                         colonia = _colonia,
                         estado = _estado,
                         municipio = _municipio,
                         tipo_asenta = _tipo_asenta
    where id_direccion = _id_direccion;

    update afiliado set nombre = _nombre,
                        ap_materno = _ap_materno,
                        ap_paterno = _ap_paterno,
                        rfc = _rfc,
                        curp = _curp,
                        email = _email,
                        telefono = _telefono,
                        fecha_ingreso = _fecha_ingreso,
                        fecha_nacimiento = _fecha_nacimiento,
                        centro_trabajo_id_centro_trabajo = _id_centro_trabajo,
                        status_id_status = _id_status,
                        estado_civil_id_estado_civil = _id_civil,
                        plaza_id_plaza = _id_plaza
    where id_afiliado = _id_afiliado;

    select 200 as status, 'ok' as response;

end $$ 
delimiter ;

delimiter $$
drop procedure if exists eliminarAgremiado;
create procedure eliminarAgremiado(
    in _id int
)
begin
    delete from afiliado where id_afiliado = _id;
    select 200 as code, 'ok' as response;
end $$
delimiter ;

delimiter $$
drop procedure if exists eliminarUsuario;
create procedure eliminarUsuario(
    in _id int
)
begin
    DELETE FROM usuario WHERE id_usuarios = _id;
end $$
delimiter ;

delimiter $$
drop procedure if exists getBitacora;
create procedure getBitacora(
    
)
begin
	SELECT nombre_ct, email, rol, feha_log, hora_log, salida_log FROM log_acceso ORDER BY id_registro DESC;
end $$
delimiter ;