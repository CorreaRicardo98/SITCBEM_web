$(document).ready(function(){
    getNombre();
    isIn();
});

function getNombre() {
    const nombre = Cookies.get('nombre_usuario_admin');
    console.log(nombre);
    $("#nombre_usuario").text(nombre);
}

function isIn() {
    if (Cookies.get('id_usuario') != undefined) {
        
    }else{
        $(window).attr(
            "location",
            "../../index.html"
            );
    }
}

function logOut() {
    let currentDate = new Date();
    let time = currentDate.getHours() + ":" + currentDate.getMinutes() + ":" + currentDate.getSeconds();
    const id = Cookies.get('id_usuario');

    $.ajax({
        url:'../../controller/loginController.php',
        method:'POST',
        data:{
            time:time,
            id:id,
            key:3
        },
        success:function(response){
            console.log(response);
            Cookies.remove('id_rol');
            Cookies.remove('nombre_usuario_admin');
            Cookies.remove('id_usuario');
            Cookies.remove('id_usuario');
            $(window).attr(
                "location",
                "../../index.html"
                );
        }
    });
}