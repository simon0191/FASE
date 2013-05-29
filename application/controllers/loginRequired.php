<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of LoginRequired
 *
 * @author simon
 */
class LoginRequired extends CI_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->helper('url');
        $this->load->library('session');
        if(!$this->session->userdata('logged_in')){
            redirect('login');
        }
    }

}

?>
