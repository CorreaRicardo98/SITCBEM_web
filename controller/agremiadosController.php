<?php
ob_start();
include(__DIR__."/../model/database.php");

class AgremiadosController
{
    public static function getDatabaseConnection()
    {
        return new Database();
    }

    public static function getAllJobs()
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


public static function getAllCivil()
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


public static function addNewAgremiado()
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
    echo $query;

    header('Location:../views/administrador/agremiados.html');
}

public static function getAfiliados()
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

public static function getDataAfiliado()
{
    $id = $_POST['id'];
    $database = AgremiadosController::getDatabaseConnection();
    $query = "call getafiliadodata($id)";
    $runQuery = $database->query($query);
    $fila = $runQuery->fetch_array();
    echo json_encode($fila);
}

public function updateAgremiado()
{
    $id = $_POST['id_agremiado_editar'];
    $id_dir = $_POST['id_direccion'];
    $nombre = $_POST['nombre_editar'];
    $aparetrno = $_POST['apaterno_editar'];
    $amaterno = $_POST['amaterno_editar'];
    $rfc_editar = $_POST['rfc_editar'];
    $curp_editar = $_POST['curp_editar'];
    $email_editar = $_POST['email_editar'];
    $telefono_editar = $_POST['telefono_editar'];
    $ingreso = $_POST['ingreso_editar'];
    $nacimiento_editar = $_POST['nacimiento_editar'];
    $trabajo = $_POST['trabajo_editar'];
    $estado_civil = $_POST['estado_civil_editar'];
    $plaza = $_POST['plaza_editar'];
    $postal_editar = $_POST['postal_editar'];
    $colonia_editar = $_POST['colonia_editar'];
    $municipio_editar = $_POST['municipio_editar'];
    $estado_editar = $_POST['estado_editar'];
    $tipo_asentamiento_editar = $_POST['tipo_asentamiento_editar'];
    $calle_editar = $_POST['calle_editar'];
    $numero_exterior_editar = $_POST['numero_exterior_editar'];
    $numero_interior_editar = $_POST['numero_interior_editar'];
    $database = AgremiadosController::getDatabaseConnection();
    $query = "call updateAgremiado(
        $id,
        '$nombre',
        '$aparetrno',
        '$amaterno',
        '$rfc_editar',
        '$curp_editar',
        '$email_editar',
        '$telefono_editar',
        '$ingreso',
        '$nacimiento_editar',
        $trabajo,
        1,
        $estado_civil,
        $plaza,
        $postal_editar,
        '$colonia_editar',
        '$municipio_editar',
        '$estado_editar',
        '$tipo_asentamiento_editar',
        '$calle_editar',
        '$numero_interior_editar',
        '$numero_exterior_editar',
        $id_dir)";


        $database->query($query);

        echo $query;

        header('Location:../views/administrador/agremiados.html');
}

public function eliminarAremiado()
{
    $id = $_POST['id'];
    $database = AgremiadosController::getDatabaseConnection();
    $query = "call eliminarAgremiado($id)";

    $runQuery = $database->query($query);
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
    case 6:
        AgremiadosController::updateAgremiado();
        break;
    case 7:
        AgremiadosController::eliminarAremiado();
        break;
    
    default:
        # code...
        break;
}