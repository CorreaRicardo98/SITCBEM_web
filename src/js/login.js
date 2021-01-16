$(document).ready(function(){
    getRoles();
    AlreadyIn();
});

function getRoles() { // con esta funcion obtenemos todos los roles para llenar el select de roles
    // Esta forma de trabajo se llama Ajax nos permite llamar funciones PHP de manera asincrona
    // parece dificil al pincipio pero cuando le encuentras se hace en automatico
    // Los datos mas basico que tiene una funcion ajax son:
    $.ajax({
        url:'controller/loginController.php', // URL esta es la ruta para llegar a nuestro controlador, cabe mencionar que la ruta se pone como si estuvieramos en el archivo html no en el javascript
        method:'POST',// En metodo usualmente usamos POST por seguridad
        data:{ // Aqui especificamos los datos que se le van a mandar al archivo php
            key:1 // key es una variable inventada para que el archivo sepa que funcion ejecutar
        },
        success:function(response){ // la parte de success se activa cuando php ya nos contesto y nos regresa datos lo cual es el respone
            var parsejson = $.parseJSON(response); // los datos que nos manda llegan en formato de text pero tenemos que pasarlo a un json
            $.each(parsejson,function(index){ // con esto recorremos todo el json y obtenemos cada uno de los registros
                const opcion = '<option value="'+ parsejson[index].id +'">'+ parsejson[index].nombre +'</option>'; // hacemos la estructura de un option con los datos que nos regresa
                $("#opc").append(opcion); // la funcion append lo que hace es agregar elementos html en este caso le estamos agregando option a un select
            });
        }
    });
}

function login() {
    const email = $("#exampleInputEmail1").val(); // esta es la forma de sacar el valor de un input usando su id
    const pass = $("#exampleInputPassword1").val();
    const opt = $("#opc").val(); // igual para un select
    var today = new Date();                                   // estas funciones son para sacar hora y fecha
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0');
    var yyyy = today.getFullYear();

    today = mm + '/' + dd + '/' + yyyy;

    let currentDate = new Date();
    let time = currentDate.getHours() + ":" + currentDate.getMinutes() + ":" + currentDate.getSeconds();

    $.ajax({
        url:'controller/loginController.php',
        method:'POST',
        data:{
            key:2,
            user:email, // aqui estamos mandando mas datos mediante data{}
            pass:pass, // los datos se mandan asi nombre:valor a php llegarian asi $_POST['pass'] -> pass;
            rol:opt, // no es necesario que el nombre sea el mismo en los dos pero usualmente se usa para no confundirse pero esto queda asi $_POST['rol'] -> opt
            fecha:today,
            hora:time
        },
        beforeSend:function(){ // esta funcion se dispara mientras se hace la comunicacion qui pordemos reproducir alguna animacion

        },
        success:function(response){
            //para trabajar con cookies en el html se tiene que agregar un script src el archivo de login lo tiene agregado
            var parsejson = $.parseJSON(response);
            Cookies.set('id_rol',parsejson.id); // esta es la forma sencilla de agregar una cookie
            Cookies.set('nombre_usuario_admin',parsejson.nombre);
            Cookies.set('id_usuario',parsejson.id_usu)
            switch (parsejson.id) { // aqui revisamos que privilegio tiene el usuario
                case "1":
                    $(window).attr( // esta funcion manda a uns direccion que le indiques en este caso tiene panel.htm en la carpeta administrador
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
                    // como todo cuando ninguna acerte llegamos a un caso en el que el usuari no existe 
                    var alert = '<div class="alert alert-warning alert-dismissible fade show" role="alert"><strong>Alerta! </strong>'+parsejson.response+'<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
                    $("#toast").append(alert);
                    console.log("no encontrado");
            
                default:
                    break;
            }
        }
    });
}

function AlreadyIn() { // esta funcion revisa si la persona que esta iniciando ya estuvo dentro y no cerro sesion
    if (Cookies.get('id_rol') != undefined) { // si la cookie n existe nos lanzaria un undefined
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