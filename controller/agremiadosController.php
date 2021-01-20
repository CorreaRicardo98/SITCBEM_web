<?php
ob_start();
include(__DIR__."/../model/database.php");

class AgremiadosController
{
    public function getDatabaseConnection()
    {
        return new Database();
    }

    public function getAllJobs()
    {
        $database = AgremiadosController::getDatabaseConnection();
        $query = "call getJobs()";
        $runQuery = $database->query($query);

        if ($runQuery->num_rows > 0) {
            $result = array();
            while($fila = $runQuery->fetch_array()){
                array_push($result,array(
                    "id" => $fila['id_centro_trabajo'],
                    "nombre" => $fila['nombre_ct']
                ));
            
                echo json_encode($result);
            }
        }
    }


public function getAllCivil()
{
    $database = AgremiadosController::getDatabaseConnection();
    $query = "call getCivil()";
    $runQuery = $database->query($query);
    if ($runQuery->num_rows > 0) {
        $result = array();
        while ($fila = $runQuery->fetch_array()) {
            array_push($result,array(
                "id" => $fila['id_estado_civil'],
                "nombre" => $fila['estado_civil']
            ));
        }
        echo json_encode($result);
    }
}


public function addNewAgremiado()
{
    $nombre = $_POST['nombre_nuevo'];
    $aparetrno = $_POST['apaterno_nuevo'];
    $amaterno = $_POST['amaterno_nuevo'];
    $rfc_nuevo = $_POST['rfc_nuevo'];
    $curp_nuevo = $_POST['curp_nuevo'];
    $email_nuevo = $_POST['email_nuevo'];
    $telefono_nuevo = $_POST['telefono_nuevo'];
    $ingreso = $_POST['ingreso'];
    $nacimiento_nuevo = $_POST['nacimiento_nuevo'];
    $trabajo = $_POST['trabajo'];
    $estado_civil = $_POST['estado_civil'];
    $plaza = $_POST['plaza'];
    $postal_nuevo = $_POST['postal_nuevo'];
    $colonia_nuevo = $_POST['colonia_nuevo'];
    $municipio_nuevo = $_POST['municipio_nuevo'];
    $estado_nuevo = $_POST['estado_nuevo'];
    $tipo_asentamiento_nuevo = $_POST['tipo_asentamiento_nuevo'];
    $calle_nuevo = $_POST['calle_nuevo'];
    $numero_exterior_nuevo = $_POST['numero_exterior_nuevo'];
    $numero_interior_nuevo = $_POST['numero_interior_nuevo'];

    if ($numero_exterior_nuevo == 's/n') {
        $numero_exterior_nuevo =  0;
    }
    if ($numero_interior_nuevo == 's/n') {
        $numero_interior_nuevo =  0;
    }


    $ruta = "../../src/img/people/".$email_nuevo.".png";
    $tmp_name = $tmp_name = $_FILES["foto_nuevo"]["tmp_name"];
    move_uploaded_file($tmp_name,__DIR__.'/../src/img/people/'.$email_nuevo.'.png');
    $database = AgremiadosController::getDatabaseConnection();
    $query = "CALL agregarAfiliado( '$nombre',
                                    '$aparetrno',
                                    '$amaterno',
                                    '$rfc_nuevo',
                                    '$curp_nuevo',
                                    '$email_nuevo',
                                    '$ruta',
                                    '$telefono_nuevo',
                                    '$ingreso',
                                    '$nacimiento_nuevo',
                                    $trabajo,
                                    1,
                                    $estado_civil,
                                    $plaza,
                                    $postal_nuevo,
                                    '$colonia_nuevo',
                                    '$municipio_nuevo',
                                    '$estado_nuevo',
                                    '$tipo_asentamiento_nuevo',
                                    '$calle_nuevo',
                                    $numero_interior_nuevo,
                                    $numero_exterior_nuevo)";

    $database->query($query);

    header('Location:../views/administrador/agremiados.html');
}

public function getAfiliados()
{
    $database = AgremiadosController::getDatabaseConnection();
    $query = "call verAllAfiliados()";
    $runQuery = $database->query($query);

    if ($runQuery->num_rows > 0) {
        $result = array();
        while ($fila = $runQuery->fetch_array()) {
            array_push($result,array(
                "id" => $fila['id_afiliado'],
                "foto" => $fila['foto'],
                "nombre" => $fila['nombreC']
            ));
        }
        echo json_encode($result);
    }
}

public function getDataAfiliado()
{
    $id = $_POST['id'];
    $database = AgremiadosController::getDatabaseConnection();
    $query = "call getafiliadodata($id)";
    $runQuery = $database->query($query);
    $fila = $runQuery->fetch_array();
    echo json_encode($fila);
}


}

switch ($_POST['key']) {
    case 1:
        AgremiadosController::getAllJobs();
        break;
    case 2:
        AgremiadosController::getAllCivil();
        break;
    case 3:
        AgremiadosController::addNewAgremiado();
        break;
    case 4:
        AgremiadosController::getAfiliados();
        break;
    case 5:
        AgremiadosController::getDataAfiliado();
        break;
    
    default:
        # code...
        break;
}