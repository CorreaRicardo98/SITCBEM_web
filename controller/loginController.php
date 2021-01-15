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

}

switch ($_POST['key']) {
    case 1:
        LoginController::getRoles();
        break;
    
    default:
        # code...
        break;
}