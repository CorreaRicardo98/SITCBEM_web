$(document).ready(function(){
    getRoles();
    AlreadyIn();
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

function login() {
    const email = $("#exampleInputEmail1").val();
    const pass = $("#exampleInputPassword1").val();
    const opt = $("#opc").val();
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();

    today = mm + '/' + dd + '/' + yyyy;

    let currentDate = new Date();
    let time = currentDate.getHours() + ":" + currentDate.getMinutes() + ":" + currentDate.getSeconds();

    $.ajax({
        url:'controller/loginController.php',
        method:'POST',
        data:{
            key:2,
            user:email,
            pass:pass,
            rol:opt,
            fecha:today,
            hora:time
        },
        beforeSend:function(){

        },
        success:function(response){
            var parsejson = $.parseJSON(response);
            Cookies.set('id_rol',parsejson.id);
            Cookies.set('nombre_usuario_admin',parsejson.nombre);
            Cookies.set('id_usuario',parsejson.id_usu)
            switch (parsejson.id) {
                case "1":
                    $(window).attr(
                        "location",
                        "views/administrador/panel.html"
                        );
                    break;
                case "2":
                    $(window).attr(
                        "location",
                        "views/operador/panel.html"
                        );
                    break;
                case "3":
                    $(window).attr(
                        "location",
                        "views/secretario/panel.html"
                        );
                    break;
                case "0":
                    var alert = '<div class="alert alert-warning alert-dismissible fade show" role="alert"><strong>Alerta! </strong>'+parsejson.response+'<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
                    $("#toast").append(alert);
                    console.log("no encontrado");
            
                default:
                    break;
            }
        }
    });
}

function AlreadyIn() {
    if (Cookies.get('id_rol') != undefined) {
        switch (Cookies.get('id_rol')) {
            case "1":
                $(window).attr(
                    "location",
                    "views/administrador/panel.html"
                    );
                break;
            case "2":
                $(window).attr(
                    "location",
                    "views/operador/panel.html"
                    );
                break;
            case "3":
                $(window).attr(
                    "location",
                    "views/secretario/panel.html"
                    );
                break;
            case "0":
                var alert = '<div class="alert alert-warning alert-dismissible fade show" role="alert"><strong>Alerta! </strong>'+parsejson.response+'<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
                $("#toast").append(alert);
                console.log("no encontrado");
        
            default:
                break;
        }
        
    }
    
}