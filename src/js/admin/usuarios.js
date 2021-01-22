$(document).ready(function(){
    getAllUsuarios();
    getAllRoles();
});

function borrarUsuario(ID){

    $.ajax({
        url:'../../controller/usuariosController.php',
        method:'POST',
        dataType:'JSON',
        data:{
            key:4,
            id:ID
        },
        success:function(response){
            

        }
    });
    
}
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
                             '<td><button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#modalEditar"><i class="fas fa-user-edit"></i>      Editar</button></td>'+
                             '<td><button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modalEliminar"><i class="fas fa-user-times"></i>     Eliminar</button></td>'+
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
            });
        }
    });

}

