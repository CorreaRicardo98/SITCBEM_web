$(document).ready(function(){
    getRoles();
});

function getRoles() {
    $.ajax({
        url:'controller/loginController.php',
        method:'POST',
        data:{
            key:1
        },
        success:function(response){
            var parsejson = $.parseJSON(response);
            $.each(parsejson,function(index){
                const opcion = '<option value="'+ parsejson[index].id +'">'+ parsejson[index].nombre +'</option>';
                $("#opc").append(opcion);
            });
        }
    });
}