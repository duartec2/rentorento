<?php
class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
    protected function _initRequest()
    {
        $this->bootstrap('FrontController');
        $front = $this->getResource('FrontController');
        $request = new Zend_Controller_Request_Http();
        $front->setRequest($request);
    }

    protected function _initPlaceholders()
    {
        $this->bootstrap('View');
        $view = $this->getResource('View');

        $view->doctype('HTML5');

        // Set the initial title and separator:
        $view->headTitle('RentoRento')->setSeparator(' | ');

        // Set the initial stylesheet:
        if(APPLICATION_ENV == 'development')
            $view->headLink()->prependStylesheet($view->baseUrl('/public/css/style.less'), 'screen', null, array('type' => 'text/less'));
        else
            $view->headLink()->prependStylesheet($view->baseUrl('/public/css/style.css'));

        // Set the initial JS to load:
        $view->headScript()->prependFile($view->baseUrl('/public/js/jquery-1.7.2.min.js'));

        if(APPLICATION_ENV == 'development')
           $view->headScript()->appendFile($view->baseUrl('/public/js/less-1.3.0.min.js'));

        $view->headMeta()->setCharset('UTF-8');
        $view->headMeta()->appendName('keywords', 'rentorento, renta, venta, casas, departamentos, casa, departamento');
        $view->headMeta()->appendName('description', 'Sitio de búsqueda de casas y departamentos en venta y renta');

    }

}

