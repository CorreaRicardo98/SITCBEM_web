$(document).ready(function(){
    getAllUsuarios();
    getAllRoles();

    $('#buscar').keyup(function(){
        var resultado = new RegExp($(this).val(),'i');
        $('.tablaUsers tr').hide();
        $('.tablaUsers tr').filter(function(){
            return resultado.test($(this).text());
        }).show();
    });
});


function getAllUsuarios() {
    $.ajax({
        url:'../../controller/usuariosController.php',
        method:'POST',
        data:{
            key:1,
        },
        success:function(response){
            var parsejson = $.parseJSON(response);
            $.each(parsejson,function(index){
                const campos='<tr scope="col">'+
                             '<td>'+parsejson[index].nombre+'</td>'+
                             '<td>'+parsejson[index].apellido_paterno+'</td>'+
                             '<td>'+parsejson[index].apellido_materno+'</td>'+
                             '<td>'+parsejson[index].rol+'</td>'+
                             '<td>'+parsejson[index].correo+'</td>'+
                             '<td>'+parsejson[index].pass+'</td>'+
                             '<td><button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#modaleditar" onclick="preEditarUsuario('+parsejson[index].ID+')"><i class="fas fa-user-edit"></i>      Editar</button></td>'+
                             '<td><button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modaleliminar" onclick="preEliminarUsuario('+parsejson[index].ID+')"><i class="fas fa-user-times"></i>     Eliminar</button></td>'+
                             '</tr scope="col">';
                $("#campos").append(campos);
            });
        }
    });
}

function getAllRoles() {
    $.ajax({
        url:'../../controller/usuariosController.php',
        method:'POST',
        data:{
            key:2,
        },
        success:function(response){
            var parsejson = $.parseJSON(response);
            $.each(parsejson,function(index){
                const opt = '<option value="'+ parsejson[index].id +'">'+ parsejson[index].nombre +'</option>';
                $("#roles").append(opt);
                $("#roles_editar").append(opt);
            });
        }
    });

}

function preEditarUsuario(id) {
    $.ajax({
        url:'../../controller/usuariosController.php',
        method:'POST',
        dataType:'JSON',
        data:{
            key:5,
            id:id
        },
        success:function(data){
            $("#id_usuario_editar").val(data.id_usuarios);
            $("#nombre_editar").val(data.nombre_usuario);
            $("#apaterno_editar").val(data.ap_pat_usuario);
            $("#amaterno_editar").val(data.ap_mat_usuario);
            $("#email_editar").val(data.email_usuario);
            $("#pass_editar").val(data.pass_usuario);

        }
    });
}

function preEliminarUsuario(id) {
    $("#id_eliminarUsuario").val(id);
}

function eliminarUsuario() {
    let id = $("#id_eliminarUsuario").val();
    $.ajax({
        url:'../../controller/usuariosController.php',
        method:'POST',
        data:{
            key:7,
            id:id
        },
        success:function(data) {
            getAllUsuarios();
            $("#campos").load(" #campos");
        }
    });
}


