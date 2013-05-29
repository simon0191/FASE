<?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Signup extends CI_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->helper('form');
        $this->load->helper('url');
        $this->load->library('grocery_CRUD');
        $this->load->library('session');
        $this->load->database();
    }
    
    public function index(){
        if ($this->session->userdata('logged_in')) {
            redirect('main');
        } else {
            $this->load->view('signup',$this->displaySignUpForm());
        }
    }
    public function valid_user_name($username) {

        $query = $this->db->get_where('usuario',array('username'=>$username));
        if($query->num_rows > 0) {
            $this->form_validation->set_message('valid_user_name', 'Nombre de usuario ya existe');
            return false;
        }
        return true;
        
    }
    public function valid_num_documento($numeroDocumento) {

        $query = $this->db->get_where('usuario_informacion',array('num_documento'=>$numeroDocumento));
        if($query->num_rows > 0) {
            $this->form_validation->set_message('valid_num_documento', 'Numero de documento ya registrado');
            return false;
        }
        return true;
        
    }
    
    public function displaySignUpForm() {
        //Base de datos de destino
        $this->grocery_crud->set_table('usuario_informacion');
        //Título del formulario
        $this->grocery_crud->set_subject('Registro');
        
        //Campos a tener en cuenta
        $this->grocery_crud->fields(
            'nombre','apellidos',
            'tipo_documento_id','num_documento',
            'username','password','password_verification', //datos de tabla usuario
            'eps_id',
            'sexo_id','fecha_nacimiento','estado_civil_id',
            'ciudad_origen','barrio','direccion',
            'telefono_fijo','telefono_celular',
            'email',
            'nombre_acudiente','telefono_acudiente',
            'usuario_id'//Invisible
            );

        //Campos requeridos
        $this->grocery_crud->required_fields(
            'num_documento',
            'username',
            'tipo_documento_id',
            'nombre',
            'apellidos',
            'sexo_id',
            'fecha_nacimiento',
            'ciudad_origen',
            'barrio',
            'direccion',
            'estado_civil_id',
            'eps_id',
            'password',
            'password_verification'
            );

        //ocultar campos
        $this->grocery_crud
        ->field_type('usuario_id','invisible');

        //Configurar campos de contraseña
        $this->grocery_crud
        ->field_type('password','password')
        ->field_type('password_verification','password');

        //Relacionar con tabla eps
        $this->grocery_crud->set_relation('eps_id','eps','nombre')
        ->display_as('eps_id','EPS');

        //Relacionar con tabla estado_civil
        $this->grocery_crud->set_relation('estado_civil_id','estado_civil','nombre')
        ->display_as('estado_civil_id','Estado civil');

        //Relacionar con tabla tipo_documento
        $this->grocery_crud->set_relation('tipo_documento_id','tipo_documento','nombre')
        ->display_as('tipo_documento_id','Tipo de documento');

        //Relacionar con tabla tipo_documentosexo
        $this->grocery_crud->set_relation('sexo_id','sexo','nombre')
        ->display_as('sexo_id','Sexo');

        //Validar que el nombre de usuario no exista
        $this->grocery_crud
        ->set_rules('username','valid_user_name','callback_valid_user_name')
        ->display_as('username','Usuario');

        //Validar que el número de documento no exista
        $this->grocery_crud->
        set_rules('num_documento','valid_num_documento','callback_valid_num_documento');

        //Configurar campos de contraseña
        $this->grocery_crud
        ->display_as('password','Contraseña')
        ->display_as('password_verification','Verificación de contraseña')
        ->field_type('password','password')//Mostrar como contraseña
        ->field_type('password_verification','password')//Mostrar como contraseña
        ->set_rules('password_verification','password_match','matches[password]');//Verificación
        
        /** Procedimientos antes de registrar el nuevo usuario
        ** 1. Insertar nuevo usuario
        ** 2. Recuperar el id del nuevo usuario
        ** 3. Quitar contraseña y usuario de los datos
        ** 4. Configurar rol estudiante
        **/
        $this->grocery_crud->callback_before_insert(array($this,'before_insert_callback'));
        $this->grocery_crud->callback_after_insert(array($this,'after_insert_callback'));

        //Permitir únicamente registro
        $this->grocery_crud->unset_list();
        $this->grocery_crud->unset_back_to_list();
        try{
            $output = $this->grocery_crud->render();
        } catch(Exception $e) {
         
            if($e->getCode() == 14) //The 14 is the code of the "You don't have permissions" error on grocery CRUD.
            {
                redirect(strtolower(__CLASS__).'/'.strtolower(__FUNCTION__).'/add');
            }
            else
            {

                show_error($e->getMessage());
            }
            
        }

        $this->show((array)$output);
    }
    public function before_insert_callback($data) {
        $password = md5($data['password']);
        $username = $data['username'];
        //1. Insertar nuevo usuario
        $user = array(
           'username' => $username ,
           'password' => $password
        );
        //Inicio transacción (Fin en 'function after_insert_callback')
        $this->db->trans_begin();
        $this->db->insert('usuario', $user); 
        // 2. Recuperar el id del nuevo usuario
        if( $this->db->affected_rows() > 0 ) {
            /*
            $query = $this->db->get_where('usuario',array('NombreUsuario'=>$username));
        $data['usuarioId'] = $query->row()->id;
            */
            $query = $this->db->get_where('usuario',array('username'=>$username));
            $data['usuario_id'] = $query->row()->id;
            //3. Quitar contraseña de los datos
            unset($data['password']);
            unset($data['password_verification']);
            unset($data['username']);
            //4. 
            $rol = array(
                'rol_id' => 1,//Id rol 'estudiante'
                'usuario_id' => $data['usuario_id']
                );
            $this->db->insert('rol_usuario', $rol);
            if($this->db->affected_rows() > 0) {
                return $data;    
            }
            return false;    
        }
        print "<script type=\"text/javascript\">alert('fuck 1');</script>";
        redirect('login');
        return false;
    }
    public function after_insert_callback($post_array,$primary_key) {
        //Fin transacción
        $this->db->trans_complete();
    }
    public function show($output=null){
        $this->load->view('signup',$output);
    }
    public function backTohome(){
        /*
        $cont = 1;
        $query = $this->db->get('sede');
        foreach ($query->result() as $row) {
            $row->id = $cont++;
            $this->db->where('NombreSede',$row->NombreSede);
            $this->db->update('sede',$row);
        }
        */
        redirect('login');

    }
}
?>
