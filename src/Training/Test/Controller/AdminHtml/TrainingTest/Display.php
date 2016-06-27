<?php

namespace Training\Test\Controller\AdminHtml\TrainingTest;

use \Magento\Framework\Controller\Result\Json as JsonResult;
use \Magento\Framework\Controller\Result\JsonFactory;
use \Magento\Framework\Json\Helper\Data as JsonHelper;
use \Magento\Backend\App\Action;
use \Magento\Framework\App\Action\Context;

class Display extends Action
{
    protected $_publicActions = ['display'];

    public function __construct(
        Context $context,
        JsonHelper $jsonHelper,
        JsonFactory $jsonResponse,
        \Psr\Log\LoggerInterface $logger
    ) {
        parent::__construct($context);

        $this->jsonHelper = $jsonHelper;
        $this->jsonResponse = $jsonResponse;
        $this->logger = $logger;
    }

    public function execute()
    {
        $this->logger->addInfo('XXXXX');
        
        $request = $this->getRequest();   
        
        $name = $request->getParam('name');

        $jsonResponse = $this->jsonResponse->create();
        $jsonResponse->setJsonData($this->jsonHelper->jsonEncode($name));
        return $jsonResponse;
    }

    /**
     * Check the permission to run it
     *
     * @return boolean
     */
    protected function _isAllowed()
    {
        $request = $this->getRequest();
        return (bool) $request->getParam('display');
    }
}
