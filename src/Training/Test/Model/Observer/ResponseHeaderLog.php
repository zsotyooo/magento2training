<?php

namespace Training\Test\Model\Observer;

use Magento\Framework\Event\ObserverInterface;

class ResponseHeaderLog implements ObserverInterface
{
    private $_logger;

    public function __construct(\Psr\Log\LoggerInterface $logger)
    {
        $this->_logger = $logger;
    }

    public function execute(\Magento\Framework\Event\Observer $observer)
    {
        $response = $observer->getEvent()->getData('response');
        
        if (!$response) {
            return;
        }

        $body = $response->getBody();

        //$this->_logger->addInfo("Response body: $body");
    }
}
