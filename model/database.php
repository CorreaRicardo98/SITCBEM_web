<?php
class Database extends mysqli
{

    private $DB_HOST = 'localhost';
    private $DB_USER = 'root';
    private $DB_PASS = '';
    private $DB_NAME = 'sistema_cobach';


    public function __construct()
    {
        parent::__construct($this->DB_HOST, $this->DB_USER, $this->DB_PASS, $this->DB_NAME);
        $this->set_charset("utf8");
        if ($this->connect_errno) {
            die('Error en la conexión ' . mysqli_connect_errno());
        } else {
            //echo "Conectado";
            
        }
    }
}