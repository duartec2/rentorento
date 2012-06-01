<?php

class UserController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        // action body
    }

    public function loginAction()
    {
        $request = $this->getRequest();
        $form    = new Application_Form_Login();



        $this->view->form = $form;
    }


}



