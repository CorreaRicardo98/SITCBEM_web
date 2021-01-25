$(document).ready(function(){
    getAllAgremiados();
});


function getAllAgremiados() {
    $.ajax({
        url:'../../controller/agremiadosController.php',
        method:'POST',
        data:{
            key:4,
        },
        dataType:'JSON',
        success:function(parsejson){
            $.each(parsejson,function(index){
                let carta = '<div class="col col-sm-12 col-md-4 col-lg-4 mt-3">';
                carta+= '<div class="card" style="border:0.1px solid #000000; box-shadow: 5px 10px 10px rgba(0, 0,0,0.3);">';
                carta+= '<img src="'+parsejson[index].foto+'" class="rounded mx-auto d-block" alt="..." style="height:150px; object-fit: cover; border:0.1px solid #000000; margin-top:25px;">';
                carta+= '<div class="card-body">';
                carta+= '<p>'+parsejson[index].nombre+'</p><br>';
                carta+= '<div class="row">';
                carta+= '<div class="col">';
                carta+= '<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="getDataAgremiado('+parsejson[index].id+')"><i class="fas fa-eye"></i>       Ver</button>';
                carta+= '</div>';
                carta+= '</div>';
                carta+= '</div>';
                carta+= '</div>';
                carta+= '</div>';
            
                $("#cartitas").append(carta);
            });
        }
    });
}

function getDataAgremiado(id) {
    $.ajax({
        url:'../../controller/agremiadosController.php',
        method:'POST',
        dataType:'JSON',
        data:{
            key:5,
            id:id
        },
        success:function(data){
            var list = '<li class="list-group-item"><strong>Nombre:</strong> '+data.nombre+' '+data.ap_paterno+' '+data.ap_materno+'</li>';
            list+='<li class="list-group-item"><strong>RFC:</strong> '+data.rfc+'</li>';
            list+='<li class="list-group-item"><strong>CURP:</strong> '+data.curp+'</li>';
            list+='<li class="list-group-item"><strong>Correo:</strong> '+data.email+'</li>';
            list+='<li class="list-group-item"><strong>Telefono:</strong> '+data.telefono+'</li>';
            list+='<li class="list-group-item"><strong>Fecha de Ingreso:</strong> '+data.fecha_ingreso+'</li>';
            list+='<li class="list-group-item"><strong>Fecha de Nacimiento:</strong> '+data.fecha_nacimiento+'</li>';
            list+='<li class="list-group-item"><strong>Estado Civil:</strong> '+data.estado_civil+'</li>';
            list+='<li class="list-group-item"><strong>Tipo de Plaza:</strong> '+data.tipo_plaza+'</li>';
            list+='<li class="list-group-item"><strong>Código Postal:</strong> '+data.cod_postal+'</li>';
            list+='<li class="list-group-item"><strong>Colonia:</strong> '+data.colonia+'</li>';
            list+='<li class="list-group-item"><strong>Municipio:</strong> '+data.municipio+'</li>';
            list+='<li class="list-group-item"><strong>Estado:</strong> '+data.estado+'</li>';
            list+='<li class="list-group-item"><strong>Tipo de Asentamiento:</strong> '+data.tipo_asenta+'</li>';
            list+='<li class="list-group-item"><strong>Calle:</strong> '+data.calle+'</li>';
            list+='<li class="list-group-item"><strong>Numero Exterior:</strong> '+data.no_ext+'</li>';
            if (data.no_int == 0) {
                list+='<li class="list-group-item"><strong>Númenro Interior:</strong> S/N</li>';
            }else{
                list+='<li class="list-group-item"><strong>Númenro Interior:</strong> '+data.no_int+'</li>';
            }
            

            $("#verData").html(list);
        }
    });
}

