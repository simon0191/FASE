<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Login extends CI_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->helper('form');
        $this->load->helper('url');
        $this->load->library('session');
        $this->load->database();
    }

    public function index() {
        if ($this->session->userdata('logged_in')) {
            redirect('main');
        } else {
            $this->load->view('login');
        }
    }

    public function validate() {
        $username = $this->input->post('txt_username');
        $password = $this->input->post('txt_password');
        if (($data = $this->validateLogin($username,$password))) {

            $this->session->set_userdata(array(
                'logged_in' => TRUE,
                'username' => $data->username,
                'id' => $data->id
            ));
            redirect('main');
        } else {
            $output = array(
                'error'=>'usuario o contraseña incorrectos'
            );
            $this->show($output);
        }
    }
    public function show($output=null){
        $this->load->view('login',$output);
    }
    public function validateLogin($username, $password) {
        $query = $this->db->get_where('usuario',array(
            'username' => $username,
            'password' => md5($password),
            ));
        if($query->num_rows > 0) {
            return $query->row();
        }
        else {
            return false;
        }        
    }
    public function forgotPassword() {

    }
    public function signup() {
        redirect('signup');
    }
}

?>
