<?php

ob_start();
include(__DIR__."/../model/database.php");

class bitacoraController
{
    public static function getDatabaseConnection()
    {
        return new Database();
    }

    public static function getDatosBitacora()
    {
        $database = bitacoraController::getDatabaseConnection();
        $query = "CALL getBitacora()";
        $table = $database->query($query);
        $hora='Sesión activa';
        if ($table-> num_rows >0) {
            $result = array();
            while ($fila = $table->fetch_array()) {

                if($fila['salida_log']==null)
                {
                    array_push($result,array(
                        "nombre" => $fila['nombre_ct'],
                        "email" => $fila['email'],
                        "rol" => $fila['rol'],
                        "fecha_loggin" => $fila['feha_log'],
                        "hora_loggin" => $fila['hora_log'],
                        "salida_loggin" => $hora
                    ));
                }else{
                    array_push($result,array(
                        "nombre" => $fila['nombre_ct'],
                        "email" => $fila['email'],
                        "rol" => $fila['rol'],
                        "fecha_loggin" => $fila['feha_log'],
                        "hora_loggin" => $fila['hora_log'],
                        "salida_loggin" => $fila['salida_log']
                    ));
                }

            }
            echo json_encode($result);
        }

        
    }
}


switch ($_POST['key']) {
    case 1:
        bitacoraController::getDatosBitacora();
        break;
    default:
        # code...
        break;
}

?>