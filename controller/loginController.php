<?php
ob_start();
include(__DIR__."/../model/database.php");

class LoginController
{
    public function getDatabaseConnection()
    {
        return new Database();
    }

    public function getRoles()
    {
        $database = LoginController::getDatabaseConnection();
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

    public function login()
    {
        $user = $_POST['user'];
        $pass = $_POST['pass'];
        $rol = $_POST['rol'];
        $date = $_POST['fecha'];
        $time = $_POST['hora'];

        $database = LoginController::getDatabaseConnection();
        $query = "CALL login( '$user', '$pass', '$date', '$time',$rol)";
        $runQuery = $database->query($query);
        $fila = $runQuery->fetch_array();

        echo json_encode($fila);
    }

    public function logOut()
    {
        $usuario = $_POST['id'];
        $time = $_POST['time'];
        $database = LoginController::getDatabaseConnection();
        $query = "CALL logOut('$time',$usuario)";
        $runQuery = $database->query($query);
        $fila = $runQuery->fetch_array();

        echo json_encode($fila);
    }

}

switch ($_POST['key']) {
    case 1:
        LoginController::getRoles();
        break;
    case 2:
        LoginController::login();
        break;
    case 3:
        LoginController::logOut();
        break;
    
    default:
        # code...
        break;
}