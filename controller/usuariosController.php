<?php

ob_start();
include(__DIR__."/../model/database.php");

class usuariosController
{
    public static function getDatabaseConnection()
    {
        return new Database();
    }

    public static function getAllUsuarios()
    {
        $database = usuariosController::getDatabaseConnection();
        $query = "call getUsuarios()";
        $runQuery = $database->query($query);

        if ($runQuery->num_rows > 0) {
            $result = array();
            while($fila = $runQuery->fetch_array()){
                array_push($result,array(
                    "ID" => $fila['id_usuarios'],
                    "nombre" => $fila['nombre_usuario'],
                    "apellido_paterno" => $fila['ap_pat_usuario'],
                    "apellido_materno" => $fila['ap_mat_usuario'],
                    "rol" => $fila['nombre_rol'],
                    "correo" => $fila['email_usuario'],
                    "pass" => $fila['pass_usuario']
                ));
            
                
            }
            echo json_encode($result);
        }
    }

    public static function getAllRoles()
    {
        $database = usuariosController::getDatabaseConnection();
        $query = "CALL getRoles()";
        $table = $database->query($query);

        if ($table-> num_rows >0) {
            $result = array();
            while ($fila = $table->fetch_array()) {
                array_push($result,array(
                    "id" => $fila['idRoles'],
                    "nombre" => $fila['nombre_rol']
                ));
            }
            echo json_encode($result);
        }

        
    }

    public static function addNewUsuario()
    {
        $nombre = $_POST['nombre_nuevo'];
        $a_paterno = $_POST['apaterno_nuevo'];
        $a_materno = $_POST['amaterno_nuevo'];
        $rol = $_POST['roles'];
        $correo = $_POST['email_nuevo'];
        $pass = $_POST['pass_nuevo'];

        $database = usuariosController::getDatabaseConnection();
        $query = "CALL agregarUsuario('$nombre','$a_materno','$a_paterno','$rol','$correo','$pass')";

        $database->query($query);

        header('Location:../views/administrador/usuarios.html');
    }

    public static function deleteUsuario()
    {
        $id = $_POST['ID'];
        $database = AgremiadosController::getDatabaseConnection();
        $query = "call getafiliadodata($id)";
        $database->query($query);
        header('Location:../views/administrador/usuarios.html');
    }
}


switch ($_POST['key']) {
    case 1:
        usuariosController::getAllUsuarios();
        break;
    case 2:
        usuariosController::getAllRoles();;
        break;
    case 3:
        usuariosController::addNewUsuario();
    break;
    case 4:
        usuariosController::deleteUsuario();
    break;
    
    default:
        # code...
        break;
}

?>