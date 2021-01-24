$(document).ready(function(){
    getBitacora();

    $('#buscar').keyup(function(){
        var resultado = new RegExp($(this).val(),'i');
        $('.tablaBitacora tr').hide();
        $('.tablaBitacora tr').filter(function(){
            return resultado.test($(this).text());
        }).show();
    });
});

function getBitacora()
{
    $.ajax({
        url:'../../controller/bitacoraController.php',
        method:'POST',
        data:{
            key:1,
        },
        success:function(response){
            var parsejson = $.parseJSON(response);
            $.each(parsejson,function(index){
                const campos='<tr scope="col">'+
                             '<td>'+parsejson[index].nombre+'</td>'+
                             '<td>'+parsejson[index].email+'</td>'+
                             '<td>'+parsejson[index].rol+'</td>'+
                             '<td>'+parsejson[index].fecha_loggin+'</td>'+
                             '<td>'+parsejson[index].hora_loggin+'</td>'+
                             '<td>'+parsejson[index].salida_loggin+'</td>'+
                             '</tr scope="col">';
                $("#campos_bitacora").append(campos);
            });
        }
    });
}